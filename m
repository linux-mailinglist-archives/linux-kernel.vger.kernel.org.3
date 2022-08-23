Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B7059E89D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343891AbiHWRHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343741AbiHWRDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:03:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5C31500F5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661261599; x=1692797599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3zoCdOcjyr4K5YgRDl3bvytvKlVK3dosi2s/H4dU0ZE=;
  b=g9hw7lSvR+0X/iY9EDkW8/q4sD3hG0dgZ8DyHmrKKI2eJV2/sfPSOM1q
   8Gvz6HxYWRirghWg1RrtRyE0EAampEwdPO5ISNZg/DYaAkeZb/LeAPXMP
   E1IUkb//K1kWGo9fIFetnb3K513hbyLNU7SYjgro9stpMJ+go8FrW1NWH
   oKCz39gDATwShQ8+qnDn3Bu+JoMsw+PDTh8y5Yf3IfkBfPh3hD5cT9fwO
   okbs40b0EJQthGx6nABVws5drfhqQho/yWYdtm7dTH+y3hxbTCpBfHIOb
   Mt+/TUSKcf7Uje5ePOz2lJD2/EEdW8n395KbyrPjxocr4DeSHV8JTv/OX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="319733422"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="319733422"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 06:33:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="638657306"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 06:33:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oQU1r-002SDv-2p;
        Tue, 23 Aug 2022 16:33:15 +0300
Date:   Tue, 23 Aug 2022 16:33:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 1/1] mfd: intel_soc_pmic_chtdc_ti: Switch from
 __maybe_unused to pm_sleep_ptr() etc
Message-ID: <YwTXGwzqzKzx+S0q@smile.fi.intel.com>
References: <20220616171234.43729-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616171234.43729-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 08:12:34PM +0300, Andy Shevchenko wrote:
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less heavier for builds
> than the use of __maybe_unused attributes.

Any comments?

-- 
With Best Regards,
Andy Shevchenko


