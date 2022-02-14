Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1B4B4DC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350756AbiBNLR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:17:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350657AbiBNLQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:16:57 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544F6C90F;
        Mon, 14 Feb 2022 02:47:45 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 10so10217096plj.1;
        Mon, 14 Feb 2022 02:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=WBz9wSzC1COUhRnuqu93k1sQGTqUdjZifk5j2PKmpTY=;
        b=XuCn5xxzHMgnieyuuilLSF1fzhAZedI4X6RAhrrbBbKZvfekcjgYhhS89NZsw64E3T
         qL8f0+cmcSW7NGXrm82AgbRztrRtusCgmRIwnpbd9vPHa2rCBz+/Jb3F624bsdHZ4yP1
         EiOhvd8r1kY2+KNZfY0I2dwWwIyVZYdA4hDqSpW14GJUBQlZ6tp3bkGyvB2uEYhwH5j6
         DhFE6+fE9Avf0Mz2qqwGP6NE/MAl1YbxjfzmylplBc5lY4QvvEE8I2O1THN8RWE8LdHy
         aZliExoEjuNBAbiwGqOsTkY7gOC2nSOQ1hc/+1bpAYLRSOwVQ5QUQSrPFwJWA4raVRRD
         2C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=WBz9wSzC1COUhRnuqu93k1sQGTqUdjZifk5j2PKmpTY=;
        b=2ZWLZtx+kv0otEvkB5/qRiT6TSNYa2fxuw+PH/5qhNX07AZyqWSUs5jeshFX8Ra3x2
         djvG0AFAjPLbFG0DOXZdaUZtDLzFITx52f1khvrlI3oNd4slTuVqe8Z+o0wXsx2e+V4N
         t3Y4BjpCUE9GmP92Vag5MCX1MtXhL8xMiuiUyg9BZLMQhpekkqo6hgf4F3XmUu1TEIAg
         CWf0QZtnpHXdnqftdu4UZhann9dWOMeWIC6zeWG5+izcFhBZ0Bs7sjP3BhwYEGedVgvj
         k1Y1I3GTzk1lAxsgLTp7LrinSKz66fxzD7+D9q44pui9TCtlnwKiHqPezLRCTvDIwdWM
         xlpg==
X-Gm-Message-State: AOAM533p0pVylzfq2B/3eb6T/w604TdfLKEGYDn29wc82pz6aZpFKdLq
        7MP36F8daEVlMR2VnmFrNmZ+EKyJ8JA=
X-Google-Smtp-Source: ABdhPJz/Tf0uG+oB9Zum9MMPYirQmSlJ7gdkJyeP11SL4LTvTeQ1N9ktasn1GSxi51ImQg9vERJYvg==
X-Received: by 2002:a17:90a:e553:: with SMTP id ei19mr14091662pjb.177.1644835664861;
        Mon, 14 Feb 2022 02:47:44 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id f8sm36590436pfv.24.2022.02.14.02.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 02:47:44 -0800 (PST)
Message-ID: <8baf7006-90ed-25b8-3005-69b5475215cf@gmail.com>
Date:   Mon, 14 Feb 2022 19:47:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     Miguel Ojeda <ojeda@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     alex.gaynor@gmail.com, ark.email@gmail.com, bobo1239@web.de,
        bobwxc@email.cn, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, jtitor@2k36.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org, me@kloenk.de,
        michal.lkml@markovi.net, mpe@ellerman.id.au,
        ndesaulniers@google.com, rust-for-linux@vger.kernel.org,
        thesven73@gmail.com, torvalds@linux-foundation.org,
        wedsonaf@google.com, wei.liu@kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20220212130410.6901-16-ojeda@kernel.org>
Subject: Re: [PATCH v4 15/20] docs: add Rust documentation
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220212130410.6901-16-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please find inline comments WRT ReST-in-kereneldoc.

Jon, if I'm missing something, please enlighten me.

