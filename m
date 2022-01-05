Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305174854A4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 15:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbiAEOc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 09:32:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:17508 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240918AbiAEOcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 09:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641393167; x=1672929167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0sxvYCr9VCz0GQWpfHPRHGVMkJ3+y7jjBz7FBdztPqM=;
  b=g0UFlizAOg7IX2Kz/RmP4lJfWqbAr+a1oBqhpCVoXyit4GFKdyAZebQj
   bbYY7pCRzaubjZx9PBqWIqvWnaKT1HVclmbtctdzFKn42x9MRicTk6Fiy
   rErGd5AwMljNkO37YXUuIGdBpFO4KKOZ7011uzG2DfYK4O5PVtSJpEA/o
   Xb3npGHCUYuwFmQzrnAWSf3rBgC/hXGxiVXJHBxCUA6HAXMWLx5Odaj5y
   5So9OXLlcThGsIwePs2FTJgsonAbfNkYAFLFmIdQYuaGEAjxuCUI/SFNL
   ggkrr52AWiPWZuWUPSMQnD4u4VdlxAOvkdVaRiD98P0aDZKo+z2X9dLPa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242251556"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="242251556"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 06:24:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="472510753"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 06:24:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1n57Bo-006jFt-QI;
        Wed, 05 Jan 2022 16:22:56 +0200
Date:   Wed, 5 Jan 2022 16:22:56 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <aardelean@deviqon.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thor Thayer <thor.thayer@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: altera-a10sr: Switch to use fwnode instead
 of of_node
Message-ID: <YdWpwCCqd5jkhnaI@smile.fi.intel.com>
References: <20211223122733.86981-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223122733.86981-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 02:27:33PM +0200, Andy Shevchenko wrote:
> GPIO library now accepts fwnode as a firmware node, so
> switch the driver to use it.

Any comments on this?

-- 
With Best Regards,
Andy Shevchenko


