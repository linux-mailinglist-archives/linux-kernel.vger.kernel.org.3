Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031684C725A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiB1RQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiB1RQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:16:06 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9682E70CE2;
        Mon, 28 Feb 2022 09:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646068526; x=1677604526;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wy3mr4XjYMV/acNZkxjYvh8ckQJX8upX4/iAoBhu4Is=;
  b=PoJHC0fB1hhQe0dvH9sTwIdPBTeijABEAXooZsWpZqoVhXDr56lMfhxh
   t87m3RE5KsslsUxqot+5Pq1qsXONcJwDCyRnpvqNqylWzAbqp3oz80UIu
   RlibouLZ/WLgmY36M7G98D7h6aQXmuZ0dW4nSbVw/dUQGzwvDURNDBxo8
   Ze6bnuU4YGWZySMFLqsjU4dx2KHNSRgLfzuqGNnsjxr6+rGM+1k7HcSjK
   pE7foiC/AYPdrW2zSfSIOzTlazxr+SWdH92NmLl60D3kPxyYrstF0X+3U
   jXYGz4N3gQf+9fYr5/7s/P5sFiWOLHgyKvISAy/LplvDCFPb7ayo/Z9fr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="313652615"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="313652615"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:13:06 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="593289987"
Received: from adigar-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.152.236])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 09:13:05 -0800
Message-ID: <bcfcf159c62a2a071a7bc7020f811fd9383af6de.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/4] Thermal library and tools
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Mon, 28 Feb 2022 09:13:05 -0800
In-Reply-To: <3a3320d1-c4a8-d5e0-63ef-dd098711f38e@linaro.org>
References: <20220218125334.995447-1-daniel.lezcano@linaro.org>
         <3a3320d1-c4a8-d5e0-63ef-dd098711f38e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,
On Thu, 2022-02-24 at 22:41 +0100, Daniel Lezcano wrote:
> 
> Hi,
> 
> What shall I do with this series? Is everyone ok with it?
> 
Some comments
1. White space errors while applying
$git am ../daniel/\[PATCH\ v1\ 1_4\]\ tools_lib_thermal_\ Add\ a\
thermal\ library.mbox
Applying: tools/lib/thermal: Add a thermal library
.git/rebase-apply/patch:234: trailing whitespace.
clean: 
.git/rebase-apply/patch:715: trailing whitespace.
				     
nla_get_u32(attrs[THERMAL_GENL_ATTR_TZ_TEMP]), arg); 
.git/rebase-apply/patch:878: trailing whitespace.
	
.git/rebase-apply/patch:879: trailing whitespace.
struct thermal_handler; 
.git/rebase-apply/patch:1103: trailing whitespace.
}	
warning: squelched 5 whitespace errors
warning: 10 lines add whitespace errors.

$git am ../daniel/\[PATCH\ v1\ 2_4\]\ tools_thermal_\ Add\ util\
library.mbox
Applying: tools/thermal: Add util library
.git/rebase-apply/patch:152: trailing whitespace.
clean: 
.git/rebase-apply/patch:259: trailing whitespace.
	
.git/rebase-apply/patch:285: trailing whitespace.
	
.git/rebase-apply/patch:385: trailing whitespace.
		
