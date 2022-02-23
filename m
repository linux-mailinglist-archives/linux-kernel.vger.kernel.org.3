Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FFB4C1861
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242715AbiBWQTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242676AbiBWQTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:19:31 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8451CFD9;
        Wed, 23 Feb 2022 08:19:03 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21NGIqJ7097571;
        Wed, 23 Feb 2022 10:18:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645633132;
        bh=XQR0qPDs+QAmZNpBuHaSeoBNsjKlCLVAkyh5EqtiKYo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YFmRgZszVmbXw0371c+TVY/0eyI9xAkewUwNHvRZjUkkTnXIoKj4+RNBZIFLwx+bz
         zerMoLG1kCBrDvMkxhGv64NsTREA428YbakENHrdw0NAyASswg4Dg48soQnVzD4/Om
         kEjyoXp6n0qR9c1FBfh0Qkmmy65ZcT41pQXrsJuo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21NGIqbv044286
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Feb 2022 10:18:52 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 23
 Feb 2022 10:18:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 23 Feb 2022 10:18:52 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21NGIpaU084652;
        Wed, 23 Feb 2022 10:18:51 -0600
Date:   Wed, 23 Feb 2022 21:48:50 +0530
From:   Aparna M <a-m1@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <praneeth@ti.com>, <grygorii.strashko@ti.com>, <nikhil.nd@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-sk: Add DT entry for onboard
 LEDs
Message-ID: <20220223161850.5kpotstxkadbefp2@ti.com>
References: <20220223083229.8044-1-a-m1@ti.com>
 <20220223135534.jbmbdvc4zye7udmc@grafting>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220223135534.jbmbdvc4zye7udmc@grafting>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07:55-20220223, Nishanth Menon wrote:
> On 14:02-20220223, Aparna M wrote:
> > AM642 SK has 8 leds connected to tpic2810 onboard. Add support for these
> > gpio leds.
> > 
> > Signed-off-by: Aparna M <a-m1@ti.com>
> > ---
> >  arch/arm64/boot/dts/ti/k3-am642-sk.dts | 70 ++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> > index 6b04745147be..31e45bafa49e 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
> [...]
> 
> > +
> > +	exp2: gpio@60 {
> > +		compatible = "ti,tpic2810";
> 
> Sorry, but no.
> please convert
> 	Documentation/devicetree/bindings/gpio/gpio-tpic2810.txt to yaml
> 
> prior to any patches that enable it. (dtbs_check should have already
> warned you about this).

A patch for changing binding to yaml has already been sent. 
Link to patchwork: https://patchwork.ozlabs.org/project/linux-gpio/patch/20220223072308.31868-1-a-m1@ti.com/

> 
> > +		reg = <0x60>;
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		gpio-line-names = "LED1","LED2","LED3","LED4","LED5","LED6","LED7","LED8";
> > +	};
> >  };
> >  
> >  &main_i2c3 {
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

Thanks,
Aparna M
