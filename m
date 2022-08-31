Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3E45A76E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiHaGto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiHaGtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:49:40 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9CBBFC41
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:49:38 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id u11so3649943vkk.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ELRucgG8m2V6r9SU9tGEGft3z5bvHcQ3jF1PQm77q5o=;
        b=ZIrJ0tiWVVU8nNYRXiO3Lt9VsXHRDLWdE5Bh0KzQsIXXK+UzqwyDpMbHKxs3/Wr4aW
         /qG7tMyfQqVmu770gH5NRRXP08axADzKP/VcbXYsYfAlaTfRtJtAEuwNsxtYArO1XMmJ
         0MjAwBgtGmYbWmZPUPnZHehmIdHslq+rVKeTIt8dDbCWhSsHZ8jaieKkEPkLYOLlxaWp
         im5Zn2v4nKnng5agsxl4X2BnoxCWJJlKU59ROaLV8fH45Zlq843TAu336vZjBYvdxP3U
         g+s+En2zaOriGxPxdI7xFw8NrypejQQSfuEgY0uExCsRmBX9mvLv0XZEOLoVwmE6vlOY
         3vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ELRucgG8m2V6r9SU9tGEGft3z5bvHcQ3jF1PQm77q5o=;
        b=zlIlC3lGEKAivxZA2EV5COHvMREIrgBOg3Qo/O2LFmjAHhxB8fLbXuH07/Pt1pRk/U
         Hvok7D4hhJzHHAYgJaXuDAa+UF6ZshBH15e6lSYnmzPcyOVBkFGmro6WDdiv99XtPJDz
         5w0YnY/b2YG21piJTyHokqTOQl+5GvxysafRl5Oqac2bDXm3XTUqQPaAtChvLoOY4nat
         Bhb5Y7Ms9ucH1fJDLVeRVjwCzKts6vIhsVPvGYRa/D1hWNaggvERLXk1568WweQ3IhJH
         tgSfgGzy8V6v7F4sLY0z/5S6eH9hAjYW2nsJk4OxZAqDXSYEPIqEMOS7aDVTMLkDQ9ll
         1wGQ==
X-Gm-Message-State: ACgBeo1gtiSTMFrEetVveaEgWSwHY4NgPwvGiBiFLFHM61LPmiOWssRL
        jFF6bgdh24BIYtztJ9ZA6p8m1oby9AnnPZ2bLOby+Uzzj7I=
X-Google-Smtp-Source: AA6agR62/mUooJshCxkFnyDJ75P1vapplxRXV0b6l25K3vzkllJy7I5QW4YaBfRyeK+UCLofKDsuyap3Iw8oEyJA7io=
X-Received: by 2002:a1f:2f43:0:b0:381:9296:91d4 with SMTP id
 v64-20020a1f2f43000000b00381929691d4mr5924656vkv.33.1661928577338; Tue, 30
 Aug 2022 23:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220831064046.20936-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220831064046.20936-1-yuanjilin@cdjrlc.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 30 Aug 2022 23:49:27 -0700
Message-ID: <CAMo8BfLv5Ppz_Kq_krCBwqYqqFL+GKX2+Tmzzw3PS=Bmm4Gghg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: fix repeated words in comments
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     chris@zankel.net, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 11:40 PM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
>
> Delete the redundant word 'that'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>  arch/xtensa/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
> index 0c25e035ff10..998299debbf5 100644
> --- a/arch/xtensa/kernel/traps.c
> +++ b/arch/xtensa/kernel/traps.c
> @@ -322,7 +322,7 @@ static void do_illegal_instruction(struct pt_regs *regs)
>          * When call0 application encounters an illegal instruction fast
>          * exception handler will attempt to set PS.WOE and retry failing
>          * instruction.
> -        * If we get here we know that that instruction is also illegal
> +        * If we get here we know that instruction is also illegal

I'd say that the sentence is correct.
It says that (we know that) (that instruction is also illegal).

-- 
Thanks.
-- Max
