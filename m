Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F2553E838
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiFFJUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbiFFJUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:20:14 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DAC3617D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:20:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 84DB23200937;
        Mon,  6 Jun 2022 05:20:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 Jun 2022 05:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1654507210; x=1654593610; bh=z7m5NyH/mE
        vLKqvSJdYSlrspdh+MTs/yya0ru7N26FY=; b=af+rpan26X8+Yun8w57p1riCh5
        XUOlCx56kJEYEI2JWRfItLpwywDedqvdz376qX3rnPE1zUW0cE8bJ5jYBaGTwAzR
        jH8hbYgtKFPqkUPdalQYDIdo902sdGosO2tQo7E5Cx1KfdHPCcvfuDVGupXG0okf
        g4Peqt5vSUym4/fTccalRwVUwdIa8sGqZK5GyhnBoLvAdo04EaMETZS8FBT+Xlu5
        Z/hrluyL8cUUp5wCwiV8ZNceWuPxv01NjCjn/BYwFxre1eJgGq/zDQTj7PG9WbFH
        5lbhpOQQ7SMWE0HmnCo7aA+C3uiigXARV4DpYas6jexJQL8w2O6/zhPlJIIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654507210; x=1654593610; bh=z7m5NyH/mEvLKqvSJdYSlrspdh+M
        Ts/yya0ru7N26FY=; b=sbrGXNTxR5TdfVd9XeOtKLJTIcRoRlVQ8qFspvubS26F
        HAalrbos69dp2KTHPA35dFYv4VGyqyMvTsuRWF79eIxQ1K8G7LrdTJRkaaovl+IJ
        k6R+jmn/1dmeEzK0kHwHxHNqaSir+bco42FTjRWL0XkkLh23VKp7RXFnZi1SIlXP
        iskVPwcKfPz2e3JzqYMiNhQ5laCSbRBjnY53YfSIrvCGlTU/zf9vCKrA4BgD8Ak+
        giBzZ58DfkKib9PrnTOma3OAs3s/FZA4ts2Da9AoZvgpG1G97a6BVKeCZvVUgfmr
        iRoU1QyZr1G8zFbL/1e3AdkkjIBFbvDoA4aCkNU5aQ==
X-ME-Sender: <xms:yMadYutzqixSl1V29cRiJTAYqL1HrR3vGFnXsoxDG0WHDSAcgtcpCw>
    <xme:yMadYjeZUhdXcVHVG62DiizmNmyYyiZKoY0PUjfiB3VOgSt1ihzAB-m8SnjXw3niO
    YNAHYEDnKDdecQ216c>
X-ME-Received: <xmr:yMadYpz-5gudxZxyK7dGKdUQIxbHwxlvpUjKcO0rTXETmznh5JNdW2AXwpCNIO-9yBflmDt--fJsIggQsx4v7eMcS8HA-EyG74Vz2CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejgeeiveevvdfgffeftdevuefhheduveejieefgeejveeuhfetkeelgfev
    teefffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:yMadYpP8zd5pjLaNqCxVRXz30x0G8rRHh6WFl6XOHx3Yo15ZcWPHAg>
    <xmx:yMadYu9gaHx2mf7xxSO4g40anA1MPc6DydauAssvAOj24MAyvNtueQ>
    <xmx:yMadYhWcwt7-v2JIKGZ6Xcnn-YzsQL0x1g2r0SOIeiGW5q-l0GNUWg>
    <xmx:ysadYv0M9YM2lun4ZAsPDydP4lij1j3v1HqRor7r1UaCa3n-1Yjv6Q>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jun 2022 05:20:08 -0400 (EDT)
Date:   Mon, 6 Jun 2022 11:20:06 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        wens@csie.org, airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, megi@xff.cz,
        Roman Stratiienko <roman.o.stratiienko@globallogic.com>
Subject: Re: [PATCH] drm/sun4i: sun8i: Add support for pixel blend mode
 property
Message-ID: <20220606092006.4bgxibmayv44juox@houat>
References: <20220605154731.17362-1-roman.o.stratiienko@globallogic.com>
 <4714286.GXAFRqVoOG@jernej-laptop>
 <CAGphcdniPFdqgLcpUc88ak9GzNaCvmj_TDVYTOe2bXto-Y12FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xv3a7fv5iml6x7mx"
Content-Disposition: inline
In-Reply-To: <CAGphcdniPFdqgLcpUc88ak9GzNaCvmj_TDVYTOe2bXto-Y12FQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xv3a7fv5iml6x7mx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 06, 2022 at 11:17:20AM +0300, Roman Stratiienko wrote:
> Hello Jernej,
>=20
> Thank you for having a look.
>=20
> =D0=B2=D1=81, 5 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 23:37, Jernej =C5=
=A0krabec <jernej.skrabec@gmail.com>:
> >
> > Dne nedelja, 05. junij 2022 ob 17:47:31 CEST je Roman Stratiienko napis=
al(a):
> > > Allwinner DE2 and DE3 hardware support 3 pixel blend modes:
> > > "None", "Pre-multiplied", "Coverage"
> > >
> > > Add the blend mode property and route it to the appropriate registers.
> > >
> > > Note:
> > > "force_premulti" parameter was added to handle multi-overlay channel
> > > cases in future changes. It must be set to true for cases when more
> > > than 1 overlay layer is used within a channel and at least one of the
> > > overlay layers within a group uses premultiplied blending mode.
> >
> > Please remove this parameter. It's nothing special, so it can be easily=
 added
> > once it's actually needed. For now, it only complicates code.
>=20
> I would prefer keeping it if you do not have any strong opinion against i=
t.
>=20
> I am working now on exposing all overlays, so it will be needed soon anyw=
ay.

KMS assumes pre-multiplied alpha anyway, so we shouldn't need a
parameter to force it: we're always going to force it.

> Also it helps to better understand the COV2PREMULT mode which has not
> the best description in the datasheet. Only after testing this
> register using devmem I became confident on its purpose.

Sounds like a good job for a comment in the source code.

Maxime

--xv3a7fv5iml6x7mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYp3GxgAKCRDj7w1vZxhR
xeljAP9mEJgJMfjtVvkdDxEKuUW2ug6RTtPkaaitLKaDGcVC6QD/dXp7EEhjGu1b
XDV2tbEGEJAHonQrLQMqo8eOo3pFZA0=
=8iFG
-----END PGP SIGNATURE-----

--xv3a7fv5iml6x7mx--
