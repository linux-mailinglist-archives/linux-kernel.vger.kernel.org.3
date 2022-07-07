Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC12C56A5B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiGGOmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiGGOmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:42:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD6A32062;
        Thu,  7 Jul 2022 07:42:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso10829128wmq.4;
        Thu, 07 Jul 2022 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hFBY/59HAcFXCoUkn6tpERfsKHI5WTonhgCZoTEbwOg=;
        b=AAATC3IjXA6RsahrVYilBmFfSZ0oguDLc8FvDpacKln1dFLCUvEQZ2nN6IR5h+zGC5
         PNRYRY5SuGZH+FdXjM8eG/xR1tcE0uouLFZTBfR9y52L9t+jidmQiVG5ghkp4MJVDPHA
         ASvn0USJ5JXe7VcHNYfvMklfuUa6H6TrV329QRNRhYi4O3EXbpt872KWynvrNWeDLfc1
         Mt+1UO2Bxdt1Jb1oILXZxD8BAL6ZyjOTVWnDjIk9/0ho1F8YK0Qeul64ZQPAx+N+5vb+
         itGx7lAflAgy8SaDBo5AXQP3SRjLEqcsoRiwcABoep6kSXWxQ2CDdkSe9McOVTvUyNsA
         2GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hFBY/59HAcFXCoUkn6tpERfsKHI5WTonhgCZoTEbwOg=;
        b=D+83TAFB9N9N7swm6PJB7FjzoS0JLqL33IpqZoEJOdgGgD88hvsqFmfTrIzFvEWCWS
         ecBa6P5VhoZpwS+FDSpbn4YCFDhb4IZZv3DDDmzrZWmWTuVDJXgTzbY8nzut3vb2ujxZ
         eAJz11G1EqnDLAckCx7iX9KMTeAXKSVEIKvtDXn+6LO8/1heRjds8XXgm7pyyu7j01ZL
         PQ1e4I2vrnNeYat8d471SOzJ/dkZAObOKzceOmwm6rmC622ZlyNohxpwTUtoNfxulUfS
         nscXPnR+3r7odZqRBjckoPuCsdiuPIioBsJC67Oc6zcp3EWaFp+nCFo1D90v8LY2F8wv
         8MGw==
X-Gm-Message-State: AJIora/TQAZYvQjMOC2JRS9fMS0RZbc8JcC61Q/L1exwjUfStnNwur/g
        VQeJfoS7cMYUie+8FUQfWaw=
X-Google-Smtp-Source: AGRyM1sWtLR8zgi6kzKF2OShM6ctfTjiFq7rNCAiC2vlw6wFlKpTJ4dcj02VoAJ2FYooe9pPWq0Fog==
X-Received: by 2002:a05:600c:4e8d:b0:3a1:2e4d:1dd2 with SMTP id f13-20020a05600c4e8d00b003a12e4d1dd2mr5074937wmq.85.1657204931102;
        Thu, 07 Jul 2022 07:42:11 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0021d62e30a62sm14467685wrl.50.2022.07.07.07.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:42:10 -0700 (PDT)
Message-ID: <0958f352-2eaa-d051-ec14-a379bb2c0d8c@gmail.com>
Date:   Thu, 7 Jul 2022 16:42:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 00/11] MT8195 Chromebooks devicetrees - Google Tomato
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        gtk3@inbox.ru, luca@z3ntu.xyz, sam.shih@mediatek.com,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
References: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
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



On 04/07/2022 12:13, AngeloGioacchino Del Regno wrote:
> This is the first part for upstreaming Google's Cherry Tomato
> Chromebook (Acer Chromebook Spin 513): in this series, we introduce
> the devicetrees for the four revisions of this Chromebook and enable
> every controller and feature that can be added as per the current
> state of the main SoC devicetrees (mt8195.dtsi) and its PMIC
> devicetree (mt6359.dtsi).
> 
> More parts will come as soon as more support will be added by
> MediaTek in the mt8195 devicetree.
> 

Series applied, thanks!

> Note: This series will introduce a dtbs_check warning about a failure
>        to match compatible for 'mediatek,mt6359': that's expected, as
>        this is defined in devicetree/bindings/mfd/mt6397.txt (so there
>        is no schema, yet).
> 
> Changes in v2:
>   - Added changes from Nìcolas' review
>   - Changed board 'model' from 'MediaTek Tomato' to 'Acer Tomato'
> 
> This series depends on the following fixes:
> [1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220630110453.186526-1-angelogioacchino.delregno@collabora.com/
> [2]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220630122334.216903-1-angelogioacchino.delregno@collabora.com/
> [3]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220630131543.225554-1-angelogioacchino.delregno@collabora.com/
> 
> 
> And it depends on Nìcolas' dt-bindings patch for the [01/11] to
> apply cleanly (this is done to keep mediatek.yaml ordered):
> [4]: https://lore.kernel.org/all/20220629155956.1138955-2-nfraprado@collabora.com/
> 
> 
> AngeloGioacchino Del Regno (11):
>    dt-bindings: arm: mediatek: Add MT8195 Cherry Tomato Chromebooks
>    arm64: dts: mediatek: Introduce MT8195 Cherry platform's Tomato
>    arm64: dts: mediatek: cherry: Add platform regulators layout and
>      config
>    arm64: dts: mediatek: cherry: Assign interrupt line to MT6359 PMIC
>    arm64: dts: mediatek: cherry: Add support for internal eMMC storage
>    arm64: dts: mediatek: cherry: Document gpios and add default pin
>      config
>    arm64: dts: mediatek: cherry: Enable I2C and SPI controllers
>    arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers
>    arm64: dts: mediatek: cherry: Enable MT6360 sub-pmic on I2C7
>    arm64: dts: mediatek: cherry: Enable support for the SPI NOR flash
>    arm64: dts: mediatek: cherry: Add I2C-HID touchscreen on I2C4
> 
>   .../devicetree/bindings/arm/mediatek.yaml     |  13 +
>   arch/arm64/boot/dts/mediatek/Makefile         |   3 +
>   .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  15 +
>   .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  35 +
>   .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  36 +
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 702 ++++++++++++++++++
>   6 files changed, 804 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> 
