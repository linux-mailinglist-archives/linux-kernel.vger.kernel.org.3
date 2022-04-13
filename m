Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558324FFC3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiDMRSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiDMRSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:18:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0718A6A040
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649870169; x=1681406169;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xEIEdgtiPiiXaH4CPOTBcydtVmvhoAkEJd4UOtCh7RE=;
  b=f3vvN48Vfu/5HmmOBte5TlSlCh903kY6neWF5dRrs0A+ziUq339UL8Y3
   TfkgyknfJP5B73rdFFhtnT6fshgp6DT0dswPBxux7MXSN+j1FsNqpjz8c
   QNkhnwutnMWe28oR0gcQMYsGbuzdYu1VM3+n1fI/U0pQCO/qr7ncaAS2c
   82X6tPq/e0SaXDxjDQGfUHdz66/VvSPIKWi1t42KJGjLCfId7x0MJypd0
   JYK1Q/0gdU4ry9di8iFyoCBOS2zy4XDlVz4FHhMhjY+C7yes2zmaL1iz+
   kxMh7Alw57OyzhfQ0w9EYglXRhjpOMeRt4MjI/nsVmI1i+aAW6pqfw37L
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="287756884"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="287756884"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:16:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="573362828"
Received: from jardanow-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.150.86])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:16:05 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Cong Liu <liucong2@kylinos.cn>, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Cong Liu <liucong2@kylinos.cn>,
        intel-gvt-dev <intel-gvt-dev@lists.freedesktop.org>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH] drm/i915: Remove intel_gvt_init_host declaration
In-Reply-To: <20220413072415.27231-1-liucong2@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220413072415.27231-1-liucong2@kylinos.cn>
Date:   Wed, 13 Apr 2022 20:16:02 +0300
Message-ID: <87sfqggazx.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022, Cong Liu <liucong2@kylinos.cn> wrote:
> this function has been deleted since commit 9bdb073464d6 ("drm/i915/gvt:
> Change KVMGT as self load module"), remove the deprecated function
> declaration.

I don't want to push this right now avoid conflicts in other pending
work. Cc'd Zhi & Zhenyu to pick this up.

BR,
Jani.

>
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>
> ---
>  drivers/gpu/drm/i915/intel_gvt.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_gvt.h b/drivers/gpu/drm/i915/intel_gvt.h
> index d7d3fb6186fd..daaf0957ebbc 100644
> --- a/drivers/gpu/drm/i915/intel_gvt.h
> +++ b/drivers/gpu/drm/i915/intel_gvt.h
> @@ -31,7 +31,6 @@ int intel_gvt_init(struct drm_i915_private *dev_priv);
>  void intel_gvt_driver_remove(struct drm_i915_private *dev_priv);
>  int intel_gvt_init_device(struct drm_i915_private *dev_priv);
>  void intel_gvt_clean_device(struct drm_i915_private *dev_priv);
> -int intel_gvt_init_host(void);
>  void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv);
>  void intel_gvt_resume(struct drm_i915_private *dev_priv);
>  #else

-- 
Jani Nikula, Intel Open Source Graphics Center
