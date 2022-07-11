Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D233C56D40A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiGKEsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiGKEsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:48:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF0E1900F;
        Sun, 10 Jul 2022 21:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657514878; x=1689050878;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=MjNTYLGdvhEIt8nnujq9JqluQ/hMJx3/KNyjN4wrhg8=;
  b=LR2lBk1SC9wzmVE/6izMsOqYEJwjhYEN+45dqOiPysDb7I6vbapJT2wi
   BwJCD9bKmLsGhip0A+Z49QcTvNJ0886Ycudu1t2Z7JJ9aaw6KeD5y4HBX
   jAXrKujxgVa3MVqurXic6LUQN8dNziDs57r0njAzOieczW3bqJo1Eh5ut
   qRknzprfCVFlJLBvm++nbZn9YoPtKyQUzCugXKXmG+xAIW6QIpFNzNhJF
   SIejrc/8bg99IBxSbkfaJG1FIrxtO58KKV+S/MfIPnr2ES+IRZtTk5fg0
   rdzp5wJ8HQ1MuK1IR1Qc9paBULOzn0U9LzQdv3xVbrESioE1pHItG9Q+8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282125172"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="asc'?scan'208";a="282125172"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 21:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="asc'?scan'208";a="598910490"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2022 21:47:54 -0700
Date:   Mon, 11 Jul 2022 12:24:30 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gvt-dev@lists.freedesktop.org,
        Zhi Wang <zhi.a.wang@intel.com>
Subject: Re: [PATCH] drm/i915/gvt: fix typo in comment
Message-ID: <20220711042430.GR1089@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20220521111145.81697-49-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+dH9khzwljbvYE07"
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-49-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+dH9khzwljbvYE07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022.05.21 13:10:59 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>=20
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gt=
t.c
> index 9c5cc2800975..c919f14c4fcb 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -2341,7 +2341,7 @@ static int emulate_ggtt_mmio_write(struct intel_vgp=
u *vgpu, unsigned int off,
>  			gvt_vgpu_err("fail to populate guest ggtt entry\n");
>  			/* guest driver may read/write the entry when partial
>  			 * update the entry in this situation p2m will fail
> -			 * settting the shadow entry to point to a scratch page
> +			 * setting the shadow entry to point to a scratch page
>  			 */
>  			ops->set_pfn(&m, gvt->gtt.scratch_mfn);
>  		} else
>=20

Sorry for late reply!

Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>


--+dH9khzwljbvYE07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYsul9QAKCRCxBBozTXgY
J9ExAJ4niV+SwtyX80S7SJNTbxCAfj8fXgCfXvmZBkMeJzbCX9v2ScqDY08D2io=
=hUis
-----END PGP SIGNATURE-----

--+dH9khzwljbvYE07--
