Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E821855C68E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbiF1FBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiF1FBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:01:05 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6602654A;
        Mon, 27 Jun 2022 22:01:03 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i7so20244514ybe.11;
        Mon, 27 Jun 2022 22:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rkzgZWeh0D6TjHr5N2qUjBjE8rUNExMUZg23IPB3kwY=;
        b=PxxHVSPFNpl+BQjxsXBQB05qfkO5aGBP9M/kJSHHOqXRcN8r3O1Df2h6iUwb5PC2Bt
         cTeXZswe0PgvW4thfx4oxgVcSt0r/PqxH1EB8VpW3TuocTfBH4Rhl32GFhvcYjyTF2VD
         xIksN75GE0w2ssAmzOOTp/hyujk49IDUsQUhrNMfvFS++YXRl9vsrBsG8a776MLE8NGy
         ai/bs1eAJjZ9PUWJ6wzzQYePFtJmwUEGdUqvL0rhjUMR8J2XNBoMt06fULJcuH9Zn2mR
         7zE1CwP4GR2MDt64eY1orjhDUi9dLLGX013PnpmjJelbXp9Z9Ms4n8K3KfYCZ2nOAJB6
         R5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rkzgZWeh0D6TjHr5N2qUjBjE8rUNExMUZg23IPB3kwY=;
        b=tGixsE+XmEbVej2hMsMpSBhFDMljMCxHoB3cSSYXn/CLudQsDyiT7JkBYDmoafOvqW
         1qaRylywrKs34v+LXoF9ui+0Xu83e0+7Ni4tHPQUW2BFc6zmcTFEnCg/AxmCQcLjHblg
         LLRSx9SInK7/8bJQRSRUTlShrWbe3IYu2nqteRAsDpbWOW9EIzT9aFpY3Lkso1GsXdf6
         t+dvNpsdrqFUmkWGMIcn7y8CRdNupMMT9vigZHiCetzMQxH4myLdMjES5Qzi9Tlnj2f6
         1nKnjWKk3Irz0WvQxfDx5fRP410jXTRcB2JNOwSE6JeOC5QR3yelMJyhKD2EDsQG98ob
         sfSw==
X-Gm-Message-State: AJIora9+WepM1nsAauKtkWqt1jvGrv2O0vnVCHpGG6UqgDHXgn9Gpvqe
        BrXndlAapNxKCJGlkflYdMVdXeA0FCj970Yhqe3u+4fB
X-Google-Smtp-Source: AGRyM1uVWY/GnX0gegO/2S+3H6diz7nn7VGhC9qnYEcHfiGC1SWQ25UBl6R9cSegldH2sqbp6uoqBZ6q9BYUp2X6dGg=
X-Received: by 2002:a05:6902:1544:b0:66d:3948:da54 with SMTP id
 r4-20020a056902154400b0066d3948da54mr206114ybu.27.1656392463023; Mon, 27 Jun
 2022 22:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
 <20220627151819.22694-7-lukas.bulwahn@gmail.com> <bd2957f4-3793-d876-8b1f-1dbb9cf160d1@gmail.com>
In-Reply-To: <bd2957f4-3793-d876-8b1f-1dbb9cf160d1@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 28 Jun 2022 07:00:41 +0200
Message-ID: <CAKXUXMz58KV5m2HzYTwG7eq=2n4TMOT_F4Q8fL0Tn-7VAgtHAg@mail.gmail.com>
Subject: Re: [RFC PATCH 06/11] docs: process: remove outdated submitting-drivers.rst
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 3:21 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 6/27/22 22:18, Lukas Bulwahn wrote:
> >  There are numerous sources of information on Linux kernel development and
> >  related topics.  First among those will always be the Documentation
> > -directory found in the kernel source distribution.  The top-level :ref:`process/howto.rst <process_howto>`
> > -file is an important starting point; :ref:`process/submitting-patches.rst <submittingpatches>`
> > -and :ref:`process/submitting-drivers.rst  <submittingdrivers>`
> > -are also something which all kernel developers should
> > -read.  Many internal kernel APIs are documented using the kerneldoc
> > -mechanism; "make htmldocs" or "make pdfdocs" can be used to generate those
> > -documents in HTML or PDF format (though the version of TeX shipped by some
> > -distributions runs into internal limits and fails to process the documents
> > -properly).
> > +directory found in the kernel source distribution.  Start with the
> > +top-level :ref:`process/howto.rst <process_howto>`; also read
> > +:ref:`process/submitting-patches.rst <submittingpatches>`. Many internal
> > +kernel APIs are documented using the kerneldoc mechanism; "make htmldocs"
> > +or "make pdfdocs" can be used to generate those documents in HTML or PDF
> > +format (though the version of TeX shipped by some distributions runs into
> > +internal limits and fails to process the documents properly).
> >
>
> Did you mean "beware that TeX distribution version as shipped by distributions
> may fail to properly generate the documents"? I have never tried pdfdocs,
> since the dependency requirement can be huge (hundreds of MB needed to
> download packages), so I can't tell whether the phrase is relevant.
>

I only touched this sentence with 'make pdfdocs' above to reformat the
paragraph after deleting the reference to submitting-drivers. Maybe
the statement on make pdfdocs is outdated already or we should refer
to the documentation build page instead?

> > -  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>` and :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
> > -    These files describe in explicit detail how to successfully create
> > +  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
> > +    This file describes in explicit detail how to successfully create
> >      and send a patch, including (but not limited to):
> >
>
> Maybe "This document" instead of file?
>

Either 'this file' or 'this document' fits for me. I have just been
conservative here: It was 'These files' (written by the original
author) and after deleting the second reference, it is just 'this
file'.

If there is no strong opinion, I would leave this as-is.

> > @@ -12,9 +12,8 @@ This document contains a large number of suggestions in a relatively terse
> >  format.  For detailed information on how the kernel development process
> >  works, see Documentation/process/development-process.rst. Also, read
> >  Documentation/process/submit-checklist.rst
> > -for a list of items to check before submitting code.  If you are submitting
> > -a driver, also read Documentation/process/submitting-drivers.rst; for device
> > -tree binding patches, read
> > +for a list of items to check before submitting code.
> > +For device tree binding patches, read
> >  Documentation/devicetree/bindings/submitting-patches.rst.
>
> The hunk above is OK.
>
> --
> An old man doll... just what I always wanted! - Clara
