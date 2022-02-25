Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11DB4C3ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiBYB0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiBYB0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:26:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7377A223127;
        Thu, 24 Feb 2022 17:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645752348; x=1677288348;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AHywceCH61a0uC6jFQg+vmedTy7sSvp1pQ8B9HZ+b3E=;
  b=M7SoZXqKtwIe+e0yYRNL56zq2g2X0VQl5QSU430UA1aiASQMnBJXL4NV
   rc2iSMPeP76YvRbTaj1weZgf4HsUWjMJYxOLHv6hoF8t6EkTJrpehb4RR
   7nZwgRBh116VW8X1xDuyQ/VRRxL5TqJnm87fJnxsCYvyr8KsgmnhIInC0
   mn4lDcChJBCEb4wIpRbLpAarPb1KvjVK+NPaGl0WibUlece3mDIBBQqIr
   Z0WLKdHdrGYxeM6HLqFCpCYdUtsVY4me0fSxw3gZBGKLUh4m6GbOHJWNJ
   OsKkuoRBXDbPcgx2tfafQjYmlu0Pyf/fbdDj/SF35N4qYigT0Fu6lwelu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="233016891"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="233016891"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 17:25:48 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="549026403"
Received: from rjfenger-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.48.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 17:25:47 -0800
Message-ID: <111b378d22a7c5353bbd4537e0219a4d07d015ff.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/4] Thermal library and tools
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Thu, 24 Feb 2022 17:25:47 -0800
In-Reply-To: <3a3320d1-c4a8-d5e0-63ef-dd098711f38e@linaro.org>
References: <20220218125334.995447-1-daniel.lezcano@linaro.org>
         <3a3320d1-c4a8-d5e0-63ef-dd098711f38e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Want to try out on a system and check. But unfortunately couldn't get
to it yet. Hope to get to it next week. Is that OK?

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

