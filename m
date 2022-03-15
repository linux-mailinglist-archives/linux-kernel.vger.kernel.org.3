Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D64DA260
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351044AbiCOS1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiCOS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:27:32 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFE85A0A1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:26:19 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id gm1so157999qvb.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=l3gXoXKLC0zHJI2/h4gKXr3SExv7m4/0z9HVf//L8tk=;
        b=nDqLXcEulqyBYqM2e5KW+Vmk8p5TpN5uxmQ66Z9BvPnmJUBJ/P/oX41mOgrQCrTg2U
         Ph4GuJPQUrYP+yDki6Uk5Qn7GyNd/qggfbQ9p8jY6Zv8xFWyZEa1ARSn3RGPu1zvwVaF
         2hWnQN7b7f2VGRuQ6iGkRehWB4YFLYNKyPEPLbnNpjvRE2EnzVJ8XnKGTBLzPyRdG6Px
         nMtrnq3Ql1qoe2FEfoWLHf3cvKqPvuzKbXS+tfAZQN4/MKNLX7NqQMc/r2FLBtm0VoWf
         PnqQc15+Q8OOJW/EL1ogxEX33MK82bTqWUJn+YzrZSRPVorP2UPFZSSA/90+R2D/GH12
         f/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=l3gXoXKLC0zHJI2/h4gKXr3SExv7m4/0z9HVf//L8tk=;
        b=n94Y2wnAa6b8YpcG6kDmDLPi8hX1CyokHPsCJDtzaDVge3Kl3e3H1yVN2ZuNc06EzE
         SO6vxhD57nGomSuKfvnMNB4iurphIDdruqnzFapItkWERjBbpykEkjALYFFvZREJacFE
         UbuQ5/j/h6oFGmpTE5jbLlsabD1QQ6SS9sWeBStvihp+s3Tn+L9uGKSrU9Da17Q2cT3p
         tXBCZFdiKhCgv4uPhqQ6/6I48/LwAeZpj6293GJhrfId9lMpaY3Ev76fydiD26lXxDZP
         kZ6bVt7I3YXEHep4TqjlE/sob2TWBfh41dwRiXWda2fXme0eouXy1gkgHX2iHmKiDeNq
         xXXw==
X-Gm-Message-State: AOAM532NH479h4ExHlNNnOojak2x1fDXdeYSdGyhfRJFnWZ1XU134+pV
        Qfbnl6a2Yl9qrP4rd3KvOLN6Nru/Tsmi2WlA
X-Google-Smtp-Source: ABdhPJyNUQu+vjW2T7gMj/Px7A+cgWb0gtqHLTBtL1b0oOx07mBP2G2ejfg0/I8SsFbwSLThIGq/HQ==
X-Received: by 2002:a05:6214:c87:b0:435:4e8d:1866 with SMTP id r7-20020a0562140c8700b004354e8d1866mr22665774qvr.22.1647368778884;
        Tue, 15 Mar 2022 11:26:18 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id d19-20020a05622a05d300b002e1e720ddcesm847324qtb.4.2022.03.15.11.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 11:26:18 -0700 (PDT)
Message-ID: <d3e1957d65f8847c5cce5788c06e125d4e06e7dd.camel@ndufresne.ca>
Subject: Re: [PATCH 10/24] media: platform: rename amphion/ to nxp/amphion/
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Fabio Estevam <festevam@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Date:   Tue, 15 Mar 2022 14:26:17 -0400
In-Reply-To: <74af5c2eb40369185a5a233b106513cbc14401c0.1647167750.git.mchehab@kernel.org>
References: <cover.1647167750.git.mchehab@kernel.org>
         <74af5c2eb40369185a5a233b106513cbc14401c0.1647167750.git.mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 13 mars 2022 à 11:51 +0100, Mauro Carvalho Chehab a écrit :
> As the end goal is to have platform drivers split by vendor,
> rename amphion/ to nxp/amphion/.

Amphion Semi is a chip vendor, just like Hantro (now owned merged in
Verisilicon) and Chips&Media. Their hardware could be found on other SoC in the
future. Note this one got acquired by Allegro, and it isn't clear if they will
continue that product or not. Unlike CODA, which is a product name, the driver
implement support for both known products (Malone, the decoder and Windsor, the
encoder).

https://www.finsmes.com/2019/10/allegro-dvt-acquires-amphion-semiconductor.html

