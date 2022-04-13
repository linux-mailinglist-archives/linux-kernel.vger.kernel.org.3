Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924104FFC06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiDMRFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiDMRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:05:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC117674FA;
        Wed, 13 Apr 2022 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649869386; x=1681405386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3sLJ+uyAKa3UrdllPSpp3zBHMlm7dcdDzaDGCF4r4Ts=;
  b=CL+t1ik9fqBLjojWU3b96wU0539otnM2E3WxHAWlZS+WBy1yokPmz6TI
   K95NaTcpMe7/lk/13jqr+p1Lo1xzyR1iGboCarYKC0enW9tBk5/y3l+L9
   GmqfztucJA3nSltRLnVfDFEh4RgfTyZv5pLo0hf4rRAuVKhxDuTR6oI7H
   QL6KrzED1O4FcDrWk/0ZcHJyTo2jb0IbbND2hvRo2U7Mdtrd+pkLVf9xu
   vv+8FbbZQumdA1FAm+T2fDrbZ7rq3bhj7KegoZY9g7bTCVdYqLRSxzA8P
   x8QQGtP4NAeQkjEH4/WrAaSrYl1UOUWiMx7piJpfNz4AJHG+u0zOMoJsE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="244606126"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="244606126"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:02:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="527018619"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:02:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1negKT-001w6X-Qi;
        Wed, 13 Apr 2022 19:58:53 +0300
Date:   Wed, 13 Apr 2022 19:58:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 1/3] iio: imu: adis16480: Make use of device properties
Message-ID: <YlcBTfVdtp7nUhjR@smile.fi.intel.com>
References: <20220413144124.72537-1-andriy.shevchenko@linux.intel.com>
 <PH0PR03MB67867FD2A0043F5331D1C5E399EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR03MB67867FD2A0043F5331D1C5E399EC9@PH0PR03MB6786.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:25:49PM +0000, Sa, Nuno wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Wednesday, April 13, 2022 4:41 PM

...

> You beat me to do this. I actually had planned to do this next week
> once I saw we already have fwnode_irq_get_byname(). Anyways...
> 
> Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> 
> (I will still give this a test next week)

Thanks!

-- 
With Best Regards,
Andy Shevchenko


