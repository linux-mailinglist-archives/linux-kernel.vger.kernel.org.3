Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45D84EBD70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244702AbiC3JSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244706AbiC3JS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:18:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9431F25C54;
        Wed, 30 Mar 2022 02:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648631803; x=1680167803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u/cy2/AdvnF64CBs9i/0Wl3P9S34F9SVM/vWq+6wsTA=;
  b=NPTT8I1Xz1VMzQN2bmpMTKcjLZlR+YfEA2WRlf7jZAaqtd55xyGuA6bY
   huBwlpYek/EvKVeEMwhjiarwQds1DFw1raugtRbGHZuKPukWLA7TnyxAZ
   g7SkN8WdTuvjtJP1d6/hUwVYH174YP3Aqi1SNJ0cL/AEY72/QmUDGHfzM
   flWOWn+6Ku/Ox0rtp4iHQuS8n5zBZAmNf6ZWQXb7CS9rMAd0YB54vZJod
   u0Mw7QrCwn/p1m6l+gJB2ucxC4qmodZqDBcJ+Eys5Yrxhoog7LTyy84Df
   ud6SG3mFj0QtDYxOlDmNWRb2+6VAqEKf56ZE2ZsaSlnh1mtsmZhtPmIT9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259467214"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="259467214"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 02:16:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="503244616"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 02:16:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nZUQx-009IxE-H9;
        Wed, 30 Mar 2022 12:16:07 +0300
Date:   Wed, 30 Mar 2022 12:16:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com, digetx@gmail.com,
        ulf.hansson@linaro.org, cai.huoqing@linux.dev, bbasu@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc/tegra: pmc: update Tegra234 reset sources
Message-ID: <YkQf13VH7RzrEcG/@smile.fi.intel.com>
References: <20220330063635.1689-1-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330063635.1689-1-spatra@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 12:06:35PM +0530, Sandipan Patra wrote:
> Reset_sources list is updated to add all reset sources
> and removing ones that do not actually exist.

...

> +	"SYS_RESET_N",	/*0*/

Missed spaces in the comment here and everywhere else.

Not sure about indices. If it's going to be a part of the hardware programming
interface it may make sense to use hexadecimal rather than decimal.

-- 
With Best Regards,
Andy Shevchenko


