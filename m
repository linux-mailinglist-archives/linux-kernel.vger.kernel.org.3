Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4EC4A9FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiBDTOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:14:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:3048 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231728AbiBDTOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644002048; x=1675538048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IqYgTa7UYBztaNoVH32tJ/hHlFS47elux5CJXuQPtqU=;
  b=C6R/iPPjlIw2g1O9PBK41vOCILgb90UkO+gBTLk6VVnvq+RU4Qo3bqb1
   Id1T/4dyw494E53s1Fh1Zeazlfwz9HuIJzU693CA0yDOHbRj+6hSpXkLA
   xoJ66Atl7puQ+28QOOacmvDKOtZv2cDShaZ/3QTfTkG3Cmx6o+CpTUqPE
   UMajEYaqrYjvrm9feOCNO6Rt1Rc4rN6pwuR8HiCpTA4reuq3Va5WxW7UN
   sJBwMgAxXaXNkHs7WqXcnfwXfC5yvg4hJLQopamguCbssjTfQm3LMv7Fk
   OsOCb6pH6P2aVB6ekZMXTNorqs0Ba5rl7Zqz6voa3Qbcuz4CQodeGQxS2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="334823189"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="334823189"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:14:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="677185868"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:14:08 -0800
Date:   Fri, 4 Feb 2022 11:14:07 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 06/44] mm/pkeys: Add Kconfig options for PKS
Message-ID: <20220204191407.GZ785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-7-ira.weiny@intel.com>
 <b19f8123-a6dc-9004-efb9-2085fbccb7c2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19f8123-a6dc-9004-efb9-2085fbccb7c2@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 04:06:29PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > @@ -1867,6 +1867,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
> >  	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
> >  	select ARCH_USES_HIGH_VMA_FLAGS
> >  	select ARCH_HAS_PKEYS
> > +	select ARCH_HAS_SUPERVISOR_PKEYS
> 
> For now, this should be:
> 
> 	select ARCH_HAS_SUPERVISOR_PKEYS if CPU_SUP_INTEL
> 
> unless the AMD folks speak up and say otherwise. :)

Done for now.

Ira
