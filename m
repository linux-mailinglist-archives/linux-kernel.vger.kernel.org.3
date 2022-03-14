Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1121C4D7DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiCNImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiCNImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:42:12 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C11D3C485;
        Mon, 14 Mar 2022 01:41:00 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22E8W6Gm026719;
        Mon, 14 Mar 2022 09:40:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=selector1; bh=myxRaXF7Vh1hom2EyP1oBMMoYj0tzQQHrP5Q5LaW5eM=;
 b=EulMrCmsuYdRv3+6aAPzwPbanFQYssovU29+YmWql1Xd7KLulmm444ZtM2n+rScohaNh
 hk7poVuAV6A+9ZbVViSghmAnfWQAyub7N9KJHwXobIoYKB3Lk0XRtrYdkFkMEY1aKLTE
 8ZpN39lIS2vxvjfRyXk03Az6CQ1MWNMmBaOjDYfs3fk/vnsbSKpe64QLxV5IX6t4vjBj
 iiN0rtM68wJLpTnUjDl6pZKdvAkheHrO0LfOcuMdLZe/mGdqWruzbm+OsppVG56RAuaC
 RBzrO7G+VGwJWGWLa+aPj8xBbztlIPNXIlMJyxuB75peAhNKAmuPvcPcjXEQCAAABaHL ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3erhtp13pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 09:40:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB1E010002A;
        Mon, 14 Mar 2022 09:39:56 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8ECFA2132C8;
        Mon, 14 Mar 2022 09:39:56 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 14 Mar
 2022 09:39:56 +0100
Date:   Mon, 14 Mar 2022 09:39:42 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitriy Ulitin <ulitin@ispras.ru>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 17/24] media: platform: rename stm32/ to sti/stm32/
Message-ID: <20220314083942.GA526468@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitriy Ulitin <ulitin@ispras.ru>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <cover.1647167750.git.mchehab@kernel.org>
 <dc5be62a56ac19c6f49f4c8432558fd7b0efe7e6.1647167750.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc5be62a56ac19c6f49f4c8432558fd7b0efe7e6.1647167750.git.mchehab@kernel.org>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_02,2022-03-11_02,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

I don't think stm32 should be put within the sti platform folder.
sti and stm32 are 2 different platforms from ST Microelectronics.
STi refers to the platform with SoCs such as STiH407/STiH410 and STiH418
while stm32 are all STM32 ones. Those two platforms aren't related.
What about having a folder stmicro or stmicroelectronics (too long
probably :D) with the 2 folders sti and stm32 into it ?

Alain

On Sun, Mar 13, 2022 at 11:51:58AM +0100, Mauro Carvalho Chehab wrote:
> As the end goal is to have platform drivers split by vendor,
> rename stm32/ to sti/stm32/.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/
> 
>  MAINTAINERS                                               | 2 +-
>  drivers/media/platform/Kconfig                            | 2 +-
>  drivers/media/platform/Makefile                           | 2 +-
>  drivers/media/platform/{ => sti}/stm32/Kconfig            | 0
>  drivers/media/platform/{ => sti}/stm32/Makefile           | 0
>  drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-hw.c   | 0
>  drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-regs.h | 0
>  drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.c      | 0
>  drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.h      | 0
>  drivers/media/platform/{ => sti}/stm32/stm32-dcmi.c       | 0
>  10 files changed, 3 insertions(+), 3 deletions(-)
>  rename drivers/media/platform/{ => sti}/stm32/Kconfig (100%)
>  rename drivers/media/platform/{ => sti}/stm32/Makefile (100%)
>  rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-hw.c (100%)
>  rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-regs.h (100%)
>  rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.c (100%)
>  rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.h (100%)
>  rename drivers/media/platform/{ => sti}/stm32/stm32-dcmi.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7711a5ea125e..620705e0f043 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12046,7 +12046,7 @@ L:	linux-media@vger.kernel.org
>  S:	Supported
>  T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
> -F:	drivers/media/platform/stm32/stm32-dcmi.c
> +F:	drivers/media/platform/sti/stm32/stm32-dcmi.c
>  
>  MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index c3594807f8d7..cf373bfbca1b 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -95,7 +95,7 @@ source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
>  source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
>  source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
>  source "drivers/media/platform/sti/Kconfig"
> -source "drivers/media/platform/stm32/Kconfig"
> +source "drivers/media/platform/sti/stm32/Kconfig"
>  source "drivers/media/platform/ti-vpe/Kconfig"
>  source "drivers/media/platform/via/Kconfig"
>  source "drivers/media/platform/xilinx/Kconfig"
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> index 6a766acfbe37..e3dd2331003a 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -40,7 +40,7 @@ obj-y += sti/bdisp/
>  obj-y += sti/c8sectpfe/
>  obj-y += sti/delta/
>  obj-y += sti/hva/
> -obj-y += stm32/
> +obj-y += sti/stm32/
>  obj-y += ti-vpe/
>  obj-y += via/
>  obj-y += xilinx/
> diff --git a/drivers/media/platform/stm32/Kconfig b/drivers/media/platform/sti/stm32/Kconfig
> similarity index 100%
> rename from drivers/media/platform/stm32/Kconfig
> rename to drivers/media/platform/sti/stm32/Kconfig
> diff --git a/drivers/media/platform/stm32/Makefile b/drivers/media/platform/sti/stm32/Makefile
> similarity index 100%
> rename from drivers/media/platform/stm32/Makefile
> rename to drivers/media/platform/sti/stm32/Makefile
> diff --git a/drivers/media/platform/stm32/dma2d/dma2d-hw.c b/drivers/media/platform/sti/stm32/dma2d/dma2d-hw.c
> similarity index 100%
> rename from drivers/media/platform/stm32/dma2d/dma2d-hw.c
> rename to drivers/media/platform/sti/stm32/dma2d/dma2d-hw.c
> diff --git a/drivers/media/platform/stm32/dma2d/dma2d-regs.h b/drivers/media/platform/sti/stm32/dma2d/dma2d-regs.h
> similarity index 100%
> rename from drivers/media/platform/stm32/dma2d/dma2d-regs.h
> rename to drivers/media/platform/sti/stm32/dma2d/dma2d-regs.h
> diff --git a/drivers/media/platform/stm32/dma2d/dma2d.c b/drivers/media/platform/sti/stm32/dma2d/dma2d.c
> similarity index 100%
> rename from drivers/media/platform/stm32/dma2d/dma2d.c
> rename to drivers/media/platform/sti/stm32/dma2d/dma2d.c
> diff --git a/drivers/media/platform/stm32/dma2d/dma2d.h b/drivers/media/platform/sti/stm32/dma2d/dma2d.h
> similarity index 100%
> rename from drivers/media/platform/stm32/dma2d/dma2d.h
> rename to drivers/media/platform/sti/stm32/dma2d/dma2d.h
> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/sti/stm32/stm32-dcmi.c
> similarity index 100%
> rename from drivers/media/platform/stm32/stm32-dcmi.c
> rename to drivers/media/platform/sti/stm32/stm32-dcmi.c
> -- 
> 2.35.1
> 
