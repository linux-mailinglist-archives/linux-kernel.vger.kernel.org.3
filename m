Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B475749C3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbiGNJ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiGNJ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:57:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF084C603
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657792624; x=1689328624;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jm5IY6xwqjhzPn9Sa0+lhMEHPOhFZtYu1pdlIzIHsq0=;
  b=BFQdKhkCnfJVpGsmU8H8UNb7Iv+gkm6Tp0S49F0j/dT8UxNhrla+AMzU
   0Zi+3B1BC+CsttKuo4m/rxcseXC/GN2vQMg8txhgPuRpKpscuDrK7mgJQ
   ASwADRaRTFVt0jWOZSXarxD9Jrv3S/BzotMdlNldCXvIEuJl2cnNOOSfu
   b/5+3CVP0068NRW+SfEjGKZXyVxvzCacCV446uxZd2XYVs1FHOvZGUvdj
   Ij9cnmYg2zyt1AIGI4g6d/Pgy91f76YPBWGRY22LoUIRNSqhzdMgOK27u
   NBG/tx5HkQey0tOl5HeogPX06OdvzDuUK11Uo1e1VXcCkLhhJbMY1knSO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="286608714"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="286608714"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 02:57:03 -0700
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="653810786"
Received: from acsok-mobl.ti.intel.com (HELO maurocar-mobl2) ([10.252.37.128])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 02:57:00 -0700
Date:   Thu, 14 Jul 2022 11:56:57 +0200
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Patnana Venkata Sai <venkata.sai.patnana@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Fernando Ramos <greenfoo@u92.eu>
Subject: Re: [Intel-gfx] [PATCH v2 05/39] drm/i915: display: fix kernel-doc
 markup warnings
Message-ID: <20220714114239.5da0362d@maurocar-mobl2>
In-Reply-To: <Ys9BksNo/iylds2g@intel.com>
References: <cover.1657699522.git.mchehab@kernel.org>
        <e860a7d8e5f9c41c462ef354b9ca6f36ae142e1b.1657699522.git.mchehab@kernel.org>
        <Ys9BksNo/iylds2g@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 18:05:06 -0400
Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:

> On Wed, Jul 13, 2022 at 09:11:53AM +0100, Mauro Carvalho Chehab wrote:
> > There are a couple of issues at i915 display kernel-doc markups:
> > 
> > 	drivers/gpu/drm/i915/display/intel_display_debugfs.c:2238: warning: Function parameter or member 'intel_connector' not described in 'intel_connector_debugfs_add'
> > 	drivers/gpu/drm/i915/display/intel_display_debugfs.c:2238: warning: Excess function parameter 'connector' description in 'intel_connector_debugfs_add'
> > 	drivers/gpu/drm/i915/display/intel_display_power.c:700: warning: expecting prototype for intel_display_power_put_async(). Prototype was for __intel_display_power_put_async() instead
> > 	drivers/gpu/drm/i915/display/intel_tc.c:807: warning: Function parameter or member 'work' not described in 'intel_tc_port_disconnect_phy_work'
> > 	drivers/gpu/drm/i915/display/intel_tc.c:807: warning: Excess function parameter 'dig_port' description in 'intel_tc_port_disconnect_phy_work'
> > 
> > Those are due to wrong parameter of function name. Address them.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > ---
> > 
> > To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/
> > 
> >  drivers/gpu/drm/i915/display/intel_display_debugfs.c | 2 +-
> >  drivers/gpu/drm/i915/display/intel_display_power.c   | 2 +-
> >  drivers/gpu/drm/i915/display/intel_tc.c              | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> > index 6c3954479047..1e35eb01742b 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> > @@ -2229,7 +2229,7 @@ DEFINE_SHOW_ATTRIBUTE(i915_current_bpc);
> >  
> >  /**
> >   * intel_connector_debugfs_add - add i915 specific connector debugfs files
> > - * @connector: pointer to a registered drm_connector
> > + * @intel_connector: pointer to a registered drm_connector
> >   *
> >   * Cleanup will be done by drm_connector_unregister() through a call to
> >   * drm_debugfs_connector_remove().
> > diff --git a/drivers/gpu/drm/i915/display/intel_display_power.c b/drivers/gpu/drm/i915/display/intel_display_power.c
> > index 589af257edeb..fd6b71160a06 100644
> > --- a/drivers/gpu/drm/i915/display/intel_display_power.c
> > +++ b/drivers/gpu/drm/i915/display/intel_display_power.c
> > @@ -685,7 +685,7 @@ intel_display_power_put_async_work(struct work_struct *work)
> >  }
> >  
> >  /**
> > - * intel_display_power_put_async - release a power domain reference asynchronously
> > + * __intel_display_power_put_async - release a power domain reference asynchronously  
> 
> oh, we are really using __ prefix for non-static functions?! o.O

Yeah... Btw, this is actually a common practice to have __ prefix on
non-static and even on exported functions. Usually, the __ variant
assumes that a spinlock/mutex were already taken previously.

However, that's not the case here, as it starts holding a mutex.

In this specific case, the __ variant is called by an inline
function on a different way, depending if 
CONFIG_DRM_I915_DEBUG_RUNTIME_PM is true. On such case, it passes 
the runtime PM wakeref, otherwise it passes a -1.

Funny enough, intel_display_power_put() ifdef is inside the C
file, using a different implementation:

#if IS_ENABLED(CONFIG_DRM_I915_DEBUG_RUNTIME_PM)
	...
	void intel_display_power_put(struct drm_i915_private *dev_priv,
        	                     enum intel_display_power_domain domain,
                	             intel_wakeref_t wakeref)
	...
#else
	...
	void intel_display_power_put_unchecked(struct drm_i915_private *dev_priv,
                                       enum intel_display_power_domain domain)
	...
#endif

For consistency, I would use the same solution for both, probably
at the C file, and avoiding use a __ prefix for the async put version.

> anyway, with that ditto "()" consistency,
> 
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

Thanks!

Btw, I'm removing "()" from patches 1-3 (both at descriptions and
internally), keeping your R-B on them too.

Regards,
Mauro
