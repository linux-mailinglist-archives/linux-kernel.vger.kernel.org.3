Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F09E4A9FF3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiBDTWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 14:22:32 -0500
Received: from mga01.intel.com ([192.55.52.88]:56286 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbiBDTWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:22:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644002550; x=1675538550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wSIco4HSOt+lt6TCo7dRtlCvVXG5VRlkxc5iG/KagDM=;
  b=oFV6gY7pFI+xkli7hbFFI2gJqq1ffbkGfgV6q+mCmLwTDZTQx5qT4sGP
   f8p7jS/kxhUMdIX+GLje8aDjPVAxflMv9pdYwKUULQouVafnZzYSwGG5y
   UGomPjmoBbqzyaFILTKKRCO4WpD/c2zMNJto3XpQ2wWw4BFdVzwjyBrLz
   jSERJId/YgTC+OePNwFDgZznLApUmNRC5gyJ6hwR79d76Z2ts6Rh9avuc
   b6tnXHW+MVvbHyjikLhAiFfiDstsFj3bjnuz51J5G7FPC85uA9FYDDNc6
   1xOWgd7/FQDUDuZRLT9a96u4QeSTtQtY4eQAxLvGp9E8nkKik7Z748zSn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="272931237"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="272931237"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:21:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="677187308"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:21:28 -0800
Date:   Fri, 4 Feb 2022 11:21:28 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 07/44] x86/pkeys: Add PKS CPU feature bit
Message-ID: <20220204192128.GA785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-8-ira.weiny@intel.com>
 <63950211-4244-3f85-0fb3-eb5a38d4ed50@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63950211-4244-3f85-0fb3-eb5a38d4ed50@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 03:05:36PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Protection Keys for Supervisor pages (PKS) enables fast, hardware thread
> > specific, manipulation of permission restrictions on supervisor page
> 
> Nit: should be "hardware-thread-specific".
> 
> > mappings.  It uses the same mechanism of Protection Keys as those on
> > User mappings but applies that mechanism to supervisor mappings using a
> > supervisor specific MSR.
> 
> "supervisor-specific"
> 
> 	Memory Protection Keys (pkeys) provides a mechanism for
> 	enforcing page-based protections, but without requiring
> 	modification of the page tables when an application changes
> 	protection domains.
> 
> 	The kernel currently supports the pkeys for userspace (PKU)
> 	architecture.  That architecture has been extended to
> 	additionally support supervisor mappings.  The supervisor
> 	support is referred to as PKS.
> 
> I probably wouldn't mention the MSR unless you want to say:
> 
> 	The main difference between PKU and PKS is that PKS does not
> 	introduce any new instructions to write to its register.  The
> 	register is exposed as a normal MSR and is accessed with the
> 	normal MSR instructions.
> 
> 
> > The CPU indicates support for PKS in bit 31 of the ECX register after a
> > cpuid instruction.
> 
> I'd just remove this sentence.  We don't need to rehash each tiny morsel
> of the architecture in a commit message.

All done.  Thanks for the verbiage.
Ira

