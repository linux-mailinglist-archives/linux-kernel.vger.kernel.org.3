Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52EC52D5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiESOQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiESOQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:16:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D59664727;
        Thu, 19 May 2022 07:16:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id C206B1F45D2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652969781;
        bh=XbAw2pqdCdBIkgqghfc0hWUSQub6dtMpVtqgjfj/UEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WhooF1ket7xkncwQFrVakvcjQz5Cnqvyn17ORhSJ1X1ouQpSeqoIEl54SKARlaAUQ
         XDB3L3hEfaQ3zJgJZS9sJOiWSg9TivMcVCyCyg2e290tkoiopeKV+xMfTfEIzWtclI
         IUKwk6LxPyBb5doe6T20ga9qzlBqN10pZROpBhOmzCLv+3Y8LiddH1y3myjkKcEZ8x
         0JBCuuHpH+8asdc3gg6CNCY5hNZQJ9DLqOYeXO1OlqBfh3TcneYMBeMaJSlbt2lCbr
         0VSeYgTwtYfQxJoO9ePC5wzLSMPUtTrUQ7NNMyqdKA5m73pRl3b/+4FGmbSCkVgSwz
         sU3cJTdzjkxZw==
Date:   Thu, 19 May 2022 10:16:15 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxim Kutnij <gtk3@inbox.ru>, Rob Herring <robh+dt@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 00/16] Introduce support for MediaTek MT8192 Google
 Chromebooks
Message-ID: <20220519141615.2ojp3pihvmwgg5zs@notapiano>
References: <20220512205602.158273-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512205602.158273-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 04:55:46PM -0400, Nícolas F. R. A. Prado wrote:
> 
> This series introduces Devicetrees for the MT8192-based Asurada platform
> as well as Asurada Spherion and Asurada Hayato boards.
> 
> Support for the boards is added to the extent that is currently enabled
> in the mt8192.dtsi, as to not add any dependencies to this series.
> 
> This series was peer-reviewed internally before submission.

Hi,

it was noticed that there are some inconsistencies in the pinctrl-mt8192.c
driver and patches will be sent to fix them. Since this series would add the
first users for the mt8192 pinctrl, let's hold off this series for now, in order
to avoid any ABI breakage. After the pinctrl patches land, I'll do any updates
needed in the DT and send a new version for this series.

Thanks,
Nícolas

> 
> v2: https://lore.kernel.org/all/20220505194550.3094656-1-nfraprado@collabora.com/
> v1: https://lore.kernel.org/all/20220316151327.564214-1-nfraprado@collabora.com/
> 
> Changes in v3:
> - Renamed regulator nodes to be generic
> - Fixed keyboard layout for Hayato
> 
> Changes in v2:
> - Added patches 1-2 for Mediatek board dt-bindings
> - Added patches 13-16 enabling hardware for Asurada that has since been
>   enabled on mt8192.dtsi
> 
> Nícolas F. R. A. Prado (16):
>   dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-spherion
>   dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-hayato
>   arm64: dts: mediatek: Introduce MT8192-based Asurada board family
>   arm64: dts: mediatek: asurada: Document GPIO names
>   arm64: dts: mediatek: asurada: Add system-wide power supplies
>   arm64: dts: mediatek: asurada: Enable and configure I2C and SPI busses
>   arm64: dts: mediatek: asurada: Add ChromeOS EC
>   arm64: dts: mediatek: asurada: Add keyboard mapping for the top row
>   arm64: dts: mediatek: asurada: Add Cr50 TPM
>   arm64: dts: mediatek: asurada: Add Elan eKTH3000 I2C trackpad
>   arm64: dts: mediatek: asurada: Add I2C touchscreen
>   arm64: dts: mediatek: spherion: Add keyboard backlight
>   arm64: dts: mediatek: asurada: Enable XHCI
>   arm64: dts: mediatek: asurada: Enable PCIe and add WiFi
>   arm64: dts: mediatek: asurada: Add MT6359 PMIC
>   arm64: dts: mediatek: asurada: Add SPMI regulators
> 
>  .../devicetree/bindings/arm/mediatek.yaml     |  13 +
>  arch/arm64/boot/dts/mediatek/Makefile         |   2 +
>  .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  47 ++
>  .../mediatek/mt8192-asurada-spherion-r0.dts   |  62 ++
>  .../boot/dts/mediatek/mt8192-asurada.dtsi     | 748 ++++++++++++++++++
>  5 files changed, 872 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> 
> -- 
> 2.36.1
