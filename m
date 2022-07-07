Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF6D56A5A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiGGOkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiGGOkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:40:11 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE7131DF4;
        Thu,  7 Jul 2022 07:40:06 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m13so17075096ioj.0;
        Thu, 07 Jul 2022 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lLAAA3jB5ned5BtejBh+nPdee1Nblybf2I+LfI9tzQs=;
        b=bOH+gOGS1u/iAoiZWro7bolFufuXBkMZK3BmdgRtq6mS8ETkhcbgAz/GaBT87WcvUM
         7CO9/h/JJBpBzlMwLoho5HxJU5wq7xtlmSv/8XgyPISZZrN56CyegikUvPhyU1b9/ZKz
         qvQL9alQJoWSzkV2ZYZxobmAUomcpncFitywVRS2qiQqaa448ZpkcuLhzydHoEwRJl3p
         u1I4P1sxV66/HohRwRZQ8UvoFTIvx4bvoyQB2s9ZCkRtozwq4EiGZieQEn0ppg3Uckzi
         jxlTcs/h2v89lnyEifEx91C16k/3nONG2M7Zs8c+kMsLF0+JDPhnZsocRKEm5chJXwLK
         INkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lLAAA3jB5ned5BtejBh+nPdee1Nblybf2I+LfI9tzQs=;
        b=V4z7XtlfHNZy+igKy9aiGv7kNys2a1NLXLFQBW5Md1Zivjkh3XfJjlbdOMPJhGk/bY
         4CCWF5gc9QBXFe907W7eL2jpCbUc3UFcEyr1/kclhBjhJicqSwAKI2A/QukxOl9v7rg9
         YxWtGHI1ymkXl5PwbUnEgV93uHCcwVUhP8+ArLY/T4oAXfPlTAHQa089PIkJcNEbz2sP
         WV+4l++RjgL78X9vSiKIDDNpI8eKGDEE7yYwFWfk0DKLIlzMkMG8qUB/58ic9I4UzYcg
         YJzjAPOq6JxBwdCJ2WE2scg3pfsWz4Ml03v658zDIsi9em4Iw+Ei950ltGMmqp7cArzE
         L42w==
X-Gm-Message-State: AJIora9zUco3xYTmwKl4Cgeg8Hcao0COWuXguiVxfatLuh+Tg7Xr5OXS
        3xrigbnbDCeGhq4Uk1eJPuM=
X-Google-Smtp-Source: AGRyM1tcdZz6WCLgzbZOg4t66E2w8JRX6w6VJKKALhz2O8eKDvyuRelZup930FhxSmAKhzVB6L13Zg==
X-Received: by 2002:a05:6602:1593:b0:678:d98b:cf60 with SMTP id e19-20020a056602159300b00678d98bcf60mr3584389iow.172.1657204805902;
        Thu, 07 Jul 2022 07:40:05 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i5-20020a056e02054500b002dc27838576sm2847886ils.77.2022.07.07.07.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:40:04 -0700 (PDT)
Message-ID: <730cf556-6512-1d54-b798-01aa90a88406@gmail.com>
Date:   Thu, 7 Jul 2022 16:40:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 00/19] Introduce support for MediaTek MT8192 Google
 Chromebooks
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, Maxim Kutnij <gtk3@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220629155956.1138955-1-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220629155956.1138955-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 29/06/2022 17:59, Nícolas F. R. A. Prado wrote:
> 
> This series introduces Devicetrees for the MT8192-based Asurada platform
> as well as Asurada Spherion and Asurada Hayato boards.
> 
> Support for the boards is added to the extent that is currently enabled
> in the mt8192.dtsi, and using only properties already merged in the
> dt-bindings, as to not add any dependencies to this series.
> 
> This series was peer-reviewed internally before submission.
> 

Whole series applied. Thanks!

> Series tested on next-20220629.
> 
> v3: https://lore.kernel.org/all/20220512205602.158273-1-nfraprado@collabora.com/
> v2: https://lore.kernel.org/all/20220505194550.3094656-1-nfraprado@collabora.com/
> v1: https://lore.kernel.org/all/20220316151327.564214-1-nfraprado@collabora.com/
> 
> Changes in v4:
> - Added patches 17-19 enabling MMC, SCP and SPI NOR flash
> - Switched mediatek,drive-strength-adv for drive-strength-microamp
> - Switched mediatek,pull-up-adv for bias-pull-up
> - Updated Vgpu minimum voltage to appropriate value
> 
> Changes in v3:
> - Renamed regulator nodes to be generic
> - Fixed keyboard layout for Hayato
> 
> Changes in v2:
> - Added patches 1-2 for Mediatek board dt-bindings
> - Added patches 13-16 enabling hardware for Asurada that has since been
>    enabled on mt8192.dtsi
> 
> Nícolas F. R. A. Prado (19):
>    dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-spherion
>    dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-hayato
>    arm64: dts: mediatek: Introduce MT8192-based Asurada board family
>    arm64: dts: mediatek: asurada: Document GPIO names
>    arm64: dts: mediatek: asurada: Add system-wide power supplies
>    arm64: dts: mediatek: asurada: Enable and configure I2C and SPI busses
>    arm64: dts: mediatek: asurada: Add ChromeOS EC
>    arm64: dts: mediatek: asurada: Add keyboard mapping for the top row
>    arm64: dts: mediatek: asurada: Add Cr50 TPM
>    arm64: dts: mediatek: asurada: Add Elan eKTH3000 I2C trackpad
>    arm64: dts: mediatek: asurada: Add I2C touchscreen
>    arm64: dts: mediatek: spherion: Add keyboard backlight
>    arm64: dts: mediatek: asurada: Enable XHCI
>    arm64: dts: mediatek: asurada: Enable PCIe and add WiFi
>    arm64: dts: mediatek: asurada: Add MT6359 PMIC
>    arm64: dts: mediatek: asurada: Add SPMI regulators
>    arm64: dts: mediatek: asurada: Enable MMC
>    arm64: dts: mediatek: asurada: Enable SCP
>    arm64: dts: mediatek: asurada: Add SPI NOR flash memory
> 
>   .../devicetree/bindings/arm/mediatek.yaml     |  13 +
>   arch/arm64/boot/dts/mediatek/Makefile         |   2 +
>   .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  47 +
>   .../mediatek/mt8192-asurada-spherion-r0.dts   |  62 ++
>   .../boot/dts/mediatek/mt8192-asurada.dtsi     | 959 ++++++++++++++++++
>   5 files changed, 1083 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> 
