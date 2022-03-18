Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E584DD91C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiCRLnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbiCRLnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:43:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579BB1AFE81;
        Fri, 18 Mar 2022 04:41:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C64901F45EBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647603717;
        bh=38LWzYJDtDdvCT+rEuKuiIONjBDiSSh7TRAEYzRgbQA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LhYBoKjN1NdA3+zF6zvnERYP7YgAG1aMkjiCxnTw00yK87owK5SvAoZTgcbtGmsxS
         1Qdc9p77vNYwYKLtPC8liOtDnZ9hETH8zPKUB7ZIwYy2HWcH7ysngbvny4F/KODc1a
         A3AHI0uAeTvvgJbd9dj9exQYEY5BqGkfk+mrgCnAuBVLFyJoMsWKl/bcgfp8WS88Ye
         4xvYWEHvnqsUnO9M9gBDFiMXZHlacSu3PI8ngrLnmwgVNTJpD4DDDScW/hCbCdNm8E
         aeet8ZhJ3srH2vf5L/01UD9oL1K3IYHgJ90wL3GfcUaTQygjVsfgNEhUgi+CqWgRQA
         3AqYF3cbDx5Gw==
Message-ID: <07a02061-6528-a772-c91f-a658c6170a83@collabora.com>
Date:   Fri, 18 Mar 2022 12:41:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 00/10] Introduce support for MediaTek MT8192 Google
 Chromebooks
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220316151327.564214-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220316151327.564214-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/03/22 16:13, Nícolas F. R. A. Prado ha scritto:
> 
> This series introduces Devicetrees for the MT8192-based Asurada platform
> as well as Asurada Spherion and Asurada Hayato boards.
> 
> Support for the boards is added to the extent that is currently enabled
> in the mt8192.dtsi, as to not add any dependencies to this series.
> 
> After the series adding various missing nodes on MT8192 [1] is merged, a
> new series will be sent enabling the remaining devices on the Asurada
> platform.
> 
> While the dts files added in this series introduce a couple new
> dtbs_check warnings, they are fixed by another series [2].
> 
> This series was peer-reviewed internally before submission.

This series was not only peer-reviewed internally, but also tested so, for the
entire series, other than my R-b, if that's relevant:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> 
> [1] https://lore.kernel.org/linux-mediatek/20220304130809.12924-1-allen-kh.cheng@mediatek.com/
> [2] https://lore.kernel.org/linux-mediatek/20220315211936.442708-1-nfraprado@collabora.com/
> 
> 
> Nícolas F. R. A. Prado (10):
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
> 
>   arch/arm64/boot/dts/mediatek/Makefile         |   2 +
>   .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  18 +
>   .../mediatek/mt8192-asurada-spherion-r0.dts   |  33 +
>   .../boot/dts/mediatek/mt8192-asurada.dtsi     | 616 ++++++++++++++++++
>   4 files changed, 669 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> 

