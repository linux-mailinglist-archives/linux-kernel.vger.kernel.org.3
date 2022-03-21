Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228F64E3368
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiCUWuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiCUWu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:50:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818073AA9B3;
        Mon, 21 Mar 2022 15:30:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id EB1D81F42B4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647901817;
        bh=dFAsJXFVHpj6L27TiVAj76slpePHnCZeJGPIhOfYCBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nxvWJ72cpm4nlluTG0iCgd2ziG647YzSolB4dxZnRO85gg4mrgijbJeZL6LTxb1l2
         pbpmGP9/0UpQnCZ+qrHlR7fj7kB7qNuY0CRU4pyvzloXxtG7vKjEAamIWEH82W06X3
         R8m/KRlyY6iUk+AzQJaVFJOjWm0muPpMYznIttYtzFv8UzkN/ky0Mc0HZldN7ZM8HD
         UjHJfz5hNBJQ40v84w9v7VnMumX0upmZ2l+MuH4r8DJvKz36Q2ZMgQiJu3br1Eb6+7
         /SWphaLm19v4JzxXKGxvoFsDAWSUPn32iAj7bA3FaeX5u+djgv6/ZbwiUs9u3Zb6li
         nv/+Oxk8cgwtg==
Date:   Mon, 21 Mar 2022 18:30:12 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
Subject: Re: [PATCH v4 10/22] arm64: dts: mt8192: Fix nor_flash status
 disable typo
Message-ID: <20220321223012.4sbj63pywc4mjqvc@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-11-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318144534.17996-11-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:45:22PM +0800, Allen-KH Cheng wrote:
> Correct nor_flash status disable typo of mt8192 SoC.
> 
> Fixes: d0a197a0d064a ("arm64: dts: mt8192: add nor_flash device node")
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 3a7f93d8eeaa..75c21edccf85 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -934,7 +934,7 @@
>  			assigned-clock-parents = <&clk26m>;
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -			status = "disable";
> +			status = "disabled";
>  		};
>  
>  		i2c3: i2c@11cb0000 {
> -- 
> 2.18.0
> 
> 
