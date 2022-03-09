Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135604D3C63
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbiCIVvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbiCIVu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:50:59 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48243B459B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646862599; x=1678398599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HV/+nnR+t+oLvJeCRHCts1IrxHyVQNRs7afgjp2JRlg=;
  b=el4f+7j/ZOgGUlTCwkwShk1+Te9x9a09VFnjEeGFgm5Sw3GJ2MEgxigC
   8KJHZ2mrTYa1ezaRpd1lkcHMTHdGbK2lR1DBJtQedIV/X2iWrWgNxEzpN
   6eslCrXqcCUjzHTII45sdctdjYR0LjkzWHXNYxc69mq1i8qTEOxPbH2vk
   sSX1cRH4KIMtSJAFqlZ9ttPlDySGwlx8VCLNUnffyGQtIhJM4ro7KpdjF
   Da71vdiJccrg6R7rdJs1jLQaXR719+U8tXuLfAhtC54djaqOncvaAzpKG
   ihPSwKi5cj3VKLeHzj5xwnyHa0dmTqdHW8kDcTOMo98J3e5vWCAmDcQuH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318324148"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="318324148"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 13:49:56 -0800
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="642311367"
Received: from sli6-mobl.amr.corp.intel.com (HELO [10.209.104.236]) ([10.209.104.236])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 13:49:54 -0800
Message-ID: <ecbce3ff-7340-3dec-4682-197a6828f8ef@intel.com>
Date:   Wed, 9 Mar 2022 13:49:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv5 30/30] Documentation/x86: Document TDX kernel
 architecture
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-31-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220302142806.51844-31-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 06:28, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Document the TDX guest architecture details like #VE support,
> shared memory, etc.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
