Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5014D4DCEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbiCQTSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbiCQTRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:17:55 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4E21BC73;
        Thu, 17 Mar 2022 12:16:38 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2e592e700acso69458117b3.5;
        Thu, 17 Mar 2022 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mKapJ9uZA8L9+1rRQInLTdrF5ON+YIytttK2FOHxods=;
        b=QWXddu++c/+IQNyzISJmK8CHYpxm5aYBFc68JYLbjT8JkfG9k/5GyMEHgXhvUMqzDa
         glxxliO4fHVMnlzQAkt0yZTKz5TILZElUQPhUBzTC729SUUKEZl/K0HZZo5QZhsw+bXq
         rrd8NYGTAKSadAI5OdJVaN92GxtwwsZLi42nrkxIWeIK0EBHLBb2SBByh5LYReMYxDdR
         SQBQaNOUhbKjmspYTzlWMC+S6DWBekmzmFPTZk8DcvX1HVNlNxjPJxOq7I+PyrDYgdLU
         nuxNubhRfDcv27vkiBEfaBP0EG+xtrIh4ZfP2MEJJ8kJ5A6Vsy2NFWLdhtf7V63ugIV4
         eZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKapJ9uZA8L9+1rRQInLTdrF5ON+YIytttK2FOHxods=;
        b=Gu6faB+2YevUYJhr3U3dgbSdfqDUcd0bQJdb5sPzUWhSbHgSort191Rzt+3nDTgriX
         rIuJXkgqZaDTLc8es9LRQkceMR6WJGmNEc13ln8qXcGZ09AHhOwrtGQqIyMkgODH9dLY
         T1iYVjWQqlDlea5qUBf22tFOVmlO9H1hQcn43rtvjWjUy1f4j74ROsw04UFy00Zq3CyT
         2k9CvTETDTaA6LXl4Z/XoZXJoaKHfBOkB+fvvl1xXv/gBzi4hY5r2a0vrBq0PuOzhy1+
         AVYrs+ojoG1SeyDDkcKevNHwRDsqaBtJTCFrvzFtz5Gy/7aUHtJg+q+hcJeMdKg1/zNx
         5KVw==
X-Gm-Message-State: AOAM532M4mdKnvwfb4ELb/OjinB+7jBE08pcKjUE54F+xT5PsRldd4h1
        RudVjSOR934v5QA4Gse8D52b22HU5SrGgwp/4DE=
X-Google-Smtp-Source: ABdhPJwyQGdV/V+oTZrJb8S7IamfHGCGb/X1pRr2kzGM8sBwIXQlbjp8sH/EXpPUygW9lTgQaOuNVB60ttIIoBwOY+Q=
X-Received: by 2002:a0d:c645:0:b0:2db:9ed9:e6e5 with SMTP id
 i66-20020a0dc645000000b002db9ed9e6e5mr7745641ywd.292.1647544598024; Thu, 17
 Mar 2022 12:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647274406.git.mchehab@kernel.org> <1ebc47e42c2692fe09947d517a5e9a3b12fc58a3.1647274407.git.mchehab@kernel.org>
