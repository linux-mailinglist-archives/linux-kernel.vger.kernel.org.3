Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79C57A7DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiGSUAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbiGST76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:59:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B611760507;
        Tue, 19 Jul 2022 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658260780; x=1689796780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=12QZEh3TZoEV6JwFURckp8JLCMGijDlJVCRZdBkz9d0=;
  b=iBDtDX66txv2H2AhxtrYmv620y18PNANcXsh6NmgtUovp+/vy6yb9Ayb
   0U30v9pUimjLiZskZzRqhyU8u8EQo6Q2Jlpe4+Zqhy+RUuI8mL1qx2pXm
   ONouHz3s8QY8lPj/zqx+KAceTT1ZgPeMna9gxQ+d1ymDmOb+mUMak3RQJ
   hmfH3cfXxDSnSwR+uUTs9afeNfANBEJpU7UjpaC20TVrrLxzHs23R3tBx
   804aUx8vHrZfUNTF0evajGJ8V6/LPBV+fGDFSs5/jDv9LVeKp1m4l1+pq
   R+6VgSakA/QFOG7p2FH1gA3MQElGLr7/C1cUVgJUcAZcowUYqI8UinOg2
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="168592447"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 12:59:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 12:59:39 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Jul 2022 12:59:38 -0700
Date:   Tue, 19 Jul 2022 22:03:45 +0200
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
Subject: Re: [PATCH 3/3] ARM: dts: lan966x: Enable network driver on pcb8291
Message-ID: <20220719200345.pr3gkljjae52vnqw@soft-dev3-1.localhost>
References: <20220718212921.1506984-1-horatiu.vultur@microchip.com>
 <20220718212921.1506984-4-horatiu.vultur@microchip.com>
 <cfbe269b-998d-018a-2de9-824ef309301e@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <cfbe269b-998d-018a-2de9-824ef309301e@microchip.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 07/19/2022 07:58, Claudiu Beznea - M18063 wrote:
> On 19.07.2022 00:29, Horatiu Vultur wrote:
> > The pcb8291 has 2 ports that are connected to the internal ports of the
> > switch. Enable them in DT.
> > 
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  arch/arm/boot/dts/lan966x-pcb8291.dts | 35 +++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
> > index 2cb532aa33f0..d890e6fcdbae 100644
> > --- a/arch/arm/boot/dts/lan966x-pcb8291.dts
> > +++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
> > @@ -4,6 +4,7 @@
> >   */
> >  /dts-v1/;
> >  #include "lan966x.dtsi"
> > +#include "dt-bindings/phy/phy-lan966x-serdes.h"
> >  
> >  / {
> >  	model = "Microchip EVB - LAN9662";
> > @@ -32,6 +33,40 @@ fc3_b_pins: fc3-b-pins {
> >  	};
> >  };
> >  
> > +&mdio1 {
> > +	status = "okay";
> > +};
> > +
> > +&phy0 {
> > +	status = "okay";
> > +};
> > +
> > +&phy1 {
> > +	status = "okay";
> > +};
> > +
> > +&switch {
> > +	status = "okay";
> > +};
> > +
> > +&serdes {
> > +	status = "okay";
> > +};
> > +
> > +&port0 {
> > +	status = "okay";
> > +	phy-handle = <&phy0>;
> > +	phy-mode = "gmii";
> > +	phys = <&serdes 0 CU(0)>;
> > +};
> > +
> > +&port1 {
> > +	status = "okay";
> > +	phy-handle = <&phy1>;
> > +	phy-mode = "gmii";
> > +	phys = <&serdes 1 CU(1)>;
> > +};
> > +
> 
> Although gpio node is not places where it should be we tend to keep all the
> nodes sorted alphabetically. Could you place follow this rule for these new
> nodes?

Yes, I will update in the next version.

> 
> Thank you,
> Claudiu Beznea
> 
> >  &flx3 {
> >  	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
> >  	status = "okay";
> 

-- 
/Horatiu
