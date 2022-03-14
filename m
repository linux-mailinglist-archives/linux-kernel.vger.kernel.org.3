Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852424D8BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242743AbiCNSca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiCNSc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:32:29 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD373DDC9;
        Mon, 14 Mar 2022 11:31:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r22so23226020ljd.4;
        Mon, 14 Mar 2022 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ow6NpoOileaE6RaQfZy2uFKEhAsGL1nXF6bHUI30F+I=;
        b=GAK6D1niok8PeJ64e/Gidnlqu5e/Jo06XjvEx3tIyEYJrBblWxbdzXHTcBd7LdSq6O
         JybTG6NEAlfe7FvFv5/dk11qNBakfR88lRfVirNUSghrHUJlIRBoXRrszFGiVUd72y5I
         sXDlaq3+1IT2wUG8PsarwuMgn6X0Eav9wjp1yq5GkUrld9UzyJavne1eVtJ+RNZJaAjs
         KDy6srJQ6g2MZ8C4PTI3mIXSmh4bW/oeZ9K1HmTplGkv4VRF31S9rsZJIcRMKuhwj+tg
         qoQ4QjB7EDBPH8r14QMSoEElRI8sFOTFVGdQJbe/FMyz8ePNTNHCCzMe0dnQXtbMo14k
         YEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ow6NpoOileaE6RaQfZy2uFKEhAsGL1nXF6bHUI30F+I=;
        b=DjDBt6C3D7rQcQ6Q1fIpduNeFWD7SnIWzQY5gwv84CXJnRtrjgBKrkT+PQImf1rsjx
         MI3YRQlGMkHhjs+h8aN0BWqT69I0B5t3ag3qCqu8xaBbfNph/GB1okLGwyaw+/2V6f1L
         MKV1lCyl9H/HYZmC8Amp/t5DFjqsEh+VVngGhT33wWgBg1ptj4aAeyOUcc3PziwpQb72
         WqGYAGBrFNr8alD83gxrBbnnoZHaX6LhFOsQnkywF/6Hcb/n2+bHesZoK/wE1HzzPDBc
         PgziGm0f2+jilkBSYo9N233ML5mxMmoKPgjfDspuodocOMjPDa5xfwpjiK5sLSJ3xZUF
         B0+w==
X-Gm-Message-State: AOAM532Yra/BH6G4V3TSyd9urE5N3/4gPXN5ytVUUgNmYfgTcmKjQmfG
        xJc/V35BtxypiEBQw6Ana1E=
X-Google-Smtp-Source: ABdhPJytlp4YJnH28VUeZgTJ+Y0yHlAs/KSPcA0mbLXZCrp+7ER9DILTUeA/7Y2lhrhrub+SN/jJ+A==
X-Received: by 2002:a2e:a0c3:0:b0:247:eba1:366b with SMTP id f3-20020a2ea0c3000000b00247eba1366bmr14575792ljm.190.1647282673388;
        Mon, 14 Mar 2022 11:31:13 -0700 (PDT)
Received: from [10.0.0.127] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id f11-20020a056512228b00b004487997379esm2093422lfu.158.2022.03.14.11.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 11:31:12 -0700 (PDT)
Message-ID: <a169eef7-2f46-3ca1-db56-88adbce6a7c3@gmail.com>
Date:   Mon, 14 Mar 2022 20:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 60/67] media: platform: rename omap/ to ti/omap/
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <cover.1647274406.git.mchehab@kernel.org>
 <b01e1edbcf0589d1f3150340db6c2e81d034975a.1647274407.git.mchehab@kernel.org>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <b01e1edbcf0589d1f3150340db6c2e81d034975a.1647274407.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 14/03/2022 18:34, Mauro Carvalho Chehab wrote:
