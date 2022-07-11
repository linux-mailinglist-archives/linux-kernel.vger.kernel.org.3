Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E8D56D423
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiGKExX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGKExU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:53:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DA2DF26
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 21:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657515199; x=1689051199;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=d6/ngeTVNk998Ig8RGaNDRrOoPTixlzEU/yTANqW8Fk=;
  b=L97GUPW9t5M3SCSI7rRi3hOEInFtoPdx+wTZjdTviXRc6rCeCI8NfooP
   5V2NFGuz0CjlUNU4gerEFik+DdCjzcxwc8dFOAqVOnWD7Kob1ksROIqnd
   9f9P4WHeH+5RvYU83uKo2NAD6yicM1QIqQSYKPYJ7XkG4dOTcg0F5XW7y
   k/n1Y0F7HkywCh7gYjZU8omFk87eTWuSW6vYuq4qOUmkdgfEw3HW9rJNV
   oHAFtzuwKQqN920Lh/ND1BP3gYnr8rvJE/VfJSiaWzSRonVhCX+FQHxqN
   tY8SJy87pfH/zXeMhHQCuDxi0KNUbU1GQVyQMnFihrwXx0dw2793/cNPh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="285702708"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="asc'?scan'208";a="285702708"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 21:53:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="asc'?scan'208";a="598911385"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2022 21:53:16 -0700
Date:   Mon, 11 Jul 2022 12:29:51 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org,
        zhi.a.wang@intel.com
Subject: Re: [PATCH] drm/i915/gvt: Fix kernel-doc
Message-ID: <20220711042951.GU1089@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20220602073519.22363-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NqXz6hVRMdSFrLFa"
Content-Disposition: inline
In-Reply-To: <20220602073519.22363-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NqXz6hVRMdSFrLFa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022.06.02 15:35:19 +0800, Jiapeng Chong wrote:
> Fix the following W=3D1 kernel warnings:
>=20
> drivers/gpu/drm/i915/gvt/aperture_gm.c:308: warning: expecting prototype
> for inte_gvt_free_vgpu_resource(). Prototype was for
> intel_vgpu_free_resource() instead.
>=20
> drivers/gpu/drm/i915/gvt/aperture_gm.c:344: warning: expecting prototype
> for intel_alloc_vgpu_resource(). Prototype was for
> intel_vgpu_alloc_resource() instead.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/i915/gvt/aperture_gm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/aperture_gm.c b/drivers/gpu/drm/i91=
5/gvt/aperture_gm.c
> index 557f3314291a..3b81a6d35a7b 100644
> --- a/drivers/gpu/drm/i915/gvt/aperture_gm.c
> +++ b/drivers/gpu/drm/i915/gvt/aperture_gm.c
> @@ -298,7 +298,7 @@ static int alloc_resource(struct intel_vgpu *vgpu,
>  }
> =20
>  /**
> - * inte_gvt_free_vgpu_resource - free HW resource owned by a vGPU
> + * intel_vgpu_free_resource() - free HW resource owned by a vGPU
>   * @vgpu: a vGPU
>   *
>   * This function is used to free the HW resource owned by a vGPU.
> @@ -328,7 +328,7 @@ void intel_vgpu_reset_resource(struct intel_vgpu *vgp=
u)
>  }
> =20
>  /**
> - * intel_alloc_vgpu_resource - allocate HW resource for a vGPU
> + * intel_vgpu_alloc_resource() - allocate HW resource for a vGPU
>   * @vgpu: vGPU
>   * @param: vGPU creation params
>   *
> --=20
> 2.20.1.7.g153144c
>=20

Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>

Thanks!

--NqXz6hVRMdSFrLFa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYsunPwAKCRCxBBozTXgY
JxhDAJ4k/6vczxEcG5rUQ4LYbrk0JcAieQCbBmYAN+bZ+WtisN1xVouxnZnQ4RY=
=Fs2v
-----END PGP SIGNATURE-----

--NqXz6hVRMdSFrLFa--
