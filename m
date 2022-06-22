Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1533554412
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352342AbiFVHTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiFVHTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:19:43 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1060C1A078
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:19:43 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 59so1224906qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7zp9khTmqchqs4KxBcL6aqCiADcBm5j8vu+OxsZyaeM=;
        b=5GRJ+GG3n8XjIMgV3E1U4ptMaeQVNk97lp5WmHKUwCG7hH0ReOz7buH61BB3oIroXn
         Pi0TKDFEbmK5ZoHeqqMQ+xiODq/DBOwRFOfwsUHUpT7SuUg7WE5urUmIiQJvNLiegyQF
         Krudfw5A4DiWCA7Nm0B+6hxs9I2/VCuQcLvAcj9gVRxojnAhn8cH/AFqlJCiZknoMIW6
         vjhP/ZvKD4VAjbGqv6N17WQd0xVsUBc4XvnBxuzeFkgOOc5tYsoLsNR1aaBvvnLcX/Ws
         2NwsWzpn+2x5bhwYGF80F38B4F0UXVSRgTmrfJLbksX9ccBp5//0/agn4guYybf0Ky84
         Gc2g==
X-Gm-Message-State: AJIora90tSz3worNSieQFl+1UTFzWP5ZFaMfi+Y1XkCIrirFWn6djmv+
        O3BCuvUHu8l8Cn6wUxtY+myjxppyP3r33g==
X-Google-Smtp-Source: AGRyM1sws3bm76CobYOvcUhkWicDIjZqvuAkOVprvJBuSwaaoYtV2maxC4L4SnV6nK1sKGGga2V8QA==
X-Received: by 2002:a05:622a:4c9:b0:306:6959:e1d3 with SMTP id q9-20020a05622a04c900b003066959e1d3mr1763307qtx.680.1655882381936;
        Wed, 22 Jun 2022 00:19:41 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id r8-20020a05622a034800b00304e4bbc369sm14459576qtw.10.2022.06.22.00.19.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 00:19:41 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id n144so24579603ybf.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:19:41 -0700 (PDT)
X-Received: by 2002:a05:6902:1141:b0:669:3f2a:c6bb with SMTP id
 p1-20020a056902114100b006693f2ac6bbmr2180101ybu.365.1655882381103; Wed, 22
 Jun 2022 00:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220622061018.37575-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220622061018.37575-1-yuanjilin@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jun 2022 09:19:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWwqKyvtxkvdng0EVFfKjz9iOjK3Dhfd+iru-j731azTw@mail.gmail.com>
Message-ID: <CAMuHMdWwqKyvtxkvdng0EVFfKjz9iOjK3Dhfd+iru-j731azTw@mail.gmail.com>
Subject: Re: [PATCH] m68k:mac:Fix syntax errors in comments
To:     yuanjilin@cdjrlc.com
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
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

Hi Jilin,

On Wed, Jun 22, 2022 at 8:10 AM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
> Delete the redundant word 'in'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Thanks for your patch!

> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@ -126,7 +126,7 @@ static void via_rtc_send(__u8 data)
>
>         reg = via1[vBufB] & ~(VIA1B_vRTCClk | VIA1B_vRTCData);
>
> -       /* The bits of the byte go in in MSB order */
> +       /* The bits of the byte go in MSB order */

The original is actually correct: "to go in", "in MSB order".

>
>         for (i = 0 ; i < 8 ; i++) {
>                 bit = data & 0x80? 1 : 0;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
