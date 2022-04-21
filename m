Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F317950A14A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388198AbiDUN6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388100AbiDUN54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:57:56 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388852C100
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:55:03 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v1so2466562ljv.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9I2sv/w+bVoJVhgEON4k5i7vtxgov/Cr9H4jEyKQU44=;
        b=uPd35zp+t9AoSNs4r+Vp3gerI9BRNYp+bGV9SmMC4t1Di8G5JwPLrsrJ8vas36Vmu9
         J+PZO8qisz7ZoEOxYN8xOzv5ys4koF/bY+LyCGQ9LrE23WgtogSIRfeP1Oh2D09cEbt6
         OO2k80qci6e56m43qzH2mW7Z/XDz9GmXTZXpOQn+Gv9DcYFMV+sqqPY19Osf2oRYWAMz
         3zakafPxoqFkyEH8aNpwbBHlveLn+8xSW736SnqrjQ6wKh3E/6qIQRQM7WVV5PzpG8FY
         to1aEdA0c91W/Lvb+xUcGDufj8GB7wkM6T9QrwzVDVAOrWGjLz0rkWCc5V7Lqpn4npMj
         u1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9I2sv/w+bVoJVhgEON4k5i7vtxgov/Cr9H4jEyKQU44=;
        b=xL1RxbZyNwX8asTOsI+iWNOF41+kIcQ/iyxSKJa8HnZUZ4Sg/tEAj0KyIuFFjIp2W4
         jtyC+ShZyTVjXgKQvUlT3oyN3hlr3CW7NjE66B9YxicDaTRxl3Ee5U6GGIxQac9Vg2wV
         wyAYgLSJwYKDuqk6ZeZFNUa3+Y45+9lbPzckR3/hatpUajIxTi5nDPuUtCva0gFq5pwS
         hlslb/xGMSRJup+YgCS+uFRXAaDeFfPQHYg/cphVgMA9YKvXHuid4cxTw2yUAffLk3n4
         hatk0z4nHlwsl3YNgo0+unr4THHInTAKkE1iIhtu9m924jIlZ2G4slXPXIrod4FiMIu2
         vsdQ==
X-Gm-Message-State: AOAM532K2LvzQ9sOh2/q9tAFLJa/3HH8ylXFIrh9abruhY1KI0Hp6xnH
        FQNyl0wJARnaEurXkSzdzGfG6Ut2WK9s+xvLXwCWnWNR92o=
X-Google-Smtp-Source: ABdhPJxQ8zojrK8xdolxDcQ8zrSMsAOsNwi85QHOAAX4QMpz2jZNq6/IIYky8NRkIbD1nX8JR7qkOxUpHzF/JMNvZPU=
X-Received: by 2002:a05:651c:1783:b0:249:43a8:b6f9 with SMTP id
 bn3-20020a05651c178300b0024943a8b6f9mr16093756ljb.273.1650549301441; Thu, 21
 Apr 2022 06:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220412093102.3428-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220412093102.3428-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 15:54:25 +0200
Message-ID: <CAPDyKFofCmWC4PDQBzw-wJweOy5brD5dJ1RM2n2vM1gOTQ8peQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sh_mmcif: move platform_data header to proper location
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 at 11:31, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> We have a dedicated directory for platform_data meanwhile, don't spoil
> the MMC directory with it.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

As this is a trivial change, I have applied it for next, thanks!

Sato-san, Rich, please tell me if you see any problems with this - or
if you want me to add your acks.

Kind regards
Uffe


> ---
>
> Change since v1: fixed sorting of includes in the MMCIF driver
>                  (Thanks Geert!)
>
> I don't have the HW to test this but the buildbots are happy with this
> change. I checked that they actually tested the SH builds. To make the
> patch more readable, I used the -M (rename) feature of git-format-patch.
>
>  arch/sh/boards/board-sh7757lcr.c                | 2 +-
>  arch/sh/boards/mach-ecovec24/setup.c            | 2 +-
>  arch/sh/boot/romimage/mmcif-sh7724.c            | 2 +-
>  drivers/mmc/host/sh_mmcif.c                     | 2 +-
>  include/linux/{mmc => platform_data}/sh_mmcif.h | 2 --
>  5 files changed, 4 insertions(+), 6 deletions(-)
>  rename include/linux/{mmc => platform_data}/sh_mmcif.h (99%)
>
> diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
> index c32b4c6229d3..f39c8196efdf 100644
> --- a/arch/sh/boards/board-sh7757lcr.c
> +++ b/arch/sh/boards/board-sh7757lcr.c
> @@ -16,7 +16,7 @@
>  #include <linux/io.h>
>  #include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
> -#include <linux/mmc/sh_mmcif.h>
> +#include <linux/platform_data/sh_mmcif.h>
>  #include <linux/sh_eth.h>
>  #include <linux/sh_intc.h>
>  #include <linux/usb/renesas_usbhs.h>
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
> index 4c9522dd351f..674da7ebd8b7 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -19,7 +19,7 @@
>  #include <linux/memblock.h>
>  #include <linux/mfd/tmio.h>
>  #include <linux/mmc/host.h>
> -#include <linux/mmc/sh_mmcif.h>
> +#include <linux/platform_data/sh_mmcif.h>
>  #include <linux/mtd/physmap.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio/machine.h>
> diff --git a/arch/sh/boot/romimage/mmcif-sh7724.c b/arch/sh/boot/romimage/mmcif-sh7724.c
> index 6595b6b45bf1..d30123d859e0 100644
> --- a/arch/sh/boot/romimage/mmcif-sh7724.c
> +++ b/arch/sh/boot/romimage/mmcif-sh7724.c
> @@ -8,7 +8,7 @@
>   * for more details.
>   */
>
> -#include <linux/mmc/sh_mmcif.h>
> +#include <linux/platform_data/sh_mmcif.h>
>  #include <mach/romimage.h>
>
>  #define MMCIF_BASE      (void __iomem *)0xa4ca0000
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 5f9ebf045b1c..0fd4c9d644dd 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -43,12 +43,12 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/sdio.h>
> -#include <linux/mmc/sh_mmcif.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
>  #include <linux/of_device.h>
>  #include <linux/pagemap.h>
> +#include <linux/platform_data/sh_mmcif.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_qos.h>
>  #include <linux/pm_runtime.h>
> diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/platform_data/sh_mmcif.h
> similarity index 99%
> rename from include/linux/mmc/sh_mmcif.h
> rename to include/linux/platform_data/sh_mmcif.h
> index e25533b95d9f..6eb914f958f9 100644
> --- a/include/linux/mmc/sh_mmcif.h
> +++ b/include/linux/platform_data/sh_mmcif.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * include/linux/mmc/sh_mmcif.h
> - *
>   * platform data for eMMC driver
>   *
>   * Copyright (C) 2010 Renesas Solutions Corp.
> --
> 2.30.2
>
