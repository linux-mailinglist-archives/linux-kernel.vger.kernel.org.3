Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD675AFAAD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiIGDdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIGDdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:33:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288718F97F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 20:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662521616; x=1694057616;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=SfejAOY8Vh2jAUqBZ0f9V/aBunIXhhUCDsNMgGKnSt4=;
  b=ZkqWHOHQ8twSwK/Lp5Eiloib1aWA3cMd4v6EOVv8pPIaXBIt77w5IG/5
   b/gOSVM0myjuWjskiyhAXJnARlB9xIZW6YP6O64YEdHUSt9Pkj4ggcifd
   hH6zmsXY5LWIeZSe8nF51njH6gn7bTpraMsBMS19lC0kQ67d+ys2xYE7w
   igknLeUy59aWEq0DRdVKkivGePP3SWO3IuEt21MAt5PyN3CSKrIvBz6nK
   Ax0Ztpwa60Os4mp+rnm5SP1w9O5Esh/vqyl4DCfv2++Z9Eju+d5iY2Y/A
   CjeZ/NdjkYxxgbXEOGaiLCx9p0xkiE+mWlYTKfUQwsyX6RsUM/912524D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="277162464"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="asc'?scan'208";a="277162464"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 20:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="asc'?scan'208";a="591521197"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.159.108])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2022 20:33:31 -0700
Date:   Wed, 7 Sep 2022 11:07:54 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, alex000young@gmail.com,
        security@kernel.org, dri-devel@lists.freedesktop.org,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, zhenyuw@linux.intel.com,
        xmzyshypnc <1002992920@qq.com>, jani.nikula@linux.intel.com,
        daniel@ffwll.ch, rodrigo.vivi@intel.com,
        intel-gvt-dev@lists.freedesktop.org, zhi.a.wang@intel.com
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry.
Message-ID: <20220907030754.GU1089@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <tencent_E1BBF05904DFB73C478DCD592740AAE0780A@qq.com>
 <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com>
 <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
 <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com>
 <YxWtfjfpNsoPUrgh@kroah.com>
 <CAJedcCzMo51aiy=Dv7zn7VmL3gwkw7JgzwAPAB2Z27C9CnhoYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kGQlNN4Ir6FkfZg7"
Content-Disposition: inline
In-Reply-To: <CAJedcCzMo51aiy=Dv7zn7VmL3gwkw7JgzwAPAB2Z27C9CnhoYA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kGQlNN4Ir6FkfZg7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022.09.06 19:36:56 +0800, Zheng Hacker wrote:
> Hi Greg,
>=20
> Alex has explained how we figured out the patch. We did analyze the
> code and found it possible to reach the vulnerability code. But we
> have no physical device in hand to test the driver. So we'd like to
> discuss with developers to see if the issue exists or not.
>=20
> Best regards,
> Zheng Wang.
>=20
> Greg KH <gregkh@linuxfoundation.org> ???2022???9???5????????? 16:04??????=
???
> >
> > On Mon, Sep 05, 2022 at 03:46:09PM +0800, Zheng Hacker wrote:
> > > I rewrote the letter. Hope it works.
> > >
> > > There is a double-free security bug in split_2MB_gtt_entry.
> > >
> > > Here is a calling chain :
> > > ppgtt_populate_spt->ppgtt_populate_shadow_entry->split_2MB_gtt_entry.
> > > If intel_gvt_dma_map_guest_page failed, it will call
> > > ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and
> > > kfree(spt). But the caller does not notice that, and it will call
> > > ppgtt_free_spt again in error path.
> > >

It's a little mess in code so in theory it might be possible but
intel_gvt_dma_map_guest_page won't fail in practise...

> > > Fix this by returning the result of ppgtt_invalidate_spt to split_2MB=
_gtt_entry.
> > >

I don't see why changing ret value can fix this issue, as it doesn't change
any behavior e.g caller of ppgtt_populate_spt to handle possible different =
error return.

As current code looks assuming that ppgtt_invalidate_spt would free spt in =
good case,
I think the real cleanup should split that assumption and handle free in er=
ror case properly.

> > > Signed-off-by: Zheng Wang

This misses proper email address.

thanks

> > >
> > > ---
> > >  drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gv=
t/gtt.c
> > > index ce0eb03709c3..9f14fded8c0c 100644
> > > --- a/drivers/gpu/drm/i915/gvt/gtt.c
> > > +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> > > @@ -1215,7 +1215,7 @@ static int split_2MB_gtt_entry(struct intel_vgp=
u *vgpu,
> > >                 ret =3D intel_gvt_dma_map_guest_page(vgpu, start_gfn =
+ sub_index,
> > >                                                    PAGE_SIZE, &dma_ad=
dr);
> > >                 if (ret) {
> > > -                       ppgtt_invalidate_spt(spt);
> > > +                       ret =3D ppgtt_invalidate_spt(spt);
> > >                         return ret;
> >
> > But now you just lost the original error, shouldn't this succeed even if
> > intel_gvt_dma_map_guest_page() failed?
> >
> > And how are you causing intel_gvt_dma_map_guest_page() to fail in a real
> > system?
> >
> > thanks,
> >
> > greg k-h

--kGQlNN4Ir6FkfZg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYxgK9QAKCRCxBBozTXgY
J1DZAJsH9UU2cPdrsdx4hf7SuJorjWTN/gCeKxA/bnVUbWogMgtUPWYV8HOG9+8=
=3CHX
-----END PGP SIGNATURE-----

--kGQlNN4Ir6FkfZg7--
