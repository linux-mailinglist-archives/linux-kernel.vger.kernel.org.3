Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB814CC849
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiCCVpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiCCVpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:45:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E074ED96E;
        Thu,  3 Mar 2022 13:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646343864; x=1677879864;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=keicInxUEAKxeWmCP5NXaijHvEQLxflKToeZQsAFpxQ=;
  b=Q6GyVJuocg+KkPFz6557jyaAUhLTl4PnIvyJ+3p2Dzb25cdU3rj1tDTP
   BdWkHn+aB/olxWgVOVB8O8i74bVEHRtieWXyBAaRHCWTuUgrVP3Mo39uV
   purF0hRBNSk2La0MXs+MqZBYqGKnpjMmZ9TpoEzznmytalSBBIZp5t8qI
   sNtDUbquu2BLfT1LY3himT9XCFwDYqQyKm9ZQySJDnezZ+V37vQd3nFlm
   D1cxZlE6zm7nMqoV4c+6L9D3Ng9w0jt8SBWxizf8roHqcqDpQW70nJ1Zx
   eaIxik9AEBviI7q+n9yCImZiU6ZOInDKcNUzLQoqeCO8Zty37zn/c5Cpn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="252646611"
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="252646611"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 13:44:23 -0800
X-IronPort-AV: E=Sophos;i="5.90,153,1643702400"; 
   d="scan'208";a="642280146"
Received: from eabada-mobl2.amr.corp.intel.com (HELO [10.209.6.252]) ([10.209.6.252])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 13:44:23 -0800
Message-ID: <ce9bd1a9-491a-09e9-1cdc-a55669f8cf28@intel.com>
Date:   Thu, 3 Mar 2022 13:44:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi> <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi> <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com> <Yh7Q5fbOtr+6YWaS@iki.fi>
 <6f65287a-f69c-971e-be2c-929e327e7ff9@intel.com>
 <op.1igppyk9wjvjmi@hhuan26-mobl1.mshome.net>
 <19155cab-ecff-a8a6-f724-98c4535642ef@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
In-Reply-To: <19155cab-ecff-a8a6-f724-98c4535642ef@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 13:23, Reinette Chatre wrote:
> Unfortunately MAP_POPULATE is not supported by SGX VMAs because of their
> VM_IO and VM_PFNMAP flags. When VMAs with such flags obtain this capability
> then I believe that SGX would benefit.

Some Intel folks asked for this quite a while ago.  I think it's
entirely doable: add a new vm_ops->populate() function that will allow
ignoring VM_IO|VM_PFNMAP if present.

Or, if nobody wants to waste all of the vm_ops space, just add an
arch_vma_populate() or something which can call over into SGX.

I'll happily review the patches if anyone can put such a beast together.
