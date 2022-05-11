Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E981252340F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiEKNUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243733AbiEKNTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:19:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078742375C5;
        Wed, 11 May 2022 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652275191; x=1683811191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BDtuOCfS6C3Ia8cLwl8KAUdYzlIUCpcNho6y1uVXns4=;
  b=Oz2yPJU7ytKS8zZJOrxjM0aj0SyGK3AFuTQ8v3NC3DsDP89NptRhppYy
   w8kLv9dNR98TD+7qzQN+r6wLvDl8uZFT0K38JOgRL0zK2hoIMVppZU0X/
   QxO5qgL784Rwcpn2tF6B+ufEOl0rMG5cq9iUpFqQfus590VPeRE7idvBT
   zUdvH83+DfTX5Xap+XB8BCZQp3TCT2OWNwQeeagmnE6OLbQ4ziLORdq44
   oR3MxzkKo0U65Aadu0k3+suKn+izXDYZR3kTkfrjGgRRHUYHVApUpILyU
   tmPwHSvIWxEXmtR2mrtoRxN3j4/GU2F4q5gvQWYqcYhj6yH6m2m/YhqGc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330293914"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="330293914"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 06:19:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="658155336"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 06:19:48 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 11 May 2022 16:18:41 +0300
Date:   Wed, 11 May 2022 16:18:41 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: broxton: Add module alias for Intel
 Apollo Lake
Message-ID: <Ynu3sbnWwQgOUK4H@lahna>
References: <20220511123421.88439-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511123421.88439-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 03:34:21PM +0300, Andy Shevchenko wrote:
> We have platform device IDs for Broxton and Apollo Lake, but
> module alias is provided only for the former. Make it consistent
> by providing an alias for Apollo Lake.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