On Sat, 12 Feb 2022 14:03:41 +0100,
Miguel Ojeda <ojeda@kernel.org> wrote:
> Most of the documentation for Rust is written within the source code
> itself, as it is idiomatic for Rust projects. This applies to both
> the shared infrastructure at `rust/` as well as any other Rust module
> (e.g. drivers) written across the kernel.
> 
> However, these documents contain general information that does not
> fit particularly well in the source code, like the Quick Start guide.
> 
> It also contains an asset (SVG logo) used for the `rustdoc` target
> and a few other small changes elsewhere in the documentation folder.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Finn Behrens <me@kloenk.de>
> Signed-off-by: Finn Behrens <me@kloenk.de>
> Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Co-developed-by: Wu XiangCheng <bobwxc@email.cn>
> Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Co-developed-by: Yuki Okushi <jtitor@2k36.org>
> Signed-off-by: Yuki Okushi <jtitor@2k36.org>
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Documentation/doc-guide/kernel-doc.rst     |   3 +
>  Documentation/index.rst                    |   1 +
>  Documentation/kbuild/kbuild.rst            |   4 +
>  Documentation/process/changes.rst          |  42 +++
>  Documentation/rust/arch-support.rst        |  35 ++
>  Documentation/rust/coding-guidelines.rst   | 153 +++++++++
>  Documentation/rust/general-information.rst |  80 +++++
>  Documentation/rust/index.rst               |  21 ++
>  Documentation/rust/logo.svg                | 357 +++++++++++++++++++++
>  Documentation/rust/quick-start.rst         | 231 +++++++++++++
>  10 files changed, 927 insertions(+)
>  create mode 100644 Documentation/rust/arch-support.rst
>  create mode 100644 Documentation/rust/coding-guidelines.rst
>  create mode 100644 Documentation/rust/general-information.rst
>  create mode 100644 Documentation/rust/index.rst
>  create mode 100644 Documentation/rust/logo.svg
>  create mode 100644 Documentation/rust/quick-start.rst
> 
> diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
> index 79aaa55d6bcf..724e2ffddff1 100644
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -11,6 +11,9 @@ when it is embedded in source files.
>     reasons. The kernel source contains tens of thousands of kernel-doc
>     comments. Please stick to the style described here.
>  
> +.. note:: kernel-doc does not cover Rust code: please see
> +   Documentation/rust/docs.rst instead.
> +
>  The kernel-doc structure is extracted from the comments, and proper
>  `Sphinx C Domain`_ function and type descriptions with anchors are
>  generated from them. The descriptions are filtered for special kernel-doc
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index b58692d687f6..ca9ff1adbe0b 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -82,6 +82,7 @@ merged much easier.
>     maintainer/index
>     fault-injection/index
>     livepatch/index
> +   rust/index
>  
>  
>  Kernel API documentation
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
> index 2d1fc03d346e..468a0d216c29 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -57,6 +57,10 @@ CFLAGS_MODULE
>  -------------
>  Additional module specific options to use for $(CC).
>  
> +KRUSTFLAGS
> +----------
> +Additional options to the Rust compiler (for built-in and modules).
> +
>  LDFLAGS_MODULE
>  --------------
>  Additional options used for $(LD) when linking modules.
> diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
> index a337e8eabfe1..4ec918da321f 100644
> --- a/Documentation/process/changes.rst
> +++ b/Documentation/process/changes.rst
> @@ -31,6 +31,8 @@ you probably needn't concern yourself with pcmciautils.
>  ====================== ===============  ========================================
>  GNU C                  5.1              gcc --version
>  Clang/LLVM (optional)  11.0.0           clang --version
> +Rust (optional)        1.58.0           rustc --version
> +bindgen (optional)     0.56.0           bindgen --version
>  GNU make               3.81             make --version
>  binutils               2.23             ld -v
>  flex                   2.5.35           flex --version
> @@ -78,6 +80,29 @@ kernels. Older releases aren't guaranteed to work, and we may drop workarounds
>  from the kernel that were used to support older versions. Please see additional
>  docs on :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
>  
> +Rust (optional)
> +---------------
> +
> +A particular version of the Rust toolchain is required. Newer versions may or
> +may not work because the kernel depends on some unstable Rust features, for
> +the moment.
> +
> +Each Rust toolchain comes with several "components", some of which are required
> +(like ``rustc``) and some that are optional. The ``rust-src`` component (which
> +is optional) needs to be installed to build the kernel. Other components are
> +useful for developing.
> +
> +Please see :ref:`Documentation/rust/quick-start.rst <rust_quick_start>` for
              Documentation/rust/quick-start.rst for

On document cross-referencing, see:
    https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#cross-referencing

> +instructions on how to satify the build requirements of Rust support. In
                          satisfy

