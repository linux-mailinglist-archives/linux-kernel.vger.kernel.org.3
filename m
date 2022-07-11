Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BBB56D419
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiGKEvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKEvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:51:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A868DEFC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657515067; x=1689051067;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=DqKIxDYz90DbKyEN8RiUGyWSqywXB7jm80Wv2ZwVXRg=;
  b=HX5gNqF5uKhN30ZQ1rDbUDAXBM0LkC3XaA1J1wufHa0Lp37yk/hrLWMY
   18QdXP/r9MEKhOAKU5wZhpYP5J4uxQe8bEkcFruGG1mZVQXRFa3Zop8mB
   WAnHFlVpKFIuMzDj1m8sSDQ+dShlKyA3V+1iYMWdAkgDN0w/6JwpA2p28
   /tgt74HGr1rRSRzf2VH4opKPhNdMBuqUZNEONTk5HJnNDuUzrS9sygzQJ
   DGx6vpAN2bavYvlnF7kBdAXUu+bFazEBV+MEtez6iCurhCIDdzH2m/s4n
   Tx6tDxZOVkPUOzsXu6Q4cAybH2O4bLwxrzwEgnvk7xFc0m+dbUHTuCxds
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="264984380"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="asc'?scan'208";a="264984380"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 21:51:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="asc'?scan'208";a="652305338"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2022 21:51:03 -0700
Date:   Mon, 11 Jul 2022 12:27:38 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org,
        zhi.a.wang@intel.com
Subject: Re: [PATCH 1/2] drm/i915/gvt: Fix kernel-doc
Message-ID: <20220711042738.GS1089@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20220524083733.67148-1-jiapeng.chong@linux.alibaba.com>
 <20220524083733.67148-2-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KZCIPwrNpw38UenM"
Content-Disposition: inline
In-Reply-To: <20220524083733.67148-2-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KZCIPwrNpw38UenM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022.05.24 16:37:33 +0800, Jiapeng Chong wrote:
> Fix the following W=3D1 kernel warnings:
>=20
> drivers/gpu/drm/i915/gvt/handlers.c:3066: warning: expecting prototype
> for intel_t_default_mmio_write(). Prototype was for
> intel_vgpu_default_mmio_write() instead.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/i915/gvt/handlers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/g=
vt/handlers.c
> index beea5895e499..9c8dde079cb4 100644
> --- a/drivers/gpu/drm/i915/gvt/handlers.c
> +++ b/drivers/gpu/drm/i915/gvt/handlers.c
> @@ -3052,7 +3052,7 @@ int intel_vgpu_default_mmio_read(struct intel_vgpu =
*vgpu, unsigned int offset,
>  }
> =20
>  /**
> - * intel_t_default_mmio_write - default MMIO write handler
> + * intel_vgpu_default_mmio_write() - default MMIO write handler
>   * @vgpu: a vGPU
>   * @offset: access offset
>   * @p_data: write data buffer
> --=20
> 2.20.1.7.g153144c
>=20

Sorry for late reply!

Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>

--KZCIPwrNpw38UenM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYsumugAKCRCxBBozTXgY
J8OFAJ99A0M8ef8A4meD0FhvQGGNabZ8zQCgjjZsE5OL39TY+Gb+J5eLfXmRZTU=
=cZ6P
-----END PGP SIGNATURE-----

--KZCIPwrNpw38UenM--
