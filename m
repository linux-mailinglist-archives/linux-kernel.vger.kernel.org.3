Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B747D464
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 16:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbhLVPwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 10:52:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:38092 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234501AbhLVPwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 10:52:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640188373; x=1671724373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/52NINLSBWMFVi/JeksSRB07Wwc3gFAOSE3AXFt0Qbg=;
  b=affT4tyomab1Yd0DDdUwiKzBe/QZBSeEkAt2AyhmxLec+/h+oeORYhsx
   ALkAIhaVMKcr+p3dTCuqa/Vu7SEqrtjg004U2AFe5+oS87eCwKrGHBIN6
   KiIlOuCvOeInrBR38ygbB16yMePNz1EppQDHbFdtbeUddAtemLpFCQZ3j
   pvOxOtkEgbGiJcGsT4Gd004S2RRWg/5wt4ZM/kNSQMNm+OgksLY/KLPPS
   Zqp+XvkytXT2nyVgW03goEeYXd3I5eDU3DHTLAldFxPxjpEh5aDS309c5
   Usk+hUvu7sub7efD/2eTfMmuHM/e3i/so+GcgiFM6Bj0VBTa0NfbjKoXu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="264845786"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="264845786"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 07:52:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="549533334"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 07:52:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n03tl-000njU-3J;
        Wed, 22 Dec 2021 17:51:25 +0200
Date:   Wed, 22 Dec 2021 17:51:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 1/3] spi: dln2: Propagate firmware node
Message-ID: <YcNJfKVTrU0ZAfL5@smile.fi.intel.com>
References: <20211222135423.62487-1-andriy.shevchenko@linux.intel.com>
 <YcNEz2MaigJp0UAe@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcNEz2MaigJp0UAe@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 03:31:27PM +0000, Mark Brown wrote:
> On Wed, Dec 22, 2021 at 03:54:21PM +0200, Andy Shevchenko wrote:
> > Propagate firmware node by using a specific API call, i.e. device_set_node().

> cc1: all warnings being treated as errors

Oops, I was in full impression that I have it enabled, but no, the other two
only. I'll fix this ASAP, sorry for that, I have added the configuration
option.

-- 
With Best Regards,
Andy Shevchenko


