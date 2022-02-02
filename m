Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDED4A7955
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347074AbiBBUW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:22:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:13055 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbiBBUW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643833376; x=1675369376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YA+H5SdFPGwj4cgNCMIrYhu7ruw0L0EBppDmQsEGM8Y=;
  b=mif7JblvSe61dI8zBlT4ABN8Y46qw5++MGpJRYBNUxwbuKkvgANZrP4S
   1WF2cWksysuOScgrXyXbNB/lDjlHi2GHDiwt3TaDIytzpQMh2sXuR9A2j
   7kmIawNFwxR1EScSmUmKqoFpLHwy5WecG/V5Y0LhgJGb+LP9OU+Vgh30t
   MDBmK+LKDiO0GpJKlW9i7YYrJZryFYYaFtXjNmmrX+QurbRJL+prLcMKq
   QCjLMSgu6KP6AU4sN2KZS5Z77Q6tfTnWhvIgSVnZFZmkSNUisrQHtKqnz
   XXYsw06rZI1v2UtOInhNqk1pdbQK+ao/M1Ua8mYzqbsrdylroqFwRJTTH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248230990"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="248230990"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:22:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="676563104"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:22:56 -0800
Date:   Wed, 2 Feb 2022 12:22:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 05/44] x86/fpu: Refactor arch_set_user_pkey_access()
Message-ID: <20220202202256.GV785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-6-ira.weiny@intel.com>
 <87297f57-577a-2b33-81fa-935d1756eacb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87297f57-577a-2b33-81fa-935d1756eacb@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:50:44PM -0800, Dave Hansen wrote:
> On 1/27/22 09:54, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Both PKU and PKS update their register values in the same way.  They can
> > therefore share the update code.
> > 
> > Define a helper, pkey_update_pkval(), which will be used to support both
> > Protection Key User (PKU) and the new Protection Key for Supervisor
> > (PKS) in subsequent patches.
> > 
> > pkey_update_pkval() contributed by Thomas
> > 
> > Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Looks better than my original code.  Waaaaaay simpler.
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks,
Ira

