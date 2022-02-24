Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772E54C279E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiBXJJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiBXJJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:09 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C811A02B1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645693715; x=1677229715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SUUa5i5lhsFTUO8y2auINqSfvLwChcRDCSGW5tS+R7s=;
  b=TzrPElUiiGJxVVx/FIZWujX9T07J3qnqvmOiKwxYjvmaJf1T0DKM6miH
   7e1JAwIDWBKGJvrDpuK2hdKS5baBoPMTJ7IuySluwCs7y0lcXScxjmbvR
   gQYQs40NJ9z+lJ2p/S+AVDfpS5DuastprWp3V23q5Ym38gi4H5u89Zfpo
   HaNU3hJEIXGjN6BfL+UtGlgNkNyklWh4oLnktHOun1AiSFWTVMq+aO4Lj
   9K/dcpoC24lqGoX1Xb4VgtXIFHqMeSMWG1YZYIgHQbl77f7lkEC58ZcSP
   E91//QncoXKcUS4WNjfQz0Tp+b6nGieMKNfwSbNIFvqQTucUcbpnKaDKy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315412243"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="315412243"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 01:08:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="533056699"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.255.31.244]) ([10.255.31.244])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 01:08:25 -0800
Message-ID: <70a047bc-88ef-e574-df33-d6caacef340c@intel.com>
Date:   Thu, 24 Feb 2022 17:08:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCHv2 29/29] Documentation/x86: Document TDX kernel
 architecture
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-30-kirill.shutemov@linux.intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20220124150215.36893-30-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2022 11:02 PM, Kirill A. Shutemov wrote:

> +#VE due to CPUID instruction
> +----------------------------
> +
> +In TDX guests, most of CPUID leaf/sub-leaf combinations are virtualized by
> +the TDX module while some trigger #VE. Combinations of CPUID leaf/sub-leaf
> +which triggers #VE are configured by the VMM during the TD initialization
> +time (using TDH.MNG.INIT).
> +

The description is incorrect.

TDH.MNG.INIT does not configure whether the CPUID leaf/sub-leaf triggers 
#VE or not. It configures if some feature bits in specific leaf-subleaf 
are exposed to TD guest or not.

Whether the CPUID(leaf, sub-leaf) causes #VE or not, is defined in TDX 
spec, and not configurable by user or VMM.
