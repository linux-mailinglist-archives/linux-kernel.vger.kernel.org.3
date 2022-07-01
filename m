Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E30563C47
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiGAWU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGAWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:20:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDF56F379;
        Fri,  1 Jul 2022 15:20:56 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9463A660177B;
        Fri,  1 Jul 2022 23:20:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656714054;
        bh=eo++abJtFM2trhQuGPaqjcct3hjPGbB9ZTDmZoj0k1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFlFCsXOTGHJosPSSpkqT3w4+Mz+1VCg1h7trqlD/0aVpMrAzX3lJWGlqiLQoaXvq
         2LJrJFglhIArxpmvrSWaUxeMqJMwJ6U84I1Ioc77hfqrIWr21/IEcFMOkeEf52ySuT
         YTyebCyBFwvQBJH2QvuIAH1G9C6INda6Jq2dxbz4vlorXG8GzV5R+QGaAvn21Hq1sh
         A0isuClit5UUMbaUI1u/KewO4A+bo0QRVwz03xVrdr8PPjQ8Fe6UV9A2hnHUbsbU+d
         42XiF+tGtOFHI2lxgl/A7CBZu9fhFQJiJ0ryvWgFg8dLqVHNN2nVziuP552LyK0yJs
         jswU7v95bYIJg==
Date:   Fri, 1 Jul 2022 18:20:45 -0400
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
Subject: Re: [PATCH 03/11] arm64: dts: mediatek: cherry: Assign interrupt
 line to MT6359 PMIC
Message-ID: <20220701222045.oyzynrjdvo4bfpdc@notapiano>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630153316.308767-4-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:33:08PM +0200, AngeloGioacchino Del Regno wrote:
> To allow MT6359 peripherals to trigger interrupts and the driver to
> safely handle them, assign the right interrupt line for the Cherry
> platform to the MT6359 PMIC node.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 7406d7bbf725..14f8f30b1eb3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -21,6 +21,10 @@ memory@40000000 {
>  	};
>  };
>  
> +&pmic {

This label references a node in mt6359.dtsi and you're missing the include here.
I noticed it does show up in the following patch, so either move this commit
after the next one or squash them.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> +	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
>  &uart0 {
>  	status = "okay";
>  };
> -- 
> 2.35.1
> 
