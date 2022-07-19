Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C086657A7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbiGSUAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbiGST7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:59:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF76F59264;
        Tue, 19 Jul 2022 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658260751; x=1689796751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SsUZkM33DBmffJBizAMVHUd8LRrUyoPkXeEQMPBBmUw=;
  b=H98vuN/kdBc8VInRcAoSUuulovPV/u60mphhs0mA0iwzL+iV9AdYJKpu
   njkdK+WlLt8/P5UedBqGr42o/EA0yr3qx8XKUiYs57wFqJ+yQ+kEO5or2
   NIyFHen3NQUPf/gO+7cof+ijVyLu0vdT8DpG53RJ6dH+LvQqbl8nvDzIB
   6t+bdnzaCa/3Ej4YsYjIxgkWBe7Zf5+1JhLvp68yc9BAYiGqkGzpQBfvb
   Q7WL5wp6W2+M/bFWnyZE01zbyHK7GdCudVMQX3CXpXaN0SfnREDZmCkMJ
   7w+Vs22fVGbaOYa3xaAntBNG0ZelhAo5KBbssBu37yZkrC6vMSNefRxtv
   A==;
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="168592317"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 12:59:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 12:59:11 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Jul 2022 12:59:10 -0700
Date:   Tue, 19 Jul 2022 22:03:17 +0200
From:   Horatiu Vultur - M31836 <Horatiu.Vultur@microchip.com>
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        UNGLinuxDriver <UNGLinuxDriver@microchip.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 2/3] ARM: dts: lan966x: Disable can0 on pcb8291
Message-ID: <20220719200317.m6cynb3l7wneuxoy@soft-dev3-1.localhost>
References: <20220718212921.1506984-1-horatiu.vultur@microchip.com>
 <20220718212921.1506984-3-horatiu.vultur@microchip.com>
 <530ef4f3-26ce-5a90-f2f7-d6163124bfec@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <530ef4f3-26ce-5a90-f2f7-d6163124bfec@microchip.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/19/2022 07:55, Claudiu Beznea - M18063 wrote:
> On 19.07.2022 00:29, Horatiu Vultur wrote:
> > On pcb8291, can0 and the network driver share some of the GPIOs so only
> > 1 device can be active. Therefore disable can0 as we want to enable the
> > network driver.
> > 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  arch/arm/boot/dts/lan966x-pcb8291.dts | 12 ------------
> >  1 file changed, 12 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
> > index 02fbf7371a8d..2cb532aa33f0 100644
> > --- a/arch/arm/boot/dts/lan966x-pcb8291.dts
> > +++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
> > @@ -30,18 +30,6 @@ fc3_b_pins: fc3-b-pins {
> >  		pins = "GPIO_52", "GPIO_53";
> >  		function = "fc3_b";
> >  	};
> > -
> > -	can0_b_pins:  can0-b-pins {
> > -		/* RX, TX */
> > -		pins = "GPIO_35", "GPIO_36";
> > -		function = "can0_b";
> > -	};
> > -};
> > -
> > -&can0 {
> > -	pinctrl-0 = <&can0_b_pins>;
> > -	pinctrl-names = "default";
> > -	status = "okay";
> 
> You can just delete the status line here or change it to "disabled" and
> leave the rest for reference. For evaluation one could just enable it here
> afterwards. On the other AT91 specific boards we are using status =
> "disabled"; and a short comment after like this:
> 
> 	status = "disabled"; /* Conflict with gmac0. */

That is a great idea. Yes I will do that.

> 
> >  };
> >  
> >  &flx3 {
> 

-- 
/Horatiu
