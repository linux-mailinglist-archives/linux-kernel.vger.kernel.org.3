Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B19574B60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbiGNLBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiGNLBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:01:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB90564EA;
        Thu, 14 Jul 2022 04:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657796505; x=1689332505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xvQRmOtD9iy4GDJ8UNvhijj/Osm+KeZwsU2Nobb423E=;
  b=AbZTpKDGJOb02GOi5wuY9qDOFI8tfJVo7dTpKT6eA7vLqDDUCotJwLZU
   RMavEPl7vgAAoVmjyLPYbWWBBHbAfag0sH7PcAx9IuAJSFcXxan/3jpZ3
   Q06Vs6AnSVT4fTav0b3ctxRec2ltgIwtF812PusNYB2mQVdDJ3Z9ftKWd
   4XOuEh/8qKJEtCvKIPnsIw6MHyscBAiRq3OtwURodIxBo+dmqfiA1pZbR
   OmEQYBHtZEEsRtmt7rax6hW3Wm9nzMomL2nCnnt/OQObTfNPifYFyd1Eb
   4+/nM2h8taOEiwSI8mPCMgMyT8WYPYEQx98HF+322GBBNp5KzHzd5GBxf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="371792850"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="371792850"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 04:01:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="596052131"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 04:01:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1oBwbE-001DAM-22;
        Thu, 14 Jul 2022 14:01:40 +0300
Date:   Thu, 14 Jul 2022 14:01:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: LED Maintainership
Message-ID: <Ys/3lChOW4YeTr0t@smile.fi.intel.com>
References: <Ys/kruf8DE4ISo8M@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys/kruf8DE4ISo8M@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 10:41:02AM +0100, Lee Jones wrote:
> Pavel, et al.,
> 
> Not sure what's going on behind the scenes, but it looks as though the
> LED subsystem has been left unmaintained for at least 2 months now.
> 
> Does anyone have any objection to me stepping in as temporary
> maintainer until the situation is resolved?

Vote for support the idea, thanks, Lee!

-- 
With Best Regards,
Andy Shevchenko


