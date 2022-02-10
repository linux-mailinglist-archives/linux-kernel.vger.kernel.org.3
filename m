Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594254B0F70
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242499AbiBJNzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:55:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242477AbiBJNzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:55:38 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9405FD73;
        Thu, 10 Feb 2022 05:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644501337; x=1676037337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ay0A3kx32MJfbLcM+1m+RIYTgc6yue+5l1DCkhN+RZI=;
  b=OkBvhrv96X0VwdktPXcb9GyfjCVRQfdbThoMmqyRPDKtRy8/5vd3mUPi
   esiHAqL8qF95Z6QP4jLkQSEmmPDLHQ58jOgrmn/kfAo0EJ1ucR4Snm0aV
   m/QKjbNDHWk07nJCiHo6Xj4IgzkUEZKvUB0VW90xzfz7NN4to4yhcPoht
   JGjOTNX7pJjBhAfllRpLAC2YvggisMSaFDj+JdfpPcwYyHT47+zVaTCv3
   ukgiB6kWdZnaO0axU/CrqN+ra3M63nrpHNubXFrf1pHovXaMRATWybG+Q
   jtqefbAMO48rL990FEGmWs3032NiNYBa5KZoSbGhALDvs2eenZFLRsJX1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="230138803"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="230138803"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:55:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="485691556"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 05:55:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nI9u9-0030X4-OH;
        Thu, 10 Feb 2022 15:54:37 +0200
Date:   Thu, 10 Feb 2022 15:54:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/3] iio: temperature: ltc2983: Don't hard code
 defined constants in messages
Message-ID: <YgUZHW6MHqo468X+@smile.fi.intel.com>
References: <20220207104830.83882-1-andriy.shevchenko@linux.intel.com>
 <fdb3056dcaf9dd113049adebbc3fcd74de2b3028.camel@perches.com>
 <YgFVFceYQtWq4Hww@smile.fi.intel.com>
 <20220207204421.7f905aa5@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207204421.7f905aa5@jic23-huawei>
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

On Mon, Feb 07, 2022 at 08:44:21PM +0000, Jonathan Cameron wrote:
> On Mon, 7 Feb 2022 19:21:25 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Mon, Feb 07, 2022 at 08:37:55AM -0800, Joe Perches wrote:
> > > On Mon, 2022-02-07 at 12:48 +0200, Andy Shevchenko wrote:  
> > > > In a couple of messages the constants, which have their definitions,
> > > > are hard coded into the message text. Unhardcode them.  
> > > 
> > > Found by inspection or tool?  
> > 
> > Does it matter? No, a side effect of the following patch.
> > 
> > ...
> > 
> > > > +		dev_err(dev, "Steinhart sensors size(%zu) must be %d", new_custom->size,
> > > > +			LTC2983_CUSTOM_STEINHART_SIZE);  
> > > 
> > > probably better using "%u" and not "%d"
> > > 
> > > and better with a \n termination too.  
> > 
> > I think it would be a separate change if we wish so. Let Jonathan to tell what
> > to do here.
> > 
> Either way is fine by me.  I tend to be a little flexible of trivial fixes
> in patches that are as simple as this one.

v3 has been just sent.

-- 
With Best Regards,
Andy Shevchenko


