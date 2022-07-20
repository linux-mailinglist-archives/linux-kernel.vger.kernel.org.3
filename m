Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECC457BCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiGTRhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbiGTRhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:37:43 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8748F6FA35
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:37:42 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id l3so12035014qkl.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kh7V8uHzXmxI+aoBRvnV2n6tht0bog5cLScTJnWXPGY=;
        b=EbwbmSgXMPhWVv0B+pEvm7GgrNUcU4xGk8xcLnZa/Z0Sb1907PR0Z6C5p7ZPgbhL0h
         BRfEQjUoksAfSyRGER2QbhF5sloOCX+OuyTdSHkiiLfq4tOdbM+xqvpeEOh4EdlqD0kE
         c0jgwA1Z+seyiaK5edp2gk3rf0vwqb5DKXV9fre+vpMuBZ2CCQk/3JxJ+4xHA8f1ZX9m
         jBIQMIXzZZxWndH1qOnotckc9U92Ry3XNQ+d3hnmMy6ZzufM7MD5/GOjKmqzP3BrNPmR
         vUq7NnWuMYPh2XRl8f2xzzOiLUTE/1bE3ZyF/9v4EuCgMSE286EWtgqv32uBAZhrS5zP
         lLVg==
X-Gm-Message-State: AJIora9KPvzc1cRYUEVW0HLD3gur77I7NjQMJWaSzUgZ7D60vyCkWXxz
        F81nI2dGk1gd4l81eazduKvJgbj166TLSomD
X-Google-Smtp-Source: AGRyM1tq0iYqcldGHo7XFfOgIyHTjqi44mpcM32if3vE2wxzhH/4tjjyRWC3CSl6fqQSy/kcc2ou4w==
X-Received: by 2002:a37:9703:0:b0:6b5:c0ed:8110 with SMTP id z3-20020a379703000000b006b5c0ed8110mr21412208qkd.120.1658338661573;
        Wed, 20 Jul 2022 10:37:41 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id cn11-20020a05622a248b00b0031f05408e47sm1875348qtb.95.2022.07.20.10.37.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 10:37:41 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31e1ecea074so105156877b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:37:40 -0700 (PDT)
X-Received: by 2002:a0d:c787:0:b0:31b:a963:e1de with SMTP id
 j129-20020a0dc787000000b0031ba963e1demr41498691ywd.283.1658338660732; Wed, 20
 Jul 2022 10:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220720105309.3090-1-gaoxin@cdjrlc.com>
In-Reply-To: <20220720105309.3090-1-gaoxin@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 20 Jul 2022 19:37:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVf7EOrXkUpa1E1Qx1w0Tvrt1nwRHM6B8rsGPOh=WsnyA@mail.gmail.com>
Message-ID: <CAMuHMdVf7EOrXkUpa1E1Qx1w0Tvrt1nwRHM6B8rsGPOh=WsnyA@mail.gmail.com>
Subject: Re: [PATCH] m68k/mac: Fixed duplicate "in" in comments.
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

On Wed, Jul 20, 2022 at 12:55 PM Xin Gao <gaoxin@cdjrlc.com> wrote:
> Fixed duplicate "in" in comments.
>
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>

Thanks for your patch!

> --- a/arch/m68k/mac/misc.c
> +++ b/arch/m68k/mac/misc.c
> @@ -126,7 +126,7 @@ static void via_rtc_send(__u8 data)
>
>         reg = via1[vBufB] & ~(VIA1B_vRTCClk | VIA1B_vRTCData);
>
> -       /* The bits of the byte go in in MSB order */
> +       /* The bits of the byte go in MSB order */

The original was correct.
Ask yourself the question: "How should the bits go in?"
"In MSB order".

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
