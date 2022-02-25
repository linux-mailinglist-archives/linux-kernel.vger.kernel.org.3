Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853DA4C4B16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243188AbiBYQn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243162AbiBYQnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:43:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0511516F978;
        Fri, 25 Feb 2022 08:42:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z22so8231551edd.1;
        Fri, 25 Feb 2022 08:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=S8SL7rE8T9Den9dkGBlQpTedO4EN66ojHcp4IxiL2TY=;
        b=X+IaxB/CALk6pahXiXUiNOX+jWZ48DJse2PS08TfmsykL+yrkf0pMzH+Wm/ZnLaMyx
         kZ8E3e7hNdKZt/buRQwAZwF1Z8EvsJm4vo3QIEhnGLbWyOZ93upQDcnZ7wff24bGxK8h
         bPal1Kp0gueh0fV0jZ3w/wyI2t+MDBWIYnE+gbHoyqxNFPshtlAo0xnkRMq4r0+gwowI
         XSOYyd2fCmLmOA5pKagLZ48rH6zmtf4M2Gak+efIRuOGB6aBrxe73XxKclUhOM+nnrMx
         sN+oaRc3tq5LOXslhLm0sm8FASkyOQdIzZoaGkUYq93rYAw+Vnkb9/fb6KIkonhyjtwv
         IFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=S8SL7rE8T9Den9dkGBlQpTedO4EN66ojHcp4IxiL2TY=;
        b=5kTCihLMEAdThWBR1CJW5MV0q2mqSZs1lW57FWpZwFPBMrLwNpOu2jQcFdfO1JWes+
         WglB6noPw0zE+VzL5KuvPXYRp3qZSJBe6DfS6aJSHmGJqvNPmjU2AmsTD0QBcKdSB/o2
         JA9NqUBDbcRfc9sr6C22OiUnOKGXqn3Dh1BDLOYSOGF9ij9V7Xck3dQsxbTHYI7V+aup
         qbE4pHYE7zZYlaMSmtHaAaUR89CJ9bw8+U3eDOdmAgYDNqVwJkzjAKNO5G8WWvWSuREW
         qNvJs4zNRjdrJg5gTSdeX17PNTvTgcDOqR/izQZctw83nfh+b+Thf3DtaZYucarNXb+e
         50FQ==
X-Gm-Message-State: AOAM531eTiddFSBLpGX+mRRCifiSgQSR6dyBKfAT7Bc9NLsIk6M5xNfh
        3UjBsrhiUU/KKCk+KuTFkfU=
X-Google-Smtp-Source: ABdhPJzVekY5Q6L+YRXw49HZO/1wKiAFTfdXshcnDoen7ncUKqnFoPPqIOZVbdltr3saEk+SiLt7cw==
X-Received: by 2002:a50:e004:0:b0:410:a39b:e30c with SMTP id e4-20020a50e004000000b00410a39be30cmr7738034edl.198.1645807365494;
        Fri, 25 Feb 2022 08:42:45 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id lx9-20020a170906af0900b006d0d3179e11sm1197992ejb.105.2022.02.25.08.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 08:42:45 -0800 (PST)
Message-ID: <f9488e93-6794-21bd-1e50-126c15dace1e@gmail.com>
Date:   Fri, 25 Feb 2022 17:42:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: move power domain PD_PIPE to
 rk356x
Content-Language: en-US
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
References: <20220225131602.2283499-1-michael.riesch@wolfvision.net>
 <20220225131602.2283499-2-michael.riesch@wolfvision.net>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220225131602.2283499-2-michael.riesch@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Some more comments. Have a look if it's useful.

On 2/25/22 14:15, Michael Riesch wrote:
> The power domain PD_PIPE was moved to the RK3568 specific dtsi but
> is available on the RK3566 as well. Move it back to the shared dtsi.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568.dtsi | 16 ----------------
>  arch/arm64/boot/dts/rockchip/rk356x.dtsi | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 91a0b798b857..ecc0f3015915 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -100,19 +100,3 @@ opp-1992000000 {
>  		opp-microvolt = <1150000 1150000 1150000>;
>  	};
>  };

