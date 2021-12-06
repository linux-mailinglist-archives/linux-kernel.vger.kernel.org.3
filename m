Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421DF4697F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 15:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240280AbhLFOKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 09:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245351AbhLFOJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:09:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949C1C0698C0;
        Mon,  6 Dec 2021 06:06:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D92EB810DE;
        Mon,  6 Dec 2021 14:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CDBC341D5;
        Mon,  6 Dec 2021 14:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638799568;
        bh=brvxIIBIDzX4uYqqB46LB4irz1I3UUXRbjW7q6y/1qM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOgJUYU00cU9l0K/DJCpN6u5sB3vsjVcCJ1uGEZx+Y3bXd7UufKJHyPA6o8RmC3fD
         zmsR30EUhDZu2VC+6yjFgLj195rfZTnRN3tj+Qus0i0IYoZY0XBQ6zrDF8kDhSRv6h
         jsTxqBdJG5pWXSn4fxDD8Kt/GBNd1TL1inI6CHtHdTgAkw64xvX/zgIGPVK82O6KZk
         9ptJ6YrsYmAC+htcP4J072LFkun/nG2/P4x5B+oPuJfnK/v0Yj7nwAbWlZhhXK6K4O
         8DksjJuyDT9v4ffQkQTUTsR8agj1YsPJzkTTtqD8r/ksSmC+mo+fLdhmnoAhb3QKR1
         z/I4AR6imAJLg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>, Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Yuki Okushi <jtitor@2k36.org>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 14/19] docs: add Rust documentation
Date:   Mon,  6 Dec 2021 15:03:08 +0100
Message-Id: <20211206140313.5653-15-ojeda@kernel.org>
In-Reply-To: <20211206140313.5653-1-ojeda@kernel.org>
References: <20211206140313.5653-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the documentation for Rust is written within the source code
itself, as it is idiomatic for Rust projects. This applies to both
the shared infrastructure at `rust/` as well as any other Rust module
(e.g. drivers) written across the kernel.

However, these documents contain general information that does not
fit particularly well in the source code, like the Quick Start guide.

It also contains a few binary assets used for the `rustdoc` target
and a few other small changes elsewhere in the documentation folder.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Wu XiangCheng <bobwxc@email.cn>
Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Co-developed-by: Yuki Okushi <jtitor@2k36.org>
Signed-off-by: Yuki Okushi <jtitor@2k36.org>
Co-developed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/doc-guide/kernel-doc.rst      |   3 +
 Documentation/index.rst                     |   1 +
 Documentation/kbuild/kbuild.rst             |   4 +
 Documentation/process/changes.rst           |  13 ++
 Documentation/rust/arch-support.rst         |  35 ++++
 Documentation/rust/assets/favicon-16x16.png | Bin 0 -> 798 bytes
 Documentation/rust/assets/favicon-32x32.png | Bin 0 -> 2076 bytes
 Documentation/rust/assets/rust-logo.png     | Bin 0 -> 53976 bytes
 Documentation/rust/coding.rst               |  91 +++++++++
 Documentation/rust/docs.rst                 | 101 ++++++++++
 Documentation/rust/index.rst                |  21 ++
 Documentation/rust/quick-start.rst          | 212 ++++++++++++++++++++
 12 files changed, 481 insertions(+)
 create mode 100644 Documentation/rust/arch-support.rst
 create mode 100644 Documentation/rust/assets/favicon-16x16.png
 create mode 100644 Documentation/rust/assets/favicon-32x32.png
 create mode 100644 Documentation/rust/assets/rust-logo.png
 create mode 100644 Documentation/rust/coding.rst
 create mode 100644 Documentation/rust/docs.rst
 create mode 100644 Documentation/rust/index.rst
 create mode 100644 Documentation/rust/quick-start.rst

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 79aaa55d6bcf..724e2ffddff1 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -11,6 +11,9 @@ when it is embedded in source files.
    reasons. The kernel source contains tens of thousands of kernel-doc
    comments. Please stick to the style described here.
 
