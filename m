Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A84A49B6A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580026AbiAYOln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:41:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:43560 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388509AbiAYOjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643121548; x=1674657548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KqOpHtgSiTnL+U5jInAffrw6x8jdUAMVMkKnO4pQFoE=;
  b=aRlBQKnf2nbIhJeIQPvWgFPOP2f6HfVY/c5KuDJ7+JqxHWUZhEwij51X
   hcvu7Qw16NUR8Na/Ejfh+kVWxs5axa3XCGyRNy+Sv1wiy7xHKjHgGjqha
   5GWiKX3QCV9bXUFPmwx+UJBE+G+mpS2DGblCUf4Lgmgh9ohrlsL4G7ngc
   kCXCu9Kdbm5LzyloTRBiobZjcqEg9ris2I1JDvlAeiqBjiqhGc0Jk24MX
   /0/sznLkMgzEFF8bTuRdBU+1tCLXxlTcQP0MjmYHspibKPpjHFX8Melch
   yaWBlJrRav1n/TWI5yMB3BIDTuQNKaAYewh+ZgZZeFsHPf80pchMoAT+N
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246254525"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246254525"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 06:26:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="532428160"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 06:26:57 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jan 2022 16:26:55 +0200
Date:   Tue, 25 Jan 2022 16:26:54 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Zha Qipeng <qipeng.zha@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: mfd/intel_pmc_bxt: `intel_pmc_get_resources()` results in page
 fault
Message-ID: <YfAIrkJaahKpCta6@lahna>
References: <92c233bc-d1e0-b180-efaa-27e05fbd732b@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92c233bc-d1e0-b180-efaa-27e05fbd732b@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 25, 2022 at 02:08:53PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> `intel_pmc_get_resources()` does not set the name member in the `resource`
> struct `gcr_res` resulting in a page fault.
> 

On which system you reproduce this, and how? Can you also share ACPI
dump from that system.
