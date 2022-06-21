Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09559553168
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350168AbiFULxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350132AbiFULxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:53:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7096C264D;
        Tue, 21 Jun 2022 04:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655812385; x=1687348385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WTyKWuvwfdl14ZNB8ErxGazeR6p00mzynNS4c47pf6I=;
  b=GBEkEn+UhjNu2U98cjvPDU0Rebdr1Xo+6vtiDD1hOIFVpjqgDu76JxsS
   aryaiNFa0DZkvTZed2bREERWYu3+xG3Z6MhPy692EmfRTDWJL7UkNa6Lm
   xx1AMEqzOhrWC+VLebn8gWfkqFV7RA7+J1aP7eLFExnzKwQeU6jV7WamS
   5S2E7Kg8Wk8s0IkBqHtt7N5daSy0ZwL+lKBB1Aj50jBYlIsL9CZJWw+b+
   gYJktXmgystcMhAZ4wcVH8myKUBfWGjcwEbxzJmMqZdWaxhPEPAA9AHBP
   Nj8c73HLNXtsPDYndr+ckh9ZuZgh5Le2QFqXS4PJdKYcUMe42F2cy6Aku
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="263132538"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="263132538"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 04:53:05 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="689904623"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 04:53:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3cRI-000qzk-4G;
        Tue, 21 Jun 2022 14:53:00 +0300
Date:   Tue, 21 Jun 2022 14:52:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, djrscally@gmail.com,
        sakari.ailus@linux.intel.com
Subject: Re: [PATCH -next] media: ov7251: add missing disable functions on
 error in ov7251_set_power_on()
Message-ID: <YrGxG9eIcBHbiSb+@smile.fi.intel.com>
References: <20220620112042.3231519-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620112042.3231519-1-yangyingliang@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 07:20:42PM +0800, Yang Yingliang wrote:
> Add the missing gpiod_set_value_cansleep() and clk_disable_unprepare()
> before return from ov7251_set_power_on() in the error handling case.

There is already a patch with the same version. If anything has been changed,
care about versioning and changelog.

-- 
With Best Regards,
Andy Shevchenko


