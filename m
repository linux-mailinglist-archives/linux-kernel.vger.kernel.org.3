Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970704D7D36
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbiCNIGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiCNIEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:04:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E323B3D2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:02:04 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h15so22443558wrc.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZbQvHoyGIYzvUki2Rr3koBlbf8HphwGvoPoiGFCWjVI=;
        b=Px/AIFSkS5xiQntL+czEDZNooaKyKwCT5+5oX3Dxiuaq0p2Muil6CAGE/yKjTcSPRk
         zDe4uh38/LLZAeLwbHMGwjTg12kmpC6yeWSofKA0umP5cCfX9/OYY82Bw345RNYb0ncn
         orCm5F+5ZfCmlxK+d1VXp7nIMCWzluoafQnmDOcfqWejvaYNcsBVEphbI2O0YMhV2/Sw
         btjwvk4hgGfi1Ebtg7vyteqdSKhr8lp3tlnQhW8mViZOmcTxC9P84ODdx/3FeHEOfW8P
         6h58+Jo9NlVZHRXuw0qPEJXdJKCF5VgLcohK/rtJkyKSW2QSe8R2Hvd+nhg3g9Uwmmee
         CRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZbQvHoyGIYzvUki2Rr3koBlbf8HphwGvoPoiGFCWjVI=;
        b=1d4QD/MOqYoj3dltY9CqDax0DBdb7PVZtO8T9t3eNUl9ITFo+A5C90FKgzpzgGMcEE
         w0oEIVRyatajyK5gEiclM+ko1p04DFXGf/p/kcoqwhTO7BeGxB6WfF2RtLJVvd3kod7Q
         aR84OppDH1kJZ+xRgkHFCKxv+mZvrVjeaIDy2CGmnUyn9FjmpKpRlUIf3LlPftj/Waaq
         vcy34bI0YlWQoIBT3pfiH0otqc9K1ZiKGPamzKsyZyksaJgz40cWgjifMty0BIUi7K4S
         u01Gk0C5bhd27ufzLVqDjfdq7VKhQv/aUqAE9KbKem/+UCs13P4p1PgMEkYyPZgqQSKu
         Rplw==
X-Gm-Message-State: AOAM532xpJvyAejf904ITZKzfqWb7jWTuiIgdTtfmpAiiIxLYB2fyc+B
        +edjbHNxjGL8GPjUVw+/vYm6SQ==
X-Google-Smtp-Source: ABdhPJztePfcEZyw3gKDCW6el7zVf+skc/7D+PKs0YU6FDvddmqBB//lsO2gITU97Xj5EZ5qC+/51g==
X-Received: by 2002:adf:fb4e:0:b0:1e3:3e66:d5f6 with SMTP id c14-20020adffb4e000000b001e33e66d5f6mr16194756wrs.615.1647244875196;
        Mon, 14 Mar 2022 01:01:15 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:67f0:57f7:2185:6d18? ([2001:861:44c0:66c0:67f0:57f7:2185:6d18])
        by smtp.gmail.com with ESMTPSA id v188-20020a1cacc5000000b00384b71a50d5sm14188253wme.24.2022.03.14.01.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 01:01:14 -0700 (PDT)
Message-ID: <18f984ff-36c8-dbe5-6dd0-404c4fe9deab@baylibre.com>
Date:   Mon, 14 Mar 2022 09:01:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 64/64] media: Kconfig: cleanup VIDEO_DEV dependencies
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, mjpeg-users@lists.sourceforge.net,
        openbmc@lists.ozlabs.org
References: <cover.1647242578.git.mchehab@kernel.org>
 <decd26e90adc5c16470e4f738810f22fe6478b27.1647242579.git.mchehab@kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <decd26e90adc5c16470e4f738810f22fe6478b27.1647242579.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2022 08:55, Mauro Carvalho Chehab wrote:
