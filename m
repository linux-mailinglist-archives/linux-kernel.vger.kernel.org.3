Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420145AF52F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiIFUAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiIFT7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:59:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5157BD141;
        Tue,  6 Sep 2022 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494169; x=1694030169;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vL/YDbBtpAt9jdjtaY4Sr1ZSqPRuhmV3B7r6AYlC4uw=;
  b=UodM1Py0XsVbpV99MM71DHZ7wzDvHXLpLETsU8M6bbckNIivRGV/q7cq
   9igSYmOXJ8fCWUTbvx6t6Zc7+9wP2W1P70uqes2T0JA2kZNNyTwvJ/i4H
   u45G2pPjE1v6jqcGyhLl0UWOK7JsqQcBpr5Zb79Tl0/oeMvB+LCbZXtR8
   r6x9Jwb4Zb6a7DzunUr6Otzq8GmtUapMffx9XkL5vfEyGaF0/Ld34xb3b
   6t1ZzWE2RAKecpJGHDDjpx5yBATQeCINxpKSLaYzBO5sIgVIxFmu7w1dq
   Y41u5+jd5wVuN36/F/biC0/ehn7uE7HeWn0AFj9E7E7nrfL8nOvZyi5pi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283687054"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283687054"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="859375126"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 06 Sep 2022 12:52:26 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.44.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9517C580890;
        Tue,  6 Sep 2022 12:52:23 -0700 (PDT)
Date:   Tue, 6 Sep 2022 21:47:43 +0200
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [Intel-gfx] [PATCH v2 38/39] drm/i915: add descriptions for
 some RPM macros at intel_gt_pm.h
Message-ID: <20220906214735.20faebfb@maurocar-mobl2>
In-Reply-To: <YvIy9o2dHkB1gAr6@intel.com>
References: <cover.1657699522.git.mchehab@kernel.org>
        <37e3b9aac85f1d08c0a53bae86680d504308bf67.1657699522.git.mchehab@kernel.org>
        <YvIy9o2dHkB1gAr6@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 06:12:06 -0400
Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:

> On Wed, Jul 13, 2022 at 09:12:26AM +0100, Mauro Carvalho Chehab wrote:
> > The intel_gt_pm.h file contains some convenient macros to be used
> > in GT code in order to get/put runtime PM references and for
> > checking them.
> > 
> > Add descriptions based on the ones at intel_wakeref.h and
> > intel_runtime_pm.c.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > ---
> > 
> > To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/
> > 
> >  Documentation/gpu/i915.rst            |  2 +
> >  drivers/gpu/drm/i915/gt/intel_gt_pm.h | 62 +++++++++++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> > 
> > diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> > index 6bb50edc6d79..9862d504df4d 100644
> > --- a/Documentation/gpu/i915.rst
> > +++ b/Documentation/gpu/i915.rst
> > @@ -709,6 +709,8 @@ Table Manager (TTM)
> >  
> >  .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
> >  
> > +.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_gt_pm.h  
> 
> I don't believe this is the right placement for this.

I'll add it then at:

	Other GT functionality

Section.

Regards,
Mauro


