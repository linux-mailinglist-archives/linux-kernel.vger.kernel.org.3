Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BCA59E84C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343721AbiHWRCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344337AbiHWRBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:01:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BD48B9A8;
        Tue, 23 Aug 2022 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661263840; x=1692799840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ygPyyv+pU7SFDB61ANVVMzLHJfkZTW1nqc/MGK8nQSs=;
  b=fHoWHDkqGG/DkLu9Sxx5O4huPaIoiZNt8MndxlG7aZg5GjCLMEwPPHjD
   xJTDqAr3aZwJwQ3RkxfXHquqshAmbg2eHxEQyBUgMqlKpozrwIOrHJdMB
   djC8SbxCtstI9m29IzIq1y71n8Bn/6AtTcV7jIfn8TJQoTLIE/UTMsV/6
   xrZiJYsRJGA7v1OVwmFSwkU85GEq8ixSHgv0iTwGj9lrvp+eaPjiBmmfL
   ZEqDwzbRShEioyU5MZILpf9kAxUztind/lUDCp/CN74VyMZB5bzPcX3Rp
   fEM9HRrSK80XPF/SiaKvNTo8iIkAqmPVJmD/Y+YuhKy8y6MJrbudiDm36
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294978544"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="294978544"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:10:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="642453030"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 07:10:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQUbz-002T6k-2M;
        Tue, 23 Aug 2022 17:10:35 +0300
Date:   Tue, 23 Aug 2022 17:10:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tianshu Qiu <tian.shu.qiu@intel.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/8] media: ov2740: Remove duplicative pointer in
 struct nvm_data
Message-ID: <YwTf22gkWxeyNKlR@smile.fi.intel.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 03:05:49PM +0300, Andy Shevchenko wrote:
> The struct i2c_client pointer is used only to get driver data,
> associated with a struct device or print messages on behalf.
> Moreover, the very same pointer to a struct device is already
> assigned by a regmap and can be retrieved from there.
> No need to keep a duplicative pointer.

Thanks, Bungbu, for the review. Can it be now applied?

-- 
With Best Regards,
Andy Shevchenko


