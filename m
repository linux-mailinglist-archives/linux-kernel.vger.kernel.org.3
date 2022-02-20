Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC54BCF13
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 15:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbiBTOue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 09:50:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbiBTOub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 09:50:31 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFD845046;
        Sun, 20 Feb 2022 06:50:10 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cm8so14691546edb.3;
        Sun, 20 Feb 2022 06:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EFxuQ6hya/OuHvYdtbr0hoW/qhdSsZlWYvOGdY27hok=;
        b=PGgaUGNavMME3+e4cVgMSOT6JbOJpRPhkIE+8HN78cK7BfYd7I1iPU6fxfdnYDEh6a
         eei9Ua/M5Z+cR06MnkgTSlltHA8HjUSH+0r3toXKX0qi2DxKxVKAMfUc6HkoieyqlTJD
         jDEDBwmUC1ZMqj7DSUCMnxl3KCYv/5u/Kwub+o4Wsw5PKnbR84ZvHcqIfbPR7aqvsWQn
         z1zNMhmdRhsZ5/Ipm1fbketIkTHbOwj7+uMvOBx+Wc50DgsKLxpdKLzpOugtBQCowb0f
         Pqg5LR3dAK8qku7bJCcetch2iBGljmAhRVNrjzElGXiiBlyhSQiU3AH9XdiBsey+IWLQ
         gHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EFxuQ6hya/OuHvYdtbr0hoW/qhdSsZlWYvOGdY27hok=;
        b=RgVdvnfPYRRq1oAOwzL0sUV3NjMzDACsu5awSZRfT10wXq879SOxGMAbcT7Z3g6cOT
         VDP1rpIK5uwHi6jhmiQDUa66vpRrSTWKLYKLmw0Pb6fRYDpGr4TVSHHOA/afqK/p7EmD
         Uc3QHz4fnVB0vK8aSK7kXrcxuSlZXgBgmz6hRaTaX4Uz1p899xPHgAVNYz4Rdy1p9Q0Q
         F1/gpagHYVWRHd21XpqEE0Nd8weMl0IdPcbqQuITb7xZo99yqSfUNmIzX3+GYQTn50Tm
         5xjVS3q/a712U/1ZCK6ZF+2wJWX0pNcKjSnOoZ1laVwngCBN51Lju6qS3ad+myvKDhub
         aarw==
X-Gm-Message-State: AOAM531zYdiHrQE5cUGiHKTJk91Kq2KZg+bhSg25lrTF0k33EpK9/B+J
        aRyqLS405TRvXR/nVDc/PTuDOI23HwU=
X-Google-Smtp-Source: ABdhPJzifEPoru563kIdCf5OLWnn21smZSuE/Xgn2AQSWAfzHkFS6WBgPTM7ccP/Mk2vSTqV6d9pCg==
X-Received: by 2002:a50:d088:0:b0:410:d12b:84e1 with SMTP id v8-20020a50d088000000b00410d12b84e1mr17589356edd.106.1645368608824;
        Sun, 20 Feb 2022 06:50:08 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id pg26sm2299057ejb.194.2022.02.20.06.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 06:50:08 -0800 (PST)
Date:   Sun, 20 Feb 2022 15:50:05 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/18] ARM: dts: qcom: remove redundant binding from
 ipq8064 rb3011 dts
Message-ID: <YhJVDYMfs/VzpSE8@Ansuel-xps.localdomain>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
 <20220218002956.6590-17-ansuelsmth@gmail.com>
 <Yg+pL44ogVscn9Kw@earth.li>
 <YhFAMlSA0WYoSE6w@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhFAMlSA0WYoSE6w@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 07:08:34PM +0000, Jonathan McDowell wrote:
> On Fri, Feb 18, 2022 at 02:11:59PM +0000, Jonathan McDowell wrote:
> > On Fri, Feb 18, 2022 at 01:29:54AM +0100, Ansuel Smith wrote:
> > > Mdio0_pins are now declared in ipq8064 dtsi. Usb phy are enabled by
> > > default.
> ...
> > > -	mdio0_pins: mdio0_pins {
> > > -		mux {
> > > -			pins = "gpio0", "gpio1";
> > > -			function = "gpio";
> > > -			drive-strength = <8>;
> > > -			bias-disable;
> > > -		};
> > > -	};
> > > -
> > 
> > This sets the pins to "gpio". Your earlier patch sets them to "mdio", so
> > removing this will break MDIO0 on the RB3011. It's likely that your
> > fixes for MDIO/QCA8K mean that the RB3011 can be switch to use the MDIO
> > driver rather than mdio-gpio, but that will need tested and this change
> > alone will definitely break things.
> 
> I tried the below patch to switch the RB3011 to the IPQ8064 MDIO driver
> (based on qcom,ipq8064-mdio.yaml) and get:
> 
> [    1.270310] qca8k 37000000.mdio-mii:10: Switch id detected 0 but expected 13
> 
> and none of the ports on that associated switch come up. Kernel is
> 5.15.23 rather than latest, but there are no updates to mdio-ipq8064.c
> in later kernels than I can see and none of the qca8k changes seem
> relevant. Is there something else I'm missing?
>

I encounter an error like that when the MDIO_MASTER_EN was set to 1.
Wonder if we should trigger a switch reset or a reset of the
MDIO_MASTER_EN before probing the switch? (this is currently done after
any phy read/write)
But it's strange... Wonder if the dedicated mdio can't work on this
device with 2 switch attached?

> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> index c3e3070702f9..0cafee65ca22 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> +++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> @@ -24,13 +24,13 @@ memory@42000000 {
>  		device_type = "memory";
>  	};
>  
> -	mdio0: mdio-0 {
> +	mdio0: mdio@37000000 {
>  		status = "okay";
> -		compatible = "virtual,mdio-gpio";
> -		gpios = <&qcom_pinmux 1 GPIO_ACTIVE_HIGH>,
> -			<&qcom_pinmux 0 GPIO_ACTIVE_HIGH>;
> +		compatible = "qcom,ipq8064-mdio";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		reg = <0x37000000 0x200000>;
> +		clocks = <&gcc GMAC_CORE1_CLK>;
>  
>  		pinctrl-0 = <&mdio0_pins>;
>  		pinctrl-names = "default";
> @@ -318,7 +318,7 @@ mux {
>  	mdio0_pins: mdio0_pins {
>  		mux {
>  			pins = "gpio0", "gpio1";
> -			function = "gpio";
> +			function = "mdio";
>  			drive-strength = <8>;
>  			bias-disable;
>  		};
> 
> J.
> 
> -- 
> /-\                             |  Shall I call the United Nations?
> |@/  Debian GNU/Linux Developer |
> \-                              |

-- 
	Ansuel
