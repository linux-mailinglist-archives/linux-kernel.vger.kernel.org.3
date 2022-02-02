Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FCA4A799E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347155AbiBBUjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:39:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:52961 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbiBBUjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643834349; x=1675370349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZRAsFGkDwvuNHIE8mt8h9GrgNbl6DLRauQUTsEbmS54=;
  b=Em2KZKVam0FZuF93rPw4bF+UiaGBiwakhhQaaSt1wr8mv4NzMDHDmJt+
   o8jUOEsr4a47Y5zvbpkkDA9791sO/ciI8ZVr7PPW7GLPryXcKipULv5+9
   9ZCCgQUh9Mo6p/istyctJhJQOsw0j6oS1rYuu4ctieZ1/b+3Yzr8UaC8v
   XRSDDffaItJLStLqUzKKMcshPW4zWVTLopj9VYNg+htSyGk7Z8sYY7OHU
   LfdS1+36MqtJMPlyhpuP+O1i6M7Ag1RTcLfvdky1DaOq2mlg92ftjAHkb
   DvvLSrJvI92vt9zjd2WTPp0gDVhQQn21bzvL2RP8ohlWmLsAKukBE+F2+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228670792"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="228670792"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:39:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="480243563"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:39:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFMOC-000Cmw-6N;
        Wed, 02 Feb 2022 22:38:04 +0200
Date:   Wed, 2 Feb 2022 22:38:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v1 1/1] iio: trigger: stm32-timer: Make use of device
 properties
Message-ID: <Yfrrq83cVOt8bC9i@smile.fi.intel.com>
References: <20220202175815.54100-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202175815.54100-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 07:58:15PM +0200, Andy Shevchenko wrote:
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.

Missed OF drop,

-- 
With Best Regards,
Andy Shevchenko


