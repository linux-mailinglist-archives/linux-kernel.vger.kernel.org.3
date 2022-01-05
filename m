Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8F1484F82
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 09:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiAEIpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 03:45:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:51892 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233694AbiAEIpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 03:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641372321; x=1672908321;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=riHgiHH3txI3gRT2luKsKqbMrT9muPYRCFRqvqUVq0s=;
  b=iMA7yEhTSm/GkdCpQPaPev6+iHmhu5DmpYNhy1VEhw3CgJA6iYuKZnA8
   VG2Pfzi520ZZjqHdeVzeqsp/ta/rCJrremOgsX3RFeuyW4NXGFMfbg3DJ
   Qes95UHqYQXijRMPiQqZuOM6JkGrW0/M5K19z+tM4VgLvfK9U6h5KYAKc
   FtEM6Igzley5muOpokSzmuLm6CMi+EN6orOb10ayl0Yesyr6WygfWhEpA
   SgaRNd3bgHCT6j1OOHyJscrKWM/NBTWPHA0TAcG2Vb59ygbN+JkWNficp
   L7mrcX3ewYIvdfibMwN0i0zY1kR52/1RAOKd2F9d2URmwMdYerhWq+rXi
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="305750604"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="305750604"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 00:45:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="472408073"
Received: from menright-mobl1.amr.corp.intel.com (HELO localhost) ([10.252.25.244])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 00:45:17 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@linux.ie
Cc:     daniel@ffwll.ch, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] drm/i915/fbc: replace DEFINE_SIMPLE_ATTRIBUTE
 with DEFINE_DEBUGFS_ATTRIBUTE
In-Reply-To: <20220105003929.16971-1-yang.lee@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220105003929.16971-1-yang.lee@linux.alibaba.com>
Date:   Wed, 05 Jan 2022 10:45:14 +0200
Message-ID: <87bl0qtvtx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jan 2022, Yang Li <yang.lee@linux.alibaba.com> wrote:
> Fix the following coccicheck warning:
> ./drivers/gpu/drm/i915/display/intel_fbc.c:1757:0-23: WARNING:
> intel_fbc_debugfs_false_color_fops should be defined with
> DEFINE_DEBUGFS_ATTRIBUTE
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/i915/display/intel_fbc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
> index 160fd2bdafe5..a43f5b74d6ac 100644
> --- a/drivers/gpu/drm/i915/display/intel_fbc.c
> +++ b/drivers/gpu/drm/i915/display/intel_fbc.c
> @@ -1754,7 +1754,7 @@ static int intel_fbc_debugfs_false_color_set(void *data, u64 val)
>  	return 0;
>  }
>  
> -DEFINE_SIMPLE_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
> +DEFINE_DEBUGFS_ATTRIBUTE(intel_fbc_debugfs_false_color_fops,
>  			intel_fbc_debugfs_false_color_get,
>  			intel_fbc_debugfs_false_color_set,
>  			"%llu\n");

Please fix the indentation on the continuation lines.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
