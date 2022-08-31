Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E965A7A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiHaJtE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 Aug 2022 05:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiHaJst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:48:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F3D0207
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:48:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oTKKn-0008Mh-Ti; Wed, 31 Aug 2022 11:48:33 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oTKKm-0032YJ-UX; Wed, 31 Aug 2022 11:48:32 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1oTKKm-0004eS-AC; Wed, 31 Aug 2022 11:48:32 +0200
Message-ID: <92cdeaeb8aebb22852e7a5079f41216852c27de9.camel@pengutronix.de>
Subject: Re: [PATCH v3 04/19] dt-bindings: hwmon: (mr75203) change "reset"
 property to be optional
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "Farber, Eliav" <farbere@amazon.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     talel@amazon.com, hhhawa@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, ronenk@amazon.com, itamark@amazon.com,
        shellykz@amazon.com, shorer@amazon.com, amitlavi@amazon.com,
        almogbs@amazon.com, dkl@amazon.com, andriy.shevchenko@intel.com
Date:   Wed, 31 Aug 2022 11:48:32 +0200
In-Reply-To: <671a0ee8-9b0d-b417-19ff-013681cc73d8@amazon.com>
References: <20220830192212.28570-1-farbere@amazon.com>
         <20220830192212.28570-5-farbere@amazon.com>
         <3bd5f46dff622e375c4f60140f479bf6ee483aec.camel@pengutronix.de>
         <671a0ee8-9b0d-b417-19ff-013681cc73d8@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
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

On Mi, 2022-08-31 at 12:43 +0300, Farber, Eliav wrote:
> On 8/31/2022 11:21 AM, Philipp Zabel wrote:
> > On Di, 2022-08-30 at 19:21 +0000, Eliav Farber wrote:
> > > Change "reset" property to be optional instead of required, for SOCs 
> > > that
> > > don't support a reset controller.
> > > 
> > > Signed-off-by: Eliav Farber <farbere@amazon.com>
> > > ---
> > > V3 -> v2:
> > > - Change "reset" property to be optional instead of adding new
> > >   "reset-control-skip" property.
> > > 
> > >  Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git 
> > > a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml 
> > > b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> > > index 6abde48b746e..2ec4b9da4b92 100644
> > > --- a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> > > +++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
> > > @@ -49,7 +49,6 @@ required:
> > >    - reg
> > >    - reg-names
> > >    - clocks
> > > -  - resets
> > 
> > Is this just for mr76006? Or does mr75203 work without reset as well?
> > 
> > If it is the former, maybe a new compatible should be added and resets
> > should be kept required
> 
> mr75203 also works without a reset.
> As I replied in PATCH v3 14/19, series 5/6 is relevant only for the
> temperature sensor.
> The “reset” property is relevant to the controller.

In that case,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
