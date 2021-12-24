Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D5D47F102
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 21:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344330AbhLXULr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 15:11:47 -0500
Received: from mga04.intel.com ([192.55.52.120]:55970 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhLXULr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 15:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640376707; x=1671912707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yxOVbnhxaTtSXDxw3/Z/jt2EJFus+3mv49/BliTiIyU=;
  b=eP1LlH1f/L8jYDCO8WfksxSownCXU9N5lA5iUBmfR0DqBcVC1QkGNxBe
   MHTEn+MuCUTHGNv9Le0bZaW4U/WIz1EW+JyXHdh3sjf2WMckKsYp3rQcV
   pW0TuRFicpnb9QKqe75RsHBCUVFkvmB4coi1/TVAw/T+rzLgenP6gBtfi
   HQC6XKJRNpAKtH2r401z9f54zn/lDYtZvsm1c6tHckiFs8uu7c/y9zeFn
   822G8YMM2kG0jJAqyi3gfK/tV1wJ4ZDVDluxA0kgxnjyj1QH5FW/hAb71
   1hD0FNh5HqGskir2yr/SNerKlOHSzqBanYfqJfXXR4cUWgLSKYaTEJsWV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10208"; a="239789446"
X-IronPort-AV: E=Sophos;i="5.88,233,1635231600"; 
   d="scan'208";a="239789446"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 12:11:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,233,1635231600"; 
   d="scan'208";a="485438109"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 12:11:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n0qtQ-001lu1-CW;
        Fri, 24 Dec 2021 22:10:20 +0200
Date:   Fri, 24 Dec 2021 22:10:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the driver-core tree with the
 drivers-x86-fixes tree
Message-ID: <YcYpLFmy0Z+EBRNY@smile.fi.intel.com>
References: <20211224131450.2c7e0dae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224131450.2c7e0dae@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 01:14:50PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the driver-core tree got a conflict in:
> 
>   drivers/platform/x86/intel/Kconfig
> 
> between commit:
> 
>   4f6c131c3c31 ("platform/x86/intel: Remove X86_PLATFORM_DRIVERS_INTEL")
> 
> from the drivers-x86-fixes tree and commit:
> 
>   a3c8f906ed5f ("platform/x86/intel: Move intel_pmt from MFD to Auxiliary Bus")
> 
> from the driver-core tree.
> 
> I fixed it up (see below) and can carry the fix as necessary.

Fix is correct, thanks!

-- 
With Best Regards,
Andy Shevchenko


