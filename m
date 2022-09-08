Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218535B251D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiIHRrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiIHRqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:46:38 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59483EB2FC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:46:13 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id x3so1155761qkn.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EMErwM6jy216ZWxEVAGeIf0QWKItxFlC4co4l/8Yna4=;
        b=uOrU3gpDY5vRQn8URLN+aN1Lxs8MOGftfB6BfIzx5RhM8yUH1bArziM7df1dc0zWWX
         iod1NgnoU2cDaWtUh+77PGn7Urja7IizhggTLU0TQVUAJsn2l+JlZ3TFcDefaEuvACrK
         D0pnl1NsXQOVNw4vzhrGmCddDq3O5Ugw9+QbI0EpressHNtLSDAzZjGhh18oDAKEXUGe
         QOzOPng/aApcWDB8wmO20wQB+onBiXjvUkvOoG9k0Whw6s3y5z3NdJMre4LD8USEf3+F
         Mgg5ssvBEFKBHhoJhf/Vp9RTyvuVCXh9PJDRCBBW2M46T+qcnK40pMsFAETROy7jmr3W
         RSgg==
X-Gm-Message-State: ACgBeo0KdXLiq/OooF8Q4jEaeaZxdRLPy71Y6DroJKWefYov0U9swFfz
        uK0DStrSXT6isMAlqskQPOD+xN6PR0LMGw==
X-Google-Smtp-Source: AA6agR71Quoop2CoUCxzjPLcDuhnLhaoVbrz3nVJm838z4yMAK1AdElZWqeyiXmCjv9g41laL0Ethw==
X-Received: by 2002:a05:620a:1904:b0:6b8:9cfd:2b24 with SMTP id bj4-20020a05620a190400b006b89cfd2b24mr7459189qkb.489.1662659171786;
        Thu, 08 Sep 2022 10:46:11 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id r9-20020a05620a298900b006b919c6749esm18744091qkp.91.2022.09.08.10.46.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 10:46:11 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id g5so27522020ybg.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:46:10 -0700 (PDT)
X-Received: by 2002:a25:8247:0:b0:6a9:443a:cc0b with SMTP id
 d7-20020a258247000000b006a9443acc0bmr8638582ybn.89.1662659170630; Thu, 08 Sep
 2022 10:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220908125401.28130-1-wangjianli@cdjrlc.com> <514c7366cc8e78face3094a66bb2c4bf030f9432.camel@sipsolutions.net>
In-Reply-To: <514c7366cc8e78face3094a66bb2c4bf030f9432.camel@sipsolutions.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Sep 2022 19:45:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXtPREdgoXK4wyBJiZmubDtsT5Cjjn44MzGVnpu_Ph=YQ@mail.gmail.com>
Message-ID: <CAMuHMdXtPREdgoXK4wyBJiZmubDtsT5Cjjn44MzGVnpu_Ph=YQ@mail.gmail.com>
Subject: Re: [PATCH] um/kernel: fix repeated words in comments
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     wangjianli <wangjianli@cdjrlc.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 2:56 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> On Thu, 2022-09-08 at 20:54 +0800, wangjianli wrote:
> > Delete the redundant word 'in'.
> >
> > Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> > ---
> >  arch/um/kernel/physmem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
> > index e7c7b53a1435..91485119ae67 100644
> > --- a/arch/um/kernel/physmem.c
> > +++ b/arch/um/kernel/physmem.c
> > @@ -169,7 +169,7 @@ __uml_setup("iomem=", parse_iomem,
> >  );
> >
> >  /*
> > - * This list is constructed in parse_iomem and addresses filled in in
> > + * This list is constructed in parse_iomem and addresses filled in
> >   * setup_iomem, both of which run during early boot.  Afterwards, it's
> >
> Fine, I guess, but honestly - that sentence doesn't parse well either

Not fine, the repeated "in" is correct.
Q: "Where are addresses filled in?"
A: "In setup_iomem".

> way. Might be worth addressing that at the same time...

addresses are filled in?

General note: please stop submitting these patches for auto-detected
repeated words.  There are too many false positives.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