> 
> the rest lgtm
> 
> > +
> >  Graphics Execution Manager (GEM)
> >  --------------------------------
> >  
> > diff --git a/drivers/gpu/drm/i915/gt/intel_gt_pm.h b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
> > index bc898df7a48c..a8ea6846980a 100644
> > --- a/drivers/gpu/drm/i915/gt/intel_gt_pm.h
> > +++ b/drivers/gpu/drm/i915/gt/intel_gt_pm.h
> > @@ -11,21 +11,57 @@
> >  #include "intel_gt_types.h"
> >  #include "intel_wakeref.h"
> >  
> > +/**
> > + * intel_gt_pm_is_awake: Query whether the runtime PM is awake held
> > + *
> > + * @gt: pointer to the graphics engine
> > + *
> > + * Returns: true if a runtime pm reference is currently held and the GT is
> > + * awake.
> > + */
> >  static inline bool intel_gt_pm_is_awake(const struct intel_gt *gt)
> >  {
> >  	return intel_wakeref_is_active(&gt->wakeref);
> >  }
> >  
> > +/**
> > + * intel_gt_pm_get: grab a runtime PM reference ensuring that GT is powered up
> > + * @gt: pointer to the graphics engine
> > + *
> > + * Any runtime pm reference obtained by this function must have a symmetric
> > + * call to intel_gt_pm_put() to release the reference again.
> > + *
> > + * Note that this is allowed to fail, in which case the runtime-pm wakeref
> > + * will be released and the acquisition unwound.
> > + */
> >  static inline void intel_gt_pm_get(struct intel_gt *gt)
> >  {
> >  	intel_wakeref_get(&gt->wakeref);
> >  }
> >  
> > +/**
> > + * __intel_gt_pm_get: Acquire the runtime PM reference again
> > + * @gt: pointer to the graphics engine which contains the wakeref
> > + *
> > + * Increment the PM reference counter, only valid if it is already held by
> > + * the caller.
> > + *
> > + * See intel_gt_pm_get().
> > + */
> >  static inline void __intel_gt_pm_get(struct intel_gt *gt)
> >  {
> >  	__intel_wakeref_get(&gt->wakeref);
> >  }
> >  
> > +/**
> > + * intel_gt_pm_get_if_awake: Acquire the runtime PM reference if active
> > + * @gt: pointer to the graphics engine which contains the PM reference
> > + *
> > + * Acquire a hold on the PM reference, but only if the GT is already
> > + * active.
> > + *
> > + * Returns: true if the wakeref was acquired, false otherwise.
> > + */
> >  static inline bool intel_gt_pm_get_if_awake(struct intel_gt *gt)
> >  {
> >  	return intel_wakeref_get_if_active(&gt->wakeref);
> > @@ -36,6 +72,14 @@ static inline void intel_gt_pm_might_get(struct intel_gt *gt)
> >  	intel_wakeref_might_get(&gt->wakeref);
> >  }
> >  
> > +/**
> > + * intel_gt_pm_put: Release the runtime PM reference
> > + * @gt: pointer to the graphics engine which contains the PM reference
> > + *
> > + * Release our hold on the runtime PM for GT.
> > + *
> > + * It might power down the GT right away if this is the last reference.
> > + */
> >  static inline void intel_gt_pm_put(struct intel_gt *gt)
> >  {
> >  	intel_wakeref_put(&gt->wakeref);
> > @@ -51,10 +95,28 @@ static inline void intel_gt_pm_might_put(struct intel_gt *gt)
> >  	intel_wakeref_might_put(&gt->wakeref);
> >  }
> >  
> > +/**
> > + * with_intel_gt_pm - get a GT reference ensuring that GT is powered up,
> > + *	run some code and then put the reference away.
> > + *
> > + * @gt: pointer to the gt
> > + * @tmp: pointer to a temporary wakeref.
> > + */
> >  #define with_intel_gt_pm(gt, tmp) \
> >  	for (tmp = 1, intel_gt_pm_get(gt); tmp; \
> >  	     intel_gt_pm_put(gt), tmp = 0)
> >  
> > +/**
> > + * intel_gt_pm_wait_for_idle: Wait until the runtime PM reference is idle
> > + * @gt: pointer to the graphics engine which contains the PM reference
> > + *
> > + * Wait for the earlier asynchronous release of the runtime PM reference. Note
> > + * this will wait for any third party as well, so make sure you only wait
> > + * when you have control over the GT runtime PM and trust no one else is
> > + * acquiring it.
> > + *
> > + * Return: 0 on success, error code if killed.
> > + */
> >  static inline int intel_gt_pm_wait_for_idle(struct intel_gt *gt)
> >  {
> >  	return intel_wakeref_wait_for_idle(&gt->wakeref);
> > -- 
> > 2.36.1
> >   
