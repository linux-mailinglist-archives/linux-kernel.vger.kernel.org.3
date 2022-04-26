Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D250F18E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343537AbiDZHAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbiDZHAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:00:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB40B4DF7A;
        Mon, 25 Apr 2022 23:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650956233; x=1682492233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jKxbJleSnjKHArCrWhKDUX9hPVC8Trh5097+ZmEWrzI=;
  b=aNhJMxNyL4j1YLm2K+tA1xzWGdv9Am3xsy6eiY9y5Mrc62YDQT35mSvO
   9AB7n/TD+UkO3e7gfYD5qXMVTLL9yFtj7wsfHa9dC+uv67FzuC+o+GyGR
   aDeiWfiAzW7HoHySutaAKYvpabrj5CKUlefHEkUZnYN9h54+m8bXfbwbK
   xmfMMlwXsSeAUlcZrjIgNako/lAFrjYuyitTBnsFppfaocyMx0GHBiWVL
   UEIjENLvJp9F1PKNebLjoNPrsDwWojeaqpVJRswxy/jKN0o48dDz1qAno
   hxxnjfM4aww5xGKSvvI/JafbVAPYYmoa7POFs6lKck9E8xqzqs/vcQ21L
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264998480"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="264998480"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 23:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="704917710"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 25 Apr 2022 23:57:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 26 Apr 2022 09:57:07 +0300
Date:   Tue, 26 Apr 2022 09:57:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Martin Kepplinger <martink@posteo.de>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: tps6598x: Make the interrupts
 property optional
Message-ID: <YmeXw8nerjpuKPC9@kuha.fi.intel.com>
References: <20220414083120.22535-1-a-govindraju@ti.com>
 <20220414083120.22535-2-a-govindraju@ti.com>
 <be8ab691-98f1-5fb9-fec8-7213a2288d07@kernel.org>
 <56c72151-af5f-366b-b17f-24b9fb6264da@ti.com>
 <ae54dbb1-2b02-cba2-5de2-cf3d9a4e35f5@kernel.org>
 <c1de4293-a058-5e25-9be2-b61ac39f43a3@ti.com>
 <89f7d69a-4fc8-33cc-d9ca-5c50dc5381ab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89f7d69a-4fc8-33cc-d9ca-5c50dc5381ab@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 09:42:31AM +0300, Roger Quadros wrote:
> Hi,
> 
> On 22/04/2022 08:07, Aswath Govindraju wrote:
> > Hi Roger,
> > 
> > On 21/04/22 00:46, Roger Quadros wrote:
> >> Hi,
> >>
> >> On 18/04/2022 08:19, Aswath Govindraju wrote:
> >>> Hi Roger,
> >>>
> >>> On 14/04/22 23:40, Roger Quadros wrote:
> >>>> Hi,
> >>>>
> >>>> On 14/04/2022 11:31, Aswath Govindraju wrote:
> >>>>> Support for polling has been added in the driver, which will be used by
> >>>>> default if interrupts property is not populated. Therefore, remove
> >>>>> interrupts and interrupt-names from the required properties and add a note
> >>>>> under interrupts property describing the above support in driver.
> >>>>>
> >>>>> Suggested-by: Roger Quadros <rogerq@kernel.org>
> >>>>
> >>>> I did not suggest to make interrupts optional by default.
> >>>>
> >>>> What I suggested was that if a DT property exists to explicitly
> >>>> indicate polling mode then interrupts are not required.
> >>>>
> >>>
> >>> ohh okay, got it. However, may I know if adding a dt property to
> >>> indicate polling for aiding the driver, is the correct approach to model it?
> >>>
> >>> In terms of modelling hardware, as interrupts are not connected we are
> >>> not populating the interrupts property. Shouldn't that be all. If we are
> >>> adding a property explicitly to indicate polling that can be used by
> >>> driver, wouldn't that be a software aid being added in the device tree?
> >>
> >> The hardware (tps6598x chip) has an interrupt pin and is expected to be used
> >> in normal case.
> >>
> >> Some buggy boards might have forgot to connect it. We are adding polling mode only for these buggy boards. ;)
> >> So polling mode is an exception.
> >>
> > 
> > Yes as you mentioned the interrupt line is expected to connected but
> > there could be cases where there are not enough pins on the SoC and
> > polling is used intentionally. In these cases this would be a feature
> > rather than a bug.
> 
> I do not agree that this is a feature but a board defect. You can always use
> a GPIO expander to add more GPIOs than the SoC can provide.
> 
> Type-C events are asynchronous and polling is a waste of CPU time.
> What will you do if system suspends and you need to wake up on Type-C
> status change?
> So polling mode is just an exception for the defective boards or could
> be used for debugging.
> 
> > 
> > Also, I feel like not adding interrupts property in the dt nodes will
> > indicate polling. My question is why are we adding an extra property
> > (which is being used only as an aid in the driver) when this feature can
> > be modeled by making interrupts property optional.
> 
> Because interrupt property was not originally optional for this driver.
> 
> I would like to hear what Heikki has to say about this.
> 
> Any thoughts Heikki?

I think the question is generic. How should DT describe the
connection/lack of connection? Rob should comment on this.

thanks,


> cheers,
> -roger
> 
> > 
> > Thanks,
> > Aswath
> > 
> >> cheers,
> >> -roger
> >>
> >>>
> >>> Thanks,
> >>> Aswath
> >>>
> >>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 4 ++--
> >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> >>>>> index a4c53b1f1af3..1c4b8c6233e5 100644
> >>>>> --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> >>>>> @@ -25,6 +25,8 @@ properties:
> >>>>>  
> >>>>>    interrupts:
> >>>>>      maxItems: 1
> >>>>> +    description:
> >>>>> +      If interrupts are not populated then by default polling will be used.
> >>>>>  
> >>>>>    interrupt-names:
> >>>>>      items:
> >>>>> @@ -33,8 +35,6 @@ properties:
> >>>>>  required:
> >>>>>    - compatible
> >>>>>    - reg
> >>>>> -  - interrupts
> >>>>> -  - interrupt-names
> >>>>>  
> >>>>>  additionalProperties: true
> >>>>>  
> >>>>
> >>>> cheers,
> >>>> -roger
> > 
> > 

-- 
heikki
