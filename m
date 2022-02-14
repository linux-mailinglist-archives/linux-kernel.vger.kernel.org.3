Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364814B4593
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242849AbiBNJYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:24:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiBNJYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:24:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7728E60A87;
        Mon, 14 Feb 2022 01:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644830639; x=1676366639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bVOs35Dp7Asq5//nT0TwjwfmoTvaxxpXMLgbeKZ9q9Y=;
  b=S4EDqU4dfrKl0XVt16bMpYWq0Lrm/+rfKGeSKVRQoTwLGt5scooFdZak
   ZmRFT1fcpqu7FO0yYemmgjn/f6EhSxUPWDl9pn7qNXMtNSm1kPDay2oRi
   qktL+3TGPn1lDmn7lJECLVvEG1r/RXXysix+76E995S1xgk8m2CN+eWjd
   0j4iKMTJB1+1w+EtG0TrdFlOwr054u/t30ADsimceKMTuiwSeGyxXDLEt
   sJjCm/j8CGGEKn8wLGFKPqJykjTOqOLhpxVHfpzoUDcZj8Cf+ohE3jIKr
   mhVs9wZVpKWDQ85R3Z9PH9baBgzVKlt8sARjd3a01DWDRdABF5vr98rWC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="336477221"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="336477221"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:23:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="570031384"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 01:23:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJXZW-004OM7-8W;
        Mon, 14 Feb 2022 11:23:02 +0200
Date:   Mon, 14 Feb 2022 11:23:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v3 1/1] iio: chemical: atlas-ezo-sensor: Make use of
 device properties
Message-ID: <YgofdmXx5BED0C3f@smile.fi.intel.com>
References: <20220207124204.11658-1-andriy.shevchenko@linux.intel.com>
 <20220213180757.751d1350@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213180757.751d1350@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2022 at 06:07:57PM +0000, Jonathan Cameron wrote:
> On Mon,  7 Feb 2022 14:42:04 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> +Cc: Matt

Maybe he wants to become a designated reviewer for this driver?
(Missing record in MAINTAINERS?)

> Looks straight forward to me so I'll queue it up and Matt can comment
> after if he likes.
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> all the normal checks.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


