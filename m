Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCDB4E4287
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiCVPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbiCVPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:11:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC64C245B6;
        Tue, 22 Mar 2022 08:10:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 724ED1F42FC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647961809;
        bh=AfZObamYsAzgBjwGBzLZ0dMwyLg8Ugk6+Wn+Vyfh5fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ceo3dxSOv/deDhh5BPmr3PA2Tm03KXBlilTS+pYcFXk5wdjPCkC2cquG2U1uGelti
         A+EDtqQBJ3d3+QFRBdmpQvaxMR/JJ8V3Bt/9/POutBQxkVz9Vdcbyzaf0a0e8jRKYC
         t/bGUDtW9HpyU0KpvqvB8zwc18QhCY6eyMThMOBXuy0uNCxuUI0WhfNBI0ZkWTo/EF
         b5ANXVeGlmR5o5buMsLti2/E+LxnyOrMvb2onsbgNdaav0FxZVgI5VxjytyVIua6F2
         f2HqFLuEdXrP8QUT0RfmPhuqdgsBF6WB+GvO3zyuZt1iSFzfj605gSHW7OAxsOaSV/
         T4it3pd62qz1A==
Date:   Tue, 22 Mar 2022 11:10:05 -0400
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
Subject: Re: [PATCH v4 11/22] arm64: dts: mt8192: Add efuse node
Message-ID: <20220322151005.vdds2i7qdi5mbcig@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-12-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318144534.17996-12-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 10:45:23PM +0800, Allen-KH Cheng wrote:
> Add efuse node for mt8192 SoC
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 75c21edccf85..6220d6962f58 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -937,6 +937,21 @@
>  			status = "disabled";
>  		};
>  
> +		efuse: efuse@11c10000 {
> +			compatible = "mediatek,efuse";
> +			reg = <0 0x11c10000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			lvts_e_data1: data1@1c0 {
> +				reg = <0x1c0 0x58>;
> +			};
> +
> +			svs_calibration: calib@580 {
> +				reg = <0x580 0x68>;
> +			};
> +		};
> +
>  		i2c3: i2c@11cb0000 {
>  			compatible = "mediatek,mt8192-i2c";
>  			reg = <0 0x11cb0000 0 0x1000>,
> -- 
> 2.18.0
> 
> 
