Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A86527E90
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbiEPH2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiEPH2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:28:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60931F614
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652686113; x=1684222113;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=q3m2ohYSgy6ZmyxlbpF3+joY8hSjHHJlesu9z1mgl+c=;
  b=KDgrCbGAsr4SULpkNeq7pnZYANcVkIae82ToF9tS/W1gfxmM2GT5HftD
   AWJrwjWxAHFYjhIXqM1X4LMlgFdTwcCF4SIVSzeR3/5gOdBAM5iHSzyXi
   U0nI4xAEDv3NyZDcTzgOkVA/zFHMjlKfToYGlOFCVSBD/Gzhp+GECoMUJ
   bl5x63/gEtr1oFi0/XVXDYedMbt2SSTWKRDFLcsv0SJhfN57JJTB6dwfF
   oUWduojKmLDblH5ZLuAJZV3q6LYYwGXHZUqu4sQRLL8E5TxpwmSxpqHhJ
   weCMa5q6XkP1tZNBkskGc6kOn4+ElPT5hHs1kBZSnW4CUpD+e/sl56SPi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="331382945"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="331382945"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 00:28:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="568201191"
Received: from jrozansk-mobl.ger.corp.intel.com (HELO localhost) ([10.249.130.253])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 00:28:23 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 4/7] drm/i915: Remove unnecessary include
In-Reply-To: <20220514014322.2927339-5-baolu.lu@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
 <20220514014322.2927339-5-baolu.lu@linux.intel.com>
Date:   Mon, 16 May 2022 10:28:19 +0300
Message-ID: <877d6mhr70.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2022, Lu Baolu <baolu.lu@linux.intel.com> wrote:
> intel-iommu.h is not needed in drm/i915 anymore. Remove its include.

Thanks for the cleanups. Do you want to keep the patches together or
want us to pick this up via drm-intel?

If you want to keep the patches together,

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via whichever tree suits you best. Just let us know.

BR,
Jani.


>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/i915_drv.h                | 1 -
>  drivers/gpu/drm/i915/display/intel_display.c   | 1 -
>  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_=
drv.h
> index fa14da84362e..f2a6982c3bef 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -36,7 +36,6 @@
>=20=20
>  #include <linux/i2c.h>
>  #include <linux/i2c-algo-bit.h>
> -#include <linux/intel-iommu.h>
>  #include <linux/pm_qos.h>
>=20=20
>  #include <drm/drm_connector.h>
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index 7dfeb458aa65..686ddbeebadc 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -27,7 +27,6 @@
>  #include <acpi/video.h>
>  #include <linux/i2c.h>
>  #include <linux/input.h>
> -#include <linux/intel-iommu.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/dma-resv.h>
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu=
/drm/i915/gem/i915_gem_execbuffer.c
> index d42f437149c9..c9823528ea94 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> @@ -4,7 +4,6 @@
>   * Copyright =C2=A9 2008,2010 Intel Corporation
>   */
>=20=20
> -#include <linux/intel-iommu.h>
>  #include <linux/dma-resv.h>
>  #include <linux/sync_file.h>
>  #include <linux/uaccess.h>

--=20
Jani Nikula, Intel Open Source Graphics Center
