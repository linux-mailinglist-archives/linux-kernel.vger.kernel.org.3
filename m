Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F494BF3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiBVIcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBVIb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:31:59 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD643A1A2;
        Tue, 22 Feb 2022 00:31:33 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id y26so16355535vsq.8;
        Tue, 22 Feb 2022 00:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBQ/S+xkvJ+74y8gguMwbyM41nXFoVAQwL7MwfS99aU=;
        b=NZi6+dYJAWMkqJW3iNQqSLPEP+UFuQYPGZsliD5OF6K35A2veeTdtc585/ZrkAZ3C7
         SXHPCK7ldSjXFz9XdWDgFLI9EqQYvmMJd1DkkgSlTi5HegGjiGV3RJBeZeSl8Yb38DAF
         /PhKY9m4q+VKkqeS7+eIC1Bh2ARGAkhwAnwvRdfMHU2qVwiM5Rk+b3rl4rAtl9/EsvFD
         iEMfV1l9Fn9h+FqLfzzY9a/H7ks1iApAxG92xSqPWXXb/uXQh+vcFy5TtYDJLIa8dg0F
         eK4J4n8gW6asTGORzw2UTtSsHskWX7Lo8a4mdCu0ukr8Yr/tBPkz7TDEVqGaJltnuWap
         FVZQ==
X-Gm-Message-State: AOAM530aWamj3InpxZRinZ6+9vK1bi5hsUuRLpzfa8vX9EWAyyrb9ukW
        hxnS2xc00HqSdtdpMgIWADfZqmZRE6onrg==
X-Google-Smtp-Source: ABdhPJy+TYVD8RlHqGB6w6B2CoSOcxFWaUCjg6iN0MEcSM9/iBRZ53HpnbcTvvh8t0vwmAMAEY6rag==
X-Received: by 2002:a67:d81e:0:b0:31b:a09a:1c4d with SMTP id e30-20020a67d81e000000b0031ba09a1c4dmr10340707vsj.0.1645518692591;
        Tue, 22 Feb 2022 00:31:32 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id c66sm1962214vkg.35.2022.02.22.00.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 00:31:32 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id g21so20291361vsp.6;
        Tue, 22 Feb 2022 00:31:32 -0800 (PST)
X-Received: by 2002:a67:af08:0:b0:31b:9451:bc39 with SMTP id
 v8-20020a67af08000000b0031b9451bc39mr9530796vsl.68.1645518692146; Tue, 22 Feb
 2022 00:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20220221222450.5393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVb38_nhxVqUdtedyP0wMWmgkC-4K+OgbY0bOO8Hw4w4Q@mail.gmail.com> <OS0PR01MB59226DF1128AE3BBAEA2E96E863B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59226DF1128AE3BBAEA2E96E863B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Feb 2022 09:31:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXzz1szS=6aY7RKRo1YAGqQ_AjmkXk6x4CryRtoSADfcw@mail.gmail.com>
Message-ID: <CAMuHMdXzz1szS=6aY7RKRo1YAGqQ_AjmkXk6x4CryRtoSADfcw@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: Kconfig: Explicitly select PM and
 PM_GENERIC_DOMAINS configs
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
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

Hi Biju,

On Tue, Feb 22, 2022 at 9:30 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH] soc: renesas: Kconfig: Explicitly select PM and
> > PM_GENERIC_DOMAINS configs
> >
> > On Mon, Feb 21, 2022 at 11:25 PM Lad Prabhakar <prabhakar.mahadev-
> > lad.rj@bp.renesas.com> wrote:
> > > Explicitly select PM and PM_GENERIC_DOMAINS configs for ARCH_R9A07G044
> > > and ARCH_R9A07G045 configs. PM and PM_GENERIC_DOMAINS configs are
>
> Typo ARCH_R9A07G054 configs

Thanks, will fix while applying.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
