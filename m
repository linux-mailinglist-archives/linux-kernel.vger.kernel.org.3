Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476904B8A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiBPNhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:37:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiBPNhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:37:42 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03211CF3D3;
        Wed, 16 Feb 2022 05:37:29 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 132so2186103pga.5;
        Wed, 16 Feb 2022 05:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jbgmIPg6mcyI2bdNGcYen9hRXeYps+4u66vJjpSYCqo=;
        b=g0LvFcpYfc7oKzhMCRk4i2KsbfqpzVePasSnwqlU1nMbV74KVDB+36AJlyTA2496qO
         ZLEg2wfYwmi6/m+xpsunl5atpaURPymBGg3xp9CCJHisBmPeAUWPRQiZFiLA44/FTPhz
         YN4OVsCAtztUE+uyycA6/o2qyQvjr7gNzVIt62amLCi64Zfd61aDSmPGFB2gkdDfolHU
         OUYycYU0mSgAPYLCG+HkvJ6cc5hBepOhzSV/UkEp/IkMnN2QFU9kCm48KKs8refwK3jS
         cbkdflky67qV5jZkthe7l/qsjMCTNwaGsDvcw/jYium4guNC3bkqhuLMxa1TxznE6Xs8
         stVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jbgmIPg6mcyI2bdNGcYen9hRXeYps+4u66vJjpSYCqo=;
        b=eaz5aDUDvsboQRt85GCAJx8xsbzAYxVxt0dMxFkdr1RVUzssdqRMj7FMM/6o+WP7hW
         4Fd4uGQGdaAsKhlag3l/Si+dGwuL3vgA8hz/hR2VJmUGanPkvKLVv3w/yHMP5oN5LiaM
         qwdoxDIS3KduB5u5zmMy50osAeFE67Cb9eprPsrVgp+Gsp4ty05nh1X0HAMQRXurGylq
         h6AU7p+AEasjgOkPCH1yA5fMPTEJhUK3vXgGMi70HdvN2AzuqA6pHXIjzvcqOO3BOeWx
         lLdInvfdbmHPQpDcZQCJkO8G0+p6ji5q/WM150MO5LRNQlMmKrIrPVItp06H+q0CxeiI
         EbZA==
X-Gm-Message-State: AOAM531pwGVwXDQlqZkNZaG9jZzX/0G1wXXKKyw+BvCci0+OAN8nN9Wg
        LmkqOhFn0qa+qSswbaEkSYU=
X-Google-Smtp-Source: ABdhPJx1pTSdzZkre30qEK6d3y5+GESeMMz+HFMsCtfOctCeFFiB6BeYdq9NpF2aEWPvz5qfWhHPNQ==
X-Received: by 2002:a05:6a00:244b:b0:4c9:319e:ecb7 with SMTP id d11-20020a056a00244b00b004c9319eecb7mr2805177pfj.58.1645018649260;
        Wed, 16 Feb 2022 05:37:29 -0800 (PST)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y20sm44412310pfi.78.2022.02.16.05.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 05:37:28 -0800 (PST)
Message-ID: <5d8e8c09-64ca-38cd-591d-c193d1c01c7e@gmail.com>
Date:   Wed, 16 Feb 2022 22:37:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 15/20] docs: add Rust documentation
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <20220212130410.6901-16-ojeda@kernel.org>
 <8baf7006-90ed-25b8-3005-69b5475215cf@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <8baf7006-90ed-25b8-3005-69b5475215cf@gmail.com>
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

[Dropped most CCs]

Hi Miguel.
I have a follow-up hint on cross referencing for you.  See below.

On Mon, 14 Feb 2022 19:47:36 +0900,
Akira Yokosawa wrote:
> Hi,
> 
> Please find inline comments WRT ReST-in-kereneldoc.
> 
> Jon, if I'm missing something, please enlighten me.
> 
> On Sat, 12 Feb 2022 14:03:41 +0100,
> Miguel Ojeda <ojeda@kernel.org> wrote:
[...]

