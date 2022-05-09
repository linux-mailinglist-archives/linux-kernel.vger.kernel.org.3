Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9843651F333
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiEIELC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiEIEGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:06:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E39AAE11;
        Sun,  8 May 2022 21:02:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so15889631pjb.5;
        Sun, 08 May 2022 21:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=6eVdKKgpvfyr2lmpaU0Ls6K7vbdJu1m0KcXbrbuObD4=;
        b=hH9sLId90RXxnTi03TtWtlGJZ1l/Or77bFTq/1LTS58C6VV0qLI8aEiWCouxiw7nCu
         cNelI42+zINXLWLY4N2N+Yx9V5wPAWUBw6BFpqDF2Ls418gcH+2Y4PQUOCk9Z3QL7dht
         4Oo6peOgjs9uz+HQ082wOBwyCvoXZ3SB4G1tns26nTuo5YVaXTWzcC8m/aCIt5cFBKJO
         ASK1sbsPRMTeZboQd2sTCfqgUDtJclwZe5XchholeXN81NEKdipA4p//JTIV5TbNIEx8
         Tc/SddLxDMB3axqNMr1xF0r/3a6HJDAC7Xt5pOlUfYzAnpCIejjrwRnQmp4QK9cJRYVd
         CBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=6eVdKKgpvfyr2lmpaU0Ls6K7vbdJu1m0KcXbrbuObD4=;
        b=RHE7nX/FKXzbbGHTjYUubE45AhZN13jNp2z+dzqnguMRvsEkrM3Fr4cF7mQOI9ro7Z
         dsGrsrllrUKnnxnYSbKtRQRC2kz4tTiJoXwW2e+XPF4GfjDmznAbiteZXqF3fHeSqnOh
         vw9x9GOA6fbPjLJfTu+4463cp+AyMYiTDEIBIumvHD3ZRx3cH8QKlk7pO4X6uP32qrhr
         iabVRvmYJQ7HngN2ZNUnnmuNI/d4BdM/aZeBD/yVvbQerw65mMGaRPToyJo1sKUZqZVT
         jwZuQrWzPWQAQgpNq3rPLYEhFYCnTYHgOW7fH0IN84BpFwqYvc28bEmg9xqNC7u835zD
         7FQQ==
X-Gm-Message-State: AOAM5331V+ZCD0p58AHFfkAtDzl81FuaQ4lCjBgBvJDRm0uDven/QKKO
        pnTNSfU8Q6iLl5xOi9tWpfk=
X-Google-Smtp-Source: ABdhPJziN8xtoWqM0azviq6vE079XOSlMsdPagRnGq0woepZ5+g+K8ajQh6aD0zmIIZT3AJhh04bBA==
X-Received: by 2002:a17:90a:5886:b0:1dc:6b58:91e with SMTP id j6-20020a17090a588600b001dc6b58091emr16257395pji.176.1652068935509;
        Sun, 08 May 2022 21:02:15 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902dac100b0015e8d4eb2dfsm5873971plx.297.2022.05.08.21.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 21:02:14 -0700 (PDT)
Message-ID: <7e9c2e77-8b70-6e15-3f3d-905ab42b0fcd@gmail.com>
Date:   Mon, 9 May 2022 13:02:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
To:     ojeda@kernel.org
Cc:     alex.gaynor@gmail.com, ark.email@gmail.com, bobo1239@web.de,
        bobwxc@email.cn, corbet@lwn.net, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, jarkko@kernel.org, jtitor@2k36.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org, me@jvmerkle.de,
        me@kloenk.de, michal.lkml@markovi.net, mpe@ellerman.id.au,
        ndesaulniers@google.com, rust-for-linux@vger.kernel.org,
        thesven73@gmail.com, torvalds@linux-foundation.org,
        wedsonaf@google.com, wei.liu@kernel.org
References: <20220507052451.12890-19-ojeda@kernel.org>
Subject: Re: [PATCH v6 18/23] docs: add Rust documentation
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220507052451.12890-19-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miguel,

