Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1866257A7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbiGST7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbiGST7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:59:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C4B599E1;
        Tue, 19 Jul 2022 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658260720; x=1689796720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tPtPB7gEIdG+j7cej44s8jQsR5obrLeMzi2gzAetFUA=;
  b=UI688Cr77ybQxf18C4X4CdeKC9XGZdmx8J+F9bUheKijSYpk/x3CK7Cv
   yFWwpOJBsvJqu25MAc7upno4HYTqBu3jfk0NWhIykObj4fYFRPjzn7fcz
   wgFoDIZHK5+LDv5txHISN4+Jf5cMmF8ILpHfZRxXM2N5o1Ph6I+QkeGa2
   FBGRSLGBSsQ0cemkjbldjF8C41GCg1uoS7jU4/XQXPaPfbc5lKvCQDfCI
   Nf+/LskWLS588JbFr8uTX5SwG0YeGWesPSSs2uR3tqIVYuUWCpHOaGFWi
   dANJ6MTOHIfgwSgKxw2CUYuBo/Ib3hqDV/sxkOtR5+soKXUvUQN+X+aov
   A==;
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="165487102"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 12:58:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 12:58:28 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Jul 2022 12:58:28 -0700
Date:   Tue, 19 Jul 2022 22:02:35 +0200
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
Subject: Re: [PATCH 1/3] ARM: dts: lan966x: Add gpio-restart
Message-ID: <20220719200235.sojkdhcfbnzsvund@soft-dev3-1.localhost>
References: <20220718212921.1506984-1-horatiu.vultur@microchip.com>
 <20220718212921.1506984-2-horatiu.vultur@microchip.com>
 <3e0b7137-08d1-fef2-86b5-a48419dd2101@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <3e0b7137-08d1-fef2-86b5-a48419dd2101@microchip.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/19/2022 07:52, Claudiu Beznea - M18063 wrote:
> On 19.07.2022 00:29, Horatiu Vultur wrote:
> > The pcb8291 can be rebooted by toggling the GPIO 56. Therefore enable
> > this in DT.
> > 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  arch/arm/boot/dts/lan966x-pcb8291.dts | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
> > index d56d2054c38d..02fbf7371a8d 100644
> > --- a/arch/arm/boot/dts/lan966x-pcb8291.dts
> > +++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
> > @@ -16,6 +16,12 @@ chosen {
> >  	aliases {
> >  		serial0 = &usart3;
> >  	};
> > +
> > +	gpio-restart {
> > +		compatible = "gpio-restart";
> > +		gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
> 
> Could you, please, add also pinctrl-names, pinctrl-0 for this gpio?

I am not sure I need to set pinctrl-names and pinctrl-0.
Because I don't need to setup any function for GPIO 56 to be able to
reset.
It is something similar sparx5 [1].

[1] https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi#L10

> 
> > +		priority = <200>;
> > +	};
> >  };
> >  
> >  &gpio {
> 

-- 
/Horatiu