>> diff --git a/Documentation/rust/general-information.rst b/Documentation/rust/general-information.rst
>> new file mode 100644
>> index 000000000000..9ee4c6994d08
>> --- /dev/null
>> +++ b/Documentation/rust/general-information.rst
>> @@ -0,0 +1,80 @@
>> +.. _rust_general_information:
> Unnecessary tag.
> 
>> +
>> +General Information
>> +===================
>> +
>> +This document contains useful information to know when working with
>> +the Rust support in the kernel.
>> +
>> +
>> +Code documentation
>> +------------------
>> +
>> +Rust kernel code is documented using ``rustdoc``, its built-in documentation
>> +generator.
>> +
>> +The generated HTML docs include integrated search, linked items (e.g. types,
>> +functions, constants), source code, etc. They may be read at (TODO: link when
>> +in mainline and generated alongside the rest of the documentation):
>> +
>> +	http://kernel.org/
>> +
>> +The docs can also be easily generated and read locally. This is quite fast
>> +(same order as compiling the code itself) and no special tools or environment
>> +are needed. This has the added advantage that they will be tailored to
>> +the particular kernel configuration used. To generate them, use the ``rustdoc``
>> +target with the same invocation used for compilation, e.g.::
>> +
>> +	make LLVM=1 rustdoc
>> +
>> +To read the docs locally in your web browser, run e.g.::
>> +
>> +	xdg-open rust/doc/kernel/index.html
>> +
>> +To learn about how to write the documentation, please see the coding guidelines
>> +at :ref:`Documentation/rust/coding-guidelines.rst <rust_coding_guidelines>`.
>    at Documentation/rust/coding-guidelines.rst.

Here, the cross reference is internal to Documentation/rust/.
In this case, a relative path works for both top and subdirectory level build.
So you can say:

    at coding-guidelines.rst.

> 
>> +
>> +
>> +Extra lints
>> +-----------
>> +
>> +While ``rustc`` is a very helpful compiler, some extra lints and analyses are
>> +available via ``clippy``, a Rust linter. To enable it, pass ``CLIPPY=1`` to
>> +the same invocation used for compilation, e.g.::
>> +
>> +	make LLVM=1 CLIPPY=1
>> +
>> +Please note that Clippy may change code generation, thus it should not be
>> +enabled while building a production kernel.
>> +
>> +
>> +Abstractions vs. bindings
>> +-------------------------
>> +
>> +Abstractions are Rust code wrapping kernel functionality from the C side.
>> +
>> +In order to use functions and types from the C side, bindings are created.
>> +Bindings are the declarations for Rust of those functions and types from
>> +the C side.
>> +
>> +For instance, one may write a ``Mutex`` abstraction in Rust which wraps
>> +a ``struct mutex`` from the C side and calls its functions through the bindings.
>> +
>> +Abstractions are not available for all the kernel internal APIs and concepts,
>> +but it is intended that coverage is expanded as time goes on. "Leaf" modules
>> +(e.g. drivers) should not use the C bindings directly. Instead, subsystems
>> +should provide as-safe-as-possible abstractions as needed.
>> +
>> +
>> +Conditional compilation
>> +-----------------------
>> +
>> +Rust code has access to conditional compilation based on the kernel
>> +configuration:
>> +
>> +.. code-block:: rust
>> +
>> +	#[cfg(CONFIG_X)]       // Enabled               (`y` or `m`)
>> +	#[cfg(CONFIG_X="y")]   // Enabled as a built-in (`y`)
>> +	#[cfg(CONFIG_X="m")]   // Enabled as a module   (`m`)
>> +	#[cfg(not(CONFIG_X))]  // Disabled
>> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
>> new file mode 100644
>> index 000000000000..6e20af5b723a
>> --- /dev/null
>> +++ b/Documentation/rust/index.rst
>> @@ -0,0 +1,21 @@
>> +Rust
>> +====
>> +
>> +Documentation related to Rust within the kernel. To start using Rust
>> +in the kernel, please read the
>> +:ref:`Documentation/rust/quick-start.rst <rust_quick_start>` guide.
>    in the kernel, please read the guide in Documentation/rust/quick-start.rst.
    in the kernel, please read the guide in quick-start.rst.

, and so on.

        Thanks, Akira

[...]
> 
> 
> Notes:
> 
> Those cross-references of plain path such as
> 
>    Documentation/rust/general-information.rst
> 
> are recognized when you build by the top level "make htmldocs".
> If you specify a subdirectory by "make SPHINXDIRS=rust htmldocs",
> current build script can't recognize them.  This is one of (not
> widely recognized) issues in subdirectory handling of automarkup.py.
> Hopefully, they can be resolved soon.
> 
> Tags at the top of .rst files are redundant and should be avoided.
> Existing ones can be removed after referencing sites are updated.
> 
>         Thanks, Akira
