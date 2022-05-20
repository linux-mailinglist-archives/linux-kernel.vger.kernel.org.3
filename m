Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283D852E827
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347462AbiETI55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243203AbiETI5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:57:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FE3CFE22;
        Fri, 20 May 2022 01:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653037074; x=1684573074;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8lE+zJzXvHqHdJFxq81VPdrKUjVeJsxy41x0hry8jGo=;
  b=GlRWmw38RfUpD6Gq3r1osYaaSG45S2ebDNp4BCW/MzQtLAL3iqvV82Qi
   Ru9jnMFfmKlcDHTONoo8XvlezFC+uj9oM2YZdOzrfo4/pqfVzOdeq6u3A
   aNInjTFMSMqtwkcXfgky7p3SB4/ya2D2oVZ3QcbXjTy8zXTqvA6rCtUBl
   IldJBUOExMON6a3a2E17lbuRG3FviIQ7erb9G4Coj914JQ+CH5melxz1O
   Rvc8+DlL0sN2ji20Z6zXNrfafHbLl1xiOdfyPBWexyOb3mpfuME0o7C4x
   37Dd/4lNPQb+l49kwPRGTIGwpGqq789sN6GVfcM30Ak8aY5qiJQ5FTFFJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272249727"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272249727"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 01:57:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="546588001"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 01:57:47 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 20 May 2022 11:57:44 +0300
Date:   Fri, 20 May 2022 11:57:44 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Fix kernel doc format, i.e. add
 return sections
Message-ID: <YodYCMgqI9GznHeo@lahna>
References: <20220519212645.47177-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519212645.47177-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:26:45AM +0300, Andy Shevchenko wrote:
> Kernel doc validator is not happy:
> 
>   pinctrl-intel.c:865: warning: No description found for return value of 'intel_gpio_to_pin'
>   pinctrl-intel.c:904: warning: No description found for return value of 'intel_pin_to_gpio'
>   2 warnings
> 
> Add return sections to the kernel documentation of the above mentioned
> functions.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
