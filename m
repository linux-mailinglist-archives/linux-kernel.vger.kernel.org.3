Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EB547D6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344694AbhLVS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:27:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:33504 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344690AbhLVS1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640197630; x=1671733630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uN531P6eAKoDlmobwFM1DNbNSTwy3I5gzy72Rjv6Q/8=;
  b=ZS7MZWfwKbvKrOpxFSzWZg49+LrFdtx4NENBaCQLvY+dfJ9efZBIBArm
   wAMZoJW6SGF68TjCxgc2pKZcgLz/zfy7dGy26RNVPF/pTNffOL7y9ZQW5
   TiDGhOWuCUJxYaWuJQ8qf8DTXaCt6fB9kiO6yxKQwfrcIj+ts87ik4FnZ
   pNFrMcvDyGxYHtJOxuls0HoxKjTgVlXqPFr4upNZi2kWpCjfIIXokY1d/
   ht1aD029n75kAy9x21T2KIE6qjNNoQCR6tAliMIbfQ+2ikgbSO3TBy9Xw
   2ZVxijTKRkBEZ2S720eQMPXZQW9ccczcqZypmr0HQW7yJ/EYPaOyvL4eP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="220697807"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="220697807"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 10:27:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="587098653"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 10:27:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n06J5-000uwc-2x;
        Wed, 22 Dec 2021 20:25:43 +0200
Date:   Wed, 22 Dec 2021 20:25:42 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v1 1/1] KVM: arm64: vgic: Replace kernel.h with the
 necessary inclusions
Message-ID: <YcNtpnxbyDA/CGgc@smile.fi.intel.com>
References: <20211222165552.69288-1-andriy.shevchenko@linux.intel.com>
 <8735mk1pgt.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735mk1pgt.wl-maz@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 06:09:22PM +0000, Marc Zyngier wrote:
> On Wed, 22 Dec 2021 16:55:52 +0000,
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > When kernel.h is used in the headers it adds a lot into dependency hell,
> > especially when there are circular dependencies are involved.
> 
> Which circular dependencies? What problem are you solving?

In particular moving bitmap_*alloc() APIs to the headers.

But this may be a side effect of what I realized during the attempts
of solving that issue. In any case there is no need to take entire
mess of kernel.h in another header.

-- 
With Best Regards,
Andy Shevchenko


