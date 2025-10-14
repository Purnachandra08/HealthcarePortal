document.addEventListener("DOMContentLoaded", function () {
    const calendarEl = document.getElementById("calendar");
    const selectedDateInput = document.getElementById("selectedDate");

    if (!calendarEl) return;

    let today = new Date();
    let currentMonth = today.getMonth();
    let currentYear = today.getFullYear();

    const months = ["January","February","March","April","May","June","July","August","September","October","November","December"];

    function renderCalendar(month, year) {
        calendarEl.innerHTML = "";

        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();

        // Header
        const header = document.createElement("div");
        header.classList.add("calendar-header");
        header.innerHTML = `<button id="prev">&lt;</button>
                            <span>${months[month]} ${year}</span>
                            <button id="next">&gt;</button>`;
        calendarEl.appendChild(header);

        // Days of week
        const daysRow = document.createElement("div");
        daysRow.classList.add("calendar-days-row");
        ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"].forEach(d => {
            const el = document.createElement("div");
            el.classList.add("calendar-day-name");
            el.innerText = d;
            daysRow.appendChild(el);
        });
        calendarEl.appendChild(daysRow);

        // Dates
        const datesContainer = document.createElement("div");
        datesContainer.classList.add("calendar-dates");

        for (let i=0;i<firstDay;i++){
            const empty = document.createElement("div");
            empty.classList.add("calendar-date-empty");
            datesContainer.appendChild(empty);
        }

        for (let date=1;date<=daysInMonth;date++){
            const dateEl = document.createElement("div");
            dateEl.classList.add("calendar-date");
            dateEl.innerText = date;

            const fullDate = new Date(year, month, date);
            if (fullDate < new Date().setHours(0,0,0,0)){
                dateEl.classList.add("disabled");
            } else {
                dateEl.addEventListener("click",()=>{
                    document.querySelectorAll(".calendar-date.selected").forEach(el=>el.classList.remove("selected"));
                    dateEl.classList.add("selected");
                    if(selectedDateInput) selectedDateInput.value = `${year}-${month+1}-${date}`;
                    selectedDateInput.dispatchEvent(new Event("change")); // trigger slots fetch
                });
            }
            datesContainer.appendChild(dateEl);
        }

        calendarEl.appendChild(datesContainer);

        // Prev/Next
        document.getElementById("prev").addEventListener("click",()=>{
            currentMonth--;
            if(currentMonth<0){currentMonth=11; currentYear--;}
            renderCalendar(currentMonth,currentYear);
        });
        document.getElementById("next").addEventListener("click",()=>{
            currentMonth++;
            if(currentMonth>11){currentMonth=0; currentYear++;}
            renderCalendar(currentMonth,currentYear);
        });
    }

    renderCalendar(currentMonth,currentYear);
});