> +particular, the Makefile target 'rustavailable' is useful to check why the Rust
> +toolchain may not be detected.
> +
> +bindgen (optional)
> +------------------
> +
> +``bindgen`` is used to generate the Rust bindings to the C side of the kernel.
> +It depends on ``libclang``.
> +
>  Make
>  ----
>  
> @@ -340,6 +365,13 @@ Sphinx
>  Please see :ref:`sphinx_install` in :ref:`Documentation/doc-guide/sphinx.rst <sphinxdoc>`
>  for details about Sphinx requirements.
>  
> +rustdoc
> +-------
> +
> +``rustdoc`` is used to generate the documentation for Rust code. Please see
> +:ref:`Documentation/rust/general-information.rst <rust_general_information>`
   Documentation/rust/general-information.rst

> +for more information.
> +
>  Getting updated software
>  ========================
>  
> @@ -356,6 +388,16 @@ Clang/LLVM
>  
>  - :ref:`Getting LLVM <getting_llvm>`.
>  
> +Rust
> +----
> +
> +- :ref:`Documentation/rust/quick-start.rst <rust_quick_start>`.
   - Documentation/rust/quick-start.rst.

> +
> +bindgen
> +-------
> +
> +- :ref:`Documentation/rust/quick-start.rst <rust_quick_start>`.
   - Documentation/rust/quick-start.rst.

> +
>  Make
>  ----
>  
> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
> new file mode 100644
> index 000000000000..fdcce6452623
> --- /dev/null
> +++ b/Documentation/rust/arch-support.rst
> @@ -0,0 +1,35 @@
> +.. _rust_arch_support:
This tag is not necessary.

> +
> +Arch Support
> +============
> +
> +Currently, the Rust compiler (``rustc``) uses LLVM for code generation,
> +which limits the supported architectures that can be targeted. In addition,
> +support for building the kernel with LLVM/Clang varies (see :ref:`kbuild_llvm`).
   support for building the kernel with LLVM/Clang varies
   (see Documentation/kbuild/llvm.rst).

> +This support is needed for ``bindgen`` which uses ``libclang``.
> +
> +Below is a general summary of architectures that currently work. Level of
> +support corresponds to ``S`` values in the ``MAINTAINERS`` file.
> +
> +.. list-table::
FYI, use of list-table is discouraged.  (See commit db67eb748e7a
("docs: discourage use of list tables").) 

> +   :widths: 10 10 10
      :widths: 8 12 30            <- This table looks better in html with these widths.

> +   :header-rows: 1
> +> +   * - Architecture
> +     - Level of support
> +     - Constraints
> +   * - ``arm``
> +     - Maintained
> +     - ``armv6`` and compatible only, ``RUST_OPT_LEVEL >= 2``
> +   * - ``arm64``
> +     - Maintained
> +     - None
> +   * - ``powerpc``
> +     - Maintained
> +     - ``ppc64le`` only, ``RUST_OPT_LEVEL < 2`` requires ``CONFIG_THREAD_SHIFT=15``
> +   * - ``riscv``
> +     - Maintained
> +     - ``riscv64`` only
> +   * - ``x86``
> +     - Maintained
> +     - ``x86_64`` only
> diff --git a/Documentation/rust/coding-guidelines.rst b/Documentation/rust/coding-guidelines.rst
> new file mode 100644
> index 000000000000..9181dcbc2140
> --- /dev/null
> +++ b/Documentation/rust/coding-guidelines.rst
> @@ -0,0 +1,153 @@
> +.. _rust_coding_guidelines:
  Unnecessary tag.

