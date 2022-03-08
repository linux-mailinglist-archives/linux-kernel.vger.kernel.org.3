Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897E44D1484
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbiCHKPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbiCHKPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:15:35 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A319E3EA8B;
        Tue,  8 Mar 2022 02:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646734477; x=1678270477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hpi9pMWKnJ5oF5T0+PXi9Fqc8FlAAugNzaNHUKCMea0=;
  b=CoaHFOET6u0MQV8BOZ8ftmZVddA/AWpUSVXjwGSPMfTBtMppNynKwm9C
   Sq82oqoaLlAJXMZoCJV7OYD6O02uRdK2y7xgk3zntE34++GueRSvPnPIf
   2N5DDKMo6NMQwKZ1Y/wj79ZGGI4OPR0/SoI1MID3nSwgWso1Gu53W3Bpg
   8PMnu3a3YzvnQhIDH3yqDVB21W6axRgs0oeBMuzM1dFcwTsbT3oCqT9+N
   E9w61wPcTVvoORU5z+wI+gOQtafXs8cWbhmNTYN5dBt6psXaiv0o5Przj
   fC7kDHPPAoAQR0LyKYuUv3ms+d4rbRqkYaaregQwoRMysUtOF4frCIw5O
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="315363348"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="315363348"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:14:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="595839404"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 02:14:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRWqk-00DI7W-CK;
        Tue, 08 Mar 2022 12:13:50 +0200
Date:   Tue, 8 Mar 2022 12:13:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     shruthi.sanil@intel.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Mark Gross <mgross@linux.intel.com>,
        srikanth.thokala@intel.com,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Message-ID: <YicsXm9JboW2b+5f@smile.fi.intel.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-2-shruthi.sanil@intel.com>
 <YhVuJaf3AJ1c6TpT@robh.at.kernel.org>
 <YhYa3tlTEcLct2xu@smile.fi.intel.com>
 <CAL_JsqK_k49eKZ+Z+uw29GdY9KFVJL9o5xkzg=1=yF-oEt+JRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK_k49eKZ+Z+uw29GdY9KFVJL9o5xkzg=1=yF-oEt+JRg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 04:33:23PM -0600, Rob Herring wrote:
> On Wed, Feb 23, 2022 at 5:31 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Feb 22, 2022 at 05:13:41PM -0600, Rob Herring wrote:
> > > On Tue, Feb 22, 2022 at 03:26:53PM +0530, shruthi.sanil@intel.com wrote:
> > > > From: Shruthi Sanil <shruthi.sanil@intel.com>
> > > >
> > > > Add Device Tree bindings for the Timer IP, which can be used as
> > > > clocksource and clockevent device in the Intel Keem Bay SoC.
> >
> > ...
> >
> > > > +    soc {
> > > > +        #address-cells = <0x2>;
> > > > +        #size-cells = <0x2>;
> > > > +
> > > > +        gpt@20331000 {
> > > > +            compatible = "intel,keembay-gpt-creg", "simple-mfd";
> > >
> > > It looks like you are splitting things based on Linux implementation
> > > details. Does this h/w block have different combinations of timers and
> > > counters? If not, then you don't need the child nodes at all. There's
> > > plenty of h/w blocks that get used as both a clocksource and clockevent.
> > >
> > > Maybe I already raised this, but assume I don't remember and this patch
> > > needs to address any questions I already asked.
> >
> > I dunno if I mentioned that hardware seems to have 5 or so devices behind
> > the block, so ideally it should be one device node that represents the global
> > register spaces and several children nodes.
> 
> Is it 5 devices or 9 devices?

5 devices, one of which is a timer block out of 8 timers.
You may count them as 12 altogether.

> > However, I am not familiar with the established practices in DT world, but
> > above seems to me the right thing to do since it describes the hardware as
> > is (without any linuxisms).
> 
> The Linuxism in these cases defining 1 node per driver because that's
> what is convenient for automatic probing. That appears to be exactly
> the case here. The red flag is nodes with a compatible and nothing
> else. The next question is whether the sub-devices are blocks that
> will be assembled in varying combinations and quantities. If not, then
> not much point subdividing the h/w blocks.

AFAIU the hardware architecture the amount of timers is dependent on
the IP synthesis configuration. On this platform it's 8, but it may be
1 or 2, for example.

> There's also many cases of having multiple 'identical' timers and
> wanting to encode which timer gets assigned to clocksource vs.
> clockevent. But those 'identical' timers aren't if you care about
> which timer gets assigned where. I *think* that's not the case here
> unless you are trying to pick the timer for the clockevent by not
> defining the other timers.
> 
> Without having a complete picture of what's in 'gpt-creg', I can't
> give better advice.

I guess they need to share TRM, if possible, to show what this
block is.

-- 
With Best Regards,
Andy Shevchenko


