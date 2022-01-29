Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7B24A0501
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351895AbiA2AGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:06:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:47121 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344821AbiA2AGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643414792; x=1674950792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UunOKiMHQy6XK19DztRxwXIwZtwG2fh3eR8kNC4ifYw=;
  b=DJHYcSdNb1NHaV7QE3cFeYIGOrMfT6pyhqr88OGroxYBVhTIWLf/812m
   6Dm9DX3qu7RG/L/DJ8fZqZW9H7LKUX5Z9ZeoehABItE8spHvUCAW69ITq
   maI07Hne3ReuUnXys/KFEhBuhESLLpzqnoQ4cmVUkKBV4NQbiTJQc3I8m
   LL8TYyLipQaJRbDb6o2Uny5zsUtYrhxj6eFSKD+s9GmpMCrMMYIIlHs58
   ExLsBbfoP+vwon0NnlTQwaMd2LRVuW/udTLNd7dsvc415MMKYFyJcMtIa
   YLhvq2lDBVNi9l4B1joD/gHNIbSLEkAnBajW4aYeH4aHtK5vxHtk5KhEg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="246991372"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="246991372"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:06:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697258807"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:06:32 -0800
Message-ID: <b19f8123-a6dc-9004-efb9-2085fbccb7c2@intel.com>
Date:   Fri, 28 Jan 2022 16:06:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Subject: Re: [PATCH V8 06/44] mm/pkeys: Add Kconfig options for PKS
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-7-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220127175505.851391-7-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> @@ -1867,6 +1867,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
>  	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
>  	select ARCH_USES_HIGH_VMA_FLAGS
>  	select ARCH_HAS_PKEYS
> +	select ARCH_HAS_SUPERVISOR_PKEYS

For now, this should be:

	select ARCH_HAS_SUPERVISOR_PKEYS if CPU_SUP_INTEL

unless the AMD folks speak up and say otherwise. :)