> -
> -&power {
> -	power-domain@RK3568_PD_PIPE {
> -		reg = <RK3568_PD_PIPE>;
> -		clocks = <&cru PCLK_PIPE>;

Should contain a complete list of rk3568 clocks for which RK3568_PD_PIPE
must be enabled.

Could someone check which we need here?
Same for rk3566 but then reduced.

<&cru PCLK_PIPE>,

<&cru PCLK_XPCS>,

<&cru CLK_USB3OTG0_REF>,
<&cru CLK_USB3OTG0_SUSPEND>,
<&cru ACLK_USB3OTG0>,

<&cru CLK_USB3OTG1_REF>,
<&cru CLK_USB3OTG1_SUSPEND>,
<&cru ACLK_USB3OTG1>,

<&cru ACLK_SATA0>,
<&cru CLK_SATA0_PMALIVE>,
<&cru CLK_SATA0_RXOOB>

<&cru ACLK_SATA1>,
<&cru CLK_SATA1_PMALIVE>,
<&cru CLK_SATA1_RXOOB>,

<&cru ACLK_SATA2>,
<&cru CLK_SATA2_PMALIVE>,
<&cru CLK_SATA2_RXOOB>

<&cru ACLK_PCIE20_MST>,
<&cru ACLK_PCIE20_SLV>,
<&cru ACLK_PCIE20_DBI>,
<&cru PCLK_PCIE20>,
<&cru CLK_PCIE20_AUX_NDFT>

<&cru ACLK_PCIE30X1_MST>,
<&cru ACLK_PCIE30X1_SLV>,
<&cru ACLK_PCIE30X1_DBI>,
<&cru PCLK_PCIE30X1>,
<&cru CLK_PCIE30X1_AUX_NDFT>

<&cru ACLK_PCIE30X2_MST>,
<&cru ACLK_PCIE30X2_SLV>,
<&cru ACLK_PCIE30X2_DBI>,
<&cru PCLK_PCIE30X2>,
<&cru CLK_PCIE30X2_AUX_NDFT>;

> -		pm_qos = <&qos_pcie2x1>,
> -			 <&qos_pcie3x1>,
> -			 <&qos_pcie3x2>,
> -			 <&qos_sata0>,
> -			 <&qos_sata1>,
> -			 <&qos_sata2>,
> -			 <&qos_usb3_0>,
> -			 <&qos_usb3_1>;
> -		#power-domain-cells = <0>;
> -	};

Maybe keep it here for rk3568.

> -};
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 8b9fae3d348a..742f5adcdf2b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -490,6 +490,20 @@ power-domain@RK3568_PD_RKVENC {
>  					 <&qos_rkvenc_wr_m0>;
>  				#power-domain-cells = <0>;
>  			};

> +
> +			power-domain@RK3568_PD_PIPE {
> +				reg = <RK3568_PD_PIPE>;

> +				clocks = <&cru PCLK_PIPE>;
> +				pm_qos = <&qos_pcie2x1>,
> +					 <&qos_pcie3x1>,
> +					 <&qos_pcie3x2>,
> +					 <&qos_sata0>,
> +					 <&qos_sata1>,
> +					 <&qos_sata2>,
> +					 <&qos_usb3_0>,
> +					 <&qos_usb3_1>;
> +				#power-domain-cells = <0>;
> +			};

rk3566 doesn't have a combphy0
Already in rk3566.dtsi

&power {
	power-domain@RK3568_PD_PIPE {
		reg = <RK3568_PD_PIPE>;

		clocks = <&cru PCLK_PIPE>;


Should contain a complete list of rk3566 clocks for which RK3568_PD_PIPE
must be enabled.

		pm_qos = <&qos_pcie2x1>,
			 <&qos_sata1>,
			 <&qos_sata2>,

			 <&qos_usb3_0>,

Does rk3566 have a qos_usb3_0 ??
See support list below.

			 <&qos_usb3_1>;
		#power-domain-cells = <0>;
	};
};

===

Rockchip RK3568 Datasheet V1.0-20201210.pdf page 16

Multi-PHY0 support one of the following interfaces
USB3.0 OTG
SATA0

Multi-PHY1 support one of the following interfaces
USB3.0 Host
SATA1
QSGMII/SGMII

Multi-PHY2 support one of the following interfaces
PCIe2.1
SATA2
QSGMII/SGMII

===

Rockchip RK3566 Datasheet V1.0-20201210.pdf page 16

Multi-PHY1 support one of the following interfaces
USB3.0 Host
SATA1

Multi-PHY2 support one of the following interfaces
PCIe2.1
SATA2

===

https://eji4evk5kxx.exactdn.com/wp-content/uploads/2020/12/RK3568-multiplexed-sata-usb-3.0-pcie.jpg?lossy=1&ssl=1


On rk3568:
&usb_host0_xhci {
	phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
	phy-names = "usb2-phy", "usb3-phy";
};

Does this exists on rk3566?

&usb_host0_xhci {
	phys = <&usb2phy0_otg>;
	phy-names = "usb2-phy";
};

If not then why is usb_host0_xhci in a common rk356x.dtsi ??
Else fix rk3566.dtsi

===

Johan



>  		};
>  	};
>  
