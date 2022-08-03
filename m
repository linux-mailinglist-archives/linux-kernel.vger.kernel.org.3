Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDB75889D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiHCJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiHCJv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:51:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E465C9E4;
        Wed,  3 Aug 2022 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659520208; x=1691056208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eyD63yHFj2PWQ0A22oLOeTb3kXx5Fd7gFQUUhxz6C24=;
  b=d3KNx4BQEszMv7HU2ou4haNFg6WxEzfHT1DkYkkWeYsPJLNJ/F8JgIdS
   IkvON5EpJJzodComPyfSuvk9P7boz+QiVGn5wfHz6KH5eTiFm2LiR7lEi
   hMzfC1EB17x26lxbn3xXEF5/LA27g2+P+EgYvleK5EZQ6Ul5ZXwJqLvzO
   ybAHsPUEqm/2Y1HcglDqrigRZ24QxaWqrqt03caBN0qggQQUnyX7+/ujN
   RzUQvZEl6vZjsohlNnqqnLD3h370KW6azmiAysVc8u//bpS5vPYGrqrSc
   w+Se73lUN5SMzjJiPsA9vK+/1AYTSE5gN0gDC9XsA42MhdSFUYTgbvKTi
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="272679345"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="272679345"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 02:50:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="729153417"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 02:50:04 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Aug 2022 12:47:51 +0300
Date:   Wed, 3 Aug 2022 12:47:51 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] gpiolib: acpi: Add support to ignore programming
 an interrupt
Message-ID: <YupER0QG1c+VKs8k@lahna>
References: <20220803042501.515-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803042501.515-1-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:24:59PM -0500, Mario Limonciello wrote:
> gpiolib-acpi already had support for ignoring a pin for wakeup, but
> if an OEM configures a floating pin as an interrupt source then
> stopping it from being a wakeup won't do much good to stop the
> interrupt storm.
> 
> Add support for a module parameter and quirk infrastructure to
> ignore interrupts as well.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
