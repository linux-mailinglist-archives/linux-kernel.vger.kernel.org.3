Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A674DE31D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbiCRVAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 17:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240968AbiCRVA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 17:00:29 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC31B3F69
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:59:09 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k25so10610560iok.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oNAPpR+5qx5bHO8wJ1SIgWig3LUKuwuqLo641jvFAak=;
        b=R3B03hXdzmRL4FMHavxss76+tb9Q0Hy78NbdGoHIgmWRsuIfciGr2JWywHMf/Kpkhf
         QniqntLtfhiE8E3Wo0oxTFcS1KWerJtG5tNgnrk3j2xUiX43wMMg+/mjp1wKd5A4aRIu
         ErIGjgvdava6sQlmLmDCO8Qr2P9RfzXvczFjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oNAPpR+5qx5bHO8wJ1SIgWig3LUKuwuqLo641jvFAak=;
        b=DzkffL/DWBReRodo+thzFwk3xaMMYISpo0jiFE9ceSbERsyEhorkJ0TkfjNlcy9+Yp
         Ku8qmO8O/CLVMC2KWStUrvZBkh/kLpYDBjzkU3AgpW5taiECsf/1j8uTLnr35zovfiVY
         h1z1T9TNMNNyNkW8mR7YT6ITMDOsm9aLtGpvXilPUVE6nRWt+BFYelJjJ0OgYsYyWIQo
         BLdGFP47zaleu0cQYzAJaisd4btlMgh20kXBAlx+stgEvjYtSBpYdwr+4hAnNqa8K7iD
         qjTif2VQMsZpw+NQGq2jl7JpkP/LgHeV5vpm74yNXQQkyRzFd75Io/GYRF01M5qwyewW
         7SWA==
X-Gm-Message-State: AOAM533mm5HVi+8uRcmo1bU3WcYg4oxE9z2cWtq6ntOXyah7L955DiMJ
        2VWvhvhCeRokv0JUDShYzL8R3w==
X-Google-Smtp-Source: ABdhPJw+g6qtXnLujFKVRv55AGvVhZcbGPndogV4eznqetPdpLwXYueCN6beIFsP8OoV/l235xaSaw==
X-Received: by 2002:a5d:9542:0:b0:648:f92b:7bc6 with SMTP id a2-20020a5d9542000000b00648f92b7bc6mr5223132ios.73.1647637149068;
        Fri, 18 Mar 2022 13:59:09 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d14-20020a056602328e00b006494aa126c2sm3528385ioz.11.2022.03.18.13.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 13:59:08 -0700 (PDT)
Subject: Re: [PATCH 64/64] media: Kconfig: cleanup VIDEO_DEV dependencies
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Heiko Stuebner <heiko@sntech.de>,
        Heungjun Kim <riverful.kim@samsung.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Joe Hung <joe_hung@ilitek.com>, Joel Stanley <joel@jms.id.au>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Martina Krasteva <martinax.krasteva@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Isely <isely@pobox.com>, Ming Qian <ming.qian@nxp.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Olivier Lorin <o.lorin@laposte.net>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Pavel Machek <pavel@ucw.cz>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ray Jui <rjui@broadcom.com>,
        Rick Chang <rick.chang@mediatek.com>,
        Robert Foss <robert.foss@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Scott Branden <sbranden@broadcom.com>,
        Sean Young <sean@mess.org>, Shawn Guo <shawnguo@kernel.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Todor Tomov <todor.too@gmail.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Yong Deng <yong.deng@magewell.com>,
        Yong Zhi <yong.zhi@intel.com>, Zhou Peng <eagle.zhou@nxp.com>,
        alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com,
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
        openbmc@lists.ozlabs.org, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1647242578.git.mchehab@kernel.org>
 <decd26e90adc5c16470e4f738810f22fe6478b27.1647242579.git.mchehab@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9e02d88a-3344-8d91-c652-72cb989506de@linuxfoundation.org>
Date:   Fri, 18 Mar 2022 14:59:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <decd26e90adc5c16470e4f738810f22fe6478b27.1647242579.git.mchehab@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/22 1:55 AM, Mauro Carvalho Chehab wrote:
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

>   drivers/media/test-drivers/vicodec/Kconfig    |   2 +-
>   drivers/media/test-drivers/vimc/Kconfig       |   2 +-
>   drivers/media/test-drivers/vivid/Kconfig      |   2 +-
>

For vimc change: (trimmed the recipient list to send response)

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



