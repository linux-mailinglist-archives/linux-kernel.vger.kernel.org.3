Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0CF4C114B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbiBWLcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbiBWLcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:32:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AD3DFF4;
        Wed, 23 Feb 2022 03:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645615895; x=1677151895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0zm8wIULsN4Dyhom0z7elKrKoBwJYW9qnpSEEw2q5Wk=;
  b=kog0pOB+nM8reYobUTlNS5hEPr9EMXMc5hqqtRTBdJSePP5+42ZRC+xJ
   Vv3aE1ws2ZvDtIZp6lms0hkqlYXpQ/wwciq3r39/giuhoPxb8aWxJ6brd
   YfTyz0UcfIWNVXVO5MFnondma+ZoY5haECBCm2BfkSYNC9S9q3tyQcAqm
   Q5QNZGwt9NdTsXnp6Q0phHI3HxrGZUFY/yPQnG8TtOyyyISquRPfY8LD2
   6GTKN/SxaMyVxoRDKqYWF25dl2hR0l8P270NORYqpmFdarFHne/TKhnf2
   rxZW4is9aKdHb2PfiAuCLpH6jFqD+f58s6hKmYWnmcXkxNhAJaHDXx+R9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="250769476"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="250769476"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:31:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="637389174"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:31:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nMpqx-007OOM-0K;
        Wed, 23 Feb 2022 13:30:39 +0200
Date:   Wed, 23 Feb 2022 13:30:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     shruthi.sanil@intel.com, daniel.lezcano@linaro.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mgross@linux.intel.com,
        srikanth.thokala@intel.com, lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v8 1/2] dt-bindings: timer: Add bindings for Intel Keem
 Bay SoC Timer
Message-ID: <YhYa3tlTEcLct2xu@smile.fi.intel.com>
References: <20220222095654.9097-1-shruthi.sanil@intel.com>
 <20220222095654.9097-2-shruthi.sanil@intel.com>
 <YhVuJaf3AJ1c6TpT@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhVuJaf3AJ1c6TpT@robh.at.kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 05:13:41PM -0600, Rob Herring wrote:
> On Tue, Feb 22, 2022 at 03:26:53PM +0530, shruthi.sanil@intel.com wrote:
> > From: Shruthi Sanil <shruthi.sanil@intel.com>
> > 
> > Add Device Tree bindings for the Timer IP, which can be used as
> > clocksource and clockevent device in the Intel Keem Bay SoC.

...

> > +    soc {
> > +        #address-cells = <0x2>;
> > +        #size-cells = <0x2>;
> > +
> > +        gpt@20331000 {
> > +            compatible = "intel,keembay-gpt-creg", "simple-mfd";
> 
> It looks like you are splitting things based on Linux implementation
> details. Does this h/w block have different combinations of timers and
> counters? If not, then you don't need the child nodes at all. There's
> plenty of h/w blocks that get used as both a clocksource and clockevent.
> 
> Maybe I already raised this, but assume I don't remember and this patch
> needs to address any questions I already asked.

I dunno if I mentioned that hardware seems to have 5 or so devices behind
the block, so ideally it should be one device node that represents the global
register spaces and several children nodes.

However, I am not familiar with the established practices in DT world, but
above seems to me the right thing to do since it describes the hardware as
is (without any linuxisms).

> > +            reg = <0x0 0x20331000 0x0 0xc>;
> > +            ranges = <0x0 0x0 0x20330000 0xF0>;
> > +            #address-cells = <0x1>;
> > +            #size-cells = <0x1>;
> > +
> > +            counter@e8 {
> > +                compatible = "intel,keembay-counter";
> > +                reg = <0xe8 0x8>;
> > +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +
> > +            timer@30 {
> > +                compatible = "intel,keembay-timer";
> > +                reg = <0x30 0xc>;
> > +                interrupts = <GIC_SPI 0x5 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks = <&scmi_clk KEEM_BAY_A53_TIM>;
> > +            };
> > +        };
> > +    };

-- 
With Best Regards,
Andy Shevchenko


