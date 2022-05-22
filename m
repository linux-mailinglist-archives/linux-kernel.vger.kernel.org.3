Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263655301A5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbiEVHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbiEVHhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:37:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0923CA61;
        Sun, 22 May 2022 00:36:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gi33so14343169ejc.3;
        Sun, 22 May 2022 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXPZMIuDMh3nH2dL31GT3vk5sClUvSn8jN8RcdsCbL4=;
        b=k91qRNUzU0dwmpRuQtkAG3m/N0VPpXanYb3QoApiKq42cFZT4HQL5JmtaVxgdYhlBu
         MqX+fzyKkAde9IqUMQ0ovn6zF3DCuzqSl+F5AuJTnBj1MReyWEs9yN57f6OyO4qogsD2
         LPbJGJ0hX0TxPvAR1qJMdENQajTcq/1bF2wGNhtkxjTqzB4Wu43kDbSZoMjz03+w7IQ9
         vLe4QTWG+wPpI4jcChvpgtHBbmzd3GPKw/PLATBgy2wuK+52Nt9U0kDxRSpQ+LstVk5J
         PFTRxCRtvjj1l436l5vtgAVlthegT4+iCUwVWPVjwTOxrB6fxEFMgY+oERNLFI+K/aIO
         D5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXPZMIuDMh3nH2dL31GT3vk5sClUvSn8jN8RcdsCbL4=;
        b=BAD5nx4NDmBzVvU1AlTQshWE6eSUGaQ6o2e65PxjXpvIdylDxqR1tx1OeTU0AMoKxc
         k1RAKhGOQR4fpuJSS73BQosdXNSzxfaky407lndvqmB69lvuWxLmVAXuCLqWQzsSqJXP
         SgjqR8PBst/uEoUo9Cn0caMMhtxa62UTKaO+iYV+hMGZf+bxpGurcLfHJM6nNZtUB16E
         kspyEb9kkPK1AoJvwKMDLfyWUtopuyI9mJyPX4X8NWAmCSr6n9Ye5nqwinhs2K+1aHeO
         +r7CMES5hfgMzCoiye+IJ3QBnRUsFxc7KBgiVk9BkHwLonhVmXiHyUGthQOXA8J1Jhai
         KLlw==
X-Gm-Message-State: AOAM530+vPVXN5H4Gpov6lktsxlqJTWR0ZaEog96lbXAvNC0hyIIvn8v
        gxwz+5N0LIHW+8Q9FiJPtkvEISy0YTfipw==
X-Google-Smtp-Source: ABdhPJx8/8naAzFBDiHnI0FTe8FKv3lYnIyerQW26X4ehpEB/p2aGjgHgEbyP6lICoR5V1gtsekP1Q==
X-Received: by 2002:a17:907:7283:b0:6f4:ff4f:1b6e with SMTP id dt3-20020a170907728300b006f4ff4f1b6emr14752427ejc.344.1653205018257;
        Sun, 22 May 2022 00:36:58 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id s27-20020a170906221b00b006f3ef214dbdsm4911430ejs.35.2022.05.22.00.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 00:36:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-spdx@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-sunxi@lists.linux.dev
Subject: Re: [patch 09/10] clocksource/drivers/timer-sun4i: Convert to SPDX identifier
Date:   Sun, 22 May 2022 09:36:56 +0200
Message-ID: <5567157.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20220510171254.908144392@linutronix.de>
References: <20220510171003.952873904@linutronix.de> <20220510171254.908144392@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 10. maj 2022 ob 19:24:49 CEST je Thomas Gleixner napisal(a):
> The license information clearly states GPL version 2 only. The extra text
> which excludes warranties is an excerpt of the corresponding GPLv2 clause
> 11.
> 
> So the SPDX identifier covers it completely.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-sunxi@lists.linux.dev

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clocksource/timer-sun4i.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/drivers/clocksource/timer-sun4i.c
> +++ b/drivers/clocksource/timer-sun4i.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Allwinner A1X SoCs timer handling.
>   *
> @@ -8,10 +9,6 @@
>   * Based on code from
>   * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
>   * Benn Huang <benn@allwinnertech.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
>   */
> 
>  #include <linux/clk.h>




