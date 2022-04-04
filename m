Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C1D4F1546
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348162AbiDDM5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbiDDM5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:57:12 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB9732042
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649076916; x=1680612916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/CjYIlBlDeK556thkrgohCOdY6pviJ/7+5vySTyCVZg=;
  b=AP+GzIUqnci8IYk0Di0JYHAS6Obyyo/+a9YPSEInuboleXmHHkCKVDHA
   UIMXbJxqP6u/eAa5LlqP6Ti3A6mGLy7AH5rHCCW99IOsou/sx/6kaplGb
   fjRmkChiwnFDeq7sIG3ST9R15nYIqF8Ifv4FWfjSXEiRgdfl+WlYC9GuW
   4XWvnGNUy/g1FOIvYC4GV5U3QlktTuMVSG5wWagJGZnrppmQOTGKKLQMX
   Miznvg74Ut59zij3hsFMuhCJU/d0tDBzwqtBASFaMLKnWMyqIqdGBR5zC
   CF4rNuSeQiQF9y6PmWM2A1ly9/hbW1uXJ9OrXxWZF8DFuf4WaHaNETRwX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="321201856"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="321201856"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 05:55:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="721635917"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 05:55:14 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 04 Apr 2022 15:53:03 +0300
Date:   Mon, 4 Apr 2022 15:53:03 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Brad Campbell <lists2009@fnarfbargle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Apple Thunderbolt Display chaining
Message-ID: <YkrqL/wnACNVOpSi@lahna>
References: <YkRebADER3J9ooPM@lahna>
 <d40f02e5-7274-e834-6e13-82b3dbe11284@fnarfbargle.com>
 <YkRtf2HiXBOWGjna@lahna>
 <eacc22dc-e650-a208-9484-62edd98d5778@fnarfbargle.com>
 <YkXYdcUZ1E18ENle@lahna>
 <5dcee6f7-cc8c-e3ce-920c-4ad3f5d77e14@fnarfbargle.com>
 <YkcMofXKr/ZmOSwH@lahna>
 <7ea44c20-6c65-224f-af7b-aa1bd310d038@fnarfbargle.com>
 <YkrEE0uh9EVCchfl@lahna>
 <d112651d-919d-ce2d-efac-6abbd9de0f07@fnarfbargle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d112651d-919d-ce2d-efac-6abbd9de0f07@fnarfbargle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 04, 2022 at 07:38:06PM +0800, Brad Campbell wrote:
> > Hm, you mean you don't see the timeout errors and stuff with the first
> > patch applied?
> 
> I see the config timeout errors and the controller locking up after a
> couple of unplugs, but when it does configure the DP channels, they
> both come up every time.
> 
> So, with the original patch when thunderbolt discovery works, displays
> both work. With the latest patch, whether or not the hotplug works,
> the radeon driver fails to bring up the parent head.
> 
> Both suffer from the controller config timeout reads on unplug causing
> it to become unresponsive after a couple of re-plug cycles (3 if I'm
> lucky).

I suspect the same issue is even with the first patch but it just
manifests differently. I think the timeouts are the key here and we need
to figure out why they happen.

> > I think I will make this current one a proper patch and submit upstream
> > later this week (will CC you too). For the iMac issue we may need to
> > debug it further. Not sure if you answered this one already but on iMac
> > on macOS does it work always when you plug in the whole chain?
> > 
> Yes, MacOS works fine in any order on any port.
> 
> There is a difference in the way something is set up between what the
> EFI does and what Linux does.

Agree.

> If I wait for the Chime, then a bit longer and plug the chain in
> (before the bootloader starts), Linux sets up both heads and hotplug /
> replug works.
> 
> If I cold boot with the chain plugged in, the EFI sets up one head and
> Linux configures the other. Replug fails with the clock-recovery error
> in that case.
> 
> The difference seems to be when EFI sets up, on re-plug it sets up the
> child display first (303 vs 3) and that causes the issue. Repeated
> tests can get difficult as often on the second or third plug (or
> unplug) the controller locks up and no longer responds to events.
> 
> I'll try and get a couple of clear dmesg with your last debug patch
> because it appear the chain is being discovered in a different order
> depending on whether or not the EFI set it up.

That would be helpful.

> I received my brand new Titan Ridge board today (Gigabyte B550
> Vision-d-p) and with a modified Thunderbolt rom and the last patch it
> detects and runs both Thunderbolt displays from a cold boot. Hotplug
> fails, and there are other issues related to warm boot, but they'll
> all have to wait until I get a serial console up.

Hehe, OK.

> Appreciate the persistence with this.

My pleasure ;-)