> +
> +Coding Guidelines
> +=================
> +
> +This document describes how to write Rust code in the kernel.
> +
> +
> +Style & formatting
> +------------------
> +
> +The code should be formatted using ``rustfmt``. In this way, a person
> +contributing from time to time to the kernel does not need to learn and
> +remember one more style guide. More importantly, reviewers and maintainers
> +do not need to spend time pointing out style issues anymore, and thus
> +less patch roundtrips may be needed to land a change.
> +
> +.. note:: Conventions on comments and documentation are not checked by
> +  ``rustfmt``. Thus those are still needed to be taken care of.
> +
> +The default settings of ``rustfmt`` are used. This means the idiomatic Rust
> +style is followed. For instance, 4 spaces are used for indentation rather
> +than tabs.
> +
> +It is convenient to instruct editors/IDEs to format while typing,
> +when saving or at commit time. However, if for some reason reformatting
> +the entire kernel Rust sources is needed at some point, the following can be
> +run::
> +
> +	make LLVM=1 rustfmt
> +
> +It is also possible to check if everything is formatted (printing a diff
> +otherwise), for instance for a CI, with::
> +
> +	make LLVM=1 rustfmtcheck
> +
> +Like ``clang-format`` for the rest of the kernel, ``rustfmt`` works on
> +individual files, and does not require a kernel configuration. Sometimes it may
> +even work with broken code.
> +
> +
> +Code documentation
> +------------------
> +
> +Rust kernel code is not documented like C kernel code (i.e. via kernel-doc).
> +Instead, the usual system for documenting Rust code is used: the ``rustdoc``
> +tool, which uses Markdown (a lightweight markup language).
> +
> +To learn Markdown, there are many guides available out there. For instance,
> +the one at:
> +
> +	https://commonmark.org/help/
> +
> +This is how a well-documented Rust function may look like:
> +
> +.. code-block:: rust
> +
> +	/// Returns the contained [`Some`] value, consuming the `self` value,
> +	/// without checking that the value is not [`None`].
> +	///
> +	/// # Safety
> +	///
> +	/// Calling this method on [`None`] is *[undefined behavior]*.
> +	///
> +	/// [undefined behavior]: https://doc.rust-lang.org/reference/behavior-considered-undefined.html
> +	///
> +	/// # Examples
> +	///
> +	/// ```
> +	/// let x = Some("air");
> +	/// assert_eq!(unsafe { x.unwrap_unchecked() }, "air");
> +	/// ```
> +	pub unsafe fn unwrap_unchecked(self) -> T {
> +		match self {
> +			Some(val) => val,
> +
> +			// SAFETY: The safety contract must be upheld by the caller.
> +			None => unsafe { hint::unreachable_unchecked() },
> +		}
> +	}
> +
> +This example showcases a few ``rustdoc`` features and some conventions followed
> +in the kernel:
> +
> +  - The first paragraph must be a single sentence briefly describing what
> +    the documented item does. Further explanations must go in extra paragraphs.
> +
> +  - Unsafe functions must document their safety preconditions under
> +    a ``# Safety`` section.
> +
> +  - While not shown here, if a function may panic, the conditions under which
> +    that happens must be described under a ``# Panics`` section.
> +
> +    Please note that panicking should be very rare and used only with a good
> +    reason. In almost all cases, a fallible approach should be used, typically
> +    returning a ``Result``.
> +
> +  - If providing examples of usage would help readers, they must be written in
> +    a section called ``# Examples``.
> +
> +  - Rust items (functions, types, constants...) must be linked appropriately
> +    (``rustdoc`` will create a link automatically).
> +
> +  - Any ``unsafe`` block must be preceded by a ``// SAFETY:`` comment
> +    describing why the code inside is sound.
> +
> +    While sometimes the reason might look trivial and therefore unneeded, writing
> +    these comments is not just a good way of documenting what has been taken into
> +    account, but most importantly, it provides a way to know that there are
> +    no *extra* implicit constraints.
> +
> +To learn more about how to write documentation for Rust and extra features,
> +please take a look at the ``rustdoc`` `book`_.
> +
> +.. _book: https://doc.rust-lang.org/rustdoc/how-to-write-documentation.html
> +
> +
> +Naming
> +------
> +
> +Rust kernel code follows the usual Rust naming conventions:
> +
> +	https://rust-lang.github.io/api-guidelines/naming.html
> +
> +When existing C concepts (e.g. macros, functions, objects...) are wrapped into
> +a Rust abstraction, a name as close as reasonably possible to the C side should
> +be used in order to avoid confusion and to improve readability when switching
> +back and forth between the C and Rust sides. For instance, macros such as
> +``pr_info`` from C are named the same in the Rust side.
> +
> +Having said that, casing should be adjusted to follow the Rust naming
> +conventions, and namespacing introduced by modules and types should not be
> +repeated in the item names. For instance, when wrapping constants like:
> +
> +.. code-block:: c
> +
> +	#define GPIO_LINE_DIRECTION_IN	0
> +	#define GPIO_LINE_DIRECTION_OUT	1
> +
> +The equivalent in Rust may look like (ignoring documentation):
> +
> +.. code-block:: rust
> +
> +	pub mod gpio {
> +	    pub enum LineDirection {
> +	        In = bindings::GPIO_LINE_DIRECTION_IN as _,
> +	        Out = bindings::GPIO_LINE_DIRECTION_OUT as _,
> +	    }
> +	}
> +
> +That is, the equivalent of ``GPIO_LINE_DIRECTION_IN`` would be referred to as
> +``gpio::LineDirection::In``. In particular, it should not be named
> +``gpio::gpio_line_direction::GPIO_LINE_DIRECTION_IN``.
> diff --git a/Documentation/rust/general-information.rst b/Documentation/rust/general-information.rst
> new file mode 100644
> index 000000000000..9ee4c6994d08
> --- /dev/null
> +++ b/Documentation/rust/general-information.rst
> @@ -0,0 +1,80 @@
> +.. _rust_general_information:
Unnecessary tag.

