Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF85E5207CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiEIWh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiEIWhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:37:00 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739142B9C8B;
        Mon,  9 May 2022 15:32:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:3d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6B9FB732;
        Mon,  9 May 2022 22:32:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6B9FB732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1652135561; bh=HTkL9Ze4IkU4006Q8Vcgjjy6od50oft28ldpKD38Bhs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=O3uonuVfVJtCWD2RVlNSsfnyOcttu7utR7SmYzjdMc/k1sBtiqfE8PTepkpz2FSdz
         MIYyj3y8l/9zLf45BoHzjyYSpP1F2olpiwXfjgjIslOyLoRik3ynw4E/FUpO1d1DJh
         mw6i7t9/Y8qfCiGIm5Cx2B9NkunGgfZVURltzS0Q/g7rS817nX0qwkoXTTdrltmx1S
         O8/Oy41w4/xLsFfg/edw6omQJHxRoQat3BeWuQ+Q+cXxo+as6aD5xcu6wxyEHLnQpy
         xl0hOhszcjF3cucI2xUdf/mJ3S00Lebwz7/wpAq0bOhTkJOhH5gp0G7I62ywn9UNjr
         CFYTtcMzduvCw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wu XiangCheng <bobwxc@email.cn>, Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Yuki Okushi <jtitor@2k36.org>, Wei Liu <wei.liu@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, Julian Merkle <me@jvmerkle.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v6 18/23] docs: add Rust documentation
In-Reply-To: <20220507052451.12890-19-ojeda@kernel.org>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-19-ojeda@kernel.org>
Date:   Mon, 09 May 2022 16:32:40 -0600
Message-ID: <875ymecp6f.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <ojeda@kernel.org> writes:

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

Trying to take a closer look this time...

I foresee merge conflicts, but so it goes.  Trying to split this apart
would not make a lot of sense.

[...]

> --- /dev/null
> +++ b/Documentation/rust/arch-support.rst
> @@ -0,0 +1,34 @@
> +Arch Support
> +============
> +
> +Currently, the Rust compiler (``rustc``) uses LLVM for code generation,
> +which limits the supported architectures that can be targeted. In addition,
> +support for building the kernel with LLVM/Clang varies (please see
> +Documentation/kbuild/llvm.rst). This support is needed for ``bindgen``
> +which uses ``libclang``.
> +
> +Below is a general summary of architectures that currently work. Level of
> +support corresponds to ``S`` values in the ``MAINTAINERS`` file.
> +
> +.. list-table::
> +   :widths: 10 10 10
> +   :header-rows: 1

Please use normal tables rather than list-table; this kind of thing is
really unreadable in the source form.

> +   * - Architecture
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
> index 000000000000..2a71fd68a06d
> --- /dev/null
> +++ b/Documentation/rust/coding-guidelines.rst
> @@ -0,0 +1,214 @@
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

I foresee disagreements over coding style conventions in the
future... I don't plan to be part of that conversation :)

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

I will ask whether we want this, though.  Why would anybody want to
mass-reformat the entire body of kernel code?  This seems like something
that would generate an endless stream of "helpful" patches and a lot of
churn.

Thanks,

jon
