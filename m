Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05386467DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359170AbhLCTOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:14:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:20411 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344093AbhLCTOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:14:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="237263944"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="237263944"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 11:11:22 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="610519304"
Received: from rlpollvo-mobl.amr.corp.intel.com (HELO ldmartin-desk2) ([10.212.5.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 11:11:21 -0800
Date:   Fri, 3 Dec 2021 11:11:20 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] x86/mm: Fix PAGE_KERNEL_IO removal breakage
Message-ID: <20211203191120.taonx5pwz4w3kmmm@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20211202144646.23186-1-joro@8bytes.org>
 <20211202155452.jh4qnvpx52r3od67@ldmartin-desk2>
 <20211203002513.fa43j6uvsn2ho4mm@ldmartin-desk2>
 <9148a579-2843-96f8-9b64-a3adb8fcb411@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9148a579-2843-96f8-9b64-a3adb8fcb411@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 09:35:47AM -0800, Dave Hansen wrote:
>On 12/2/21 4:25 PM, Lucas De Marchi wrote:
>> About the first patch,
>> 6b2a2138cf36 ("drm/i915/gem: Stop using PAGE_KERNEL_IO"),
>> I didn't notice any regression on the i915
>> side though. Is it safe to keep it? Otherwise we are probably better
>> off reverting everything.
>
>I'm just going to drop both of those for now:
>
>	27dff0f58bde ("x86/mm: Nuke PAGE_KERNEL_IO")
>	6b2a2138cf36 ("drm/i915/gem: Stop using PAGE_KERNEL_IO")
>
>If you work out a fix, please integrate the patch from Joerg and resubmit.

yeah, that seems the best approach here.

thanks
Lucas De Marchi
