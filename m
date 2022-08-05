Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6A58A87C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbiHEJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiHEJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:08:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC9F21E10;
        Fri,  5 Aug 2022 02:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659690493; x=1691226493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VCbk/q9Wd0lGTGIEGbC69VxKX0QDmTy8SvpJ1KoCfF0=;
  b=biSEyLDpCGbC085vqq4/C7VcR++Gz//BsrGNyI6UYr4FpmOL3E1o6lR2
   TikNhO5QuSbvVNEFVIt3KNTiCwKRxvcBluqyClmMyYPHpmwrRFoX/RW+V
   LHG6mD4MDTWoUi+QO5WBxylKaYOYMmZ6VrZjCKzU2tZzrHq9ZKFgZWTuD
   obUhfGUVuGRwjMrTy5OsaY4LS/Tw66zzFebJOax3Qcx9rAylKisq2lMIt
   zdnjoxFDc3BGrF+hES5qwMEnAbaVJQw0HJYF20W9ldCk6senONYh1/dLk
   9nECiHfPoOE/fadh/BNwz0PQbZ6uqc5+kg7o0xtvw/Sp9Nl5WXIJBIg1F
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="316045584"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="316045584"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 02:08:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="631945398"
Received: from mborg-mobl1.ger.corp.intel.com (HELO intel.com) ([10.251.214.158])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 02:08:07 -0700
Date:   Fri, 5 Aug 2022 11:08:05 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drm/i915/gt: document TLB cache invalidation
 functions
Message-ID: <Yuzd9Ysc3BDQHuSW@alfio.lan>
References: <cover.1659598090.git.mchehab@kernel.org>
 <cc68d62a1979ea859b447b94413e100472331f57.1659598090.git.mchehab@kernel.org>
 <0698c5a5-3bf2-daa4-e10e-2715f9b0d080@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0698c5a5-3bf2-daa4-e10e-2715f9b0d080@infradead.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

> > +/**
> > + * intel_gt_invalidate_tlb_full - do full TLB cache invalidation
> > + * @gt: GT structure
> 
> In multiple places (here and below) it would be nice to know what a
> GT structure is. I looked thru multiple C and header files yesterday
> and didn't find any comments about it.
> 
> Just saying that @gt is a GT structure isn't very helpful, other
> than making kernel-doc shut up.

the 'gt' belongs to the drivers/gpu/drm/i915/gt/ subsystem and
it's widely used a throughout i915.

I think it's inappropriate to describe it just here. On the other
hand I agree that a better documentation is required for the GT
itself where other parts can point to.

Andi
