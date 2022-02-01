Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599864A68CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiBAXtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:49:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:3221 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbiBAXts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643759388; x=1675295388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N5v+3xAitePIgXk9HqsvQ0c7FVlsnCz4oZ5VVefB3ak=;
  b=CKJOWuyK1gdEn33BtOKhf9IlnVxKRG5F5/OWDuVckTraTNXbzFTFwyeK
   HMx9JOPvOEE8BHa2ItnDzd+R3udFaDhA+LxKtIACwKRGiLqAJh/PiPnyh
   rVfm6SLkyQgVzYRpsZVGPZojLO4a/biqXP2oeCZnGCHkQ5XQne3dStHYq
   VmNHRX4kZ9t5/aGWdgBTJ5N9xoh1nRznNJA/AGVcQLoQuGN69cxRaD9AY
   3/icO47BdzBEVk4PgXqRuVjKCNS+NvSq6PtzC3c+Rl8NnGkmpOU7bSUJC
   aqZuoqPfQp1wp32jKGK337ZOer1k4mIA1+T35QrGEaavqllX7RUFv2uvj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="246651297"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="246651297"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 15:49:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="538035714"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 15:49:47 -0800
Date:   Tue, 1 Feb 2022 15:49:47 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 02/44] Documentation/protection-keys: Clean up
 documentation for User Space pkeys
Message-ID: <20220201234947.GS785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-3-ira.weiny@intel.com>
 <6d6866d3-fd1b-c232-0e4f-72dd9845026b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d6866d3-fd1b-c232-0e4f-72dd9845026b@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:39:10PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > +PKeys Userspace (PKU) is a feature which is found on Intel's Skylake "Scalable
> > +Processor" Server CPUs and later.  And it will be available in future
> > +non-server Intel parts and future AMD processors.
> 
> The non-server parts are quite available these days.  I'm typing on one
> right now:
> 
> 	model name	: 11th Gen Intel(R) Core(TM) i7-1165G7 @ 2.80GHz
> 
> This can probably say:
> 
> Protection Keys for Userspace (PKU) can be found on:
>  * Intel server CPUs, Skylake and later
>  * Intel client CPUs, Tiger Lake (11th Gen Core) and later
>  * Future AMD CPUs
> 
> It would be great if the AMD folks can elaborate on that a bit, but I
> understand it might not be possible if the CPUs aren't out yet.

Updated.

But I'm leery about putting in any information about AMD CPU's.  Who could I
ask directly?

Ira