> +
> +General Information
> +===================
> +
> +This document contains useful information to know when working with
> +the Rust support in the kernel.
> +
> +
> +Code documentation
> +------------------
> +
> +Rust kernel code is documented using ``rustdoc``, its built-in documentation
> +generator.
> +
> +The generated HTML docs include integrated search, linked items (e.g. types,
> +functions, constants), source code, etc. They may be read at (TODO: link when
> +in mainline and generated alongside the rest of the documentation):
> +
> +	http://kernel.org/
> +
> +The docs can also be easily generated and read locally. This is quite fast
> +(same order as compiling the code itself) and no special tools or environment
> +are needed. This has the added advantage that they will be tailored to
> +the particular kernel configuration used. To generate them, use the ``rustdoc``
> +target with the same invocation used for compilation, e.g.::
> +
> +	make LLVM=1 rustdoc
> +
> +To read the docs locally in your web browser, run e.g.::
> +
> +	xdg-open rust/doc/kernel/index.html
> +
> +To learn about how to write the documentation, please see the coding guidelines
> +at :ref:`Documentation/rust/coding-guidelines.rst <rust_coding_guidelines>`.
   at Documentation/rust/coding-guidelines.rst.

> +
> +
> +Extra lints
> +-----------
> +
> +While ``rustc`` is a very helpful compiler, some extra lints and analyses are
> +available via ``clippy``, a Rust linter. To enable it, pass ``CLIPPY=1`` to
> +the same invocation used for compilation, e.g.::
> +
> +	make LLVM=1 CLIPPY=1
> +
> +Please note that Clippy may change code generation, thus it should not be
> +enabled while building a production kernel.
> +
> +
> +Abstractions vs. bindings
> +-------------------------
> +
> +Abstractions are Rust code wrapping kernel functionality from the C side.
> +
> +In order to use functions and types from the C side, bindings are created.
> +Bindings are the declarations for Rust of those functions and types from
> +the C side.
> +
> +For instance, one may write a ``Mutex`` abstraction in Rust which wraps
> +a ``struct mutex`` from the C side and calls its functions through the bindings.
> +
> +Abstractions are not available for all the kernel internal APIs and concepts,
> +but it is intended that coverage is expanded as time goes on. "Leaf" modules
> +(e.g. drivers) should not use the C bindings directly. Instead, subsystems
> +should provide as-safe-as-possible abstractions as needed.
> +
> +
> +Conditional compilation
> +-----------------------
> +
> +Rust code has access to conditional compilation based on the kernel
> +configuration:
> +
> +.. code-block:: rust
> +
> +	#[cfg(CONFIG_X)]       // Enabled               (`y` or `m`)
> +	#[cfg(CONFIG_X="y")]   // Enabled as a built-in (`y`)
> +	#[cfg(CONFIG_X="m")]   // Enabled as a module   (`m`)
> +	#[cfg(not(CONFIG_X))]  // Disabled
> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
> new file mode 100644
> index 000000000000..6e20af5b723a
> --- /dev/null
> +++ b/Documentation/rust/index.rst
> @@ -0,0 +1,21 @@
> +Rust
> +====
> +
> +Documentation related to Rust within the kernel. To start using Rust
> +in the kernel, please read the
> +:ref:`Documentation/rust/quick-start.rst <rust_quick_start>` guide.
   in the kernel, please read the guide in Documentation/rust/quick-start.rst.

