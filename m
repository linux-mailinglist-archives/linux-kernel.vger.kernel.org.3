Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7161C4A79A8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347193AbiBBUm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:42:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:7832 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231795AbiBBUm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643834578; x=1675370578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X/DT2zgawSOc4EJy5AzdbcW2TqWpsvqNRixud/28du4=;
  b=TliWuV6F5mhXZdkk08vCZ3lFKRhtWADksk4ivXkDYwbCe9tgpd8ahJzD
   72leiT85A1eX2DA4YKLqD6KR+XmEfp2/i8Roo490yT3UHsW/3gzSlZCpA
   xa7C/NKJ4byHZ9piiaKt4XpWsG7UK5yKqebhf0cdHWMT9V3XXQaUwfID1
   uV8nXqGJ6iTKHPYlsce51b/7b+/q0a/tc+Y112TGMhWv7yNs/hTZ9vbVM
   tzjlKGes2rsc3CdAwPTNRE+yLPIJ8Qf3sNUpT3OEpvpat46ad3AqAAN5q
   /U4E/ILKf2wpon2dtR1aOxNHhnG/ryoy/WcKz1TjgZYlyaGBoLPHukW93
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="246849603"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="246849603"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:42:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="699048488"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:42:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFMRl-000CqQ-MC;
        Wed, 02 Feb 2022 22:41:45 +0200
Date:   Wed, 2 Feb 2022 22:41:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: multiplexer: Make use of device properties
Message-ID: <YfrsiZfTzwSNEY/z@smile.fi.intel.com>
References: <20220202195511.55987-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202195511.55987-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 09:55:11PM +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.

Ditto, i.e. forgot to drop depends on OF.

-- 
With Best Regards,
Andy Shevchenko


