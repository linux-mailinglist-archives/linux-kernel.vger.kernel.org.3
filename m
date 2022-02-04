Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F2F4A991B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbiBDMRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiBDMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:17:06 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0086C061714;
        Fri,  4 Feb 2022 04:17:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j23so12696971edp.5;
        Fri, 04 Feb 2022 04:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=eHBHzUia9mruyB4YUukSDrxzx6AfeOgulQdxUcrQ01Q=;
        b=SBeg0hAuVOVt3vAT8e1Ie0QdqByT0wbgDPzNIQNUUEAT1U4w1LOaL2DptiroXUHdfE
         Hkrw7cPb7cj5GDaCbStOaPaUkw+JP8qfpoQiCSQYYYzt4FjfH4dHw8qvlQk+lind9mtp
         dHPvgQrqwYy45MqJB4mDWxMKbNgBBqcPMb+bpbwtcCxJzm6woxWG90oMXT0We4Q9BuK+
         8BNiPi6096ZHmkyprgC6Qrb+KtcsmS/EoDebY+VBVw52SHkXM6yv+oRDOS7tscUg05a8
         8awoA+Fq3UtBbdMH+QgXWfx15LjDMS5MOCIxWjajedF5rl7RKVdADQThId4tJbTWSxy8
         FU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=eHBHzUia9mruyB4YUukSDrxzx6AfeOgulQdxUcrQ01Q=;
        b=CdXmZvD22G0x38YTm3MDOX9I+TWGfwmbDc1lpD0HNbhfBJnBHwhZqiY39QJkrhwyCa
         h3OQE/bNor6JbgOjwDdufgPTANgLa+y0iFsShFwhBNqpl5o56b2wKWeEXog9T3EIJTlx
         uBTIgQT5KRiby11/Vew1/HtQn/AaztUMH0qKQRpXQtJRfJ7BT20IcCpXXDpTbW93FAVz
         pelSkoNn85yEroGM3DSM/GEkdwxXaLz1r23qKehL1umLpZGw9sB3yj704tLKeIpKNLr0
         1yFIovvDjHRn4DSI0NfKJ27mmlsFLb3i4SYXsUBWNEunvqxqhpgX7saACitMd6MI/Edc
         aAdw==
X-Gm-Message-State: AOAM530LMYuUVz0Yv3Gvqbew+Xvf84NEAxnTvEp1GeY+ct0o+X1WMwaJ
        FZrlktbXj6G/KF/pAk4R6Yw=
X-Google-Smtp-Source: ABdhPJwNGOsK4+pWoc1ci4iXaJJz7WgHa2jxbtSwbSsa9Axav2aDtMiirV3zHvkRizynn7vEBUFnvQ==
X-Received: by 2002:a05:6402:40cd:: with SMTP id z13mr2737770edb.119.1643977024173;
        Fri, 04 Feb 2022 04:17:04 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d15sm610498ejw.143.2022.02.04.04.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 04:17:03 -0800 (PST)
Message-ID: <72304aa8-6845-250b-dc0e-5122428b8dd8@gmail.com>
Date:   Fri, 4 Feb 2022 13:17:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 3/4] phy: rockchip: add naneng combo phy for RK3568
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com,
        kever.yang@rock-chips.com, lee.jones@linaro.org,
        wulf@rock-chips.com, Frank Wunderlich <frank-w@public-files.de>
References: <20211230084815.28110-1-yifeng.zhao@rock-chips.com>
 <20211230084815.28110-4-yifeng.zhao@rock-chips.com>
 <4838413b-c424-cf55-0699-9cd8ac23d9c2@gmail.com>
In-Reply-To: <4838413b-c424-cf55-0699-9cd8ac23d9c2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko, Frank and others,

China is on new year vacation.

Question for Heiko:
With xpcs in a separate node, how do we pass phy modes from gmac to
xpcs, multiphy in a correct DT way?
Can we brand xpcs as phy?
Please advise.

Johan
===

