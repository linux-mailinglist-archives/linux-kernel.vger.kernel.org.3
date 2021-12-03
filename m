Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638F746798A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 15:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381521AbhLCOlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 09:41:03 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38543 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352361AbhLCOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 09:41:02 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9EDDE58017A;
        Fri,  3 Dec 2021 09:37:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 03 Dec 2021 09:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=i+PDizJ4CygpKjnA6GeSt+T0s59
        0lhPcJnx/bPZhFRM=; b=J4jfRbK2W0THIdVkbDLJx6o7KjK428mCbchaoQWCtED
        aJxs3mjZxESxpigGG6Pu7/FCOOFiLnhHFMASA2E/2vzTE7dLWHaEocBSAecapGns
        v/GgTN7mpVdj3daGcFe04TILklv7Z4AjA8CW1SLDpbI7UjVQU5GA4GqvZnc9WH8o
        zOq4SlZUhjCvuDk8b1hpkG+ggIrS0d0XLAMUa0VLYtIW+PkSfqX7CrEFC28g2X3d
        6c59U70mAaf2VrWYFu/6ITh3rO+80YLn6UwF14+pNFIxGE3TUjBMxM6jMKolmi3y
        XcorOTdFCwras1vM56pEBO4AEt0sZ+BckmgLKxUANlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=i+PDiz
        J4CygpKjnA6GeSt+T0s590lhPcJnx/bPZhFRM=; b=C/rT67gmxFNiW49lJW8qsT
        Npf3M89Enwg5Ozfh0uTs3oGF1OgGa57tBFQLtInIEwNBs4BaUHz7LABFVVT2dONm
        sluQ4ozF3f7AzsIM/E1LvlbNrwmmlaiWptkdl+9ATfH0nN6Vl3PdnwCpSPMFj45L
        bytURRM8YFZJluWMeHMYL6dUyN5TNvQTpgGhQ6o6rRRPhv9AhjDIOP6+TerVJQMh
        QrFha3IThGdhgjTUUmkZNmu9ktGTecxRcEyI+YXyuhF8wuxjRGKQuonxE/oKDb0C
        6Q7DQBW+NZtueWIlNd3RmqXyeRRmWVfHFD8A/sG4tsogjYTMOUyehAEsl/FL9zIg
        ==
X-ME-Sender: <xms:sSuqYVrnnQprUF-dMcQsEjVv3YCCYjwCmXWugrST_noZt3m88lZj-w>
    <xme:sSuqYXp5BP4ch2g2n6hWV8-QgnPG0ZP2S-YvRYFSpOkxT258fQ0NrYiJ8CSbpFQ9U
    qHgcAETSByssrH-nkM>
X-ME-Received: <xmr:sSuqYSOt4-w-i0sZtMYI5s9F_XLPvEed10aD4L0Z3P4ws9dQgmXofFwLrJYcKZDD5YPEsElin3lt0s8ApQ64abQtcjH9UXt7Xtyx5TOP6b3lOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieejgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeeutdfgjeeuudehvefgvedvtedtudelfffgffekledtffekgedukeejueevieeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:sSuqYQ6WpaWjTrKNkdI3nOEk_-O2I8vri1YOmeMMlfCHhLCaw4XfXw>
    <xmx:sSuqYU48fQGsdTu-kJD-yfKCpqYRXvPyLQA9UlAi44QbLTsVFFzAVQ>
    <xmx:sSuqYYhdT-NaidE9kDoeWEw5fYUmA2lYVBvXYwE4REazLm2F9FOcwA>
    <xmx:sSuqYUjiF_bvGMgFoBtm4yUOOfB7mwQvv5-qkZQvMvsVIJ3m9on9tQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Dec 2021 09:37:36 -0500 (EST)
Date:   Fri, 3 Dec 2021 15:37:34 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, sean@poorly.run,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, pony1.wu@gmail.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 6/6] drm/sprd: add Unisoc's drm mipi dsi&dphy driver
Message-ID: <20211203143734.pn4q6wft4s37ckut@houat>
References: <20211025093418.20545-1-kevin3.tang@gmail.com>
 <20211025093418.20545-7-kevin3.tang@gmail.com>
 <20211203103841.vkl3sjsbaohsviou@houat>
 <CAFPSGXbWv94vShNAQ9xfkDZRKgZTdjRzH9i60ak1NYaPW-OKgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xcgm6vftby67t4i2"
Content-Disposition: inline
In-Reply-To: <CAFPSGXbWv94vShNAQ9xfkDZRKgZTdjRzH9i60ak1NYaPW-OKgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xcgm6vftby67t4i2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 03, 2021 at 08:34:50PM +0800, Kevin Tang wrote:
> Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B412=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=94 18:38=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Oct 25, 2021 at 05:34:18PM +0800, Kevin Tang wrote:
> > > @@ -618,9 +619,25 @@ static void sprd_crtc_mode_set_nofb(struct drm_c=
rtc *crtc)
> > >  {
> > >       struct sprd_dpu *dpu =3D to_sprd_crtc(crtc);
> > >       struct drm_display_mode *mode =3D &crtc->state->adjusted_mode;
> > > +     struct drm_encoder *encoder;
> > > +     struct mipi_dsi_device *slave;
> > > +     struct sprd_dsi *dsi;
> > >
> > >       drm_display_mode_to_videomode(mode, &dpu->ctx.vm);
> > >
> > > +     drm_for_each_encoder(encoder, crtc->dev) {
> > > +             if (encoder->crtc !=3D crtc)
> > > +                     continue;
> >
> > encoder->crtc is deprecated. You should be using
> > encoder->drm_for_each_encoder_mask, using the encoder_mask in
> > encoder->drm_crtc_state.
>=20
> Use drm_for_each_encoder_mask to replace drm_for_each_encoder? like this:
> drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask) {
>     dsi =3D encoder_to_dsi(encoder);
>     slave =3D dsi->slave;
>=20
>     if (slave->mode_flags & MIPI_DSI_MODE_VIDEO)
>         dpu->ctx.if_type =3D SPRD_DPU_IF_DPI;
>     else
>          dpu->ctx.if_type =3D SPRD_DPU_IF_EDPI;
> }

Yes

Maxime

--xcgm6vftby67t4i2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYaorrgAKCRDj7w1vZxhR
xeExAP9ZFUc9viR8jVqxFYksuwT5OhewO0DsPjv856NwUpY+EQEAmIOyKr/k09XD
mqk6Hu3g1notikrNRfGp2DSQV5MkYgg=
=yyH3
-----END PGP SIGNATURE-----

--xcgm6vftby67t4i2--
