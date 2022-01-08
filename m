Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8AE48808B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 02:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiAHB3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 20:29:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:16537 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbiAHB3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 20:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641605342; x=1673141342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ghzyGFQkL6L79b8lYA7DMVT/1NPJx+aYKEfxD5IM+FA=;
  b=f8y+kO0WEeKTE4fhk+176m2A1EtIIrZycYIenoqg2EKpbOCt0IAY51x7
   EqIfjeUT7UaqfcTH8Cs7wvr2orUIUtDnLWIYPAqe+W3PdR/XmuswyJogH
   WQQhJ/2BJj+aSiOZw3Ug6RP4yjwEUI+zM4UhmoY7KTQv2OuIpQCmfK8C6
   xIwTruLU65Ozpa1ntGhZ7fUu3fWslYgVasRy/0LA45cXF832o7ITB1pDd
   NJVOSceENlJO9juTXWqSm4AFgSQrotUV/de3XifutmQHuKXcgWKViArH1
   +erkEQPC/K8Y6vLkFeRQ/OrHRw0pgNJf2uSR4XkrSxYS4zwDH17sCa2Q5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="229779047"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="229779047"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 17:28:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="622118767"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2022 17:28:52 -0800
Date:   Fri, 7 Jan 2022 17:30:38 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] Thermal: Introduce the Hardware Feedback
 Interface for thermal and performance management
Message-ID: <20220108013038.GB19633@ranerica-svr.sc.intel.com>
References: <20220106025059.25847-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106025059.25847-1-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 06:50:52PM -0800, Ricardo Neri wrote:
> Hi,
> 
> This is v3 of this patchset after having incorporated the feedback from
> reviewers. Please find v1 and v2 in [1] and [2], respectively.

Please disregard this version. I found a very obvious bug in patch 4. I
will post a v4 that fixes this bug.

If you have started working on providing feedback. It will be valid as
v4 will only fix that bug.

Thank you for your understanding.

Thanks and BR,
Ricardo
