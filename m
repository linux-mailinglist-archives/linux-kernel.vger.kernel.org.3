Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B45AF533
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiIFUAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiIFUAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:00:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D93BD147;
        Tue,  6 Sep 2022 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662494172; x=1694030172;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ogqkU6hwz+5RMxgjJdnuLelA2xSDzawITgx7hiHuXjg=;
  b=SIRbunZ5rXxy0hyllUzfpA5wZ/PRgjhx9+6rVdle9PxfQuq0szzz5VRM
   KXi3VEb0zKb8CU3VcQReZTT98SAiI9DhM3NIP8sBVFX4QXI3wsioAUOuc
   VMQmCLYbfOZd20wYC7hseXNm3cGzTTmDYKT9v2+t7zw4dgKykjeI9b01V
   j0li7bfZnf0JD3rQV1Yyp0IkQjdeKasYiI2zLvrwmIVcw8Qefk4o/FG2R
   /E0k7+YX+PcxiB7oq9KJcik/rsE9s5P9aZoLiRNhSfkBYPNql0fRf+dD2
   xeHBbiY5eMiMAqgfX/IfYmqc2S5CkLzlLkh0b+zqTw96BEPM/hb0x4fDt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="298004947"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="298004947"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675842746"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2022 12:52:38 -0700
Received: from maurocar-mobl2 (maurocar-mobl2.ger.corp.intel.com [10.252.44.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 14A6F580890;
        Tue,  6 Sep 2022 12:52:35 -0700 (PDT)
Date:   Tue, 6 Sep 2022 21:43:30 +0200
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [Intel-gfx] [PATCH v2 35/39] docs: gpu: i915.rst: add the
 remaining kernel-doc markup files
Message-ID: <20220906214323.3d3a0db4@maurocar-mobl2>
In-Reply-To: <YvI1CbsIZIG7FVBP@intel.com>
References: <cover.1657699522.git.mchehab@kernel.org>
        <5630ff7f2d5a99fc78b4fc2fa7e63649d23f226c.1657699522.git.mchehab@kernel.org>
        <YvI1CbsIZIG7FVBP@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 06:20:57 -0400
Rodrigo Vivi <rodrigo.vivi@intel.com> wrote:

> On Wed, Jul 13, 2022 at 09:12:23AM +0100, Mauro Carvalho Chehab wrote:
> > There are other files with kernel-doc markups:
> > 
> > 	$ git grep -l "/\*\*" $(git ls-files|grep drivers/gpu/drm/i915/) >kernel-doc-files
> > 	$ for i in $(cat kernel-doc-files); do if [ "$(git grep $i Documentation/)" == "" ]; then echo "$i"; fi; done >aaa
> > 
> > Add them to i915.rst as well.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > ---
> > 
> > To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH v2 00/39] at: https://lore.kernel.org/all/cover.1657699522.git.mchehab@kernel.org/
> > 
> >  Documentation/gpu/i915.rst | 87 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> > 
> > diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> > index 974754586be8..6bb50edc6d79 100644
> > --- a/Documentation/gpu/i915.rst
> > +++ b/Documentation/gpu/i915.rst
> > @@ -13,6 +13,11 @@ Core Driver Infrastructure
> >  This section covers core driver infrastructure used by both the display
> >  and the GEM parts of the driver.
> >  
> > +Core driver
> > +-----------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_driver.c
> > +
> >  Runtime Power Management
> >  ------------------------
> >  
> > @@ -29,6 +34,10 @@ Runtime Power Management
> >  
> >  .. kernel-doc:: drivers/gpu/drm/i915/intel_pm.c
> >  
> > +.. kernel-doc:: drivers/gpu/drm/i915/intel_wakeref.h
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_active.h  
> 
> not sure if this belongs to this group...
> 
> > +
> >  Interrupt Handling
> >  ------------------
> >  
> > @@ -44,6 +53,28 @@ Interrupt Handling
> >  .. kernel-doc:: drivers/gpu/drm/i915/i915_irq.c
> >     :functions: intel_runtime_pm_enable_interrupts
> >  
> > +Error handling
> > +--------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_gpu_error.c  
> 
> not sure if this gt hang stuff deserves a separated section
> alone and if the name is the best one....
> 
> > +
> > +Memory Handling
> > +---------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_vma_resource.h
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_vma_resource.c
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_vma.h
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_vma.c
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_mm.c
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/intel_memory_region.c
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_memcpy.c
> > +
> >  Intel GVT-g Guest Support(vGPU)  
> 
>                             ^ missing space
> 
> >  -------------------------------
> >  
> > @@ -109,6 +140,54 @@ Workarounds
> >  .. kernel-doc:: drivers/gpu/drm/i915/gt/intel_workarounds.c
> >     :doc: Hardware workarounds
> >  
> > +32-bits compatible ioctl Logic
> > +------------------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_ioc32.c
> > +
> > +Scatterlist handling
> > +--------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_scatterlist.h
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_scatterlist.c
> > +
> > +i915 request
> > +------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_request.h
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_request.c
> > +
> > +Ancillary routines  
> 
> maybe simply have an "Others" section and put everything
> that has only one item like the gpu hang one?

OK!

> 
> > +------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_deps.c
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_deps.h
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/intel_device_info.c
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_params.c
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_sw_fence_work.h
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_syncmap.c
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/intel_pcode.c
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_reg_defs.h
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/intel_wopcm.h
> > +
> > +
> > +PXP  
> 
> Protected Xe Path (PXP)
> 
> 
> > +---
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/pxp/intel_pxp_irq.c
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/pxp/intel_pxp_tee.c
> > +
> >  Display Hardware Handling
> >  =========================
> >  
> > @@ -618,6 +697,12 @@ Protected Objects
> >  Table Manager (TTM)
> >  -------------------
> >  
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_ttm_buddy_manager.h
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_ttm_buddy_manager.c
> > +
> > +.. kernel-doc:: drivers/gpu/drm/i915/intel_region_ttm.c
> > +
> >  .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> >  
> >  .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_ttm.h
> > @@ -627,6 +712,8 @@ Table Manager (TTM)
> >  Graphics Execution Manager (GEM)
> >  --------------------------------
> >  
> > +.. kernel-doc:: drivers/gpu/drm/i915/i915_gem.c
> > +
> >  .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_create.c
> >  
> >  .. kernel-doc:: drivers/gpu/drm/i915/gem/i915_gem_domain.c  
> 
> in many cases I see only the .h or only the .c... why is that?
> wouldn't be better already put both in all the cases?

No. Adding kernel-doc files that doesn't contain any markups
will produce warnings.

We're working hard upstream to have a zero-warnings policy for
documentation.

Regards,
Mauro
