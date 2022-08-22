Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE5659BB0D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiHVIHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiHVIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:06:40 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A9ADEDB;
        Mon, 22 Aug 2022 01:06:17 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id cr9so7297165qtb.13;
        Mon, 22 Aug 2022 01:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BZuv70St0sfOAw+lBqzRl+fUBQWph+V4RqtW+LWAJXE=;
        b=HpCMa5q0BkC8C6NA7QON4b4dwUPm6vJObWQTWTcXsGnVVOxeOF19mR3YDnK+jRmbmT
         dnIsRhOKt8oxttFWj1sKWO/C1Hhlfm1mdvaLslRTo9QTy4AipTjbe0t8S0iPfR1+wx0Y
         iO687VPfF9HxH9cS2MFhA+KYHl6nbnGHuS/atql0Dc/nXnVpT5jeF8ysJZKZweB7yQxk
         n+dIDlGCoGRAVafesKTUDBiyz7jpLxm6nbHBwK+oQ55HTNDXTsMnhXDz4X8BLQdCC5qY
         R8AySjmroAwGCFCIBqqEu1rQkgOBWc5qECCh4MKpH945vDUtQLNiwajcmQg6OOufBohA
         ATXQ==
X-Gm-Message-State: ACgBeo3H8bkl8lxQrxO9KEhIYH/KpzY25jR9hEIkJxuF3L+EqRBX9vjX
        44AZquT9bQfWSoGXY7sZo90xRnw8iXvzAA==
X-Google-Smtp-Source: AA6agR4Lz7xnFu8617hLfifGepI/cBlsg6L4EdUGzbKwBzxcUkrB/7bb1SsSbLQ/qR8JteQ9j6+aHA==
X-Received: by 2002:a05:622a:95:b0:343:66b1:d32a with SMTP id o21-20020a05622a009500b0034366b1d32amr14111455qtw.32.1661155576434;
        Mon, 22 Aug 2022 01:06:16 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id t13-20020a05620a450d00b006bb6c63114fsm10930354qkp.110.2022.08.22.01.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 01:06:16 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-33365a01f29so271503647b3.2;
        Mon, 22 Aug 2022 01:06:15 -0700 (PDT)
X-Received: by 2002:a25:e004:0:b0:695:d8b6:57e7 with SMTP id
 x4-20020a25e004000000b00695d8b657e7mr3698ybg.380.1661155575524; Mon, 22 Aug
 2022 01:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220821145435.49842-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220821145435.49842-1-wangjianli@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Aug 2022 10:06:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWCJCcs4thnjuwa9ZpLCdtFgptLUd9eo_gAvuKwGhG-jw@mail.gmail.com>
Message-ID: <CAMuHMdWCJCcs4thnjuwa9ZpLCdtFgptLUd9eo_gAvuKwGhG-jw@mail.gmail.com>
Subject: Re: [PATCH] platform/renesas: fix repeated words in comments
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

Hi Wangjianli,

On Sun, Aug 21, 2022 at 4:58 PM wangjianli <wangjianli@cdjrlc.com> wrote:
>  Delete the redundant word 'on'.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Thanks for your patch!

> --- a/drivers/media/platform/renesas/renesas-ceu.c
> +++ b/drivers/media/platform/renesas/renesas-ceu.c
> @@ -1101,7 +1101,7 @@ static int ceu_open(struct file *file)
>                 return ret;
>
>         mutex_lock(&ceudev->mlock);
> -       /* Causes soft-reset and sensor power on on first open */
> +       /* Causes soft-reset and sensor power on first open */

The double "on" is actually correct.  Please ask yourself the question:
"When should the sensor be powered on?".
Answer: "On first open".

Personally, I would have written "power-on" instead of "power on"
(cfr. "soft-reset"), so perhaps it's a good idea to make that change,
to prevent the next person looking for double words falling for
this again?

>         ret = pm_runtime_resume_and_get(ceudev->dev);
>         mutex_unlock(&ceudev->mlock);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
