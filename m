Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED285A7FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiHaOQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiHaOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:16:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E7EE0BF;
        Wed, 31 Aug 2022 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661955365; x=1693491365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lU/b5xtxFcAX48oYoAdtB/tqCv7ZZJ/uvnw63jeaSQc=;
  b=h6r1GLpLPhAi3PreOsEa13Yrwl8Of41u7yTtO/yWJoIPqeWknrEmDHoA
   ubsBqm5eQ7M98EpvNfJGhyk8V9Rq8KhIPUNvXQ9RFEEx0qAdyXiSQ7jsR
   IRsEjYOnAdK3yqAgba1tSoiKuVNHXCSXBki9mX1FOfcegqoYCtf4xLelE
   L+Jb9t3/X6WMFTxMrc+X2YiiLoEAHjFdzfyz4FEqj2axVCuWt95XNWXgi
   SiUo8kx75zGSh/KMIzlbcayovJCm4THwah5ydVIM6pwseFEMwYSMHzLrC
   EYpmu+Dl88jwGH+MNGlonspWQOvNLzrF72V0lx11eKhM/IG6PFkLcLJEU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294195487"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="294195487"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:16:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="589045203"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:16:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oTOVc-006Pf9-2B;
        Wed, 31 Aug 2022 17:16:00 +0300
Date:   Wed, 31 Aug 2022 17:16:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86: intel_cht_int33fe: Fix comment
 according to the code flow
Message-ID: <Yw9tIAObVXvLcg+v@smile.fi.intel.com>
References: <20220824152115.88012-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824152115.88012-1-andriy.shevchenko@linux.intel.com>
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

On Wed, Aug 24, 2022 at 06:21:15PM +0300, Andy Shevchenko wrote:
> We don't use software_node_register_nodes() in the code, fix the comment.

Any comments?

-- 
With Best Regards,
Andy Shevchenko


