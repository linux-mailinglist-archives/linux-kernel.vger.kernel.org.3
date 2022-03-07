Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69FF4CFC0E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbiCGK6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240532AbiCGK5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:57:35 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5692EB1522;
        Mon,  7 Mar 2022 02:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646648244; x=1678184244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=si1sMMOIuj0tjRYqoqqM1BVIAKXdTNzOoiPtZdEOJlQ=;
  b=Lx1jXqBBY85/QjZT8IuI/c97sGhk6L2Wil5dUnHEiZK2AvFbPnuAQUQj
   EdGtaKHhAkbyi5DoNGspMdvRkK11qO2epZjkNVRaF4Gzw2jhh2DbuatfU
   eQmhdnmTYwXvGKNCC+nakOXWNf5o8rsgP6NHILWq5zduJBK0pY3EXG1kt
   Kd/QP/rDfZ5J3tOBWRBeNmrPnUg57rKAbihKejcjroAtxDUjzIcw6Phug
   nHSn4PyTGNvawnpVk6t37MC4rbRczbFrsY+fbwuheLyiJvPLwycDpAFyL
   bZqNYXjP/nOQPuDaAyGViD98h7vr8PRZ8JaZz2c+gmdnP/Jcb60V35HKr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="279058866"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="279058866"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:17:23 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="643192228"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:17:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nRAPr-00Chm6-TC;
        Mon, 07 Mar 2022 12:16:35 +0200
Date:   Mon, 7 Mar 2022 12:16:35 +0200
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
Message-ID: <YiXbg4QwgIgLh3LW@smile.fi.intel.com>
References: <20220307034040.1111107-1-bjorn.andersson@linaro.org>
 <20220307034040.1111107-7-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307034040.1111107-7-bjorn.andersson@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2022 at 07:40:40PM -0800, Bjorn Andersson wrote:
> The ON Semiconductor FSA4480 is a USB Type-C port multimedia switch with
> support for analog audio headsets. It allows sharing a common USB Type-C
> port to pass USB2.0 signal, analog audio, sideband use wires and analog
> microphone signal.
> 
> Due to lacking upstream audio support for testing, the audio muxing is
> left untouched, but implementation of muxing the SBU lines is provided
> as a pair of Type-C mux and switch devices. This provides the necessary
> support for enabling the DisplayPort altmode on devices with this
> circuit.

...

> +static const struct regmap_config fsa4480_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = FSA4480_MAX_REGISTER,
> +};

You are using mutex for accessing hardware. Do you still need a regmap lock?
If so, add a comment to explain why.

...

> +		/* 15us to allow the SBU switch to turn off */
> +		usleep_range(15, 1000);

This is quite unusual range.

If you are fine with the long delay, why to stress the system on it?
Otherwise the use of 1000 is unclear.

That said, I would expect one of the below:

		usleep_range(15, 30);
		usleep_range(500, 1000);

...

> +	sw_desc.fwnode = dev->fwnode;

Please, don't dereference for fwnode explicitly. Use dev_fwnode().

...

> +	mux_desc.fwnode = dev->fwnode;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


