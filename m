Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B28B4CD7D7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240313AbiCDPdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbiCDPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:33:19 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3296762E0;
        Fri,  4 Mar 2022 07:32:31 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9817D5C0116;
        Fri,  4 Mar 2022 10:32:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 04 Mar 2022 10:32:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=Eh43yP8X0SEO8EEHGYTW4XKIT2ubpI7Pl3LWD5
        Ok6JQ=; b=v3yojEpX3o1nfNT55oCmXb25fDLij3fFSj5pkVk/1SRjy6UZ5b9W3V
        OSN/C5DlPBqEdp4FofebQoKJ2apjjdVUbjiRSt+/7msaILpuU1Cy3pyLKLBcei7V
        ZJLlgA6g7AoMNSZuPgBmK134DKPHqvCO0gihUXRN6ykSBdyw8E2KsCcsWeB9O1CH
        aYYkDPH3F+jFQy6yVya9OztDFE8eXHFFvkLzYkd8nWMjhG0AnBCwfBS4R2yfxQTr
        qdqYBfhCZIqdIYeF0cSLUVX8JXGiaejQ0GfE3/jazWDG6Hut8/Fwda1RYPpM++k4
        2GfbA2jNTg+mGxmvktxI/0HHN78qlFSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Eh43yP8X0SEO8EEHG
        YTW4XKIT2ubpI7Pl3LWD5Ok6JQ=; b=lp1wdcgyU3U3Pne+TbBlxM7CfETG2hO1F
        5XWIu5JIc2V4tdsFxsHltqJpNu9MUxmpW1BJY/ox7M8SF7qP5OZZIIK75M65E7Fq
        Gpx0OhytHFB6+tmvT/MargRC5xbqMfMoayN6wFleHOPZLMl3KQ029GS9TNxQKXjo
        R4UVYrbwNmrG272A8ZdN2FPl/sHxxiO+gm/lS81xqvTlujWvnk+ASoj1b+kxaJM5
        8zqZC//ASoI/MrbA+0ZEsSIk3Oc+igl+6zenrqaWSUWSvbxgcRPNgYB7ikp1C9ff
        fcObnrPZzcH4gLpfO/6XNFH9uX+cVuwIF6b0KEL+GHJqCoe2mncyA==
X-ME-Sender: <xms:DjEiYuMU1t8so9F5N6SsZCTsjzUm83iyBFsW23KP5PqXyLTrhaOElA>
    <xme:DjEiYs_yJAhyvdrvwdR9hxIWBkph-Fl28O6-6jj_TztsOsYeM1BUz-B6ViljOwQMd
    nNi4UiXiMwYLaw8aEQ>
X-ME-Received: <xmr:DjEiYlS0FfpaFCNKKX2sGxkkXVDgXlex3-wLREaNkirYYXLPvwlJ3Tf91-2T-zajAsW86pbit6GefuLZ6mel3niH5n56-p--lT4IMWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtkedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:DjEiYuurlFX2ehQMXdW6Zv_1bwc_Z1lLv9Ae3BUeDwtPLPN3Pgsw9w>
    <xmx:DjEiYmcZqoX6uUY4sz3D8PZszUaAQDN9GUC2fQyLGhui_T6fyjnpsA>
    <xmx:DjEiYi33GfoYEUIyLKzxMorOCsS98mFfjQPO777QPFYuwBYdcIADYQ>
    <xmx:DjEiYnpMYkLeJxbXyNCzZu8U98o6sxT0re_WjlyzpLV1y1R19Uvzlw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Mar 2022 10:32:29 -0500 (EST)
Date:   Fri, 4 Mar 2022 16:32:28 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock at reboot?
Message-ID: <20220304153228.eqclo7sezczzs2t4@houat>
References: <20220304104942.lypg3wvlgk2ywi2t@houat>
 <YiIfCDjOIBoM+KlB@kroah.com>
 <20220304152042.xvyxxen6yyxgx4bh@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2327xvni644guxtj"
Content-Disposition: inline
In-Reply-To: <20220304152042.xvyxxen6yyxgx4bh@houat>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2327xvni644guxtj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 04, 2022 at 04:20:42PM +0100, Maxime Ripard wrote:
> Hi Greg,
>=20
> On Fri, Mar 04, 2022 at 03:15:36PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 04, 2022 at 11:49:42AM +0100, Maxime Ripard wrote:
> > > Hi,
> > >=20
> > > I'm not entirely sure who I'm supposed to send this to, so apologies =
if
> > > I forgot somebody.
> > >=20
> > > I've had an issue when rebooting on and off for a couple of monthes, =
but
> > > I got a stacktrace from lockdep today:
> > >=20
> > > [71721.872904] reboot: Restarting system
> > > [71721.876743] ------------[ cut here ]------------
> > > [71721.877081]
> > > [71721.877084] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [71721.877086] WARNING: possible circular locking dependency detected
> > > [71721.877088] 5.17.0-rc6-next-20220303-v8+ #10 Not tainted
> >=20
> > This is linux-next, does this also happen on Linus's tree?
> >=20
> > If not, can you bisect to find the offending commit?
>=20
> Like I said, it appeared with multiple versions across the past few
> monthes (I only ever got the trace with that next-version though) so I'm
> not sure the issue has been introduced recently.
>=20
> I'll try a couple of recent Linus' tags, and bisect if I can find
> something of interest.

It happens with 5.17-rc6, I'll try with older releases

Maxime

--2327xvni644guxtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYiIxDAAKCRDj7w1vZxhR
xYuQAQDspn9drpaNfeifQrWRO46biOfyDMm7nxzD+UpykOtIMgD8Cvvs8U6WKZTH
TVY22Xwe7LAd9UarJ3aFUfwP5Z0fuw4=
=ZLz1
-----END PGP SIGNATURE-----

--2327xvni644guxtj--
