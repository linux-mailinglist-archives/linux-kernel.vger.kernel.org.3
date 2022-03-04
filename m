Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7884CD78F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbiCDPVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiCDPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:21:32 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D091C2DAF;
        Fri,  4 Mar 2022 07:20:44 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 50AA05C00E4;
        Fri,  4 Mar 2022 10:20:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 04 Mar 2022 10:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=vIOBFqmGHHo0UGS3jXq3FKUx9xG43+y7JD+VWa
        wm0Dw=; b=OigW6W3YpZj1YaMTKg4Hvrl/ywVsbzbfzJrLHNiPzWCCgwzM99Ha4a
        5PwNCRCXTwAsEzCYyKFIBX6C7qD0tJI8BbssdC5XuKR+ElPbONF3ch3Z4C2GZuTR
        Fgl3G0dZEGg0zwu2v6B+On/PQC54LlggPLb8fx10gCKk0OuRuYHAFI5E3fTC6w4B
        NGKwYplXlGDIJgo3PFMcw8UQJpvs1qnqphz+pouAdts9dQq+ErJOmcX+R+k3yFzK
        3gEJUD1sbco4aecnoADPClYU1c1d1wX9Lz4hiCGX5cyBnvu7pOJcr/I/Nxk0sOmr
        1HGPlqAFaaETz4eXNMmpS0rBy37PPC7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vIOBFqmGHHo0UGS3j
        Xq3FKUx9xG43+y7JD+VWawm0Dw=; b=Y0ApQ+DjHyLPMXff6myZ0QSzB/QqtniwH
        RM5pgdDzgWXwIlJScj6rdju71iHLroPQLMJ8riWuEZ5EHFKR84kGrIae8JOHmCgE
        44DsrjyVq83I+zEBFJrNmKQshGVfoX0b0vr3UqheYO5KYfKnjZVo43CjZTes7ROw
        lcUBvUM1X4zgFR1TeYE9Q6ghgb+/YDi0s86OVz4ZlqdTogv9hbCc7EMc6EpN0ia/
        ltLkiXeCk0zOaLeX2/jWWjLRXHRlC+OISRVmHC7HD5I9F8DgVpGLPAvKCu1+njlX
        ycFvn7V8PhkPrI/ozLUVExApsngwpV+CuF1SWAzkqT9f4Unu0nBTw==
X-ME-Sender: <xms:TC4iYtE0MkYvafikIlPgIQoNhBWR16DngjbSkcG2n0eJ_aj4RaqibA>
    <xme:TC4iYiVfdjVRTmY9N5zVHC07e1ymvPO3xJoRhh6V7wEQsRAF7A-ZA9AhlqrmsguKZ
    xC_hPblj_B4rZHzwA4>
X-ME-Received: <xmr:TC4iYvIYXuB-gXul1KczT0HC4Y85KPWxGjGvK73VGFtA9ZryXG0DD6PpqdWnGcICIkl0HoiCri7U7h0WUzuypKuYS5qHk79dohmjoDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtkedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:TC4iYjF3dTK0tOEXDYEgVBGtKroH-dwYvEPz7DqpJASZ4XjeVut-nw>
    <xmx:TC4iYjWKiaAVfTiHgUfCQJl-XpvOpCpmQByzGNa7amnl2LcF-GrVtw>
    <xmx:TC4iYuMSfsyvGCU--hs06m7ZwG-kyJqmysiafhH8B0vFuPOxggElYA>
    <xmx:TC4iYgjJBcDHMuvc25JYlX5Uvvdu53XZLG2qmP-F5LABxsoSpYnM_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Mar 2022 10:20:43 -0500 (EST)
Date:   Fri, 4 Mar 2022 16:20:42 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock at reboot?
Message-ID: <20220304152042.xvyxxen6yyxgx4bh@houat>
References: <20220304104942.lypg3wvlgk2ywi2t@houat>
 <YiIfCDjOIBoM+KlB@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="juluxzd2zb6qbxib"
Content-Disposition: inline
In-Reply-To: <YiIfCDjOIBoM+KlB@kroah.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--juluxzd2zb6qbxib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Fri, Mar 04, 2022 at 03:15:36PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 04, 2022 at 11:49:42AM +0100, Maxime Ripard wrote:
> > Hi,
> >=20
> > I'm not entirely sure who I'm supposed to send this to, so apologies if
> > I forgot somebody.
> >=20
> > I've had an issue when rebooting on and off for a couple of monthes, but
> > I got a stacktrace from lockdep today:
> >=20
> > [71721.872904] reboot: Restarting system
> > [71721.876743] ------------[ cut here ]------------
> > [71721.877081]
> > [71721.877084] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [71721.877086] WARNING: possible circular locking dependency detected
> > [71721.877088] 5.17.0-rc6-next-20220303-v8+ #10 Not tainted
>=20
> This is linux-next, does this also happen on Linus's tree?
>=20
> If not, can you bisect to find the offending commit?

Like I said, it appeared with multiple versions across the past few
monthes (I only ever got the trace with that next-version though) so I'm
not sure the issue has been introduced recently.

I'll try a couple of recent Linus' tags, and bisect if I can find
something of interest.

Maxime

--juluxzd2zb6qbxib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYiIuSgAKCRDj7w1vZxhR
xc/UAQC3WpHrYG7Eraonkvops0X+FDslLhHBUExENK4OLSq6kQD+NCD6Ho2qkD6T
k8zpK2/sUk2zCkUnHRry4j95sB64wQc=
=d/DZ
-----END PGP SIGNATURE-----

--juluxzd2zb6qbxib--