In-Reply-To: <1ebc47e42c2692fe09947d517a5e9a3b12fc58a3.1647274407.git.mchehab@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 17 Mar 2022 19:16:12 +0000
Message-ID: <CA+V-a8tJL9WssQU3e-5J1NXFanALuF_SDfUQnhbOMJJJ2ZNNmA@mail.gmail.com>
Subject: Re: [PATCH v2 57/67] media: platform: rename am437x/ to ti/am437x/
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 4:35 PM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> As the end goal is to have platform drivers split by vendor,
> rename am437x/ to ti/am437x/.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/
>
>  MAINTAINERS                                               | 2 +-
>  drivers/media/platform/Kconfig                            | 2 +-
>  drivers/media/platform/Makefile                           | 2 +-
>  drivers/media/platform/{ => ti}/am437x/Kconfig            | 0
>  drivers/media/platform/{ => ti}/am437x/Makefile           | 0
>  drivers/media/platform/{ => ti}/am437x/am437x-vpfe.c      | 0
>  drivers/media/platform/{ => ti}/am437x/am437x-vpfe.h      | 0
>  drivers/media/platform/{ => ti}/am437x/am437x-vpfe_regs.h | 0
>  8 files changed, 3 insertions(+), 3 deletions(-)
>  rename drivers/media/platform/{ => ti}/am437x/Kconfig (100%)
>  rename drivers/media/platform/{ => ti}/am437x/Makefile (100%)
>  rename drivers/media/platform/{ => ti}/am437x/am437x-vpfe.c (100%)
>  rename drivers/media/platform/{ => ti}/am437x/am437x-vpfe.h (100%)
>  rename drivers/media/platform/{ => ti}/am437x/am437x-vpfe_regs.h (100%)
>
Reviewed-by: Lad Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
Prabhakar

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c1055c27c65..f0b262176a70 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19262,7 +19262,7 @@ S:      Maintained
>  W:     https://linuxtv.org
>  Q:     http://patchwork.linuxtv.org/project/linux-media/list/
>  T:     git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
> -F:     drivers/media/platform/am437x/
> +F:     drivers/media/platform/ti/am437x/
>
>  TI BANDGAP AND THERMAL DRIVER
>  M:     Eduardo Valentin <edubezval@gmail.com>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 2ad5fde02543..5d56058fa397 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -67,7 +67,6 @@ config VIDEO_MUX
>
>  source "drivers/media/platform/allegro-dvt/Kconfig"
>  source "drivers/media/platform/allwinner/Kconfig"
> -source "drivers/media/platform/am437x/Kconfig"
>  source "drivers/media/platform/amlogic/meson-ge2d/Kconfig"
>  source "drivers/media/platform/amphion/Kconfig"
>  source "drivers/media/platform/aspeed/Kconfig"
> @@ -97,6 +96,7 @@ source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
>  source "drivers/media/platform/stm/sti/Kconfig"
>  source "drivers/media/platform/stm/stm32/Kconfig"
>  source "drivers/media/platform/ti-vpe/Kconfig"
> +source "drivers/media/platform/ti/am437x/Kconfig"
>  source "drivers/media/platform/via/Kconfig"
>  source "drivers/media/platform/xilinx/Kconfig"
>
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> index f20f1287c665..f8c4617da0ae 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -7,7 +7,6 @@
>  # (e. g. LC_ALL=C sort Makefile)
>  obj-y += allegro-dvt/
>  obj-y += allwinner/
> -obj-y += am437x/
>  obj-y += amlogic/meson-ge2d/
>  obj-y += amphion/
>  obj-y += aspeed/
> @@ -42,6 +41,7 @@ obj-y += stm/sti/delta/
>  obj-y += stm/sti/hva/
>  obj-y += stm/stm32/
>  obj-y += ti-vpe/
> +obj-y += ti/am437x/
>  obj-y += via/
>  obj-y += xilinx/
>
> diff --git a/drivers/media/platform/am437x/Kconfig b/drivers/media/platform/ti/am437x/Kconfig
> similarity index 100%
> rename from drivers/media/platform/am437x/Kconfig
> rename to drivers/media/platform/ti/am437x/Kconfig
> diff --git a/drivers/media/platform/am437x/Makefile b/drivers/media/platform/ti/am437x/Makefile
> similarity index 100%
> rename from drivers/media/platform/am437x/Makefile
> rename to drivers/media/platform/ti/am437x/Makefile
> diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/ti/am437x/am437x-vpfe.c
> similarity index 100%
> rename from drivers/media/platform/am437x/am437x-vpfe.c
> rename to drivers/media/platform/ti/am437x/am437x-vpfe.c
> diff --git a/drivers/media/platform/am437x/am437x-vpfe.h b/drivers/media/platform/ti/am437x/am437x-vpfe.h
> similarity index 100%
> rename from drivers/media/platform/am437x/am437x-vpfe.h
> rename to drivers/media/platform/ti/am437x/am437x-vpfe.h
> diff --git a/drivers/media/platform/am437x/am437x-vpfe_regs.h b/drivers/media/platform/ti/am437x/am437x-vpfe_regs.h
> similarity index 100%
> rename from drivers/media/platform/am437x/am437x-vpfe_regs.h
> rename to drivers/media/platform/ti/am437x/am437x-vpfe_regs.h
> --
> 2.35.1
>
