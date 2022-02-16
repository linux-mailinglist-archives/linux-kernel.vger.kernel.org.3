Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE3C4B83F5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiBPJRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:17:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiBPJRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:17:43 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DB321F1E9;
        Wed, 16 Feb 2022 01:17:31 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BF0D33201F86;
        Wed, 16 Feb 2022 04:17:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 16 Feb 2022 04:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=qsR1J4DV2a5/LauMmqRZ3xIwqaxibZ4KiJxVcK
        3xHgU=; b=ayhgPKtsysFcxf2i/DdDw5JCrt8RneelVY5rh333UKnjeA1o7366b4
        9/5YvAg8bfkjiy9LE1N/cCNtqt7osA1us3Vy9tf5xgSBBqZOpgJxF4OzWq/nGGAP
        JQGThcJVm0+70k23Eo9qx4ICAk3v0fKxDpefoRnE9T22T12h2dhO/d/HXp+/gWM8
        fr04PzJQvX6TbuTLQDiaW6+VAx149pawJG6RgRvl3DX4W2nU9B2rqWQYGzrpgdRf
        SshCh7QWSJURTwpB8KgUXnGCCKPReZrU9cZF3XG7QwO+ethXrwwRVRM3TgtYr1zC
        ktfAzPSmESWAxVqHT7krpiSupCGkBWWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qsR1J4DV2a5/LauMm
        qRZ3xIwqaxibZ4KiJxVcK3xHgU=; b=FqWDBGbBRdkGyQiFbJnayNJmN0BcW8AIb
        OTvdafPl+2kMexVmG3g6IoXTZmSTe/5RP+vb+eM//mtGy0hSisaw1lZhuvjU1xAi
        +/oENwaOJJaFm1s0yc7UgZhz5Ous1QEiDDXJwgbNYW+jM1b8mCbmJ0koIUYGxoxa
        zG7duUE7YySbuFvEq9lpP26Fn935WTvHnBadVmbgs8mjIMwXTEdXH5lSVOxFT6uu
        CZltQqMNTYvdusT16V6tGSD8lpnJM1sHBDVFDTXdW74SlDozfvdHOdcJmEsnHuhX
        WGp5Z1VbEw3aP3teAWpa7STihurpuP9UIrOs5yv6WrToJum+GvfVg==
X-ME-Sender: <xms:KsEMYoHremJAFbdKus8j9YvuA2qY6UGSnufZY_GN7WYMlSZ-w3gQWg>
    <xme:KsEMYhVIzp6kZHeevh5koZz8UeQGqtuTIsNHMFLh8vRQCsn6dAVNluYph39pXDxRT
    5FH5FT6-7ZFrE8v23g>
X-ME-Received: <xmr:KsEMYiLnU5Mu-TP_Ad43YvsNz14DwcPmdvinN6anZojg30nwNuS8EX_ksrtwmGIBVA7webAe0WZOlWXasC1x3MSCWBIV9rjFcsywg1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:KsEMYqFhnfAJSBbmb7_8ysPey9d6E25kA3BLQJu_pujTAlZzsi0mBA>
    <xmx:KsEMYuX7aLMUdKWaiLmJfL-cYnBvKplQyueGKK8QNGE5eBviS814rA>
    <xmx:KsEMYtOaBQTHM4MQLbJn6LcZ3ktMQFcLB77XuHhK1Ab3Rp6jz2idKQ>
    <xmx:KsEMYircMsN74mUMMja4JZTb2CLEy_uhaaIv4LRHsV5pyJrnEvMAVw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Feb 2022 04:17:29 -0500 (EST)
Date:   Wed, 16 Feb 2022 10:17:28 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 6/6] dt-bindings: display: ssd1307fb: Add myself as
 binding co-maintainer
Message-ID: <20220216091728.3cz2zxvihhnexp4h@houat>
References: <20220214133710.3278506-1-javierm@redhat.com>
 <20220214133935.3278933-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rrwezfnafowcbwm5"
Content-Disposition: inline
In-Reply-To: <20220214133935.3278933-1-javierm@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rrwezfnafowcbwm5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 02:39:35PM +0100, Javier Martinez Canillas wrote:
> The ssd130x DRM driver also makes use of this Device Tree binding to allow
> existing users of the fbdev driver to migrate without the need to change
> their Device Trees.
>=20
> Add myself as another maintainer of the binding, to make sure that I will
> be on Cc when patches are proposed for it.
>=20
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--rrwezfnafowcbwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgzBKAAKCRDj7w1vZxhR
xT4iAQCF5oEz3DtvvZKcTveObsVmtL6t+phZuQfEcF45C9PnTgD8CCq/2LT9cU7t
Mee4yteC21yEVsE+i/YzUxaCod6+Zgo=
=MXq/
-----END PGP SIGNATURE-----

--rrwezfnafowcbwm5--
