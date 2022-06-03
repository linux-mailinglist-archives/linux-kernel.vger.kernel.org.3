Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287D453CB75
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 16:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiFCOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 10:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiFCOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 10:19:52 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4463048304
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 07:19:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5F3913200903;
        Fri,  3 Jun 2022 10:19:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 03 Jun 2022 10:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1654265986; x=
        1654352386; bh=pgoZiSnqzAty0gGUl5sg2b1gr+4y+ok52CSZUbELnhs=; b=s
        aD5VBvbWjH/db2z8oHPTUNAOcujnTSV9jgaaQCTKU/lI6S9I8nGS9VkV0uriJb3H
        lU5B8QwFz75okTIFfUu8b6CqrR3QOIKas0Ie/gtJae5KlPn4H+GLmz3f2KettEhC
        U0TTOmiBYWN7r/dygmyWbENX/Re+u5cjoKt8t4Y+XoyulAlJgW6QmCo2bsWW01kk
        f4rOUgbxyIn8FCmbYPYin0N2i9daK7X3P4qDtfg4QrhVMHiaOJlwxay9sHpJKP97
        n6tz4Q4CvIK+JKvzWzG7hiF9Eu5itQrJj7K4QKALyVTqTqE7InhxxxxoRUI6btj+
        SVyPrXh05MF2+RKm8m7wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654265986; x=
        1654352386; bh=pgoZiSnqzAty0gGUl5sg2b1gr+4y+ok52CSZUbELnhs=; b=m
        STwklVkTq53ZdBXcFpxGYQlAzb7GEIkGYNgU1g/iSlmXfqHRidn1wOUIu50qzC8r
        z+MzGukeeIgtz8xTuK8aicpnkhOFy3SFYa1Q3/5BXdesp0i2M/cdI6art1c39dFC
        s0TgI/1/p+A4Zp/2yeEv35XF25NbySOQ+bnzNxwQ3ml6sM81AZxEyvrYfA2XDj2T
        TOcZbB4f5oLUo78+nEQ9lVEBFD1h7fQS4vzkc/Maj6kUQYgFnPK5NOU8vaYBjLSK
        KzeCK9yIsukI1EnKGaQ6UqMZiQZdF/iyE4ndGwHj378EfKisifvPvx9on4/OwLAU
        gWig2cWfKn7cOwgpKn7uQ==
X-ME-Sender: <xms:gRiaYqz2b-6jK6fVgUAFH5tYyZoLAZ1Qa7lCN2jMc_L6xM9hV3sj5A>
    <xme:gRiaYmSr0PPrPQxIIoUvGfWb5zTKGuYOrRVGrc0-5PdINBk9oBgbh39_VEAW94VYV
    tNZBsZDiUUwTdT7kR4>
X-ME-Received: <xmr:gRiaYsUpZfkLy95TMBHlV_kGTZkQXlx245HgZDNPdXoJP76cxADc81sJfy-x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleeigdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeefhfejveejfefgfedtudetvdfgleethefgvdevueelhedtheejteeuheeh
    geeikeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggt
    hh
X-ME-Proxy: <xmx:gRiaYggzGbB8-kfUsokcQrt3Iq4tg2npzWMmna9lRrXJwfLegnaiRA>
    <xmx:gRiaYsCuN9a1lOnv0bnzn-PfJx5-JQutnJ_pxBONZ4CiwkxPvXMyCA>
    <xmx:gRiaYhKEnFaVUIxDYykDH7nqOEbuHdHk2S2BHb2KHhWbJiJfDo85EQ>
    <xmx:ghiaYsslgSXOzPaQBvGXUzAjIygdybVm31i7lgAVX1RoWY9-lMCuCA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jun 2022 10:19:45 -0400 (EDT)
Date:   Fri, 3 Jun 2022 16:19:37 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     wens@csie.org,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, megi@xff.cz
Subject: Re: [PATCH] drm/sun4i: sun8i: Add the ability to keep scaler enabled
 for VI layer
