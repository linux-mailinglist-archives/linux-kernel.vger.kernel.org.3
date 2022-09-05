Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE785AD41B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiIENi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiIENiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:38:13 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7C31EC7B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:37:58 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0AAC7580281;
        Mon,  5 Sep 2022 09:37:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 05 Sep 2022 09:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1662385078; x=1662392278; bh=0O41lIsAoQ
        E7Npc7joN//WSwmuH7s7KunBYUx8/vABE=; b=X7HWNhyjGfDlsQRlHJm0m7wprr
        6MFfZlhumCRQ3p4goinni3jIkeUQf4wueWlUdIWrJ4uEKSLLsgDihlVS7h8NI0So
        W3IBZU0nCWqt6lcprZaMfQt+MdhJHQnb/fikIDm3i2mWEKS1+83DLroJ5FL8rtla
        Zsg8ziSEc1AfokXUmnhpFS5GYU80ZBOAND76jLKH2U115nexXrrE6xPnki3ot+v2
        auZcnuSPcKaQd2WIhOUsvlmmO2uAQbXQaFNLN3V38gg6kejHXtkWIpGetN5hW1sF
        3LSBVWWAshMasYkAzu3JsB75wgKmKhgFC++sTAEg98VImAOXbJogQmUo59Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662385078; x=1662392278; bh=0O41lIsAoQE7Npc7joN//WSwmuH7
        s7KunBYUx8/vABE=; b=GVlBEYLqTO4rnteutkIbGoa1BxOG7P5pOdaf/SCczvni
        Rfs3e+UBVE6kP/hQvryAZs7xMI5vGrFmlmuLiwiBg06SBrWrAtKgDFwQEegEY8D+
        XUhaOOa8h1gGUUhCGMBRWQCsmOyo2Wcf3SdsqA+75+dpPtpyB3RJX9rqDf3RvsA7
        mflQjKITUnKFVg+NQVrIWR3UMuI36HLsgJxlJfUyj+UIRyImf1t+7SxiehvdEK19
        uCDv9GLBNMj4EhFJzFnis+tcFRCZzh7bhq0C7f9eGtBhJf/nf4+Lm/Trd0k7m21h
        bNCLgGwUYSP+DcrhHzxPLYy+eQ7DPmqfrWfXZ3Y6uw==
X-ME-Sender: <xms:tfsVY8b0Kl6Ra5AnJ4dKw2JaW5T35FCq4jufnrR541SQPq3_pl7PLQ>
    <xme:tfsVY3Y4slKtxcZft9QOhBcaVSxasUXNI-SNEqtsWilOxLPalbRFyAzGkMr4FFPpJ
    nj9L4X6jjO-Ybs_bok>
X-ME-Received: <xmr:tfsVY29mxKw0OakVqKVQU4WbRe3SXGMYOXjsLA2ZG1YhBY3YUjLFhNueEvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeliedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejveefheefkeeiffegveelveetgffffeektdefuefhtedtgeejhefggedu
    ffffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:tfsVY2rD3viHBtzbhj594zPV9bmkEUUK7yOUcbvgaugvOkJGSwXIqg>
    <xmx:tfsVY3o0ZmiIRr9Omgyv00mK4GPuoifoE87tADOUFvaDAbczazTmcA>
    <xmx:tfsVY0SQCPSmnmkPUS0J6DYFUboV1uF0JCC3rrxYIVhnds-z0q032A>
    <xmx:tvsVYwovTK2UsDiFCbTKDlmUEEVG_54Vq2mKbf3iP2ZX11gGa7md4A>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Sep 2022 09:37:56 -0400 (EDT)
Date:   Mon, 5 Sep 2022 15:37:55 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mateusz Kwiatkowski <kfyatek@gmail.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 10/41] drm/modes: Add a function to generate analog
 display modes
Message-ID: <20220905133755.gcmmntg3wnecyqjq@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-10-459522d653a7@cerno.tech>
 <242d272b-5b79-986c-9aaf-64e62f6b37ff@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="duymfdwojjs2xq73"
Content-Disposition: inline
In-Reply-To: <242d272b-5b79-986c-9aaf-64e62f6b37ff@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--duymfdwojjs2xq73
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 31, 2022 at 03:44:52AM +0200, Mateusz Kwiatkowski wrote:
> > +#define NTSC_HFP_DURATION_TYP_NS=A0=A0 =A01500
> > +#define NTSC_HFP_DURATION_MIN_NS=A0=A0 =A01270
> > +#define NTSC_HFP_DURATION_MAX_NS=A0=A0 =A02220
>=20
> You've defined those min/typ/max ranges, but you're not using the "typ" f=
ield
> for anything other than hslen.

Yeah... I've left most of them because it was so hard to find most of
them, it's useful at least for documentation purposes. And it's a define
so there's pretty much no downside to it as far as the final binary is
involved.

> The actual "typical" value is thus always the midpoint, which isn't
> necessarily the best choice.
>=20
> In particular, for the standard 720px wide modes at 13.5 MHz, hsync_start
> ends up being 735 for 480i and 734 for 576i, instead of 736 and 732 reque=
sted
> by BT.601. That's all obviously within tolerances, but the image ends up
> noticeably off-center (at least on modern TVs), especially in the 576i ca=
se.

I'll try to fix that up.

> > +=A0=A0 =A0htotal =3D params->line_duration_ns * pixel_clock_hz / NSEC_=
PER_SEC;
>=20
> You're multiplying an unsigned int and an unsigned long - both types are =
only
> required to be 32 bit, so this is likely to overflow. You need to use a c=
ast to
> unsigned long long, and then call do_div() for 64-bit division.
>=20
> This actually overflowed on me on my Pi running ARM32 kernel, resulting in
> negative horizontal porch lengths, and drm_helper_probe_add_cmdline_mode()
> taking over the mode generation (badly), and a horrible mess on screen.

Indeed, that's bad.

> > +=A0=A0 =A0vfp =3D vfp_min + (porches_rem / 2);
> > +=A0=A0 =A0vbp =3D porches - vfp;
>=20
> Relative position of the vertical sync within the VBI effectively moves t=
he
> image up and down. Adding that (porches_rem / 2) moves the image up off c=
enter
> by that many pixels. I'd keep the VFP always at minimum to keep the image
> centered.

And you would increase the back porch only then?

Maxime

--duymfdwojjs2xq73
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYxX7swAKCRDj7w1vZxhR
xYNaAP9smEnRh5n1ZGmEenQrzOJSe2qrC45ne/SGvv82vvsHOAD/S1/3mpdTYjRp
q9UQRTTfatktAcjCnUHE0eBICMwRtA4=
=w772
-----END PGP SIGNATURE-----

--duymfdwojjs2xq73--
