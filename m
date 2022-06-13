Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE64549E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347457AbiFMUAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbiFMUAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:00:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5CA4A91A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655145090; x=1686681090;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=PA+RJfWey2I595Esrv3rrJOEx2AlZ/fX4Ur/wV2CUNU=;
  b=lEcahN0NJVkan/AVzP3uM7ASNV7XX4bOBgXu+u6j1pBZvkIQNNKjAete
   Izx2IE+OPQv/aFbca9YoO6fzt0+rD1+IrAwrDIsOVv68+X4Oj3BDpK50I
   zX1IiPkEKOgPqcHZ+KbID70XElMqa56dyQz7vuEFI7gStFY6nsTX3wSJA
   VYVSlyiMx2LOhmbIM5qWXD7s637uX0+C8MCE9z/SrzWwDHD3m9MdPl/oq
   xU88HAIr0UUSfvRRBSf7EjHTMhs8OZwSDAkMX/4stqEBqbXDdsmSq6HSp
   w99l9qudjcsJp4jP1ysu7BZNcwDovY4CsK3WZSSW/Nh2d7nqI4lVjY84H
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258204200"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="258204200"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 11:31:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="639878137"
Received: from njascanu-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.149])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 11:31:26 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Jos?= =?utf-8?Q?=C3=A9_Exp=C3=B3sito?= 
        <jose.exposito89@gmail.com>
Subject: Re: [PATCH v3 1/3] drm/rect: Add DRM_RECT_INIT() macro
In-Reply-To: <20220613171738.111013-2-jose.exposito89@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
 <20220613171738.111013-2-jose.exposito89@gmail.com>
Date:   Mon, 13 Jun 2022 21:31:24 +0300
Message-ID: <87bkuwza83.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022, Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com> wr=
ote:
> Add a helper macro to initialize a rectangle from x, y, width and
> height information.
>
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  include/drm/drm_rect.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
> index 6f6e19bd4dac..e8d94fca2703 100644
> --- a/include/drm/drm_rect.h
> +++ b/include/drm/drm_rect.h
> @@ -47,6 +47,22 @@ struct drm_rect {
>  	int x1, y1, x2, y2;
>  };
>=20=20
> +/**
> + * DRM_RECT_INIT - initialize a rectangle from x/y/w/h
> + * @x: x coordinate
> + * @y: y coordinate
> + * @w: width
> + * @h: height
> + *
> + * RETURNS:
> + * A new rectangle of the specified size.
> + */
> +#define DRM_RECT_INIT(x, y, w, h) ((struct drm_rect){ \
> +		.x1 =3D (x), \
> +		.y1 =3D (y), \
> +		.x2 =3D (x) + (w), \
> +		.y2 =3D (y) + (h) })
> +
>  /**
>   * DRM_RECT_FMT - printf string for &struct drm_rect
>   */

--=20
Jani Nikula, Intel Open Source Graphics Center
