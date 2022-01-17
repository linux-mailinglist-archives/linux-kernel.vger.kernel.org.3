Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD11C490637
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbiAQKrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbiAQKrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:47:19 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B516C061574;
        Mon, 17 Jan 2022 02:47:19 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b13so63969969edn.0;
        Mon, 17 Jan 2022 02:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kQrPFgdxVgPR6BVQXGQ/0R4Kn0v4ZftEF3a6Zc0bXEg=;
        b=VTl1vqutUhGOzDHpntFj3kNJ16v8xteNMJDLIGBN4SuZflcIMGQMoSGggoRb3tFdjQ
         ZGBScoCkznZzd4jZbF31zq/ShP/WPI5CoJUbNIKli7cbyFDmvaCx8rZqKedtwK/+Ej7q
         WuH5F+I7I7vNMF/mfmYbTxLYf8DvgwHTz1Epo6O1bwVQpBpq+EF8ydKmHyzBVYIDyMs8
         hYVnM7xdkst2GSo8BP9VCJ5XgWe9Un6juUTtiT+LSujXfGS27pOgB6nGBKp7jPsuAV0a
         JbPqIbe8VC+dPv43ZG6Hz5sJcYu0uRV1nkOFQTIFLl5iTeTxxTotjKh8dOLia1ot6NGv
         n68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kQrPFgdxVgPR6BVQXGQ/0R4Kn0v4ZftEF3a6Zc0bXEg=;
        b=kU3l8jyW1WCyXjLyM+2iHpETVJQN0EzSapB2CCpAyz5oDy5HHWsAW5g+oq0kKMbTX1
         P1/wMofH831EvgNpsxI3jq0oVtkAeUSEWIQctD2mMY+aUVgEr3HfKH4lyFZMw6ogUxQY
         6iNza/1Kf+BSyKKIHJ0tCJz39Q1A53DdXhO4cfNPmillM7EMrynJ/VblNCg1McupMD86
         fRPQ7qRTEzfxvwdeVRFGjX0TFHINLhshh6tQC2ed+A5c/34F0hdMmwOjxKcTy+nAIfFl
         1Ab3meuY3HMFWQqvnlCjqEH0isKaON935Ci3Ic/reAdTNJbtzP0xX5IJltX7b+URqJmr
         2E2w==
X-Gm-Message-State: AOAM531ft03//dlSS8nkZy1o3d06QYP18iFtH9bSlovLN3edNS+CGf7s
        00PSki6vp07GGLmdhityN0+0lEPJ/iI=
X-Google-Smtp-Source: ABdhPJy1fBH6oJcwoFfp0VB+M+Dxx9jIZNtaspcHFK8jiVeml0mwOxxjdGTIwB7HB8vIiF1gWaJWEg==
X-Received: by 2002:a05:6402:254d:: with SMTP id l13mr2009027edb.190.1642416437484;
        Mon, 17 Jan 2022 02:47:17 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l25sm2944774edc.20.2022.01.17.02.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 02:47:17 -0800 (PST)
Subject: Re: [PATCH v1 1/3] dts64: rk3568: drop pclk_xpcs from gmac0
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220116124911.65203-1-linux@fw-web.de>
 <20220116124911.65203-2-linux@fw-web.de>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <8285bea7-559c-5834-78c7-5a062b7d8269@gmail.com>
Date:   Mon, 17 Jan 2022 11:47:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220116124911.65203-2-linux@fw-web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Despite that the DT is hosted in the kernel tree
DT and mainline kernel driver support are 2 separate things.
PCLK_XPCS might be in use elsewhere.

Given the link below pclk_xpcs is only needed for rk3568.
Maybe gmac1 should have a PCLK_XPCS too, because one can select between
them.

ethernet: stmicro: stmmac: Add SGMII/QSGMII support for RK3568
https://github.com/rockchip-linux/kernel/commit/1fc7cbfe9e227c700c692f1de3137914b3ea6ca6

The original dtsi did have PCLK_XPCS in both nodes.
https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/boot/dts/rockchip/rk3568.dtsi#L2121
https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/boot/dts/rockchip/rk3568.dtsi#L1492

Maybe fix the document or leave it as it is for now as long the driver
isn't updated and someone has tested it.
That's up to the DT maintainer.

Johan

===

XPCS is also part of PD_PIPE.
See Rockchip RK3568 TRM Part1 V1.0-20210111.pdf page 475.
Please advise if the power-domain@RK3568_PD_PIPE does need a PCLK_XPCS
fix or is PCLK_PIPE enough in combination with a PHY driver?

PD_PIPE:

BIU_PIPE
USB3OTG
PCIE20
PCIE30
SATA
XPCS


	power-domain@RK3568_PD_PIPE {
		reg = <RK3568_PD_PIPE>;
		clocks = <&cru PCLK_PIPE>;
		pm_qos = <&qos_pcie2x1>,
			 <&qos_pcie3x1>,
			 <&qos_pcie3x2>,
			 <&qos_sata0>,
			 <&qos_sata1>,
			 <&qos_sata2>,
			 <&qos_usb3_0>,
			 <&qos_usb3_1>;
		#power-domain-cells = <0>;
	};



On 1/16/22 1:49 PM, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> pclk_xpcs is not supported and breaks dtbs_check, so remove it
> 
> following warnings occour, and many more
> 
> rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clocks:
>     [[15, 386], [15, 389], [15, 389], [15, 184], [15, 180], [15, 181],
>     [15, 389], [15, 185], [15, 172]] is too long
> 	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml
> rk3568-evb1-v10.dt.yaml: ethernet@fe2a0000: clock-names:
>     ['stmmaceth', 'mac_clk_rx', 'mac_clk_tx', 'clk_mac_refout', 'aclk_mac',
>     'pclk_mac', 'clk_mac_speed', 'ptp_ref', 'pclk_xpcs'] is too long
> 	From schema: Documentation/devicetree/bindings/net/snps,dwmac.yaml
> 
> after removing the clock the other warnings are also gone.
> 
> Co-developed-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 2fd313a295f8..d91df1cde736 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -32,13 +32,11 @@ gmac0: ethernet@fe2a0000 {
>  		clocks = <&cru SCLK_GMAC0>, <&cru SCLK_GMAC0_RX_TX>,
>  			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_MAC0_REFOUT>,
>  			 <&cru ACLK_GMAC0>, <&cru PCLK_GMAC0>,
> -			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_GMAC0_PTP_REF>,
> -			 <&cru PCLK_XPCS>;
> +			 <&cru SCLK_GMAC0_RX_TX>, <&cru CLK_GMAC0_PTP_REF>;
>  		clock-names = "stmmaceth", "mac_clk_rx",
>  			      "mac_clk_tx", "clk_mac_refout",
>  			      "aclk_mac", "pclk_mac",
> -			      "clk_mac_speed", "ptp_ref",
> -			      "pclk_xpcs";
> +			      "clk_mac_speed", "ptp_ref";
>  		resets = <&cru SRST_A_GMAC0>;
>  		reset-names = "stmmaceth";
>  		rockchip,grf = <&grf>;
> 
