Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02E35AD692
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiIEPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbiIEPbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:31:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E265924E;
        Mon,  5 Sep 2022 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662391819; x=1693927819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8mFpiMAF6eHHpFQcvhpWXup3tSDSzv5VQh4Nu0g1c1w=;
  b=B+pQVkybqJ9hN1Z0qMbh3NCfUfVftCRHBDmuO8L2HMk2QZgakVT2FF8k
   OU2JK9fd2PUrj/DO9hyizoTsj3JZeG9IFBKclAIY0/38pcnBtlFmWQmwk
   NNEXK08oFtbGJa8XQ0XVBZkzEJn3nvPaULA7kQaMyspzmga5VFlOWZ1DK
   ygD6PKYr78jA14UoCEJXxLaYqFfqyUe27IuZRvRLn627fBL8HkkVHQCac
   YoXbqxIYP9+2jhQ32jy3ZXY9UBWwqMa9cOJ3NGhWBWBAw3DWBhIZToPK+
   OlbP+be4p3E3tBNPDOhrCmMKWfKCxaOL+Hz8R/2hDeY+u+M/0XeJ1gdlo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="297198163"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="297198163"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 08:30:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="756074824"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 08:30:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oVE3C-008jBK-0c;
        Mon, 05 Sep 2022 18:30:14 +0300
Date:   Mon, 5 Sep 2022 18:30:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/1] media: atomisp_gmin_platform: Unexport and split
 camera_sensor_csi()
Message-ID: <YxYWBSo+fceHCAOd@smile.fi.intel.com>
References: <20220730162027.1011-1-andriy.shevchenko@linux.intel.com>
 <Yud2cwiCCnq4x50L@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yud2cwiCCnq4x50L@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Hans

On Mon, Aug 01, 2022 at 06:45:07AM +0000, Sakari Ailus wrote:
> On Sat, Jul 30, 2022 at 07:20:27PM +0300, Andy Shevchenko wrote:

...

> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thanks!

Hans, maybe you want to include this one into your bunch?

-- 
With Best Regards,
Andy Shevchenko