Found example for the way Rockchip connects sgmii in the manufacturer DT.
https://github.com/Poco-Ye/rk-ethernet/blob/master/SGMII.rar

From gmac1.txt:

> &mdio1 {
>         sgmii_phy: phy@1 {
         sgmii_phy: phy@0 { // ???

What is correct?

>                 compatible = "ethernet-phy-ieee802.3-c22";
>                 reg = <0x0>;

C45E
Clause 45 PHY Enable
When this bit is set, Clause 45 capable PHY is connected to MDIO.
When this bit is reset, Clause 22 capable PHY is connected to
MDIO.
Values:
1'b0: Clause 45 PHY is disabled
1'b1: Clause 45 PHY is enabled

>         };
> };
>
>
> &combphy2_psq {
> +       rockchip,sgmii-mac-sel = <1>;
>         status = "okay";
> };
>
>
> &gmac0 {
> 	phy-mode = "sgmii";
> 	
> 	rockchip,pipegrf = <&pipegrf>;
> 	rockchip,xpcs = <&xpcs>;
>
> 	snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_LOW>;
> 	snps,reset-active-low;
> 	/* Reset time is 20ms, 100ms for rtl8211f */
> 	snps,reset-delays-us = <0 20000 100000>;
>
> 	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>;
> 	assigned-clock-parents = <&gmac1_xpcsclk>;
>
> +	pinctrl-0 = <&gmac1m0_miim>;
> 	power-domains = <&power RK3568_PD_PIPE>;
> 	phys = <&combphy2_psq PHY_TYPE_SGMII>;
> +	phy-handle = <&sgmii_phy>;
>
> 	status = "okay";
> };

===

Proposal:
xpcs driver passes mode info to multiphy driver.
Phy arg is used for gmac source selection for PHY_INTERFACE_MODE_SGMII
and PHY_INTERFACE_MODE_QSGMII.

> 	phys = <&xpcs 0>;

===

{
	gmac0_xpcsclk: xpcs-gmac0-clock {
		compatible = "fixed-clock";
		clock-frequency = <125000000>;
		clock-output-names = "clk_gmac0_xpcs_mii";
		#clock-cells = <0>;
	};

	gmac1_xpcsclk: xpcs-gmac1-clock {
		compatible = "fixed-clock";
		clock-frequency = <125000000>;
		clock-output-names = "clk_gmac1_xpcs_mii";
		#clock-cells = <0>;
	};

	xpcs: syscon@fda00000 {
		compatible = "rockchip,rk3568-xpcs", "syscon";
		reg = <0x0 0xfda00000 0x0 0x200000>;
		clocks = <&cru PCLK_XPCS>;
		clock-names = "pclk_xpcs";

>		phys = <&multiphy2>;

		power-domains = <&power RK3568_PD_PIPE>;
 		rockchip,pipegrf = <&pipegrf>; // Switch between gmac0 and gmac1
		status = "disabled";
	};
}

&mdio1 {
         sgmii_phy: phy@0 {
                 compatible = "ethernet-phy-ieee802.3-c22";
                 reg = <0x0>;
         };
 };


&multiphy2 {
         status = "okay";
};


&gmac0 {
	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>;
 	assigned-clock-parents = <&gmac1_xpcsclk>;

 	phys = <&combphy2_psq PHY_TYPE_SGMII>;
	phy-handle = <&sgmii_phy>;
 	phy-mode = "sgmii";

> 	phys = <&xpcs 0>;

	pinctrl-0 = <&gmac1m0_miim>;

 	snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_LOW>;
	snps,reset-active-low;
 	/* Reset time is 20ms, 100ms for rtl8211f */
 	snps,reset-delays-us = <0 20000 100000>;

	status = "okay";
};

On 1/3/22 19:26, Johan Jonker wrote:
> Hi Yifeng, Kishon, rob+dt,
> 
> Some comments, have a look if it's useful.
> 
> ====
> 
> Could the DT and phy maintainer advise the correct/right driver
> structure to Yifeng, so that we can move forward!
> 
> ====
> 
