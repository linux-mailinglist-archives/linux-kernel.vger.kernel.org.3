Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225044D03C6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbiCGQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244028AbiCGQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:15:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364193BF9C;
        Mon,  7 Mar 2022 08:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646669666; x=1678205666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9lxkY6esalBBvJEOAscFPgv2UXaiF/EqM4Jnw+GpDxE=;
  b=d0ZK+Pr78qIyWV/NwaqPufVWLgofrGExRWNszCkAiDMIAWJUyfdxEIP8
   nos+onjXTN0/lz6k2tgI0DXOktpyD9Nd2lGMLKI/BnxqanysLpkGsMn6+
   wXPqVW9JhWUn6XQDM6Zj+pTrJUoKgRFjJEEWqHvVV/BmrNTmV+3yJ2XgT
   e10p1FZPyzKcUcFKmVYwJXRkJZnvpT6AJWu44xf0ua5PJUVK1pf4maFMc
   IdMLl1dvzY1ETzPuZztcJ/8oRXhkgT5j02RNV8cl+guA+D7mzKGkIkqLj
   U6SkQuim9XSbMt3VxE5QDEYW5WCzB5kvw/uaZ8Q21rOI6dcfS7p1DHu+m
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="340861379"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="340861379"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 08:14:25 -0800
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643298544"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 08:14:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRFzN-00CrBy-PE;
        Mon, 07 Mar 2022 18:13:37 +0200
Date:   Mon, 7 Mar 2022 18:13:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 7/7] usb: typec: mux: Add On Semi fsa4480 driver
Message-ID: <YiYvMf5X+S0WZ9lO@smile.fi.intel.com>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
 <20220307034040.1111107-7-bjorn.andersson@linaro.org>
 <YiXbg4QwgIgLh3LW@smile.fi.intel.com>
 <YiYbOQpX4+fP8S1W@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiYbOQpX4+fP8S1W@ripper>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 06:48:25AM -0800, Bjorn Andersson wrote:
> On Mon 07 Mar 02:16 PST 2022, Andy Shevchenko wrote:
> > On Sun, Mar 06, 2022 at 07:40:40PM -0800, Bjorn Andersson wrote:

...

> > > +		/* 15us to allow the SBU switch to turn off */
> > > +		usleep_range(15, 1000);
> > 
> > This is quite unusual range.
> > 
> > If you are fine with the long delay, why to stress the system on it?
> > Otherwise the use of 1000 is unclear.
> > 
> > That said, I would expect one of the below:
> > 
> > 		usleep_range(15, 30);
> > 		usleep_range(500, 1000);
> 
> Glad you asked about that, as you say the typical form is to keep the
> range within 2x of the lower value, or perhaps lower + 5.
> 
> But if the purpose is to specify a minimum time and then give a max to
> give the system some flexibility in it's decision of when to wake up.
> And in situations such as this, we're talking about someone connecting a
> cable, so we're in "no rush" and I picked the completely arbitrary 1ms
> as the max.
> 
> Do you see any drawback of this much higher number? (Other than it
> looking "wrong")

I see the drawback of low number. The 1000 makes not much sense to me with
the minimum 66x times less. If there is no rush, use some reasonable values,
what about

		usleep_range(100, 1000);

? 10x is way better than 66x.

-- 
With Best Regards,
Andy Shevchenko


