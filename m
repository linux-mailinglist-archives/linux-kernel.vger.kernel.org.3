Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E9554433
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350436AbiFVHYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbiFVHYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:24:30 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0982736E1F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:24:30 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 89so23991386qvc.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rOmmoLVe6WnIaNYIWpF3+s87z6ESD2tlV0e1iwEQK4=;
        b=LRn3UdPpp+/3lCQRRtW03eidEjBtiTc46tazELNfRF6N53XXvBgknauYGH8QR953S2
         hqWfeSwvb+tEnq/i05y5loSYl+Wrw7toEye9TbE233Ztcr0XLgmpgYzJGHEQSLFJhwc/
         Hb1E/slTwojCMa8Vwym0xWlZeH4bUcWSlfrLqPdwlxA+3C86YxEBLeSVxRElG30PuZFC
         oi35lG5bqfGWlvuW6g6fTlzepLEKNkqEv7r325nOfyeEdTBNU6Zmx5W9m0j1FW8vlfNS
         4l59y7G/wPzU2JjtX/Zi+T8E3PC/U3838rFYFn1r6SpkJNGTRHbLsQI9t3H7OI7KDAsX
         h9Nw==
X-Gm-Message-State: AJIora83ZqQJrQOK2DI/xO6meL59Q0hArvEtawUHrfraH83+YqcsR3IH
        ipBnHIfJUskz2MoqZCsVuc/S/QEhXYhFpg==
X-Google-Smtp-Source: AGRyM1sN+CHHVVZcz3SDju9EJ22p6P5yqD1ogE+lScH7NC80EQPBxDegug4qCuFjDz3k2WDuqvm0QA==
X-Received: by 2002:ac8:7d05:0:b0:305:2a4b:d86b with SMTP id g5-20020ac87d05000000b003052a4bd86bmr1788035qtb.234.1655882668925;
        Wed, 22 Jun 2022 00:24:28 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id a15-20020ac85b8f000000b00304e38fb3dasm15433428qta.35.2022.06.22.00.24.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 00:24:28 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id u9so18519696ybq.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 00:24:28 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr2248914ybu.604.1655882668340; Wed, 22
 Jun 2022 00:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220622062835.53980-1-yuanjilin@cdjrlc.com>
In-Reply-To: <20220622062835.53980-1-yuanjilin@cdjrlc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jun 2022 09:24:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDBEQYQZfor=wNzE_BHgCKXEnyW8WJS-dbmU++6zPDCw@mail.gmail.com>
Message-ID: <CAMuHMdWDBEQYQZfor=wNzE_BHgCKXEnyW8WJS-dbmU++6zPDCw@mail.gmail.com>
Subject: Re: [PATCH] m68k:coldfire:Fix typos in comments
To:     yuanjilin@cdjrlc.com
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
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

On Wed, Jun 22, 2022 at 8:29 AM Jilin Yuan <yuanjilin@cdjrlc.com> wrote:
> Delete the redundant word 'the'.
>
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Thanks for your patch!

> --- a/arch/m68k/coldfire/intc-2.c
> +++ b/arch/m68k/coldfire/intc-2.c
> @@ -7,7 +7,7 @@
>   * family, the 5270, 5271, 5274, 5275, and the 528x family which have two such
>   * controllers, and the 547x and 548x families which have only one of them.
>   *
> - * The external 7 fixed interrupts are part the the Edge Port unit of these
> + * The external 7 fixed interrupts are part the Edge Port unit of these

The first "the" should be replaced by "of" instead.

>   * ColdFire parts. They can be configured as level or edge triggered.
>   *
>   * (C) Copyright 2009-2011, Greg Ungerer <gerg@snapgear.com>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