+.. note:: kernel-doc does not cover Rust code: please see
+   Documentation/rust/docs.rst instead.
+
 The kernel-doc structure is extracted from the comments, and proper
 `Sphinx C Domain`_ function and type descriptions with anchors are
 generated from them. The descriptions are filtered for special kernel-doc
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 54ce34fd6fbd..1b13c2445e87 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -82,6 +82,7 @@ merged much easier.
    maintainer/index
    fault-injection/index
    livepatch/index
+   rust/index
 
 
 Kernel API documentation
diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 2d1fc03d346e..468a0d216c29 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -57,6 +57,10 @@ CFLAGS_MODULE
 -------------
 Additional module specific options to use for $(CC).
 
+KRUSTFLAGS
+----------
+Additional options to the Rust compiler (for built-in and modules).
+
 LDFLAGS_MODULE
 --------------
 Additional options used for $(LD) when linking modules.
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index b398b8576417..9f11bd5aee96 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -26,11 +26,18 @@ running a Linux kernel.  Also, not all tools are necessary on all
 systems; obviously, if you don't have any PC Card hardware, for example,
 you probably needn't concern yourself with pcmciautils.
 
+Furthermore, note that newer versions of the Rust toolchain may or may not work
+because, for the moment, we depend on some unstable features. Thus, unless you
+know what you are doing, use the exact version listed here. Please see
+:ref:`Documentation/rust/quick-start.rst <rust_quick_start>` for details.
+
 ====================== ===============  ========================================
         Program        Minimal version       Command to check the version
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  10.0.1           clang --version
+rustc (optional)       1.57.0           rustc --version
+bindgen (optional)     0.56.0           bindgen --version
 GNU make               3.81             make --version
 binutils               2.23             ld -v
 flex                   2.5.35           flex --version
@@ -329,6 +336,12 @@ Sphinx
 Please see :ref:`sphinx_install` in :ref:`Documentation/doc-guide/sphinx.rst <sphinxdoc>`
 for details about Sphinx requirements.
 
+rustdoc
+-------
+
+``rustdoc`` is used to generate Rust documentation. Please see
+:ref:`Documentation/rust/docs.rst <rust_docs>` for more information.
+
 Getting updated software
 ========================
 
diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
new file mode 100644
index 000000000000..fdcce6452623
--- /dev/null
+++ b/Documentation/rust/arch-support.rst
@@ -0,0 +1,35 @@
+.. _rust_arch_support:
+
+Arch Support
+============
+
+Currently, the Rust compiler (``rustc``) uses LLVM for code generation,
+which limits the supported architectures that can be targeted. In addition,
+support for building the kernel with LLVM/Clang varies (see :ref:`kbuild_llvm`).
+This support is needed for ``bindgen`` which uses ``libclang``.
+
+Below is a general summary of architectures that currently work. Level of
+support corresponds to ``S`` values in the ``MAINTAINERS`` file.
+
+.. list-table::
+   :widths: 10 10 10
+   :header-rows: 1
+
+   * - Architecture
+     - Level of support
+     - Constraints
+   * - ``arm``
+     - Maintained
+     - ``armv6`` and compatible only, ``RUST_OPT_LEVEL >= 2``
+   * - ``arm64``
+     - Maintained
+     - None
+   * - ``powerpc``
+     - Maintained
+     - ``ppc64le`` only, ``RUST_OPT_LEVEL < 2`` requires ``CONFIG_THREAD_SHIFT=15``
+   * - ``riscv``
+     - Maintained
+     - ``riscv64`` only
+   * - ``x86``
+     - Maintained
+     - ``x86_64`` only
diff --git a/Documentation/rust/assets/favicon-16x16.png b/Documentation/rust/assets/favicon-16x16.png
new file mode 100644
index 0000000000000000000000000000000000000000..d93115e8f47a939635b73ad3b3226837f83f7584
GIT binary patch
literal 798
zcmV+(1L6FMP)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV00006VoOIv0RI60
z0RN!9r;`8x0@F!EK~y-6ZIMf8lxGx%pYwg+WHOhSacUA1ouC<$$uN<cj8>60Bw|2Q
zLBXm~u^5_#D=(`S=^_iY%Mx4&QgPv>=t9NnMoV2tLKM_ms)9Af%fw5(#7W1=T>klg
z7yT{L`Yg|R59hq^5&lmV5CyuFQk4L<ZKr{YzzFc-BQyWf4h#T~L1jdAp|Ubm@cI0i
ze`*Z4nvb#$xC~@P<Z37s&iecn&b)a|P9P900Dk~kSF`T@kp5uvZlDd=6Ao7&{jz)6
z>O^dYzb*M0snm08V&e67;5T5iYw;fNPy^F}ZNPfK0%jMB`BiI{q-%F<$tb^i%%!2%
z=H<jxHE;sB4fFvS;EDobzzVl94m6ZXcFfXsX7W`fb+up6)VzT5a$g6q4@d#O1KmJO
z1K$8i;8)-R5Q#>kHQ)9hU`E4w8WwDzSQ5^j{RP{$p90T-9FPFg3J3zVz#ZUcfX>bi
z7A;yxeM1~$49R3G@pv=Fc*1TDf4T3TrT_sPU=(;8iPWo&8+$OuAOc!zT3TA@?cGW+
z7>p@pRs+p|0vrRR0UOu~e4a?mpOs7|DU~ch5D~QY(Ae0Bhyc<DgxtU<jqAG)_$pc_
zEN=0lly(n$PmxmY2_ixuP!`GjUBrP$zy%Fty&kGJEjLU0d&_8@Gsc-qX`-<t!C(Lp
zMK+ycZ1{WbjigxH;p5i*JW~bdFmPG}xw$iO26lQoTbs?a=|PL@*KaT>t;FLAM1-5y
z2Kgj+hMr}b_BJnN;yk!=JO5*`#Ge}A_;>#7>}u)p7^<{}rih2JH?=%?W^?ZRc@FOX
zfv!*AP*de$e7x{#Zj~JBuFoDhc9oI<oZN-4W>(osf4OvsN0v@aIZeBNvb@80Jz^D$
z%nUi!p0EA+aD^Hjx|7=*m|r;E-;d3Ik^-QoorqB;acbCFn$6(@P>M`f!VHEg^yrD9
c{K$v;cZ2KTr4Y@#wEzGB07*qoM6N<$f+87m)&Kwi

literal 0
HcmV?d00001

diff --git a/Documentation/rust/assets/favicon-32x32.png b/Documentation/rust/assets/favicon-32x32.png
new file mode 100644
index 0000000000000000000000000000000000000000..655ccbcfc8cddde1e9c7d826a3f44c1e056b1dc8
GIT binary patch
literal 2076
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
GLSTYjg4{d+

literal 0
HcmV?d00001

diff --git a/Documentation/rust/assets/rust-logo.png b/Documentation/rust/assets/rust-logo.png
new file mode 100644
index 0000000000000000000000000000000000000000..081ae80c193ba259ffc5c506ccefc4cedd915c4b
GIT binary patch
literal 53976
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
WKU7`}H-hE>0000<MNUMnLSTZyHLE88

literal 0
HcmV?d00001

diff --git a/Documentation/rust/coding.rst b/Documentation/rust/coding.rst
new file mode 100644
index 000000000000..1a8f14713edd
--- /dev/null
+++ b/Documentation/rust/coding.rst
@@ -0,0 +1,91 @@
+.. _rust_coding:
+
+Coding
+======
+
+This document describes how to write Rust code in the kernel.
+
+
+Coding style
+------------
+
+The code should be formatted using ``rustfmt``. In this way, a person
+contributing from time to time to the kernel does not need to learn and
+remember one more style guide. More importantly, reviewers and maintainers
+do not need to spend time pointing out style issues anymore, and thus
+less patch roundtrips may be needed to land a change.
+
+.. note:: Conventions on comments and documentation are not checked by
+  ``rustfmt``. Thus those are still needed to be taken care of: please see
+  :ref:`Documentation/rust/docs.rst <rust_docs>`.
+
+The default settings of ``rustfmt`` are used. This means the idiomatic Rust
+style is followed. For instance, 4 spaces are used for indentation rather
+than tabs.
+
+It is convenient to instruct editors/IDEs to format while typing,
+when saving or at commit time. However, if for some reason reformatting
+the entire kernel Rust sources is needed at some point, the following can be
+run::
+
+	make LLVM=1 rustfmt
+
+It is also possible to check if everything is formatted (printing a diff
+otherwise), for instance for a CI, with::
+
+	make LLVM=1 rustfmtcheck
+
+Like ``clang-format`` for the rest of the kernel, ``rustfmt`` works on
+individual files, and does not require a kernel configuration. Sometimes it may
+even work with broken code.
+
+
+Extra lints
+-----------
+
+While ``rustc`` is a very helpful compiler, some extra lints and analyses are
+available via ``clippy``, a Rust linter. To enable it, pass ``CLIPPY=1`` to
+the same invocation used for compilation, e.g.::
+
+	make LLVM=1 CLIPPY=1
+
+Please note that Clippy may change code generation, thus it should not be
+enabled while building a production kernel.
+
+
+Abstractions vs. bindings
+-------------------------
+
+Abstractions are Rust code wrapping kernel functionality from the C side.
+
+In order to use functions and types from the C side, bindings are created.
+Bindings are the declarations for Rust of those functions and types from
+the C side.
+
+For instance, one may write a ``Mutex`` abstraction in Rust which wraps
+a ``struct mutex`` from the C side and calls its functions through the bindings.
+
+Abstractions are not available for all the kernel internal APIs and concepts,
+but it is intended that coverage is expanded as time goes on. "Leaf" modules
+(e.g. drivers) should not use the C bindings directly. Instead, subsystems
+should provide as-safe-as-possible abstractions as needed.
+
+
+Conditional compilation
+-----------------------
+
+Rust code has access to conditional compilation based on the kernel
+configuration:
+
+.. code-block:: rust
+
+	#[cfg(CONFIG_X)]       // Enabled               (`y` or `m`)
+	#[cfg(CONFIG_X="y")]   // Enabled as a built-in (`y`)
+	#[cfg(CONFIG_X="m")]   // Enabled as a module   (`m`)
+	#[cfg(not(CONFIG_X))]  // Disabled
+
+
+Documentation
+-------------
+
+Please see :ref:`Documentation/rust/docs.rst <rust_docs>`.
diff --git a/Documentation/rust/docs.rst b/Documentation/rust/docs.rst
new file mode 100644
index 000000000000..b2f4bbe5d490
--- /dev/null
+++ b/Documentation/rust/docs.rst
@@ -0,0 +1,101 @@
+.. _rust_docs:
+
+Docs
+====
+
+This document describes how to make the most out of the kernel documentation
+for Rust.
+
+Rust kernel code is not documented like C kernel code (i.e. via kernel-doc).
+Instead, the usual system for documenting Rust code is used: the ``rustdoc``
+tool, which uses Markdown (a lightweight markup language).
+
+To learn Markdown, there are many guides available out there. For instance,
+the one at:
+
+	https://commonmark.org/help/
+
+
+Reading the docs
+----------------
+
+The generated HTML docs produced by ``rustdoc`` include integrated search,
+linked items (e.g. types, functions, constants), source code, etc.
+
+The generated docs may be read at (TODO: link when in mainline and generated
+alongside the rest of the documentation):
+
+	http://kernel.org/
+
+The docs can also be easily generated and read locally. This is quite fast
+(same order as compiling the code itself) and no special tools or environment
+are needed. This has the added advantage that they will be tailored to
+the particular kernel configuration used. To generate them, use the ``rustdoc``
+target with the same invocation used for compilation, e.g.::
+
+	make LLVM=1 rustdoc
+
+
+Writing the docs
+----------------
+
+This is how a well-documented Rust function may look like::
+
+	/// Returns the contained [`Some`] value, consuming the `self` value,
+	/// without checking that the value is not [`None`].
+	///
+	/// # Safety
+	///
+	/// Calling this method on [`None`] is *[undefined behavior]*.
+	///
+	/// [undefined behavior]: https://doc.rust-lang.org/reference/behavior-considered-undefined.html
+	///
+	/// # Examples
+	///
+	/// ```
+	/// let x = Some("air");
+	/// assert_eq!(unsafe { x.unwrap_unchecked() }, "air");
+	/// ```
+	pub unsafe fn unwrap_unchecked(self) -> T {
+		match self {
+			Some(val) => val,
+
+			// SAFETY: the safety contract must be upheld by the caller.
+			None => unsafe { hint::unreachable_unchecked() },
+		}
+	}
+
+This example showcases a few ``rustdoc`` features and some conventions followed
+in the kernel:
+
+  - The first paragraph must be a single sentence briefly describing what
+    the documented item does. Further explanations must go in extra paragraphs.
+
+  - Unsafe functions must document their safety preconditions under
+    a ``# Safety`` section.
+
+  - While not shown here, if a function may panic, the conditions under which
+    that happens must be described under a ``# Panics`` section.
+
+    Please note that panicking should be very rare and used only with a good
+    reason. In almost all cases, a fallible approach should be used, typically
+    returning a ``Result``.
+
+  - If providing examples of usage would help readers, they must be written in
+    a section called ``# Examples``.
+
+  - Rust items (functions, types, constants...) must be linked appropriately
+    (``rustdoc`` will create a link automatically).
+
+  - Any ``unsafe`` block must be preceded by a ``// SAFETY:`` comment
+    describing why the code inside is sound.
+
+    While sometimes the reason might look trivial and therefore unneeded, writing
+    these comments is not just a good way of documenting what has been taken into
+    account, but most importantly, it provides a way to know that there are
+    no *extra* implicit constraints.
+
+To learn more about how to write documentation for Rust and extra features,
+please take a look at the ``rustdoc`` `book`_.
+
+.. _book: https://doc.rust-lang.org/rustdoc/how-to-write-documentation.html
diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
new file mode 100644
index 000000000000..906a7d698c50
--- /dev/null
+++ b/Documentation/rust/index.rst
@@ -0,0 +1,21 @@
+Rust
+====
+
+Documentation related to Rust within the kernel. To start using Rust
+in the kernel, please read the
+:ref:`Documentation/rust/quick-start.rst <rust_quick_start>` guide.
+
+.. toctree::
+    :maxdepth: 1
+
+    quick-start
+    coding
+    docs
+    arch-support
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
new file mode 100644
index 000000000000..5712b1a5dbdb
--- /dev/null
+++ b/Documentation/rust/quick-start.rst
@@ -0,0 +1,212 @@
+.. _rust_quick_start:
+
+Quick Start
+===========
+
+This document describes how to get started with kernel development in Rust.
+
+
+Requirements: Building
+----------------------
+
+This section explains how to fetch the tools needed for building.
+
+Some of these requirements might be available from Linux distributions
+under names like ``rustc``, ``rust-src``, ``rust-bindgen``, etc. However,
+at the time of writing, they are likely not to be recent enough.
+
+
+rustc
+*****
+
+A particular version of the Rust compiler is required. Newer versions may or
+may not work because, for the moment, the kernel depends on some unstable
+Rust features.
+
+If ``rustup`` is being used, enter the checked out source code directory
+and run::
+
+	rustup override set 1.57.0
+
+Otherwise, fetch a standalone installer or install ``rustup`` from:
+
+	https://www.rust-lang.org
+
+
+Rust standard library source
+****************************
+
+The Rust standard library source is required because the build system will
+cross-compile ``core`` and ``alloc``.
+
+If ``rustup`` is being used, run::
+
+	rustup component add rust-src
+
+Otherwise, if a standalone installer is used, the Rust repository may be cloned
+into the installation folder of the toolchain::
+
+	git clone --recurse-submodules https://github.com/rust-lang/rust $(rustc --print sysroot)/lib/rustlib/src/rust
+
+
+libclang
+********
+
+``libclang`` (part of LLVM) is used by ``bindgen`` to understand the C code
+in the kernel, which means LLVM needs to be installed; like when the kernel
+is compiled with ``CC=clang`` or ``LLVM=1``.
+
+Linux distributions are likely to have a suitable one available, so it is
+best to check that first.
+
+There are also some binaries for several systems and architectures uploaded at:
+
+	https://releases.llvm.org/download.html
+
+Otherwise, building LLVM takes quite a while, but it is not a complex process:
+
+	https://llvm.org/docs/GettingStarted.html#getting-the-source-code-and-building-llvm
+
+See Documentation/kbuild/llvm.rst for more information and further ways
+to fetch pre-built releases and distribution packages.
+
+
+bindgen
+*******
+
+The bindings to the C side of the kernel are generated at build time using
+the ``bindgen`` tool. A particular version is required.
+
+Install it via (note that this will download and build the tool from source)::
+
+	cargo install --locked --version 0.56.0 bindgen
+
+
+Requirements: Developing
+------------------------
+
+This section explains how to fetch the tools needed for developing. That is,
+they are not needed when just building the kernel.
+
+
+rustfmt
+*******
+
+The ``rustfmt`` tool is used to automatically format all the Rust kernel code,
+including the generated C bindings (for details, please see
+:ref:`Documentation/rust/coding.rst <rust_coding>`).
+
+If ``rustup`` is being used, its ``default`` profile already installs the tool,
+thus nothing needs to be done. If another profile is being used, the component
+can be installed manually::
+
+	rustup component add rustfmt
+
+The standalone installers also come with ``rustfmt``.
+
+
+clippy
+******
+
+``clippy`` is a Rust linter. Running it provides extra warnings for Rust code.
+It can be run by passing ``CLIPPY=1`` to ``make`` (for details, please see
+:ref:`Documentation/rust/coding.rst <rust_coding>`).
+
+If ``rustup`` is being used, its ``default`` profile already installs the tool,
+thus nothing needs to be done. If another profile is being used, the component
+can be installed manually::
+
+	rustup component add clippy
+
+The standalone installers also come with ``clippy``.
+
+
+cargo
+*****
+
+``cargo`` is the Rust native build system. It is currently required to run
+the tests since it is used to build a custom standard library that contains
+the facilities provided by the custom ``alloc`` in the kernel. The tests can
+be run using the ``rusttest`` Make target.
+
+If ``rustup`` is being used, all the profiles already install the tool,
+thus nothing needs to be done.
+
+The standalone installers also come with ``cargo``.
+
+
+rustdoc
+*******
+
+``rustdoc`` is the documentation tool for Rust. It generates pretty HTML
+documentation for Rust code (for details, please see
+:ref:`Documentation/rust/docs.rst <rust_docs>`).
+
+``rustdoc`` is also used to test the examples provided in documented Rust code
+(called doctests or documentation tests). The ``rusttest`` Make target uses
+this feature.
+
+If ``rustup`` is being used, all the profiles already install the tool,
+thus nothing needs to be done.
+
+The standalone installers also come with ``rustdoc``.
+
+
+rust-analyzer
+*************
+
+The `rust-analyzer <https://rust-analyzer.github.io/>`_ language server can
+be used with many editors to enable syntax highlighting, completion, go to
+definition, and other features.
+
+``rust-analyzer`` needs a configuration file, ``rust-project.json``, which
+can be generated by the ``rust-analyzer`` Make target.
+
+
+Configuration
+-------------
+
+``Rust support`` (``CONFIG_RUST``) needs to be enabled in the ``General setup``
+menu. The option is only shown if the build system can locate ``rustc``.
+In turn, this will make visible the rest of options that depend on Rust.
+
+Afterwards, go to::
+
+	Kernel hacking
+	    -> Sample kernel code
+	        -> Rust samples
+
+And enable some sample modules either as built-in or as loadable.
+
+
+Building
+--------
+
+Building a kernel with a complete LLVM toolchain is the best supported setup
+at the moment. That is::
+
+	make LLVM=1
+
+For architectures that do not support a full LLVM toolchain, use::
+
+	make CC=clang
+
+Using GCC also works for some configurations, but it is very experimental at
+the moment.
+
+
+Hacking
+-------
+
+To dive deeper, take a look at the source code of the samples
+at ``samples/rust/``, the Rust support code under ``rust/`` and
+the ``Rust hacking`` menu under ``Kernel hacking``.
+
+If GDB/Binutils is used and Rust symbols are not getting demangled, the reason
+is the toolchain does not support Rust's new v0 mangling scheme yet.
+There are a few ways out:
+
+  - Install a newer release (GDB >= 10.2, Binutils >= 2.36).
+
+  - Some versions of GDB (e.g. vanilla GDB 10.1) are able to use
+    the pre-demangled names embedded in the debug info (``CONFIG_DEBUG_INFO``).
-- 
2.34.0