On Sat,  7 May 2022 07:24:16 +0200,
Miguel Ojeda wrote:
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
> Co-developed-by: Julian Merkle <me@jvmerkle.de>
> Signed-off-by: Julian Merkle <me@jvmerkle.de>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  Documentation/doc-guide/kernel-doc.rst     |   3 +
>  Documentation/index.rst                    |   1 +
>  Documentation/kbuild/kbuild.rst            |  17 +
>  Documentation/kbuild/makefiles.rst         |  50 ++-
>  Documentation/process/changes.rst          |  41 +++
>  Documentation/rust/arch-support.rst        |  34 ++
>  Documentation/rust/coding-guidelines.rst   | 214 ++++++++++++
>  Documentation/rust/general-information.rst |  77 +++++
>  Documentation/rust/index.rst               |  20 ++
>  Documentation/rust/logo.svg                | 357 +++++++++++++++++++++
I think you agreed splitting SVG part into its own patch with
a proper copying info, etc.  Let me see...  So, here is the link:

https://lore.kernel.org/lkml/CANiq72mLtvWJ5peSTpYQ8AeLEskga6Pda8Q7Daysv2pfycnyxA@mail.gmail.com/

I might have missed v5 of this patch series.
That might be because v5's 15/20 was not accepted by linux-doc's
lore archive (maybe) due to its size despite it had Cc: linux-doc.
v6's 18/23 was also rejected.

>  Documentation/rust/quick-start.rst         | 230 +++++++++++++
>  11 files changed, 1040 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/rust/arch-support.rst
>  create mode 100644 Documentation/rust/coding-guidelines.rst
>  create mode 100644 Documentation/rust/general-information.rst
>  create mode 100644 Documentation/rust/index.rst
>  create mode 100644 Documentation/rust/logo.svg
>  create mode 100644 Documentation/rust/quick-start.rst

I have some alternative ideas for table formatting in ReST.

> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
> new file mode 100644
> index 000000000000..482757a1f3d0
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
> +
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

Excerpt from Section "list tables" in
Documentation/doc-guide/sphinx.rst:

> The list-table formats can be useful for tables that are not easily laid
> out in the usual Sphinx ASCII-art formats.  These formats are nearly
> impossible for readers of the plain-text documents to understand, though,
> and should be avoided in the absence of a strong justification for their
> use.

So here are a couple of alternative ways to represent the table

* ASCII-art format:

============ ================ ==========================================
Architecture Level of support Constraints
============ ================ ==========================================
``arm``      Maintained       ``armv6`` and compatible only,
                              ``RUST_OPT_LEVEL >= 2``
``arm64``    Maintained       None
``powerpc``  Maintained       ``ppc64le`` only, ``RUST_OPT_LEVEL < 2``
                              requires ``CONFIG_THREAD_SHIFT=15``
``riscv``    Maintained       ``riscv64`` only
``x86``      Maintained       ``x86_64`` only
============ ================ ==========================================

* Literal block format:

::

 Architecture  Level of support  Constraints
 ------------  ----------------  -------------------------------------
 arm           Maintained        armv6 and compatible only,
                                 RUST_OPT_LEVEL >= 2
 arm64         Maintained        None
 powerpc       Maintained        ppc64le only, RUST_OPT_LEVEL < 2
                                 requires CONFIG_THREAD_SHIFT=15
 riscv         Maintained        riscv64 only
 x86           Maintained        x86_64 only


"::" above the table marks the start of a literal block.
Indents are important for la iteral block to work.
A literal block ends at a line which has the same indent as
the preceding paragraph, in this case with no indent, or at
the end of file.

As you see, those inline-literal markers of ``xxxx``, which are
distracting when the .rst file is read as plain-text, are not
necessary in the literal-block approach.  And you can directly
tweak line breaks in the Constraints column in the final HTML
and PDF docs.

In my opinion, the literal-block approach should be the most
reasonable choice here. Of course its your call which one
to choose.

        Thanks, Akira
