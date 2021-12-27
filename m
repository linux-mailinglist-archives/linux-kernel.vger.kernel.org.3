Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A7C480311
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 18:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhL0Rwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 12:52:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:4639 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhL0Rwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 12:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640627559; x=1672163559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uivZtDQsssJoVXCGHwOl0scNNO1XH+LQhL6LBCEbZQ4=;
  b=Ns7u/ZLNoSb4INMdN5O5r9JshF/uXxSK/AF2oJgMo6uTVnxkoKVwqvr7
   Y21CucQygI6DvS1ZOxS6ylXQvL3oubzIEwAV7iOITMTXwhnI4VCeDRWh3
   MNi+JE4VLRn8WiajH1NI849bVhFhWl0f0ZwdRaIFwsBq0RhXR907XG579
   cWMUE8ik8guKtZ+CmVP8dr4vEDvSyN+XOQuokY6nZQcK5WEHDaFDrW0Mw
   G5gwmvSa7DUpcLsPF0WFpkIbx5SY3FOCwHt6FvYcB9uJ/SQvs98BLqMzh
   5UetD7SwGEqqMxEC8VV6rrGyuzi0OtHjrUbHPCxL3R5Y0lQSLy1lHEUjU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="228552733"
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="228552733"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 09:52:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,240,1635231600"; 
   d="scan'208";a="615408490"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 09:52:38 -0800
Date:   Mon, 27 Dec 2021 09:52:36 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] Re-enable ENQCMD and PASID MSR
Message-ID: <Ycn9ZKgCjRWK9JC5@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dear Maintainers,

On Fri, Dec 17, 2021 at 10:01:25PM +0000, Fenghua Yu wrote:
> Problems in the old code to manage SVM (Shared Virtual Memory) devices
> and the PASID (Process Address Space ID) led to that code being
> disabled.
> 
> Subsequent discussions resulted in a far simpler approach:
> 
> 1) PASID life cycle is from first allocation by a process until that
>    process exits.
> 2) All tasks begin with PASID disabled
> 3) The #GP fault handler tries to fix faulting ENQCMD instructions very
>    early (thus avoiding complexities of the XSAVE infrastructure)

Any comments on this series?

Thanks.

-Fenghua
