Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84118563C79
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiGAWpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGAWpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:45:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0C9564D0;
        Fri,  1 Jul 2022 15:45:50 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 492C86601802;
        Fri,  1 Jul 2022 23:45:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656715549;
        bh=dMkhMWDLV8DoGp5vVqOTNrDfZz6ODLc2/CxTYZKYwz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5qPKJ5W5EoBqXWpQldSNP5tojZTuOuvLuj8ZMTe7t14rhJtbGtUu12xDfmo7UlDU
         VaOHn3sjgqKjn+ofEJg1WG3S2/JjcUAu5tsDETI59CCwXfTY7WdhCc3oB+cpPLqnRQ
         kttdnYcehORKV/AlXZco1VrD9P6OLQVnQwSO336s49NFSeI2H9OiptZxkkxAzR4M+I
         lC/ukgJ2k4bjGgm3FwTx2tNhDLPQU2sKPtSzHjd6Ulkbsps0vmJ3T4M9zfGJlHDKpp
         1L+9i9AOnQnoV8B80e/nNGeOHnEnBS/wQcT0128sb+qoO0SlQb+LT7kVTvU6U1LgmJ
         LmZB0Y/TMzS/w==
Date:   Fri, 1 Jul 2022 18:45:41 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        allen-kh.cheng@mediatek.com, gtk3@inbox.ru, luca@z3ntu.xyz,
        sam.shih@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: Re: [PATCH 09/11] arm64: dts: mediatek: cherry: Enable MT6360
 sub-pmic on I2C7
Message-ID: <20220701224541.nyjpv6fjs6ge6p4m@notapiano>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-10-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630153316.308767-10-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:33:14PM +0200, AngeloGioacchino Del Regno wrote:
> All devices of the Cherry platform have a MT6360 sub-pmic,
> providing two LDOs. Add the required node to enable the PMIC
> but without regulators yet, as these will be added in a
> later commit.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 379d0e5c4055..1668aa1be373 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -161,6 +161,18 @@ &i2c7 {
>  	clock-frequency = <400000>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c7_pin>;
> +
> +	pmic@34 {
> +		#interrupt-cells = <2>;

The binding says this should be 1.

Otherwise,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
