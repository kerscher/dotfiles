<a name="0.1.0"></a>
## 0.1.0 (2019-04-24)


#### Bug Fixes

* **Docker:**  use `docker-ce` instead of `docker-latest` ([f5144a09](f5144a09))
* **nix:**  correct check for nix startup and enable it ([66f316cf](66f316cf))

#### Features

*   Nix support ([53ad7912](53ad7912))
* **Bootstrap:**  add `tilda` to Fedora ([861394e7](861394e7))
* **LSP:**  add language server protocol to bootstrap ([4c912d3f](4c912d3f))
* **Ruby:**  re-enable automatic `rbenv` activation ([02b960c0](02b960c0))
* **bootstrap:**  `gometalinter` is deprecated, use `golangci-lint` ([caa7622e](caa7622e))
* **gitignore:**
  *  remove R and Sass ([bc3e3c39](bc3e3c39))
  *  ignore Terraform-related temporary files ([aac6f705](aac6f705))
* **go:**  add `gocode` ([1e0b390d](1e0b390d))
* **haskell:**  remove `brittany`, use only `hindent` ([f09b75da](f09b75da))
* **nix:**  disable loading by default ([46c8fd53](46c8fd53))
* **plan9:**  disable loading by default ([10ec94cb](10ec94cb))
* **python:**  add `pygments` ([9f26598b](9f26598b))
* **ruby:**
  *  use `aws-env` if available for `sumdog_tools` ([00769635](00769635))
  *  execute `sd` from `sumdog_tools` ([b0f5fe6a](b0f5fe6a))
* **terraform:**  let environment decide `aws-env` profile ([ca302207](ca302207))



