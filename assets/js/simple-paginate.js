const templatePaginate = document.createElement('template');

templatePaginate.innerHTML = `
    <nav>
        <ul class="pagination">
            <li class="page-item">
                <a class="page-link" id="page-previous">Previous</a>
            </li>
            <li class="page-item">
                <a class="page-link" id="page-next">Next</a>
            </li>
        </ul>
    </nav>

    <div style="clear: both" id="page-holder"></div>
`;

class SimplePaginate extends HTMLElement {
    static get observedAttributes() {
        return ['current-page', 'total-count', 'per-page'];
    }

    constructor() {
        super();
        // const shadow = this.attachShadow({ mode: 'open' });

        this._currentPage = 0;
        this._totalCount = 0;
        this._perPage = 10;
    }

    connectedCallback() {
        this.appendChild(templatePaginate.content.cloneNode(true));
        this.$next = this.querySelector('#page-next');
        this.$previous = this.querySelector('#page-previous');
        this.$next.addEventListener('click', this.nextPage.bind(this));
        this.$previous.addEventListener('click', this.prevPage.bind(this));
        this._render();
    }

    attributeChangedCallback(name, oldValue, newValue) {
        if (name == 'current-page') {
            this._currentPage = parseInt(newValue);
        } else if (name == 'total-count') {
            this._totalCount = parseInt(newValue);
        } else if (name == 'per-page') {
            this._perPage = parseInt(newValue);
        }
        this._render();
    }

    nextPage(e) {
        this.dispatchEvent(new Event('next'))
    }

    prevPage(e) {
        this.dispatchEvent(new Event('previous'))
    }

    disconnectedCallback() { }

    _render() {
        let pageHolder = this.querySelector("#page-holder");
        let first = (this._perPage * (this._currentPage - 1)) + 1;
        pageHolder.innerText = `${first} to ${first + this._perPage - 1} of ${this._totalCount}`;

        if (currentPage == lastPage) {
            this.querySelector("#page-next").parentElement.classList.add("disabled");
        } else {
            this.querySelector("#page-next").parentElement.classList.remove("disabled");
        }

        if (currentPage == 1) {
            this.querySelector("#page-previous").parentElement.classList.add("disabled");
        } else {
            this.querySelector("#page-previous").parentElement.classList.remove("disabled");
        }
    }
}

window.customElements.define('simple-paginate', SimplePaginate);