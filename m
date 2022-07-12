Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEC35711D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 07:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiGLFYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGLFYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 01:24:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DF5101DE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 22:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657603462; x=1689139462;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=IKMxtPSIRnCmNZR9bULecM4pIW9bVVxojRNmONEGgc4=;
  b=F8VfWKOtMNR5gcorcEVf5biWVdBB/j3v036sz+jq2JXxWT0kHbEQZaTt
   coxPQxfSDDoIhsoqPeuhaG6tXlWe1gUW+bnZB4RAJo3NubxEr8nTLezVD
   GKgphizLEB/TKVUrH5zyzVGK6ZVIPu26RN+tK6e3/eOExnE2jJMl6dyRw
   uk1YlzXeqgkx0xSHtTTTt1XKTcJvQ/OZBr26aSmVvteIucmScm+ph4pWL
   rqmF5x77iGM0h34kAAArxmrQtYVSL90pG69dXfEPOKb+llEmrtScYJ5Zf
   ZonCze/VH3iQ4NznflSPe/TdZKpCZmL2emjARtZHgq7a4+wIqubbNAOSe
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="265253912"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="asc'?scan'208";a="265253912"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 22:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="asc'?scan'208";a="599267727"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2022 22:24:18 -0700
Date:   Tue, 12 Jul 2022 13:00:51 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/32] drm/i915: gvt: fix kernel-doc trivial warnings
Message-ID: <20220712050051.GW1089@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <cover.1657565224.git.mchehab@kernel.org>
 <15fc6317ef5eb4ad7123d627c58c4aa04a4eae87.1657565224.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BYl/BInBdgsQr4gH"
Content-Disposition: inline
In-Reply-To: <15fc6317ef5eb4ad7123d627c58c4aa04a4eae87.1657565224.git.mchehab@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BYl/BInBdgsQr4gH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022.07.11 21:24:49 +0100, Mauro Carvalho Chehab wrote:
> Some functions seem to have been renamed without updating the kernel-doc
> markup causing warnings. Also, struct intel_vgpu_dmabuf_obj is not
> properly documented, but has a kerneld-doc markup.
>=20
> Fix those warnings:
> 	drivers/gpu/drm/i915/gvt/aperture_gm.c:308: warning: expecting prototype=
 for inte_gvt_free_vgpu_resource(). Prototype was for intel_vgpu_free_resou=
rce() instead
> 	drivers/gpu/drm/i915/gvt/aperture_gm.c:344: warning: expecting prototype=
 for intel_alloc_vgpu_resource(). Prototype was for intel_vgpu_alloc_resour=
ce() instead
> 	drivers/gpu/drm/i915/gvt/cfg_space.c:257: warning: expecting prototype f=
or intel_vgpu_emulate_cfg_read(). Prototype was for intel_vgpu_emulate_cfg_=
write() instead
> 	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or mem=
ber 'vgpu' not described in 'intel_vgpu_dmabuf_obj'
> 	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or mem=
ber 'info' not described in 'intel_vgpu_dmabuf_obj'
> 	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or mem=
ber 'dmabuf_id' not described in 'intel_vgpu_dmabuf_obj'
> 	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or mem=
ber 'kref' not described in 'intel_vgpu_dmabuf_obj'
> 	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or mem=
ber 'initref' not described in 'intel_vgpu_dmabuf_obj'
> 	drivers/gpu/drm/i915/gvt/dmabuf.h:61: warning: Function parameter or mem=
ber 'list' not described in 'intel_vgpu_dmabuf_obj'
> 	drivers/gpu/drm/i915/gvt/handlers.c:3066: warning: expecting prototype f=
or intel_t_default_mmio_write(). Prototype was for intel_vgpu_default_mmio_=
write() instead
> 	drivers/gpu/drm/i915/gvt/mmio_context.c:560: warning: expecting prototyp=
e for intel_gvt_switch_render_mmio(). Prototype was for intel_gvt_switch_mm=
io() instead
> 	drivers/gpu/drm/i915/gvt/page_track.c:131: warning: expecting prototype =
for intel_vgpu_enable_page_track(). Prototype was for intel_vgpu_disable_pa=
ge_track() instead
> 	drivers/gpu/drm/i915/gvt/vgpu.c:215: warning: expecting prototype for in=
tel_gvt_active_vgpu(). Prototype was for intel_gvt_activate_vgpu() instead
> 	drivers/gpu/drm/i915/gvt/vgpu.c:230: warning: expecting prototype for in=
tel_gvt_deactive_vgpu(). Prototype was for intel_gvt_deactivate_vgpu() inst=
ead
> 	drivers/gpu/drm/i915/gvt/vgpu.c:358: warning: expecting prototype for in=
tel_gvt_destroy_vgpu(). Prototype was for intel_gvt_destroy_idle_vgpu() ins=
tead
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---

Hi, thanks for this, but there're already several fixes in queue right now,=
 e.g
https://patchwork.freedesktop.org/series/104302/ and
https://patchwork.freedesktop.org/series/104640/, but looks there're other =
uncaught issues.
I'd like to submit current in queue first, then maybe you could update for =
others?


--BYl/BInBdgsQr4gH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYsz/+gAKCRCxBBozTXgY
J4vQAKCMH46gTKH1fklSj9leE4TwPisR4QCeO3K7++guiaV79LrJuEyXo9VDYGI=
=vaK2
-----END PGP SIGNATURE-----

--BYl/BInBdgsQr4gH--
