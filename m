Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F6578A69
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiGRTOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiGRTOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:14:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738A2CCB5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658171676; x=1689707676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xp0ZNpYz19QNvdTmcofg5uiTtsnhZ7FV23L2OrUqiGk=;
  b=oK5xstkmQCZbYkMlbh0O8l1J82qi1tLAUnJ3v4ZsOI8C57QHY+PvJz1c
   mr9uEI4PW2b5LPhhhNetonBQQqB6h8L0MdE8Fu2do6ufVABzl0JZEIykY
   hkZxAKG2XJpUczkhshPOj+pKabdJM3VQNpFUzhxrHy/5izruRpnYj4/R2
   /MLMxyIPYIwdcvnQZRYwRbtXxIhKKBKF+RAMBZTB/rZX83Fha3SlUi5k2
   h2X7x/CmT1LQ5LWSJoIsDUhz72SXlyos/EpO85wrzOdtr8shBc2v4h8MX
   e1YqRy97uEnCQfJLTTBfVMDa/dqS4jfIOIA+OQuG5ueEVZoNaWoKx2DlC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="266082098"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="266082098"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:14:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="700145102"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 12:14:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oDWCE-001OPa-29;
        Mon, 18 Jul 2022 22:14:22 +0300
Date:   Mon, 18 Jul 2022 22:14:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ALSA: isa: Use INVALID_HWIRQ definition
Message-ID: <YtWxDmEtDMORLUSX@smile.fi.intel.com>
References: <20220715205737.83076-1-andriy.shevchenko@linux.intel.com>
 <87zgh9tuna.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgh9tuna.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 08:54:17AM +0200, Takashi Iwai wrote:
> On Fri, 15 Jul 2022 22:57:37 +0200,
> Andy Shevchenko wrote:

...

> > -#define INVALID_IRQ  ((unsigned)-1)
> > -
> > +#define INVALID_IRQ  ((unsigned)INVALID_HWIRQ)
> 
> This seems failing to build on my local tree as is.
> We need to include <linux/irq.h> explicitly.

As Marc told me this is probably the way to the wrong direction, so, please,
discard this patch anyway.

-- 
With Best Regards,
Andy Shevchenko


