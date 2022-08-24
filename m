Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC1859F45F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbiHXHb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiHXHbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:31:42 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8726DAFC;
        Wed, 24 Aug 2022 00:31:27 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id g14so2569013qto.11;
        Wed, 24 Aug 2022 00:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=82WQkDOdERyND7bY3iF+8AcDaMfTG/LJhOwz2xG4mtY=;
        b=nwC2idr7DAFJGlnNplknxJAQ2EomFfv0BiDBozR+O+pfeeJt+drQBD0quQ7FtoYprP
         jPxUxClpbiRL3NK/EaL4sL+hHgj8AoAfMKCUylLigg6bC5rfgY5RhEMSDhEVI/Ts4RLD
         2b2SoIZQfgUlaS2FoSKUm4KAdMNiw8WuWmlN2KGJYYJGhREzAS/Zq8ByiaQqsXHvJhTc
         qkG5gvBnoAUI3diWcWx/01fkmCcmoMeYfmax/JEAiPB6Y2Eey93f8lRfOw3DXoPNduIv
         1RkxT35RWn8XLD6lujHOazfCx3nYq1zWjf+Jeo1ovBKW7iY+kOa0GS1NHp0Xtv5WtIo7
         FLHQ==
X-Gm-Message-State: ACgBeo3RkHOZCKyzQed38Q/ElfXic01trc/PPtvpwX/4YAOjPF/A+96c
        77eZvnM0EmlzK3CXF3REJ+T8NewZuLPYHw==
X-Google-Smtp-Source: AA6agR6Bn5LJwMR6U7+Q60fowE/jUAE7zd+qkzKHzsRfvNs6VFlGtVTcUt6YawUu6fSDn2opudN1mw==
X-Received: by 2002:a05:622a:195:b0:344:5630:dcc with SMTP id s21-20020a05622a019500b0034456300dccmr22628147qtw.598.1661326286269;
        Wed, 24 Aug 2022 00:31:26 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id t39-20020a05622a182700b00342f7beccd0sm12896450qtc.45.2022.08.24.00.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 00:31:25 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3246910dac3so438119857b3.12;
        Wed, 24 Aug 2022 00:31:25 -0700 (PDT)
X-Received: by 2002:a81:658:0:b0:334:a23e:6caa with SMTP id
 85-20020a810658000000b00334a23e6caamr28318780ywg.283.1661326285004; Wed, 24
 Aug 2022 00:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220816130713.28597-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220816130713.28597-1-yuanjilin@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 Aug 2022 09:31:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV8iVoNKMKz1A12+P3hbvsJ8xgwKX8-LNTs+85dn2YDEw@mail.gmail.com>
Message-ID: <CAMuHMdV8iVoNKMKz1A12+P3hbvsJ8xgwKX8-LNTs+85dn2YDEw@mail.gmail.com>
Subject: Re: [PATCH] video/fbdev: fix repeated words in comments
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jilin,

On Tue, Aug 16, 2022 at 3:08 PM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
>  Delete the redundant word 'set'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Thanks for your patch, which is now commit 253cabc01468d6b5 ("fbdev:
ssd1307fb: Fix repeated words in comments") in fbdev/for-next

> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -450,7 +450,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
>         if (ret < 0)
>                 return ret;
>
> -       /* Set Set Area Color Mode ON/OFF & Low Power Display Mode */
> +       /* Set Area Color Mode ON/OFF & Low Power Display Mode */
>         if (par->area_color_enable || par->low_power) {
>                 u32 mode;

Given the register being written below is called
SSD1307FB_SET_AREA_COLOR_MODE, I think the original was correct
(hint: the "S" in "Set" was capitalized).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