> +
> +.. toctree::
> +    :maxdepth: 1
> +
> +    quick-start
> +    general-information
> +    coding-guidelines
> +    arch-support
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`
> diff --git a/Documentation/rust/logo.svg b/Documentation/rust/logo.svg
> new file mode 100644
> index 000000000000..65be792a5abe
> --- /dev/null
How about adding a suitable license identifier in a comment?
For example, Documentation/userspace-api/media/v4l/selection.svg carries this:

<?xml version="1.0" encoding="UTF-8"?>
<!-- SPDX-License-Identifier: GPL-2.0 OR GFDL-1.1-no-invariants-or-later -->

[hunk of SVG omitted]

> diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
> new file mode 100644
> index 000000000000..260393c48379
> --- /dev/null
> +++ b/Documentation/rust/quick-start.rst
> @@ -0,0 +1,231 @@
> +.. _rust_quick_start:
Unnecessary tag.

> +
> +Quick Start
> +===========
> +
> +This document describes how to get started with kernel development in Rust.
> +
> +
> +Requirements: Building
> +----------------------
> +
> +This section explains how to fetch the tools needed for building.
> +
> +Some of these requirements might be available from Linux distributions
> +under names like ``rustc``, ``rust-src``, ``rust-bindgen``, etc. However,
> +at the time of writing, they are likely not to be recent enough unless
> +the distribution tracks the latest releases.
> +
> +To easily check whether the requirements are met, the following target
> +can be used::
> +
> +	make LLVM=1 rustavailable
> +
> +This triggers the same logic used by Kconfig to determine whether
> +``RUST_IS_AVAILABLE`` should be enabled; but it also explains why not
> +if that is the case.
> +
> +
> +rustc
> +*****
> +
> +A particular version of the Rust compiler is required. Newer versions may or
> +may not work because, for the moment, the kernel depends on some unstable
> +Rust features.
> +
> +If ``rustup`` is being used, enter the checked out source code directory
> +and run::
> +
> +	rustup override set $(scripts/min-tool-version.sh rustc)
> +
> +Otherwise, fetch a standalone installer or install ``rustup`` from:
> +
> +	https://www.rust-lang.org
> +
> +
> +Rust standard library source
> +****************************
> +
> +The Rust standard library source is required because the build system will
> +cross-compile ``core`` and ``alloc``.
> +
> +If ``rustup`` is being used, run::
> +
> +	rustup component add rust-src
> +
> +The components are installed per toolchain, thus upgrading the Rust compiler
> +version later on requires re-adding the component.
> +
> +Otherwise, if a standalone installer is used, the Rust repository may be cloned
> +into the installation folder of the toolchain::
> +
> +	git clone --recurse-submodules \
> +		--branch $(scripts/min-tool-version.sh rustc) \
> +		https://github.com/rust-lang/rust \
> +		$(rustc --print sysroot)/lib/rustlib/src/rust
> +
> +In this case, upgrading the Rust compiler version later on requires manually
> +updating this clone.
> +
> +
> +libclang
> +********
> +
> +``libclang`` (part of LLVM) is used by ``bindgen`` to understand the C code
> +in the kernel, which means LLVM needs to be installed; like when the kernel
> +is compiled with ``CC=clang`` or ``LLVM=1``.
> +
> +Linux distributions are likely to have a suitable one available, so it is
> +best to check that first.
> +
> +There are also some binaries for several systems and architectures uploaded at:
> +
> +	https://releases.llvm.org/download.html
> +
> +Otherwise, building LLVM takes quite a while, but it is not a complex process:
> +
> +	https://llvm.org/docs/GettingStarted.html#getting-the-source-code-and-building-llvm
> +
> +See :ref:`Documentation/kbuild/llvm.rst <kbuild_llvm>` for more information and
   See Documentation/kbuild/llvm.rst for more information and

> +further ways to fetch pre-built releases and distribution packages.
> +
> +
> +bindgen
> +*******
> +
> +The bindings to the C side of the kernel are generated at build time using
> +the ``bindgen`` tool. A particular version is required.
> +
> +Install it via (note that this will download and build the tool from source)::
> +
> +	cargo install --locked --version $(scripts/min-tool-version.sh bindgen) bindgen
> +
> +
> +Requirements: Developing
> +------------------------
> +
> +This section explains how to fetch the tools needed for developing. That is,
> +they are not needed when just building the kernel.
> +
> +
> +rustfmt
> +*******
> +
> +The ``rustfmt`` tool is used to automatically format all the Rust kernel code,
> +including the generated C bindings (for details, please see
> +:ref:`Documentation/rust/coding-guidelines.rst <rust_coding_guidelines>`).
   Documentation/rust/coding-guidelines.rst).

> +
> +If ``rustup`` is being used, its ``default`` profile already installs the tool,
> +thus nothing needs to be done. If another profile is being used, the component
> +can be installed manually::
> +
> +	rustup component add rustfmt
> +
> +The standalone installers also come with ``rustfmt``.
> +
> +
> +clippy
> +******
> +
> +``clippy`` is a Rust linter. Running it provides extra warnings for Rust code.
> +It can be run by passing ``CLIPPY=1`` to ``make`` (for details, please see
> +:ref:`Documentation/rust/general-information.rst <rust_general_information>`).
   Documentation/rust/general-information.rst).

> +
> +If ``rustup`` is being used, its ``default`` profile already installs the tool,
> +thus nothing needs to be done. If another profile is being used, the component
> +can be installed manually::
> +
> +	rustup component add clippy
> +
> +The standalone installers also come with ``clippy``.
> +
> +
> +cargo
> +*****
> +
> +``cargo`` is the Rust native build system. It is currently required to run
> +the tests since it is used to build a custom standard library that contains
> +the facilities provided by the custom ``alloc`` in the kernel. The tests can
> +be run using the ``rusttest`` Make target.
> +
> +If ``rustup`` is being used, all the profiles already install the tool,
> +thus nothing needs to be done.
> +
> +The standalone installers also come with ``cargo``.
> +
> +
> +rustdoc
> +*******
> +
> +``rustdoc`` is the documentation tool for Rust. It generates pretty HTML
> +documentation for Rust code (for details, please see
> +:ref:`Documentation/rust/general-information.rst <rust_general_information>`).
   Documentation/rust/general-information.rst).

> +
> +``rustdoc`` is also used to test the examples provided in documented Rust code
> +(called doctests or documentation tests). The ``rusttest`` Make target uses
> +this feature.
> +
> +If ``rustup`` is being used, all the profiles already install the tool,
> +thus nothing needs to be done.
> +
> +The standalone installers also come with ``rustdoc``.
> +
> +
> +rust-analyzer
> +*************
> +
> +The `rust-analyzer <https://rust-analyzer.github.io/>`_ language server can
> +be used with many editors to enable syntax highlighting, completion, go to
> +definition, and other features.
> +
> +``rust-analyzer`` needs a configuration file, ``rust-project.json``, which
> +can be generated by the ``rust-analyzer`` Make target.
> +
> +
> +Configuration
> +-------------
> +
> +``Rust support`` (``CONFIG_RUST``) needs to be enabled in the ``General setup``
> +menu. The option is only shown if a suitable Rust toolchain is found (see
> +above). In turn, this will make visible the rest of options that depend on Rust.
> +
> +Afterwards, go to::
> +
> +	Kernel hacking
> +	    -> Sample kernel code
> +	        -> Rust samples
> +
> +And enable some sample modules either as built-in or as loadable.
> +
> +
> +Building
> +--------
> +
> +Building a kernel with a complete LLVM toolchain is the best supported setup
> +at the moment. That is::
> +
> +	make LLVM=1
> +
> +For architectures that do not support a full LLVM toolchain, use::
> +
> +	make CC=clang
> +
> +Using GCC also works for some configurations, but it is very experimental at
> +the moment.
> +
> +
> +Hacking
> +-------
> +
> +To dive deeper, take a look at the source code of the samples
> +at ``samples/rust/``, the Rust support code under ``rust/`` and
> +the ``Rust hacking`` menu under ``Kernel hacking``.
> +
> +If GDB/Binutils is used and Rust symbols are not getting demangled, the reason
> +is the toolchain does not support Rust's new v0 mangling scheme yet.
> +There are a few ways out:
> +
> +  - Install a newer release (GDB >= 10.2, Binutils >= 2.36).
> +
> +  - Some versions of GDB (e.g. vanilla GDB 10.1) are able to use
> +    the pre-demangled names embedded in the debug info (``CONFIG_DEBUG_INFO``).
> -- 
> 2.35.1
> 

Notes:

Those cross-references of plain path such as

   Documentation/rust/general-information.rst

are recognized when you build by the top level "make htmldocs".
If you specify a subdirectory by "make SPHINXDIRS=rust htmldocs",
current build script can't recognize them.  This is one of (not
widely recognized) issues in subdirectory handling of automarkup.py.
Hopefully, they can be resolved soon.

Tags at the top of .rst files are redundant and should be avoided.
Existing ones can be removed after referencing sites are updated.

        Thanks, Akira
