Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A377351BD0D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355466AbiEEKWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245305AbiEEKWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:22:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D7A51E4B
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651745936; x=1683281936;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mZUGkTm0Df4lduKfx+xv0mj6B6QM8Vh6UCcg8dJR6Ko=;
  b=FYEUckw2koCHeP0AbmAZebM48LvYj4/PcSPZwtKbbL1kt7PqAk8yRNr6
   6VMAsiW12cpeK+quetaeIawkKwgSx9S3vTBXaqtd7rr05hiD09KnuPGxB
   jZhVfRzqFUCdgb5NOPeXGIPy6DGgJ4Ba5Jeb72p6/v3ELSIne4gIMnvV6
   2YRIgtCgTPl6yfVv/rAf2mmQzL9E1OjGcnrtDCgaUm25OFX1qyvTXJ0Cc
   9/QpdAAdipcFHfGbsa6qFKn51tvk1HzuSxZXzoFC5LwT+Zcg1GhtQf0rt
   X4bJBQlYK7qugwRGoREI8xPul8+J/L9NiEmLCiGw9vPQ2+VV37miZ0/oM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267662339"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="267662339"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:18:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="694594805"
Received: from mstepka-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.134.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:18:48 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, daniel@ffwll.ch
Cc:     airlied@linux.ie, tvrtko.ursulin@linux.intel.com,
        rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next 1/2] drm/i915: Remove duplicated include in
 intel_sseu.c
In-Reply-To: <20220504224816.41653-1-yang.lee@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220504224816.41653-1-yang.lee@linux.alibaba.com>
Date:   Thu, 05 May 2022 13:18:43 +0300
Message-ID: <87wnf0l1to.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 May 2022, Yang Li <yang.lee@linux.alibaba.com> wrote:
> Fix following includecheck warning:
> ./drivers/gpu/drm/i915/gt/intel_sseu.c: linux/string_helpers.h is
> included more than once.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Already fixed by commit 10dcf783f7e9 ("drm/i915: remove superfluous
string helper include").

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/gt/intel_sseu.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_sseu.c b/drivers/gpu/drm/i915/gt/intel_sseu.c
> index 9881a6790574..fdd25691beda 100644
> --- a/drivers/gpu/drm/i915/gt/intel_sseu.c
> +++ b/drivers/gpu/drm/i915/gt/intel_sseu.c
> @@ -10,8 +10,6 @@
>  #include "intel_gt_regs.h"
>  #include "intel_sseu.h"
>  
> -#include "linux/string_helpers.h"
> -
>  void intel_sseu_set_info(struct sseu_dev_info *sseu, u8 max_slices,
>  			 u8 max_subslices, u8 max_eus_per_subslice)
>  {

-- 
Jani Nikula, Intel Open Source Graphics Center
