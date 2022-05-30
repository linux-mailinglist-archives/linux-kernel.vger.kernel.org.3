Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9E537B25
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 15:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbiE3NNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 09:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbiE3NNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 09:13:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69354688;
        Mon, 30 May 2022 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653916426; x=1685452426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZKd3SVXOKrULud4iJfh9S6YT30WQ3/NPAZyPwoh/9tU=;
  b=ZtnsFO0fxTPnQEHZ6udoUrYL1YIDcjfkihVkZNiQbDane7XykAqUSADZ
   l+DB437ypGQWbqTDp2koMR8f27BGb6ahEjcW/BBgcqJ5tJXMVnf2v6I1/
   HLpqVyPUFlM46F8357zHcdyyN2myHEgYxSlonqUuPkN9B7iDo2A6QsVRG
   UNudQHRe8zRGFi3OzTGw5RPnE0BQBAfAcMqnqFBzyXCftS/RPkYJGGWYU
   dFvpb6nUjJWrgkYI4GLsbTLymVm1g0MpQUasvKcu44VKlDNTn/8a+RURz
   +AA9oV+mAwzZT2KyfR4iWIg9WNlPdQVKtBX/qFwaOZrZ+sqPqbxUhiUe4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="338035853"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="338035853"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 06:13:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="751168567"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 06:13:43 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 30 May 2022 16:13:40 +0300
Date:   Mon, 30 May 2022 16:13:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        dave.hansen@linux.intel.com
Subject: Re: [PATCH v1 1/1] MAINTAINERS: Update Intel pin control to Supported
Message-ID: <YpTDBAyBhr/z9z4X@lahna>
References: <20220530115750.70470-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530115750.70470-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 02:57:50PM +0300, Andy Shevchenko wrote:
> The actual status of the code is Supported.
> 
> Reported-by: dave.hansen@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
