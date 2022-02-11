Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56EE4B2E2E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350378AbiBKUFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:05:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345579AbiBKUFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:05:46 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645E2CEF;
        Fri, 11 Feb 2022 12:05:43 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 72E661F47303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644609942;
        bh=o4MNnjz0g9MzLgF7YAjio5nz9ZeVzPRdWcJ/3ixks5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1bDNZ3+pFlYzR86aNw+bDkYHR6gTj+C/KjVGpnoZxktcBwYndQ87DLKvA/mgnshA
         zfQFwtGYjvKqiSQ3vut/WG29G2SvZPwL1OoSEdrQMFCwKY0LRcAvn9204z+S0d+bku
         QLrH8HnD7E4ritTGBPAXh0mwxhP0vQWgtNnMiajq2PrDjWOQt7J1T9OOu9WkA8s7K+
         qGWzg8NF1NecangLtK5PM5eEmLqCSw3CFZiIzjDHqxMTIrJ+Rc+4S4s5JNQjZhwmr1
         VVhZHfCf/g9Cc4ZF8Gl25Bv/grgDqE2NaZVoXSMLXG6W+yC+Mydesl9oOHjQBfii7P
         zKScceZDto1fQ==
Date:   Fri, 11 Feb 2022 15:05:35 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
Subject: Re: [PATCH] arm64: dts: mt8192: Add watchdog node
Message-ID: <20220211200535.yt7nco3c4awweih4@notapiano>
References: <20220207094024.22674-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220207094024.22674-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

thanks for the patch.

On Mon, Feb 07, 2022 at 05:40:24PM +0800, Allen-KH Cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> Add watchdog device node to MT8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index cc3953df0153..c1d4030e7e4b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -301,6 +301,12 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		watchdog: watchdog@10007000 {
> +			compatible = "mediatek,mt8192-wdt";
> +			reg = <0 0x10007000 0 0x100>;
> +			#reset-cells = <1>;
> +		};
> +
>  		apmixedsys: syscon@1000c000 {
>  			compatible = "mediatek,mt8192-apmixedsys", "syscon";
>  			reg = <0 0x1000c000 0 0x1000>;
> -- 
> 2.18.0
> 