> As the end goal is to have platform drivers split by vendor,
> rename omap/ to ti/omap/.
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab@kernel.org/
> 
>  drivers/media/platform/Kconfig                        | 2 +-
>  drivers/media/platform/Makefile                       | 2 +-
>  drivers/media/platform/{ => ti}/omap/Kconfig          | 0
>  drivers/media/platform/{ => ti}/omap/Makefile         | 0
>  drivers/media/platform/{ => ti}/omap/omap_vout.c      | 0
>  drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.c | 0
>  drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.h | 0
>  drivers/media/platform/{ => ti}/omap/omap_voutdef.h   | 0
>  drivers/media/platform/{ => ti}/omap/omap_voutlib.c   | 0
>  drivers/media/platform/{ => ti}/omap/omap_voutlib.h   | 0
>  10 files changed, 2 insertions(+), 2 deletions(-)
>  rename drivers/media/platform/{ => ti}/omap/Kconfig (100%)
>  rename drivers/media/platform/{ => ti}/omap/Makefile (100%)
>  rename drivers/media/platform/{ => ti}/omap/omap_vout.c (100%)
>  rename drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.c (100%)
>  rename drivers/media/platform/{ => ti}/omap/omap_vout_vrfb.h (100%)
>  rename drivers/media/platform/{ => ti}/omap/omap_voutdef.h (100%)
>  rename drivers/media/platform/{ => ti}/omap/omap_voutlib.c (100%)
>  rename drivers/media/platform/{ => ti}/omap/omap_voutlib.h (100%)
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 4f95ea9b1221..43a654e87613 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -81,7 +81,6 @@ source "drivers/media/platform/mediatek/mtk-vcodec/Kconfig"
>  source "drivers/media/platform/mediatek/mtk-vpu/Kconfig"
>  source "drivers/media/platform/nvidia/tegra-vde/Kconfig"
>  source "drivers/media/platform/nxp/Kconfig"
> -source "drivers/media/platform/omap/Kconfig"
>  source "drivers/media/platform/qcom/Kconfig"
>  source "drivers/media/platform/renesas/Kconfig"
>  source "drivers/media/platform/rockchip/Kconfig"
> @@ -96,6 +95,7 @@ source "drivers/media/platform/stm/stm32/Kconfig"
>  source "drivers/media/platform/ti-vpe/Kconfig"
>  source "drivers/media/platform/ti/am437x/Kconfig"
>  source "drivers/media/platform/ti/davinci/Kconfig"
> +source "drivers/media/platform/ti/omap/Kconfig"
>  source "drivers/media/platform/ti/omap3isp/Kconfig"
>  source "drivers/media/platform/via/Kconfig"
>  source "drivers/media/platform/xilinx/Kconfig"
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> index c2bab3ba9ef6..39fa6aaad13b 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -21,7 +21,6 @@ obj-y += mediatek/mtk-vcodec/
>  obj-y += mediatek/mtk-vpu/
>  obj-y += nvidia/tegra-vde/
>  obj-y += nxp/
> -obj-y += omap/
>  obj-y += qcom/camss/
>  obj-y += qcom/venus/
>  obj-y += renesas/
> @@ -41,6 +40,7 @@ obj-y += stm/stm32/
>  obj-y += ti-vpe/
>  obj-y += ti/am437x/
>  obj-y += ti/davinci/
> +obj-y += ti/omap/
>  obj-y += ti/omap3isp/
>  obj-y += via/
>  obj-y += xilinx/
> diff --git a/drivers/media/platform/omap/Kconfig b/drivers/media/platform/ti/omap/Kconfig
> similarity index 100%
> rename from drivers/media/platform/omap/Kconfig
> rename to drivers/media/platform/ti/omap/Kconfig
> diff --git a/drivers/media/platform/omap/Makefile b/drivers/media/platform/ti/omap/Makefile
> similarity index 100%
> rename from drivers/media/platform/omap/Makefile
> rename to drivers/media/platform/ti/omap/Makefile
> diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/ti/omap/omap_vout.c
> similarity index 100%
> rename from drivers/media/platform/omap/omap_vout.c
> rename to drivers/media/platform/ti/omap/omap_vout.c
> diff --git a/drivers/media/platform/omap/omap_vout_vrfb.c b/drivers/media/platform/ti/omap/omap_vout_vrfb.c
> similarity index 100%
> rename from drivers/media/platform/omap/omap_vout_vrfb.c
> rename to drivers/media/platform/ti/omap/omap_vout_vrfb.c
> diff --git a/drivers/media/platform/omap/omap_vout_vrfb.h b/drivers/media/platform/ti/omap/omap_vout_vrfb.h
> similarity index 100%
> rename from drivers/media/platform/omap/omap_vout_vrfb.h
> rename to drivers/media/platform/ti/omap/omap_vout_vrfb.h
> diff --git a/drivers/media/platform/omap/omap_voutdef.h b/drivers/media/platform/ti/omap/omap_voutdef.h
> similarity index 100%
> rename from drivers/media/platform/omap/omap_voutdef.h
> rename to drivers/media/platform/ti/omap/omap_voutdef.h
> diff --git a/drivers/media/platform/omap/omap_voutlib.c b/drivers/media/platform/ti/omap/omap_voutlib.c
> similarity index 100%
> rename from drivers/media/platform/omap/omap_voutlib.c
> rename to drivers/media/platform/ti/omap/omap_voutlib.c
> diff --git a/drivers/media/platform/omap/omap_voutlib.h b/drivers/media/platform/ti/omap/omap_voutlib.h
> similarity index 100%
> rename from drivers/media/platform/omap/omap_voutlib.h
> rename to drivers/media/platform/ti/omap/omap_voutlib.h

-- 
Péter
