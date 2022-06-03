Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE12253CE0E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344468AbiFCR2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbiFCR2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:28:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A52DFF8;
        Fri,  3 Jun 2022 10:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654277295; x=1685813295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aqTdvCdhbd6MUKmaxiP+UahPXjI0zjjVlad/cYW8qMg=;
  b=e/IcF4ihHaeiwDpjWy9NfGRKhCl9EBFKv+D3FJplw/qx4ca5d9zGmZ7c
   JQLNg6oVlgURhABLVUTmTYzD3k6XLwZGDhxMm9YTBJW4Q8wHf4rQab9EP
   XDoirGTtPA0rnIcAFL6H6/00sHvXdXeZOKApXOc0drL6mPJUrIAj981Wh
   Klkp2BQrsRCNXG5w855jb4WHaWJZbgvEJ7bMufur1aOUprgL10bAOpX9t
   feoj4JsAFwnGWnCZe6oUzCwu3fHN04p0UZc5LkkbvdlHdGsMhOyalrrln
   qBWKMMyO3+5W+25f0lFkXJQbX9PmHNjyjxzzEgtOzEI4prjBbVS4QJ/Hx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="276051385"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="276051385"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:28:14 -0700
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="757568114"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:28:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nxB5l-000SdY-IO;
        Fri, 03 Jun 2022 20:28:09 +0300
Date:   Fri, 3 Jun 2022 20:28:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, thierry.reding@gmail.com
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Fix kernel doc for struct line
Message-ID: <YppEqYTZyWaulKjI@smile.fi.intel.com>
References: <20220520164726.60638-1-andriy.shevchenko@linux.intel.com>
 <d796b54d-7559-f9ff-bb4b-4e75a707db2d@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d796b54d-7559-f9ff-bb4b-4e75a707db2d@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 10:10:49AM -0700, Dipen Patel wrote:
> Acked-by: Dipen Patel <dipenp@nvidia.com>

Thanks!

Bart, this can be applied, I think.

-- 
With Best Regards,
Andy Shevchenko


