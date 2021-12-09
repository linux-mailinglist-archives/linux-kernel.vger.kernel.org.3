Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED4F46ECDA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhLIQPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:15:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:40656 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhLIQPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:15:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="298924660"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="298924660"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 08:04:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="463291598"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2021 08:04:58 -0800
Date:   Thu, 9 Dec 2021 08:03:46 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
Message-ID: <20211209160346.GA7692@ranerica-svr.sc.intel.com>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
 <20211106013312.26698-7-ricardo.neri-calderon@linux.intel.com>
 <b51c9b2a-40d2-6575-7746-3059eec53519@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b51c9b2a-40d2-6575-7746-3059eec53519@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:29:46AM +0100, Daniel Lezcano wrote:
> On 06/11/2021 02:33, Ricardo Neri wrote:
> > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > 
> > Add a new netlink event to notify change in CPU capabilities in terms of
> > performance and efficiency.
> > 
> > Firmware may change CPU capabilities as a result of thermal events in the
> > system or to account for changes in the TDP (thermal design power) level.
> > 
> > This notification type will allow user space to avoid running workloads
> > on certain CPUs or proactively adjust power limits to avoid future events.
> > 
> 
> [ ... ]
> 
> > +	[THERMAL_GENL_ATTR_CPU_CAPABILITY_ID]	= { .type = NLA_U32 },
> > +	[THERMAL_GENL_ATTR_CPU_CAPABILITY_PERF]	= { .type = NLA_U32 },
> > +	[THERMAL_GENL_ATTR_CPU_CAPABILITY_EFF]	= { .type = NLA_U32 },
> >  };
> 
> AFAIU, 0 <= perf < 256 and 0 <= eff < 256, right?
> 
> Is the following true?
> 
> 	0 <= perf + eff < 256

No, they are not. They are set independently.

Thanks and BR,
Ricardo

