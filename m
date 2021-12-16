Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4808D477192
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhLPMXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:23:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:16303 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236002AbhLPMXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:23:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="220154325"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="220154325"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 04:23:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="482803947"
Received: from emnevill-mobl.ger.corp.intel.com (HELO localhost) ([10.252.20.65])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 04:23:44 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: remove circ_buf.h includes
In-Reply-To: <20211216115920.15981-1-jslaby@suse.cz>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211216115920.15981-1-jslaby@suse.cz>
Date:   Thu, 16 Dec 2021 14:23:41 +0200
Message-ID: <871r2c4u2a.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021, Jiri Slaby <jslaby@suse.cz> wrote:
> The last user of macros from that include was removed in 2018 by the
> commit below.
>
> Fixes: 6cc42152b02b ("drm/i915: Remove support for legacy debugfs crc interface")
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_pipe_crc.c | 1 -
>  drivers/gpu/drm/i915/i915_irq.c               | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_pipe_crc.c b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
> index 8ac263f471be..9070935b0443 100644
> --- a/drivers/gpu/drm/i915/display/intel_pipe_crc.c
> +++ b/drivers/gpu/drm/i915/display/intel_pipe_crc.c
> @@ -24,7 +24,6 @@
>   *
>   */
>  
> -#include <linux/circ_buf.h>
>  #include <linux/ctype.h>
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
> diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
> index 5b98fb0532b5..e77f644d41e8 100644
> --- a/drivers/gpu/drm/i915/i915_irq.c
> +++ b/drivers/gpu/drm/i915/i915_irq.c
> @@ -28,7 +28,6 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/circ_buf.h>
>  #include <linux/slab.h>
>  #include <linux/sysrq.h>

-- 
Jani Nikula, Intel Open Source Graphics Center
