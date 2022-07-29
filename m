Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676415855F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239143AbiG2UOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2UOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:14:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D98B86C1C;
        Fri, 29 Jul 2022 13:14:30 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 01AE26601B8B;
        Fri, 29 Jul 2022 21:14:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659125668;
        bh=G4GT0Els2R2O6vlylb/sPAqakzAO0cQG7B/tH51PEEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRKbidvNZSHnE0RihwLLsClpimZvmfrieKisTV9H8nPXadNlgHePR5iSRGqrzWmqz
         GvKCBSP5Y9j9eQK+RtEAmhLv/YMPgCDicqCvMRHVTOyUBdwxngGfCf4p4lU64aIEB/
         AkbgRn6Lfhz8lS4AayccSN1+IR/X2Rvsm7fzTK9+RNB1GOji/h1VZpYC3wT3gKXaJt
         krsxsnm00Yq47GNmtoDFQ3xKPkkx/IBbSTklQo6QFFPDViqUVTWjEzF78wkZjTDIfG
         R2UBLuZ774WBQedpkWci3XWz4/9wBLjimTpQQZt6lx2MwpTWYI5Y0a3kG79dlDXRar
         PGPvmvpDBMKHQ==
Date:   Fri, 29 Jul 2022 16:14:21 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: Re: [PATCH v8 5/6] arm64: dts: mt8195: Add efuse node to mt8195
Message-ID: <20220729201421.fxybo57g46ftghgd@notapiano>
References: <20220726135506.485108-1-bchihi@baylibre.com>
 <20220726135506.485108-6-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726135506.485108-6-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 03:55:05PM +0200, Balsam CHIHI wrote:
> This adds the efuse node. This will be required by the thermal driver
> to get the calibration data.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 0ff34edcf8c8..4fbf24b5d202 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1236,6 +1236,22 @@ nor_flash: spi@1132c000 {
>  			status = "disabled";
>  		};
>  
> +		efuse: efuse@11c10000 {
> +			compatible = "mediatek,efuse";
> +			reg = <0 0x11c10000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			lvts_efuse_data1: lvts1-calib@1bc {
> +				reg = <0x1bc 0x14>;
> +			};
> +			lvts_efuse_data2: lvts2-calib@1d0 {
> +				reg = <0x1d0 0x38>;
> +			};
> +			svs_calibration: calib@580 {
> +				reg = <0x580 0x64>;
> +			};
> +		};
> +

This commit doesn't apply, there's already an efuse node on mt8195.dtsi. Please
rebase.

Thanks,
Nícolas
