Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E92521488
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241428AbiEJMCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbiEJMBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:01:55 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0212265FF;
        Tue, 10 May 2022 04:57:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r27so18251486iot.1;
        Tue, 10 May 2022 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nya3smcu6m6BJ3o7w8h7OZ/4ZZg2D1j+6By65hBtg4E=;
        b=VM/se0UDyiCCdJ4l8cbmpToryRKbD6kiPcp2LmQMrA21sF0s4m3DdEm4RpCOUNwV8I
         zDeKt5ByRnZNdMNAWT/RDqJPysImrh09HXKZB4Y1tF9UkPcBja4pfU59CsRatHaZAreb
         F/Jq6/QeHqdzqsxdCwWutFkbsN0RGLfVRpli/1UUeIoe7hos0YR/QDTDjC1kvXAZNXn0
         3wXQP7jpGBQqFLavn0RI8llPOpbrwgtCUdf6ttw+nQaZHkjte6L2zsJ9KZ+jX0QK0G25
         6JugcVh4hJcIfD8G7Exyof6Y7VhNfcygJvujMTKIynlQ/6VLsIKKGi5fHpxp2u9jcYG4
         K9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nya3smcu6m6BJ3o7w8h7OZ/4ZZg2D1j+6By65hBtg4E=;
        b=yyVPLhIM8bpQCBLZkgZHNsqbPWmCG2Hd+7KrSXDCvP3iSdjh0yDVdto7RMzwHO9ndU
         it5S3/Lp2oc+Q8798V4J6r6WV4C8ZnmaOSzt89XG7+BfigRf+aTBHs6hJV8WhSjr1z9F
         rRpvg9dbRxMEHxGt3LNu6MKvdOtm1olIPp9V5lDvIxpJTrpqBfJT4SRc6hyaoHc9fvvt
         TK2IeCiqMKKe0Fgus304oLZs0b4ASkjsHLynfCxtfmeB8NELzSTCgQc+nrmbex/WRWLV
         oSsvWilPai/mYH3rNIxq9mxgJaHT6UmCkuPhd+eufPZG0zqJh9Gicm1I6OIU4pkGySVq
         0Icw==
X-Gm-Message-State: AOAM5336AkptnplJ4u4ufU0Jhkko5iAi91X0qPDti13Pohmp1iqxRBbz
        T9XE1zbFMCzBo93aSTUhy/GqYTVeqQBu2lsDBG0=
X-Google-Smtp-Source: ABdhPJw+YkPy7lik4xxTFzDwdo471gN3AwACu2d05g47DAHxJcBzjqEDWZ1Vcu1N5BSpjD7Gb7k5QKIg2zNd9ask5DE=
X-Received: by 2002:a02:c6af:0:b0:32a:f5f6:34bc with SMTP id
 o15-20020a02c6af000000b0032af5f634bcmr9967949jan.186.1652183872250; Tue, 10
 May 2022 04:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-19-ojeda@kernel.org> <7e9c2e77-8b70-6e15-3f3d-905ab42b0fcd@gmail.com>
 <CANiq72mBVo4+htxVjY0wB1Y3GO2PEUiZjZKRYT8ddwx84-hAtg@mail.gmail.com>
 <92a7010c-5bb2-65df-edde-0ca88e035c2e@gmail.com> <8735hicoy7.fsf@meer.lwn.net>
In-Reply-To: <8735hicoy7.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 10 May 2022 13:57:40 +0200
Message-ID: <CANiq72mna9MKSgJYs19k=ieYu4v4TuemLdp1wkyhr9hqJ-tuAQ@mail.gmail.com>
Subject: Re: [PATCH v6 18/23] docs: add Rust documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Akira Yokosawa <akiyks@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Wu XiangCheng <bobwxc@email.cn>, Daniel Xu <dxu@dxuuu.xyz>,
        Gary Guo <gary@garyguo.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yuki Okushi <jtitor@2k36.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Julian Merkle <me@jvmerkle.de>, Finn Behrens <me@kloenk.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>
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

On Tue, May 10, 2022 at 12:37 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Yeah, but the issues are all with me :)  Please accept my apologies for
> letting it slip through the cracks.

No apologies needed! It is not an important patch -- I just thought it
would be better to have the "base logo" merged before the "derived
one".

> Looking at it now, though, I hesitate to add the logo (and another
> COPYING file) in the top-level Documentation directory - I'd really
> rather people not have to pick through a bunch of unrelated stuff to
> find the actual docs they want.  I'd recommend we make a
> Documentation/images (or .../assets or whatever) and put things like
> logos there.

Yeah, makes sense to avoid dumping things in the top-level directory.

> Disagree?  If not, could I get a version of the patch that does that?  I
> promise not to set on it for three months this time...

+1, I will send it.

Thanks Jon!

Cheers,
Miguel