> media Kconfig has two entries associated to V4L API:
> VIDEO_DEV and VIDEO_V4L2.
> 
> On Kernel 2.6.x, there were two V4L APIs, each one with its own flag.
> VIDEO_DEV were meant to:
> 	1) enable Video4Linux and make its Kconfig options to appear;
> 	2) it makes the Kernel build the V4L core.
> 
> while VIDEO_V4L2 where used to distinguish between drivers that
> implement the newer API and drivers that implemented the former one.
> 
> With time, such meaning changed, specially after the removal of
> all V4L version 1 drivers.
> 
> At the current implementation, VIDEO_DEV only does (1): it enables
> the media options related to V4L, that now has:
> 
> 	menu "Video4Linux options"
> 		visible if VIDEO_DEV
> 
> 	source "drivers/media/v4l2-core/Kconfig"
> 	endmenu
> 
> but it doesn't affect anymore the V4L core drivers.
> 
> The rationale is that the V4L2 core has a "soft" dependency
> at the I2C bus, and now requires to select a number of other
> Kconfig options:
> 
> 	config VIDEO_V4L2
> 		tristate
> 		depends on (I2C || I2C=n) && VIDEO_DEV
> 		select RATIONAL
> 		select VIDEOBUF2_V4L2 if VIDEOBUF2_CORE
> 		default (I2C || I2C=n) && VIDEO_DEV
> 
> In the past, merging them would be tricky, but it seems that it is now
> possible to merge those symbols, in order to simplify V4L dependencies.
> 
> Let's keep VIDEO_DEV, as this one is used on some make *defconfig
> configurations.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab@kernel.org/
> 
>   drivers/input/rmi4/Kconfig                    |   2 +-
>   drivers/input/touchscreen/Kconfig             |   4 +-
>   drivers/media/Kconfig                         |   3 +
>   drivers/media/common/saa7146/Kconfig          |   2 +-
>   drivers/media/dvb-core/Kconfig                |   2 +-
>   drivers/media/dvb-frontends/Kconfig           |   4 +-
>   drivers/media/i2c/Kconfig                     | 250 +++++++++---------
>   drivers/media/i2c/ccs/Kconfig                 |   2 +-
>   drivers/media/i2c/cx25840/Kconfig             |   2 +-
>   drivers/media/i2c/et8ek8/Kconfig              |   2 +-
>   drivers/media/i2c/m5mols/Kconfig              |   2 +-
>   drivers/media/pci/Kconfig                     |   2 +-
>   drivers/media/pci/bt8xx/Kconfig               |   2 +-
>   drivers/media/pci/cobalt/Kconfig              |   2 +-
>   drivers/media/pci/cx18/Kconfig                |   2 +-
>   drivers/media/pci/dt3155/Kconfig              |   2 +-
>   drivers/media/pci/intel/ipu3/Kconfig          |   2 +-
>   drivers/media/pci/ivtv/Kconfig                |   2 +-
>   drivers/media/pci/meye/Kconfig                |   2 +-
>   drivers/media/pci/saa7146/Kconfig             |   6 +-
>   drivers/media/pci/sta2x11/Kconfig             |   2 +-
>   drivers/media/pci/tw5864/Kconfig              |   2 +-
>   drivers/media/pci/tw68/Kconfig                |   2 +-
>   drivers/media/pci/tw686x/Kconfig              |   2 +-
>   drivers/media/platform/Kconfig                |   6 +-
>   drivers/media/platform/allegro-dvt/Kconfig    |   2 +-
>   .../platform/allwinner/sun4i-csi/Kconfig      |   2 +-
>   .../platform/allwinner/sun6i-csi/Kconfig      |   2 +-
>   .../media/platform/allwinner/sun8i-di/Kconfig |   2 +-
>   .../platform/allwinner/sun8i-rotate/Kconfig   |   2 +-
>   .../media/platform/amlogic/meson-ge2d/Kconfig |   2 +-
>   drivers/media/platform/aspeed/Kconfig         |   2 +-
>   drivers/media/platform/atmel/Kconfig          |   8 +-
>   drivers/media/platform/cadence/Kconfig        |   4 +-
>   drivers/media/platform/chips-media/Kconfig    |   2 +-
>   drivers/media/platform/intel/Kconfig          |   2 +-
>   drivers/media/platform/marvell/Kconfig        |   4 +-
>   .../media/platform/mediatek/mtk-jpeg/Kconfig  |   2 +-
>   .../media/platform/mediatek/mtk-mdp/Kconfig   |   2 +-
>   .../platform/mediatek/mtk-vcodec/Kconfig      |   2 +-
>   .../media/platform/mediatek/mtk-vpu/Kconfig   |   2 +-
>   .../media/platform/nvidia/tegra-vde/Kconfig   |   2 +-
>   drivers/media/platform/nxp/Kconfig            |   6 +-
>   drivers/media/platform/nxp/amphion/Kconfig    |   2 +-
>   drivers/media/platform/nxp/imx-jpeg/Kconfig   |   2 +-
>   drivers/media/platform/qcom/camss/Kconfig     |   2 +-
>   drivers/media/platform/qcom/venus/Kconfig     |   2 +-
>   drivers/media/platform/renesas/Kconfig        |  30 +--
>   .../media/platform/renesas/rcar-vin/Kconfig   |   4 +-
>   drivers/media/platform/rockchip/rga/Kconfig   |   2 +-
>   .../media/platform/rockchip/rkisp1/Kconfig    |   2 +-
>   .../media/platform/samsung/exynos-gsc/Kconfig |   2 +-
>   .../media/platform/samsung/exynos4-is/Kconfig |   2 +-
>   .../media/platform/samsung/s3c-camif/Kconfig  |   2 +-
>   .../media/platform/samsung/s5p-g2d/Kconfig    |   2 +-
>   .../media/platform/samsung/s5p-jpeg/Kconfig   |   2 +-
>   .../media/platform/samsung/s5p-mfc/Kconfig    |   2 +-
>   drivers/media/platform/sti/bdisp/Kconfig      |   2 +-
>   drivers/media/platform/sti/delta/Kconfig      |   2 +-
>   drivers/media/platform/sti/hva/Kconfig        |   2 +-
>   drivers/media/platform/sti/stm32/Kconfig      |   4 +-
>   drivers/media/platform/ti/am437x/Kconfig      |   2 +-
>   drivers/media/platform/ti/davinci/Kconfig     |  12 +-
>   drivers/media/platform/ti/omap/Kconfig        |   2 +-
>   drivers/media/platform/ti/omap3isp/Kconfig    |   2 +-
>   drivers/media/platform/ti/vpe/Kconfig         |   4 +-
>   drivers/media/platform/via/Kconfig            |   2 +-
>   drivers/media/platform/xilinx/Kconfig         |   2 +-
>   drivers/media/radio/Kconfig                   |  54 ++--
>   drivers/media/radio/si470x/Kconfig            |   2 +-
>   drivers/media/radio/wl128x/Kconfig            |   2 +-
>   drivers/media/spi/Kconfig                     |   4 +-
>   drivers/media/test-drivers/Kconfig            |   2 +-
>   drivers/media/test-drivers/vicodec/Kconfig    |   2 +-
>   drivers/media/test-drivers/vimc/Kconfig       |   2 +-
>   drivers/media/test-drivers/vivid/Kconfig      |   2 +-
>   drivers/media/tuners/Kconfig                  |   6 +-
>   drivers/media/tuners/e4000.c                  |   6 +-
>   drivers/media/tuners/fc2580.c                 |   6 +-
>   drivers/media/usb/airspy/Kconfig              |   2 +-
>   drivers/media/usb/au0828/Kconfig              |   6 +-
>   drivers/media/usb/cpia2/Kconfig               |   2 +-
>   drivers/media/usb/dvb-usb-v2/Kconfig          |   8 +-
>   drivers/media/usb/dvb-usb/Kconfig             |   4 +-
>   drivers/media/usb/gspca/Kconfig               |  96 +++----
>   drivers/media/usb/gspca/gl860/Kconfig         |   2 +-
>   drivers/media/usb/gspca/m5602/Kconfig         |   2 +-
>   drivers/media/usb/hackrf/Kconfig              |   2 +-
>   drivers/media/usb/hdpvr/Kconfig               |   2 +-
>   drivers/media/usb/msi2500/Kconfig             |   2 +-
>   drivers/media/usb/pvrusb2/Kconfig             |   2 +-
>   drivers/media/usb/pwc/Kconfig                 |   2 +-
>   drivers/media/usb/s2255/Kconfig               |   2 +-
>   drivers/media/usb/stkwebcam/Kconfig           |   2 +-
>   drivers/media/usb/usbtv/Kconfig               |   2 +-
>   drivers/media/usb/uvc/Kconfig                 |   2 +-
>   drivers/media/usb/zr364xx/Kconfig             |   2 +-
>   drivers/media/v4l2-core/Kconfig               |  12 +-
>   drivers/media/v4l2-core/Makefile              |   2 +-
>   drivers/staging/media/atomisp/Kconfig         |   2 +-
>   drivers/staging/media/atomisp/i2c/Kconfig     |  14 +-
>   drivers/staging/media/hantro/Kconfig          |   2 +-
>   drivers/staging/media/imx/Kconfig             |   2 +-
>   drivers/staging/media/ipu3/Kconfig            |   2 +-
>   drivers/staging/media/max96712/Kconfig        |   2 +-
>   drivers/staging/media/meson/vdec/Kconfig      |   2 +-
>   drivers/staging/media/omap4iss/Kconfig        |   2 +-
>   drivers/staging/media/rkvdec/Kconfig          |   2 +-
>   drivers/staging/media/sunxi/cedrus/Kconfig    |   2 +-
>   drivers/staging/media/tegra-video/Kconfig     |   2 +-
>   drivers/staging/media/zoran/Kconfig           |   2 +-
>   drivers/staging/most/video/Kconfig            |   2 +-
>   .../vc04_services/bcm2835-camera/Kconfig      |   2 +-
>   drivers/usb/gadget/Kconfig                    |   2 +-
>   drivers/usb/gadget/legacy/Kconfig             |   2 +-
>   sound/pci/Kconfig                             |   4 +-
>   116 files changed, 371 insertions(+), 376 deletions(-)


Reviewed-by: Neil Armstrong <narmstrong@baylibre.com> # for meson-vdec & meson-ge2d
