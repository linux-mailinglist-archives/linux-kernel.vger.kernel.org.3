Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C110C58C46D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbiHHHwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbiHHHwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:52:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B567311C29
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 00:52:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oKxYk-0007h1-RS; Mon, 08 Aug 2022 09:52:22 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oKxYj-0005lW-J7; Mon, 08 Aug 2022 09:52:21 +0200
Date:   Mon, 8 Aug 2022 09:52:21 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v1 2/3] dt-bindings: firmware: imx: Add imx-scu
 gpio node
Message-ID: <20220808075221.hijtkvubgtw3wirf@pengutronix.de>
References: <20220804184908.470216-1-shenwei.wang@nxp.com>
 <20220804184908.470216-3-shenwei.wang@nxp.com>
 <8e1ffa95-686b-ca4b-1a2b-b7115dc41c98@linaro.org>
 <AM9PR04MB8274CE6735619BD6B8FB0143899E9@AM9PR04MB8274.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB8274CE6735619BD6B8FB0143899E9@AM9PR04MB8274.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-05, Shenwei Wang wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Sent: Friday, August 5, 2022 1:56 AM
> > To: Shenwei Wang <shenwei.wang@nxp.com>; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; linus.walleij@linaro.org; brgl@bgdev.pl;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>
> > Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > gpio@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v1 2/3] dt-bindings: firmware: imx: Add imx-scu gpio
> > node
> > 
> > Caution: EXT Email
> > 
> > On 04/08/2022 20:49, Shenwei Wang wrote:
> > > Add the description for imx-scu gpio subnode.
> > >
> > > Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/firmware/fsl,scu.yaml | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> > b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> > > index b40b0ef56978..080955b6edd8 100644
> > > --- a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> > > +++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> > > @@ -30,6 +30,11 @@ properties:
> > >        Clock controller node that provides the clocks controlled by the SCU
> > >      $ref: /schemas/clock/fsl,scu-clk.yaml
> > >
> > > +  gpio:
> > > +    description:
> > > +      GPIO control over the SCU firmware APIs
> > 
> > I don't understand this description. How GPIO can control some API?
> 
> How about change to "Control the GPIO PINs on SCU domain over the firmware APIs"?

For linux it doesn't matter how the GPIOs are controlled. They can be
controlled by a co-processor like this SCU or by an I2C expander or they
are native, the list goes on. All those details are hidden.

Regards,
  Marco

> 
> Thanks,
> Shenwei
> 
> > 
> > Best regards,
> > Krzysztof