Message-ID: <20220603141937.modhvsqa3urmpcxr@penduick>
References: <20220602180118.66170-1-r.stratiienko@gmail.com>
 <20220603082416.ukohug3mwzu43csu@penduick>
 <CAGphcdkPJ57bkw4nxuSnk0TD1RGW5j9M-A0ek6t1rDnMY2PS8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGphcdkPJ57bkw4nxuSnk0TD1RGW5j9M-A0ek6t1rDnMY2PS8Q@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 11:57:35AM +0300, Roman Stratiienko wrote:
> Hi Maxime,
>=20
> =D0=BF=D1=82, 3 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 11:24, Maxime Rip=
ard <maxime@cerno.tech>:
> >
> > Hi,
> >
> > On Thu, Jun 02, 2022 at 06:01:18PM +0000, Roman Stratiienko wrote:
> > > According to DE2.0/DE3.0 manual VI scaler enable register is double
> > > buffered, but de facto it doesn't, or the hardware has the shadow
> > > register latching issues which causes single-frame picture corruption
> > > after changing the state of scaler enable register.
> > >
> > > Allow the user to keep the scaler always enabled, preventing the UI
> > > glitches on the transition from scaled to unscaled state.
> > >
> > > NOTE:
> > > UI layer scaler has more registers with double-buffering issue and ca=
n't
> > > be workarounded in the same manner.
> > >
> > > You may find a python test and a demo video for this issue at [1]
> > >
> > > [1]: https://github.com/GloDroid/glodroid_tests/issues/4
> >
> > Please describe the issue entirely here. The commit log must be self-su=
fficient.
>=20
> Commit message already states "single-frame picture corruption after
> changing the state of scaler enable register", therefore I find it
> already self-sufficient
>=20
> Also I find demo videos and link to tests useful for the followers to
> go further with investigation.

Until a couple of years, where that URL isn't valid anymore and it's just u=
seless.

> If you have something specific in mind when asking to enhance the
> commit message please say it.

What sequence of events trigger the issue, what issue it triggers and
why your solution addresses it would be nice

> > > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 12 ++++++++++++
> > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c |  4 +++-
> > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/su=
n4i/sun8i_mixer.c
> > > index 71ab0a00b4de..15cad0330f66 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > @@ -27,6 +27,18 @@
> > >  #include "sun8i_vi_layer.h"
> > >  #include "sunxi_engine.h"
> > >
> > > +/* According to DE2.0/DE3.0 manual VI scaler enable register is doub=
le
> > > + * buffered, but de facto it doesn't, or the hardware has the shadow
> > > + * register latching issues which causes single-frame picture corrup=
tion
> > > + * after changing the state of scaler enable register.
> > > + * Allow the user to keep the scaler always enabled, preventing the =
UI
> > > + * glitches on the transition from scaled to unscaled state.
> > > + */
> > > +int sun8i_vi_keep_scaler_enabled;
> > > +MODULE_PARM_DESC(keep_vi_scaler_enabled,
> > > +              "Keep VI scaler enabled (1 =3D enabled, 0 =3D disabled=
 (default))");
> > > +module_param_named(keep_vi_scaler_enabled, sun8i_vi_keep_scaler_enab=
led, int, 0644);
> > > +
> >
> > It's not clear to me why we would want to make that a parameter?
> >
> >1 If it never works, we should fix it once and for all and not allow a b=
roken setup at all.
>=20
> It's a hardware issue and can be fixed only within the hardware.
>=20
> Current patch is a workaround that if enabled can cause increased
> power consumption for existing users. Therefore I think it is better
> to give existing distro-maintainers a chance to test it prior to
> delivery.

Except distro-maintainers are likely never going to notice that flag
exists in the first place, won't be using it and thus the issue will
remain.

Maxime