I'm not sure what to suggest here yet. allegro/amphion/ could be a workaround ?

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/
> 
>  MAINTAINERS                                            | 2 +-
>  drivers/media/platform/Kconfig                         | 2 +-
>  drivers/media/platform/Makefile                        | 2 +-
>  drivers/media/platform/{ => nxp}/amphion/Kconfig       | 0
>  drivers/media/platform/{ => nxp}/amphion/Makefile      | 0
>  drivers/media/platform/{ => nxp}/amphion/vdec.c        | 0
>  drivers/media/platform/{ => nxp}/amphion/venc.c        | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu.h         | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_cmds.c    | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_cmds.h    | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_codec.h   | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_color.c   | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_core.c    | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_core.h    | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_dbg.c     | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_defs.h    | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_drv.c     | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_helpers.c | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_helpers.h | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_imx8q.c   | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_imx8q.h   | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_malone.c  | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_malone.h  | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_mbox.c    | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_mbox.h    | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_msgs.c    | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_msgs.h    | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_rpc.c     | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_rpc.h     | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_v4l2.c    | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_v4l2.h    | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_windsor.c | 0
>  drivers/media/platform/{ => nxp}/amphion/vpu_windsor.h | 0
>  33 files changed, 3 insertions(+), 3 deletions(-)
>  rename drivers/media/platform/{ => nxp}/amphion/Kconfig (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/Makefile (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vdec.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/venc.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_cmds.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_cmds.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_codec.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_color.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_core.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_core.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_dbg.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_defs.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_drv.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_helpers.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_helpers.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_imx8q.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_imx8q.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_malone.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_malone.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_mbox.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_mbox.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_msgs.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_msgs.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_rpc.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_rpc.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_v4l2.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_v4l2.h (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_windsor.c (100%)
>  rename drivers/media/platform/{ => nxp}/amphion/vpu_windsor.h (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9333d46047e..74901acf8f06 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1037,7 +1037,7 @@ M:	Zhou Peng <eagle.zhou@nxp.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/amphion,vpu.yaml
> -F:	drivers/media/platform/amphion/
> +F:	drivers/media/platform/nxp/amphion/
>  
>  AMS AS73211 DRIVER
>  M:	Christian Eggers <ceggers@arri.de>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index f07ab9a98e3b..2e3925408aa0 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -69,7 +69,6 @@ source "drivers/media/platform/allegro-dvt/Kconfig"
>  source "drivers/media/platform/allwinner/Kconfig"
>  source "drivers/media/platform/am437x/Kconfig"
>  source "drivers/media/platform/amlogic/meson-ge2d/Kconfig"
> -source "drivers/media/platform/amphion/Kconfig"
>  source "drivers/media/platform/aspeed/Kconfig"
>  source "drivers/media/platform/atmel/Kconfig"
>  source "drivers/media/platform/cadence/Kconfig"
> @@ -85,6 +84,7 @@ source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
>  source "drivers/media/platform/mediatek/mtk-vpu/Kconfig"
>  source "drivers/media/platform/nvidia/tegra-vde/Kconfig"
>  source "drivers/media/platform/nxp/Kconfig"
> +source "drivers/media/platform/nxp/amphion/Kconfig"
>  source "drivers/media/platform/omap/Kconfig"
>  source "drivers/media/platform/omap3isp/Kconfig"
>  source "drivers/media/platform/qcom/Kconfig"
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> index ce9909534218..7a28b60dbbe6 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -9,7 +9,6 @@ obj-y += allegro-dvt/
>  obj-y += allwinner/
>  obj-y += am437x/
>  obj-y += amlogic/meson-ge2d/
> -obj-y += amphion/
>  obj-y += aspeed/
>  obj-y += atmel/
>  obj-y += cadence/
> @@ -25,6 +24,7 @@ obj-y += mediatek/mtk-vcodec/
>  obj-y += mediatek/mtk-vpu/
>  obj-y += nvidia/tegra-vde/
>  obj-y += nxp/
> +obj-y += nxp/amphion/
>  obj-y += omap/
>  obj-y += omap3isp/
>  obj-y += qcom/camss/
> diff --git a/drivers/media/platform/amphion/Kconfig b/drivers/media/platform/nxp/amphion/Kconfig
> similarity index 100%
> rename from drivers/media/platform/amphion/Kconfig
> rename to drivers/media/platform/nxp/amphion/Kconfig
> diff --git a/drivers/media/platform/amphion/Makefile b/drivers/media/platform/nxp/amphion/Makefile
> similarity index 100%
> rename from drivers/media/platform/amphion/Makefile
> rename to drivers/media/platform/nxp/amphion/Makefile
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/nxp/amphion/vdec.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vdec.c
> rename to drivers/media/platform/nxp/amphion/vdec.c
> diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/nxp/amphion/venc.c
> similarity index 100%
> rename from drivers/media/platform/amphion/venc.c
> rename to drivers/media/platform/nxp/amphion/venc.c
> diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/nxp/amphion/vpu.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu.h
> rename to drivers/media/platform/nxp/amphion/vpu.h
> diff --git a/drivers/media/platform/amphion/vpu_cmds.c b/drivers/media/platform/nxp/amphion/vpu_cmds.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_cmds.c
> rename to drivers/media/platform/nxp/amphion/vpu_cmds.c
> diff --git a/drivers/media/platform/amphion/vpu_cmds.h b/drivers/media/platform/nxp/amphion/vpu_cmds.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_cmds.h
> rename to drivers/media/platform/nxp/amphion/vpu_cmds.h
> diff --git a/drivers/media/platform/amphion/vpu_codec.h b/drivers/media/platform/nxp/amphion/vpu_codec.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_codec.h
> rename to drivers/media/platform/nxp/amphion/vpu_codec.h
> diff --git a/drivers/media/platform/amphion/vpu_color.c b/drivers/media/platform/nxp/amphion/vpu_color.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_color.c
> rename to drivers/media/platform/nxp/amphion/vpu_color.c
> diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/nxp/amphion/vpu_core.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_core.c
> rename to drivers/media/platform/nxp/amphion/vpu_core.c
> diff --git a/drivers/media/platform/amphion/vpu_core.h b/drivers/media/platform/nxp/amphion/vpu_core.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_core.h
> rename to drivers/media/platform/nxp/amphion/vpu_core.h
> diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/nxp/amphion/vpu_dbg.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_dbg.c
> rename to drivers/media/platform/nxp/amphion/vpu_dbg.c
> diff --git a/drivers/media/platform/amphion/vpu_defs.h b/drivers/media/platform/nxp/amphion/vpu_defs.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_defs.h
> rename to drivers/media/platform/nxp/amphion/vpu_defs.h
> diff --git a/drivers/media/platform/amphion/vpu_drv.c b/drivers/media/platform/nxp/amphion/vpu_drv.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_drv.c
> rename to drivers/media/platform/nxp/amphion/vpu_drv.c
> diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/nxp/amphion/vpu_helpers.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_helpers.c
> rename to drivers/media/platform/nxp/amphion/vpu_helpers.c
> diff --git a/drivers/media/platform/amphion/vpu_helpers.h b/drivers/media/platform/nxp/amphion/vpu_helpers.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_helpers.h
> rename to drivers/media/platform/nxp/amphion/vpu_helpers.h
> diff --git a/drivers/media/platform/amphion/vpu_imx8q.c b/drivers/media/platform/nxp/amphion/vpu_imx8q.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_imx8q.c
> rename to drivers/media/platform/nxp/amphion/vpu_imx8q.c
> diff --git a/drivers/media/platform/amphion/vpu_imx8q.h b/drivers/media/platform/nxp/amphion/vpu_imx8q.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_imx8q.h
> rename to drivers/media/platform/nxp/amphion/vpu_imx8q.h
> diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/nxp/amphion/vpu_malone.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_malone.c
> rename to drivers/media/platform/nxp/amphion/vpu_malone.c
> diff --git a/drivers/media/platform/amphion/vpu_malone.h b/drivers/media/platform/nxp/amphion/vpu_malone.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_malone.h
> rename to drivers/media/platform/nxp/amphion/vpu_malone.h
> diff --git a/drivers/media/platform/amphion/vpu_mbox.c b/drivers/media/platform/nxp/amphion/vpu_mbox.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_mbox.c
> rename to drivers/media/platform/nxp/amphion/vpu_mbox.c
> diff --git a/drivers/media/platform/amphion/vpu_mbox.h b/drivers/media/platform/nxp/amphion/vpu_mbox.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_mbox.h
> rename to drivers/media/platform/nxp/amphion/vpu_mbox.h
> diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/nxp/amphion/vpu_msgs.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_msgs.c
> rename to drivers/media/platform/nxp/amphion/vpu_msgs.c
> diff --git a/drivers/media/platform/amphion/vpu_msgs.h b/drivers/media/platform/nxp/amphion/vpu_msgs.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_msgs.h
> rename to drivers/media/platform/nxp/amphion/vpu_msgs.h
> diff --git a/drivers/media/platform/amphion/vpu_rpc.c b/drivers/media/platform/nxp/amphion/vpu_rpc.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_rpc.c
> rename to drivers/media/platform/nxp/amphion/vpu_rpc.c
> diff --git a/drivers/media/platform/amphion/vpu_rpc.h b/drivers/media/platform/nxp/amphion/vpu_rpc.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_rpc.h
> rename to drivers/media/platform/nxp/amphion/vpu_rpc.h
> diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/nxp/amphion/vpu_v4l2.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_v4l2.c
> rename to drivers/media/platform/nxp/amphion/vpu_v4l2.c
> diff --git a/drivers/media/platform/amphion/vpu_v4l2.h b/drivers/media/platform/nxp/amphion/vpu_v4l2.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_v4l2.h
> rename to drivers/media/platform/nxp/amphion/vpu_v4l2.h
> diff --git a/drivers/media/platform/amphion/vpu_windsor.c b/drivers/media/platform/nxp/amphion/vpu_windsor.c
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_windsor.c
> rename to drivers/media/platform/nxp/amphion/vpu_windsor.c
> diff --git a/drivers/media/platform/amphion/vpu_windsor.h b/drivers/media/platform/nxp/amphion/vpu_windsor.h
> similarity index 100%
> rename from drivers/media/platform/amphion/vpu_windsor.h
> rename to drivers/media/platform/nxp/amphion/vpu_windsor.h

