Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8820349820C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbiAXOZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:25:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:63763 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238109AbiAXOZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643034306; x=1674570306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sfjkK22NlOUo/XJ4kG04bQhmoPnIkhf2ZWI38Fc2OVg=;
  b=d29WbpZiD+hx8RUikC7umeIl9uefHO+RJChKWMc8+C5gShOMqNlM8XHp
   UE3aBs9eqgiJcn8Ya9xZOdBqMOx/iRIiC7oewxl7X7CcKrDvt7VfOafBX
   mAWgYGtk0s3CMhYOjQbhj1GOEw1954jM63E7ww2COxkm9mW1u0+pdtHXQ
   t41/P/MscwKKeScWE0LDbqmEa2JCntq3GF4XPUe2rTxPieK9EGasdQ9eK
   6+n813inj+4cApbTjq1t/XpYugY23X6LliyWCrDfAj5WZva88KuGOH9xI
   9TCUEjgmRUyVDkDAxvuDtp9u4fdTHgN9Bm9EZWvNiaBQEJ80TdNbYzGg0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246000553"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246000553"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:25:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="534242458"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:25:03 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Jan 2022 16:22:49 +0200
Date:   Mon, 24 Jan 2022 16:22:49 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Remove useless DMA-32 fallback configuration
Message-ID: <Ye62OesXyIDhBEyy@lahna>
References: <4b40fc065771fadc1a5187d533bd760e034ece58.1641732679.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b40fc065771fadc1a5187d533bd760e034ece58.1641732679.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 01:51:31PM +0100, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> 
> While at it, include directly <linux/dma-mapping.h> instead on relying on
> indirect inclusion.
> 
> [1]: https://lkml.org/lkml/2021/6/7/398
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thanks!
