Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858B84A68CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbiBAXyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:54:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:31748 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbiBAXyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643759662; x=1675295662;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=1/Y1IYa5dfZtRgazES+BTTy+QyCzD5BEi/rzkEVnTXA=;
  b=JuMBLHENd5czYE5cztSQkMhP7xRvaIjlD7hdn72LpzSev5RsXiwx+jPg
   HZLR/95TBhVoTZ0ky1VHWBUvffeWWvN6PH7iaukOy4Hr8EpeO5GAgEc6g
   FVvL1LWvA5iBltClmar25JNYnjQu4Iyds41bxxvQ10h7LZkuSyuOyFgHb
   o/7jNUvAhj3AkJscnI22O1f4UBuGusXiOxYH0fxA/VK2WUcIdTJujSJ6f
   VtF7eJ3FOuTai4GkCpb1IDPX0qGp6gGhyPlkP44v6tubMQuSuBak6KE3/
   MWif9BjG3aW+yFaUUbOYDEKJa1LxjL9dh19yGIwCjmFADVTtj54ed29kG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="334179477"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="334179477"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 15:54:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="565777611"
Received: from kssimha-mobl1.amr.corp.intel.com (HELO [10.212.228.15]) ([10.212.228.15])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 15:54:22 -0800
Message-ID: <21762a91-ce69-540a-6209-537aad5ae7b7@intel.com>
Date:   Tue, 1 Feb 2022 15:54:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-3-ira.weiny@intel.com>
 <6d6866d3-fd1b-c232-0e4f-72dd9845026b@intel.com>
 <20220201234947.GS785175@iweiny-DESK2.sc.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 02/44] Documentation/protection-keys: Clean up
 documentation for User Space pkeys
In-Reply-To: <20220201234947.GS785175@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/22 15:49, Ira Weiny wrote:
>> Protection Keys for Userspace (PKU) can be found on:
>>  * Intel server CPUs, Skylake and later
>>  * Intel client CPUs, Tiger Lake (11th Gen Core) and later
>>  * Future AMD CPUs
>>
>> It would be great if the AMD folks can elaborate on that a bit, but I
>> understand it might not be possible if the CPUs aren't out yet.
> Updated.
> 
> But I'm leery about putting in any information about AMD CPU's.  Who could I
> ask directly?

I forgot who from AMD was chiming in on pkeys.  So, I did:

	git log --author=amd.com arch/x86/

and searched for 'keys'.  I came up with this pretty quickly:

> commit 38f3e775e9c242f5430a9c08c11be7577f63a41c
> Author: Babu Moger <babu.moger@amd.com>
> Date:   Thu May 28 11:08:23 2020 -0500
> 
>     x86/Kconfig: Update config and kernel doc for MPK feature on AMD
>     
>     AMD's next generation of EPYC processors support the MPK (Memory
>     Protection Keys) feature. Update the dependency and documentation.
>     
>     Signed-off-by: Babu Moger <babu.moger@amd.com>
>     Signed-off-by: Borislav Petkov <bp@suse.de>
>     Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
>     Link: https://lkml.kernel.org/r/159068199556.26992.17733929401377275140.stgit@naples-babu.amd.com
You also don't have to go out and find this information for your
documentation.  Just say "future" and then poke the AMD folks.
