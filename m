Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9585495260
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377022AbiATQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377001AbiATQaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:30:18 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1B1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:30:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id e9-20020a05600c4e4900b0034d23cae3f0so15016130wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VzQQqeSGM3LxrK+WlCEqJXUoY8XCwDe0p9TbewA3bqI=;
        b=SMmvG8ttOsH2vuDlmU0xbdKf8b0D1tZeGEAes0tKRsVpLPBDxdDKxdwg3kHTju7JRR
         q3B4myh5Iob5I9CE61Irl4AhfpX28mPM49bLGV9nKAHK4vpnf/41gRGfp3J0tyUfU0jG
         OHw4jUit5a+p5QtVu5gNEm00RX1xcns7bk1WZHVxxX/nLcqUeDYDs1lLYl+N8KNI7t1l
         Rv8XQ7BzAtoBAbVa683Znz2sAR/Ok49tux4Jml34p3qUvFe2168yZnVf9JGKaOW+5x9S
         nIsQdhXS7HnmTujM9T9qgK4QCZw842A3JYycTgXEh6yqW1UKtBxlDaiNELAVWD8HWx0I
         op9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=VzQQqeSGM3LxrK+WlCEqJXUoY8XCwDe0p9TbewA3bqI=;
        b=NfhMjMN+rHlWP7WC69Oms9JGlZmI+XKhLw56e/T0WoIaPaR6DuPJUIjJMPNE8nITEy
         LnTOQz9zD5VDhYgCfUFoTVC/+/768qAng8f3uuEWLc35fl3dnWrD5Mt5J2+rjkuwcEjb
         bHzsw7VQ+wy2zxwfIEzmzgfxj+is1bqKq0BNjyT64s4AK86ymIAQonv/sWhB3OPvB1nJ
         gBTILBJnwHmE70I/tva9fqYcIKBSvN0gYkkwj4jkE6W0nYLPhJGA+XhHSjalQW6zDIcr
         m3ZJr8BxTeZ/QOGrGq+MeMGPrvitH4Js+p+qVZuNRKqdRjU9a6rgIkjevOmmMXYa35pV
         lgTQ==
X-Gm-Message-State: AOAM532jeej4CsCcHVE/A0ALK7JiFuuCl9IH56sqmYbPKBHwy89jOIBH
        26FMRZO0K0e/fOwPoQZ2v+VIoA==
X-Google-Smtp-Source: ABdhPJy04CbGdXKCJfGvM1t5iOiiIWRQ30w4QVsJUTsNDk2vUYA8WdMht68yiE/0LjztlBaEdUy6Iw==
X-Received: by 2002:a1c:256:: with SMTP id 83mr6927850wmc.89.1642696216410;
        Thu, 20 Jan 2022 08:30:16 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:ced2:397a:bee8:75f5? ([2001:861:44c0:66c0:ced2:397a:bee8:75f5])
        by smtp.gmail.com with ESMTPSA id p15sm3074542wrq.66.2022.01.20.08.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 08:30:15 -0800 (PST)
Subject: Re: [PATCH v2 6/6] drm/meson: add support for MIPI-DSI transceiver
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org,
        martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220120083357.1541262-1-narmstrong@baylibre.com>
 <20220120083357.1541262-7-narmstrong@baylibre.com>
 <CAMty3ZBvbPvKgUpNW1LVho5_S9kwzNioE0SxvX_E8bmgw-+fXw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <b2086dd4-643f-26b3-3930-4d8beb170b75@baylibre.com>
Date:   Thu, 20 Jan 2022 17:30:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMty3ZBvbPvKgUpNW1LVho5_S9kwzNioE0SxvX_E8bmgw-+fXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/01/2022 15:24, Jagan Teki wrote:
> On Thu, Jan 20, 2022 at 2:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The Amlogic G12A/G12B/SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
>> with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI
>> Glue on other Amlogic SoCs.
>>
>> This adds support for the Glue managing the transceiver, mimicing the init flow provided
>> by Amlogic to setup the ENCL encoder, the glue, the transceiver, the digital D-PHY and the
>> Analog PHY in the proper way.
>>
>> An optional "MEAS" clock can be enabled to measure the delay between each vsync feeding the
>> DW-MIPI-DSI transceiver.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/Kconfig             |   7 +
>>  drivers/gpu/drm/meson/Makefile            |   1 +
>>  drivers/gpu/drm/meson/meson_dw_mipi_dsi.c | 357 ++++++++++++++++++++++
>>  drivers/gpu/drm/meson/meson_dw_mipi_dsi.h | 160 ++++++++++
>>  4 files changed, 525 insertions(+)
>>  create mode 100644 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
>>  create mode 100644 drivers/gpu/drm/meson/meson_dw_mipi_dsi.h
>>
>> diff --git a/drivers/gpu/drm/meson/Kconfig b/drivers/gpu/drm/meson/Kconfig
>> index 6c70fc3214af..71a1364b51e1 100644
>> --- a/drivers/gpu/drm/meson/Kconfig
>> +++ b/drivers/gpu/drm/meson/Kconfig
>> @@ -17,3 +17,10 @@ config DRM_MESON_DW_HDMI
>>         default y if DRM_MESON
>>         select DRM_DW_HDMI
>>         imply DRM_DW_HDMI_I2S_AUDIO
>> +
>> +config DRM_MESON_DW_MIPI_DSI
>> +       tristate "MIPI DSI Synopsys Controller support for Amlogic Meson Display"
>> +       depends on DRM_MESON
>> +       default y if DRM_MESON
>> +       select DRM_DW_MIPI_DSI
>> +       select GENERIC_PHY_MIPI_DPHY
>> diff --git a/drivers/gpu/drm/meson/Makefile b/drivers/gpu/drm/meson/Makefile
>> index 833e18c20603..43071bdbd4b9 100644
>> --- a/drivers/gpu/drm/meson/Makefile
>> +++ b/drivers/gpu/drm/meson/Makefile
>> @@ -6,3 +6,4 @@ meson-drm-y += meson_encoder_hdmi.o meson_encoder_dsi.o
>>
>>  obj-$(CONFIG_DRM_MESON) += meson-drm.o
>>  obj-$(CONFIG_DRM_MESON_DW_HDMI) += meson_dw_hdmi.o
>> +obj-$(CONFIG_DRM_MESON_DW_MIPI_DSI) += meson_dw_mipi_dsi.o
> 
> Can the naming convention prefix with dw-mipi-dsi like other glue
> drivers follow?

Seems only rockchip names their glue like that:

$ find drivers/gpu/drm/ -name "*dw*mipi*dsi*.c"
drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
drivers/gpu/drm/stm/dw_mipi_dsi-stm.c

If you look at dw-hdmi it's even worse:

$ find drivers/gpu/drm/ -name "*dw*hdmi*.c" | grep -v mod
drivers/gpu/drm/meson/meson_dw_hdmi.c
drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c
drivers/gpu/drm/bridge/synopsys/dw-hdmi-ahb-audio.c
drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
drivers/gpu/drm/imx/dw_hdmi-imx.c
drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c

Neil
> 
> Jagan.
> 
