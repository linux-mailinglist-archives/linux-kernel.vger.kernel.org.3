Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DEA482CD4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 22:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiABVdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 16:33:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:59057 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbiABVdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 16:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641159232; x=1672695232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tOcLdskDoTN5jzMcDLB+fw9JZCfDnWPdrjL4XDr6GIM=;
  b=VFT7Ezhs5iUsOpeOAjNgRxx/lAyAYccCy4YOXpVOZdn8H98M9sA5uhNI
   96/KhgU2zZbfeZv0y3D5TvaPpkhBUeobA+WIbphz5CUiJk8EU/yLDXMy5
   obLKt6/mx33CwMXnl9+zDxcaRP7ZZHZN/Lhxd9EKDf2PrF5Ked+V32bmI
   PT8fKErrcYFGt7NjosExznlXUn8UQC08e8Daw6fE2X52eSiNMLYi3ucL/
   Y5B6Bw1cLl0lpKM39YwSsx1E9FtYDHSMYmyec4QRj/A4EGgu7/fw4inuF
   OTF8UwZtZjtPVi0Rpht3Kzy1xfZxLsceYXWs/6/VcD/5QGTnVpPAjCP1z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="229301323"
X-IronPort-AV: E=Sophos;i="5.88,256,1635231600"; 
   d="scan'208";a="229301323"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2022 13:33:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,256,1635231600"; 
   d="scan'208";a="667237249"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jan 2022 13:33:51 -0800
Date:   Sun, 2 Jan 2022 13:35:32 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] x86: Add definitions for the Intel Hardware
 Feedback Interface
Message-ID: <20220102213532.GB14930@ranerica-svr.sc.intel.com>
References: <20211220151438.1196-1-ricardo.neri-calderon@linux.intel.com>
 <20211220151438.1196-3-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0if855q45KOvCkOGq3DZfx4nsH1yzr5qCEYvZCe1bzASw@mail.gmail.com>
 <Yc32tQF+rvuqwLYf@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yc32tQF+rvuqwLYf@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 07:13:09PM +0100, Borislav Petkov wrote:
> On Thu, Dec 30, 2021 at 07:03:57PM +0100, Rafael J. Wysocki wrote:
> 
> > Subject: Re: [PATCH v2 2/7] x86: Add definitions for the Intel Hardware Feedback Interface
> 
> Make that subject prefix "x86/cpu:" when committing pls.
> 
> With that:
> 
> Acked-by: Borislav Petkov <bp@suse.de>
> 
> Thx.

Thank you Boris. I will make the requested change.

BR,
Ricardo
