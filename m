Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20394AAAE8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380905AbiBESbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:31:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:43165 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239809AbiBESbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644085880; x=1675621880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FiAMsmUEnLLcZZu5SK9dJ0vGx8Wbqfrul5XkUxgza2w=;
  b=WuDjkrSlopyHEfmxqcFLplM+5HVH+oKCEbzKSbfQN35FxI2pYKoKqFsu
   f/IDqm3lPUVe92v9A/FyQ5Hw+NmH5TiLALIXMYuTwkTGlw/6uf4ceCZC9
   raHQNHDrQXu0Q8i/WFe31NaTQObTY282PrIdTyTjBbGnIhknzxPd+LuH/
   vjVdocR3Ro+8PwGytE29BBuhcrp+xpzClG8DYuifcxAE3VlOljGV2gpsD
   FKsr1NFbQ1Hlwz2z2EhPc/uvYGj1yyF13OM/awFj74jgPECiuo8qxc7Qx
   lY6rDrHb7G4HL19rLZmXMRr3d3Nu86wgyt19RVxoDmBn7Mew1FV1JIbH0
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248478721"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="248478721"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:31:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="498791829"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:31:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nGPpD-001LRt-4G;
        Sat, 05 Feb 2022 20:30:19 +0200
Date:   Sat, 5 Feb 2022 20:30:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 1/1] iio: multiplexer: Make use of device properties
Message-ID: <Yf7COufm4GG7VkJu@smile.fi.intel.com>
References: <20220202204427.57506-1-andriy.shevchenko@linux.intel.com>
 <20220205173854.14a7aca0@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205173854.14a7aca0@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 05:38:54PM +0000, Jonathan Cameron wrote:
> On Wed,  2 Feb 2022 22:44:27 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Looks good to me, but as it's complex I'd like Peter + anyone else interested
> to have a bit more time to take a look before I apply this one.

Sure, I would love to see more eyes and hear comments!

-- 
With Best Regards,
Andy Shevchenko


