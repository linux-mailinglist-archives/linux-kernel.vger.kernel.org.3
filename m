Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188A7561ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiF3NAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbiF3NAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:00:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581AD40E67;
        Thu, 30 Jun 2022 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656594031; x=1688130031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9urzIR46J5jYUfSVvNA3boWDK/TfPp3KBc05EjU6wsw=;
  b=U/eRaNi2qjLrRdTHvBk3vu4C8xfMmxdfaQorlvelINek4tto8rrmGWrL
   jvZlbgJZsoLa33TbhhmS74a2zLK7SIZQ1sTZPAqTi5NkJBtoIKj8r4Pc2
   uLZKcAhgNnMPpIXLWRTXh1Qo7o63583jWehwmMGcYK3bEnL1sHhc03rYj
   o58W+D77ZQ1yjjXcZEJDuebAGuSb0KpEmh+2jbINJmEBsloI9Met6Lsdu
   4qR1H0MyIcri/D9m+X5SR0nYpYGKu/cl4K+ei1pU+uoLrwujxo6dsCQs+
   7JK+OudsrFfitaBGRnDKZYrXHhp0Ta5xpO370fzH4jCENVu+FrPwfBgHg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="279884722"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="279884722"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 06:00:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="680964614"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 06:00:28 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 30 Jun 2022 16:00:26 +0300
Date:   Thu, 30 Jun 2022 16:00:26 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Cai Huoqing <cai.huoqing@linux.dev>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Add Intel Meteor Lake pin
 controller support
Message-ID: <Yr2eaj9oxhYQDKJG@lahna>
References: <20220630123858.74300-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630123858.74300-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 03:38:58PM +0300, Andy Shevchenko wrote:
> This driver adds pinctrl/GPIO support for Intel Meteor Lake. The
> GPIO controller is based on the next generation GPIO hardware but still
> compatible with the one supported by the Intel core pinctrl/GPIO driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
