Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DBD48BD5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348845AbiALCjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:39:13 -0500
Received: from out162-62-57-137.mail.qq.com ([162.62.57.137]:59485 "EHLO
        out162-62-57-137.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348820AbiALCjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1641955147;
        bh=YJOZ0DHq0HPOI2c9wmn0uQXGJU3fbFlfj0a8vg3s/B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SuuZmycnkuLQnaQgoXhjI/cZnbhUGn7JX91XybAjYUubFwzYUxrfjg7n2e5Hc/Li+
         VjpKlTJ9ygoniTsPM2FmWaK+0PJ+azeK11/p4CbdaJZ8BbvaToC7zgU8ynN3v/DXXX
         5U59h+fCFYXuK1TLifXHX+L2FhYrsx4EdNLxp5Cw=
Received: from localhost ([119.32.47.91])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id 97715046; Wed, 12 Jan 2022 10:37:55 +0800
X-QQ-mid: xmsmtpt1641955075tsopsxz2g
Message-ID: <tencent_361798B1357958BC1B1694977A6C9935CD0A@qq.com>
X-QQ-XMAILINFO: MhuEEgXNPF1fGDDgrGmI2iiVw3WG9loC7Up4JVeuQcgA8TbG+cR4kF6BxjXdr1
         X3V2NLwY10m0Wc20N62WgsAqxMwUDCb6fAMQq0hCXkeljvabfZd9elqI2fSeW1tK0Or+pzEG2J/I
         Ib2EAcecJFP1kv8HLJTGtykhru1zXx4FBBZf+e2I5y5wI10hZRgB7wDUQvK8K42TA2d128rqNvO1
         uhB1YQmb1KbVbZ0JxWyIP8d3mJLunhKrzkUAF139R32nAweVn7AuZcYc3yd5Vi4hgEOv5ZrE13Ta
         cuPGX5BwXFd6xhM8zyBE77cgUeEO+cFCXdiRomyU1dovdWKqrberom7g2+VEfpD03NSvwmC7lGi8
         65v7tBAXrtUKZZHove92FWBP1yIK+6JQvrns/K6vatwmljJlsa4O+EshiScS0KP568g+CrYFYGlu
         uCFnA+1tlCXJ0ExavSPAvWLSq9TqKXsPj9vBryAXXuWAg3NVJK3jrKyT+sq5SRFW02yFCEJnWh/P
         M3fxxbPqDP6ZSV/LNARSUW8DYd2iS19/ISXAvNIDYs5NQv9zPLKX/LUyDXWNIcWe067G6uUDGFSJ
         Alaj6lNs8N1JZ1QOCj64OwaSs08g4VbHza1+83S5ZX3FM3LdAmpFGzLcOqDfJU+82ZpDvitBSXC7
         7l07Labgd6hPjF7UAF4AKk1eVd6mIwlLoxCir2D0haRdKf3tQyaimbgYhenhvYE1TehQ66zdjeLN
         O0mv7koIxCiw08bpMH+JR3SsX1IbPlxMd7qZ6nCes4xFdC+iwylqDTmqjI61lo6D9ywlDC3lE3Ix
         tScQONJO2S+pqAPVB+6BR20dT5Qll1N6Q4ANkGMafFIU6SQ0IuyqFzfOPAeVaQWG2mdW/8LG3JcJ
         2xUojdujGv
Date:   Wed, 12 Jan 2022 10:37:55 +0800
From:   Conley Lee <conleylee@foxmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     robh@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sun7i-a20-marsboard.dts: add marsboard-a20 support
X-OQ-MSGID: <Yd4/Aw6ohs3WJJ4Z@fedora>
References: <YdS1GVkRopRSoD5S@robh.at.kernel.org>
 <tencent_13C536D91764B05D794CBCF3156C963E6C0A@qq.com>
 <20220111103542.f7ilg2ugqklpztr5@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220111103542.f7ilg2ugqklpztr5@houat>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/22 at 11:35上午, Maxime Ripard wrote:
> Date: Tue, 11 Jan 2022 11:35:42 +0100
> From: Maxime Ripard <maxime@cerno.tech>
> To: conleylee@foxmail.com
> Cc: robh@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
>  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] sun7i-a20-marsboard.dts: add marsboard-a20
>  support
> 
> Hi,
> 
> On Wed, Jan 05, 2022 at 10:45:50AM +0800, conleylee@foxmail.com wrote:
> > From: conley <conleylee@foxmail.com>
> 
> This should be your full name in the author and signed-off-by
> 
> > ARM dts: sun7i: Add Marsboard A20 board
> > 
> > This patch add support for Marsboard A20 board.
> > 
> > The Marsboard A20 is a A20 based SBC with 1G RAM, 8G Flash, micro SD
> > card slot , SATA socketm 10/100 ethernet, HDMI port, 4 USB2.0 ports, 2
> > USB2.0 OTG, USB WIFI(RTL8188EU) with antenna.
> > 
> > Change since v1.
> >   - Spearate biddings and dts as two patches.
> >   - use SPDX tag
> 
> And the changelog should be after the --- below
> 
> > Signed-off-by: conley <conleylee@foxmail.com>
> > ---
> >  arch/arm/boot/dts/Makefile                |   1 +
> >  arch/arm/boot/dts/sun7i-a20-marsboard.dts | 183 ++++++++++++++++++++++
> >  2 files changed, 184 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun7i-a20-marsboard.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 0de64f237cd8..4628a2617313 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1219,6 +1219,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
> >  	sun7i-a20-icnova-swac.dtb \
> >  	sun7i-a20-lamobo-r1.dtb \
> >  	sun7i-a20-linutronix-testbox-v2.dtb \
> > +	sun7i-a20-marsboard.dtb \
> >  	sun7i-a20-m3.dtb \
> >  	sun7i-a20-mk808c.dtb \
> >  	sun7i-a20-olimex-som-evb.dtb \
> > diff --git a/arch/arm/boot/dts/sun7i-a20-marsboard.dts b/arch/arm/boot/dts/sun7i-a20-marsboard.dts
> > new file mode 100644
> > index 000000000000..7ab6aa30fee6
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun7i-a20-marsboard.dts
> > @@ -0,0 +1,183 @@
> > +// SPDX-License-Identifier: LGPL-2.1+
> 
> The license for DT files is usually a dual-license with GPL and MIT,
> which would be:
> 
> SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> 
> You can't link to a DT, so GPL and LGPL should be equivalent here, and
> MIT is useful for other projects (like the *BSD) that reuse the DT.
> 
> > +/*
> > + * Copyright 2021 Conley Lee
> > + * Conley Lee <conleylee@foxmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +#include "sun7i-a20.dtsi"
> > +#include "sunxi-common-regulators.dtsi"
> > +
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +/ {
> > +	model = "HAOYU Electronics Marsboard A20";
> > +	compatible = "haoyu,a20-marsboard", "allwinner,sun7i-a20";
> 
> Is there multiple boards called marsboard?
> 
> If not, then the compatible should be haoyu,marsboard.
> 
> The file name should be sun7i-a20-haoyu-marsboard too.
> 
> > +	aliases {
> > +		serial0 = &uart0;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0:115200n8";
> > +	};
> > +
> > +	hdmi-connector {
> > +		compatible = "hdmi-connector";
> > +		type = "a";
> > +
> > +		port {
> > +			hdmi_con_in: endpoint {
> > +				remote-endpoint = <&hdmi_out_con>;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&ahci {
> > +	target-supply = <&reg_ahci_5v>;
> > +	status = "okay";
> > +};
> > +
> > +&codec {
> > +	status = "okay";
> > +};
> > +
> > +&cpu0 {
> > +	cpu-supply = <&reg_dcdc2>;
> > +};
> > +
> > +&de {
> > +	status = "okay";
> > +};
> > +
> > +&ehci0 {
> > +	status = "okay";
> > +};
> > +
> > +&ehci1 {
> > +	status = "okay";
> > +};
> > +
> > +&gmac_mii_pins {
> > +	pins = "PA0", "PA1", "PA2",
> > +	"PA3", "PA4", "PA5", "PA6",
> > +	"PA7", "PA8", "PA9", "PA10",
> > +	"PA11", "PA12", "PA13", "PA14",
> > +	"PA15", "PA16", "PA17";
> > +};
> 
> Why do you need that node?
> 
> Maxime

1. There are two boards called marsboard, another one is based on
   sun4i-a10.
2. About the gmac_mii_pins node: the pin PA17 is connected to PHY
   as EXTERR signal on sun7i-a20-marsboard, it's different from 
   the definetion in dtsi.

Thanks ~
