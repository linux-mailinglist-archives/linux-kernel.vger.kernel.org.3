Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B447565873
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiGDORy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiGDOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:17:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BAEB85B;
        Mon,  4 Jul 2022 07:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656944247; x=1688480247;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BBZYtapvFnPY20DGygY2cUcUMOKUbHJ8PjVBtFJUlyI=;
  b=ZusTjEx/usoXFCs1wWADprN7IyJRpgq2bzjB/uJsVeFccSBJESY1JDrH
   mvnFS4+XrTRdl+6lKGpAC89HjTldAVG4jNAGipHoIDuiD2uzzjwCbOZAc
   U45GXMCDy81ZZowW3uGG8/Rj94dmXtyV1ejPwzbqeqhCwkuoUcsEP9CJE
   R/gt49xMny5TgTyI8Y2WNdqMYt3P1jcuw83z6nxVuJpbNTC8VnsYHMK/Y
   GAgdd6MNrlZvgfkVPTbDOuSCnE68bXZoULZFvRmM5XUGFOxck6QLzHUZA
   lg4y5M4ihSvSbSuWsOHqe0Cm9futwPm5MlQGvhAnqC/hUshyyTIO8omzW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="308675987"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="308675987"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 07:17:27 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="590088160"
Received: from bbao3-mobl1.ccr.corp.intel.com ([10.249.173.150])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 07:17:23 -0700
Message-ID: <b3a0fc8ebb472286a4effba9f96ea2cbc5ed9b8d.camel@intel.com>
Subject: Re: [PATCH v3 07/12] thermal/core: Rename trips to ntrips
From:   Zhang Rui <rui.zhang@intel.com>
To:     Lukasz Luba <lukasz.luba@arm.com>,
        Daniel Lezcano <daniel.lezcano@linexp.org>,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        rafael@kernel.org
Date:   Mon, 04 Jul 2022 22:17:21 +0800
In-Reply-To: <4ad311e5-62e1-d06b-7c5e-315ed923b5a5@arm.com>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
         <20220703183059.4133659-8-daniel.lezcano@linexp.org>
         <4ad311e5-62e1-d06b-7c5e-315ed923b5a5@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-04 at 09:24 +0100, Lukasz Luba wrote:
> 
> On 7/3/22 19:30, Daniel Lezcano wrote:
> > In order to use thermal trips defined in the thermal structure,
> > rename
> > the 'trips' field to 'ntrips' to have the 'trips' field containing
> > the
> > thermal trip points.
> > 
> > Cc: Alexandre Bailon <abailon@baylibre.com>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc; Eduardo Valentin <eduval@amazon.com>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
> > ---
> >   drivers/thermal/gov_fair_share.c        |  6 +++---
> >   drivers/thermal/gov_power_allocator.c   |  4 ++--
> >   drivers/thermal/tegra/tegra30-tsensor.c |  2 +-
> >   drivers/thermal/thermal_core.c          | 20 ++++++++++----------
> >   drivers/thermal/thermal_helpers.c       |  4 ++--
> >   drivers/thermal/thermal_netlink.c       |  2 +-
> >   drivers/thermal/thermal_sysfs.c         | 22 +++++++++++---------
> > --
> >   include/linux/thermal.h                 |  2 +-
> >   8 files changed, 31 insertions(+), 31 deletions(-)
> 
> 
> [snip]
> 
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index 6289b0bb1c97..3a57878a2a6c 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> 
> Missing updated ne name in comment here:
>   * @trips:      number of trip points the thermal zone supports
> 
> 
> > @@ -165,7 +165,7 @@ struct thermal_zone_device {
> >   	struct thermal_attr *trip_hyst_attrs;
> >   	enum thermal_device_mode mode;
> >   	void *devdata;
> > -	int trips;
> > +	int ntrips;
> >   	unsigned long trips_disabled;	/* bitmap for disabled
> > trips */
> >   	unsigned long passive_delay_jiffies;
> >   	unsigned long polling_delay_jiffies;
> 
> Maybe this is only my bias, but this new name 'ntrips' looks
> like negation in electronics.
> 
> We have examples like: num_cpus, num_pins, num_leds, num_groups,
> num_locks, num_buffers, num_phys, etc...
> 
> Could we have 'num_trips' and follow to this convention here as well?
> 
I'd vote for "num_trips". :)

-rui

