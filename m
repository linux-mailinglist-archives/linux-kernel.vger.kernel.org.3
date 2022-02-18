Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2174BBA79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 15:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbiBROMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 09:12:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbiBROMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 09:12:20 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91571CF3FF;
        Fri, 18 Feb 2022 06:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AFOMvvbG8wpHBqSiIQwNOw6u0U2QISmLN6bKLzdQXKw=; b=KyrMSeWSyxqM/fC2RFpPFiAYaS
        +ICxvIgoTnG8sWBJofCZieifqspQFS0M/v89LcNAaQ7xwsoq2XzeJVB+eafefJ+AeMCyJIwXOKt6M
        m68cqbhvZi7On1/qFsDZfdHd4nbN2Fti3pXiP7kAcBsjtLjIVDGDxZIXiXrk6JXHTL8VZy1PPbrRK
        3IrvRtCopph/R9rGVKg7ZnpWVnNoBXup8l4+nzCxsGL6tQ1TxVfY4hatCUUyO5r+bX/YscegBEhex
        Xop8ThM3JoDLO43pUV1vbq7J6s7hgzipvO2g+UNkuEk7QaYqTEKblFDffIRDwOt9Wyd0vhqaMjIDN
        lP2c7u9w==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1nL3zL-008mdX-Qw; Fri, 18 Feb 2022 14:11:59 +0000
Date:   Fri, 18 Feb 2022 14:11:59 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/18] ARM: dts: qcom: remove redundant binding from
 ipq8064 rb3011 dts
Message-ID: <Yg+pL44ogVscn9Kw@earth.li>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
 <20220218002956.6590-17-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218002956.6590-17-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:29:54AM +0100, Ansuel Smith wrote:
> Mdio0_pins are now declared in ipq8064 dtsi. Usb phy are enabled by
> default.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> index 0982b6214fb7..ddc9cc49ab60 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> +++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> @@ -259,10 +259,6 @@ &gsbi7_serial {
>  	status = "okay";
>  };
>  
> -&hs_phy_1 {
> -	status = "okay";
> -};
> -
>  &nand {
>  	status = "okay";
>  
> @@ -309,15 +305,6 @@ mux {
>  		};
>  	};
>  
> -	mdio0_pins: mdio0_pins {
> -		mux {
> -			pins = "gpio0", "gpio1";
> -			function = "gpio";
> -			drive-strength = <8>;
> -			bias-disable;
> -		};
> -	};
> -

This sets the pins to "gpio". Your earlier patch sets them to "mdio", so
removing this will break MDIO0 on the RB3011. It's likely that your
fixes for MDIO/QCA8K mean that the RB3011 can be switch to use the MDIO
driver rather than mdio-gpio, but that will need tested and this change
alone will definitely break things.

>  	mdio1_pins: mdio1_pins {
>  		mux {
>  			pins = "gpio10", "gpio11";
> @@ -358,10 +345,6 @@ mux {
>  	};
>  };
>  
> -&ss_phy_1 {
> -	status = "okay";
> -};
> -
>  &usb3_1 {
>  	pinctrl-0 = <&usb1_pwr_en_pins>;
>  	pinctrl-names = "default";
> -- 
> 2.34.1
> 

J.

-- 
/-\                             |  Even the Evening Herald slags me
|@/  Debian GNU/Linux Developer |                off.
\-                              |