.git/rebase-apply/patch:392: trailing whitespace.
		/* 
warning: squelched 1 whitespace error
warning: 6 lines add whitespace errors.
$git am ../daniel/\[PATCH\ v1\ 3_4\]\ tools_thermal_\ A\ temperature\
capture\ tool.mbox
Applying: tools/thermal: A temperature capture tool
.git/rebase-apply/patch:165: trailing whitespace.
	regex_t regex;	
.git/rebase-apply/patch:205: trailing whitespace.
	
.git/rebase-apply/patch:208: trailing whitespace.
	
.git/rebase-apply/patch:249: trailing whitespace.
		
.git/rebase-apply/patch:265: trailing whitespace.
	
warning: squelched 13 whitespace errors
warning: 18 lines add whitespace errors.

$ git am ../daniel/\[PATCH\ v1\ 4_4\]\ tools_thermal_\ Add\ thermal\
daemon\ skeleton.mbox
Applying: tools/thermal: Add thermal daemon skeleton
.git/rebase-apply/patch:170: trailing whitespace.
}		
.git/rebase-apply/patch:186: trailing whitespace.
	
.git/rebase-apply/patch:197: trailing whitespace.
	
.git/rebase-apply/patch:199: trailing whitespace.
	
.git/rebase-apply/patch:348: trailing whitespace.
	
warning: squelched 3 whitespace errors
warning: 8 lines add whitespace errors.


2. No help or man page
thermal_engine has some options. There is no --help or man

3. Silent failure

For example:
$sudo ./thermal-engine 

4.
sudo ./thermometer 
Options;
 * config: 'thermometer.conf'
 * log level: '7'
 * postfix: -2022-02-28_16:51:33
 * output: .

What an user can do?

Thanks,
Srinivas
 
> 
> 
> On 18/02/2022 13:53, Daniel Lezcano wrote:
> > This series provides a thermal library providing the basic callback
> > oriented
> > netlink communication and events with the thermal framework, a
> > temperature
> > capture tool and a thermal monitoring skeleton using the thermal
> > library.
> > 
> > Changelog:
> >   - V1:
> >      - Took into account RFC comments (unsubscribe, error enum,
> > thermal daemon
> >        renamed to thermal-engine)
> > 
> > Daniel Lezcano (4):
> >    tools/lib/thermal: Add a thermal library
> >    tools/thermal: Add util library
> >    tools/thermal: A temperature capture tool
> >    tools/thermal: Add thermal daemon skeleton
> > 
> >   tools/Makefile                                |  36 +-
> >   tools/lib/thermal/.gitignore                  |   2 +
> >   tools/lib/thermal/Build                       |   5 +
> >   tools/lib/thermal/Makefile                    | 165 ++++++++
> >   tools/lib/thermal/commands.c                  | 351
> > ++++++++++++++++
> >   tools/lib/thermal/events.c                    | 164 ++++++++
> >   tools/lib/thermal/include/thermal.h           | 141 +++++++
> >   tools/lib/thermal/libthermal.map              |  25 ++
> >   tools/lib/thermal/libthermal.pc.template      |  12 +
> >   tools/lib/thermal/sampling.c                  |  75 ++++
> >   tools/lib/thermal/thermal.c                   | 126 ++++++
> >   tools/lib/thermal/thermal_nl.c                | 215 ++++++++++
> >   tools/lib/thermal/thermal_nl.h                |  46 ++
> >   tools/thermal/lib/Build                       |   3 +
> >   tools/thermal/lib/Makefile                    | 158 +++++++
> >   .../thermal/lib/libthermal_tools.pc.template  |  12 +
> >   tools/thermal/lib/log.c                       |  77 ++++
> >   tools/thermal/lib/log.h                       |  31 ++
> >   tools/thermal/lib/mainloop.c                  | 135 ++++++
> >   tools/thermal/lib/mainloop.h                  |  14 +
> >   tools/thermal/lib/thermal-tools.h             |  10 +
> >   tools/thermal/lib/uptimeofday.c               |  40 ++
> >   tools/thermal/lib/uptimeofday.h               |  12 +
> >   tools/thermal/thermal-engine/Build            |   2 +
> >   tools/thermal/thermal-engine/Makefile         |  27 ++
> >   tools/thermal/thermal-engine/thermal-engine.c | 287 +++++++++++++
> >   tools/thermal/thermometer/Build               |   2 +
> >   tools/thermal/thermometer/Makefile            |  23 +
> >   tools/thermal/thermometer/thermometer.c       | 393
> > ++++++++++++++++++
> >   tools/thermal/thermometer/thermometer.conf    |   5 +
> >   30 files changed, 2591 insertions(+), 3 deletions(-)
> >   create mode 100644 tools/lib/thermal/.gitignore
> >   create mode 100644 tools/lib/thermal/Build
> >   create mode 100644 tools/lib/thermal/Makefile
> >   create mode 100644 tools/lib/thermal/commands.c
> >   create mode 100644 tools/lib/thermal/events.c
> >   create mode 100644 tools/lib/thermal/include/thermal.h
> >   create mode 100644 tools/lib/thermal/libthermal.map
> >   create mode 100644 tools/lib/thermal/libthermal.pc.template
> >   create mode 100644 tools/lib/thermal/sampling.c
> >   create mode 100644 tools/lib/thermal/thermal.c
> >   create mode 100644 tools/lib/thermal/thermal_nl.c
> >   create mode 100644 tools/lib/thermal/thermal_nl.h
> >   create mode 100644 tools/thermal/lib/Build
> >   create mode 100644 tools/thermal/lib/Makefile
> >   create mode 100644 tools/thermal/lib/libthermal_tools.pc.template
> >   create mode 100644 tools/thermal/lib/log.c
> >   create mode 100644 tools/thermal/lib/log.h
> >   create mode 100644 tools/thermal/lib/mainloop.c
> >   create mode 100644 tools/thermal/lib/mainloop.h
> >   create mode 100644 tools/thermal/lib/thermal-tools.h
> >   create mode 100644 tools/thermal/lib/uptimeofday.c
> >   create mode 100644 tools/thermal/lib/uptimeofday.h
> >   create mode 100644 tools/thermal/thermal-engine/Build
> >   create mode 100644 tools/thermal/thermal-engine/Makefile
> >   create mode 100644 tools/thermal/thermal-engine/thermal-engine.c
> >   create mode 100644 tools/thermal/thermometer/Build
> >   create mode 100644 tools/thermal/thermometer/Makefile
> >   create mode 100644 tools/thermal/thermometer/thermometer.c
> >   create mode 100644 tools/thermal/thermometer/thermometer.conf
> > 
> 
> 

