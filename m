Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C271F521A79
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343518AbiEJN66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245174AbiEJNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:38:36 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED7E266CA4;
        Tue, 10 May 2022 06:28:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4626C5C010F;
        Tue, 10 May 2022 09:27:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 10 May 2022 09:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1652189279; x=1652275679; bh=V6n23Qh6v/
        2jyzSVv1tn7FsIF7VHsBZB/caUq+pIMMg=; b=nYnGnjTuTItTYE14cgml9pWfyF
        BSZTajAxncG0KbjQcTvr2rQTOdPLen7jZ40XG6+e2af0TMsDqzG+5xQ7GRTh2uzj
        JFMSUEieXdFynepr4KUdUn6p2KRfMaVUap7a/MNzycoqYyZs9zHgdngdPJl8yE6x
        RhyzsnCxy3ys3ANvQ3Q733+V1zKgVsei7xcM+XRzYvfB/XiShYFunKlXAo1tPneO
        ofy0OX4kkB9w0s7wGYXAM0vTC+ot5kwd/lF+dRmRp2ZA11RArdO+i1w6CAXVjjNM
        mbDi9PHQq0FCaRzGiLIlL+rNHCXhYkrFJnQIX/6HWTTGOj8QJNf5VgVpErpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652189279; x=
        1652275679; bh=V6n23Qh6v/2jyzSVv1tn7FsIF7VHsBZB/caUq+pIMMg=; b=u
        /51tmdFk5+4+4ukJvcpU7nAQP1AEn1m7Gg0Mws2lO3DsABt8RaoXLjSrkdTHrEXb
        dut+J996Mn7gOqGUm9utPZ3LdVGhn0ZZs8PUnShhf77l+ETsqZBxjpAIZNlhC6tE
        m6GxBiyGcK0RE09Ld/8rxtXwPlk3sYDWfYk1Au//ylFMTs1lid7aGz/3qK1g79MN
        8e881/VH04RJcRnc5ucLPh1qXzOsf/9GuJvwYXxa0fHWV4U3/DK7JSRwBic4gLlJ
        24MTTNGxzw1s/PwOueY3LUpB9REi1pPPt1HSoLxmOyfOJsFNUzypMjfkwQ004xPD
        VvhQDPeX974SGUjJ686XQ==
X-ME-Sender: <xms:Xmh6Yqr_BMNg0-l-chG3sXXrMIfgqy_4iXzBtz9KGJivQSPYUCijKw>
    <xme:Xmh6YoqzgesNwJN_GFqrQbywJhrno4rIMjwvdeS2mO7UIUpEA8bxps5pxnDS9cCTa
    -TVE2Fi_cdpjkiBMp4>
X-ME-Received: <xmr:Xmh6YvPFH_S64W__4GZUMoDXFt2ERekiBzVG29-KRF2zbMYv7yRwDOJNzh4dETm9F7FL0GzPLqeLgN3dJRldF-eLvglGxElPKNykQss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedugdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Xmh6Yp4GR_jxquWbiZnqiYycMDnCL7XR4R8tHrC-jyTvQqI-A_LGrw>
    <xmx:Xmh6Yp6JG-C-QUHGCywYJ3iZuAWEqsi2Sr9pLNIxFNzoUFZ_7VuaNA>
    <xmx:Xmh6Ypgo7IscSJYi-xK6fi138IjgYH2CGQ6TJc8vIfQCE_Ld9tMmmw>
    <xmx:X2h6YuEKw_S7tOfqzAZawgqvAkrGR5R4pGegipRmF-jwbzZToaSXZA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 May 2022 09:27:58 -0400 (EDT)
Date:   Tue, 10 May 2022 15:27:56 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: bcm2835: fix bcm2835_clock_choose_div
Message-ID: <20220510132756.qmyjca53xu44iwn7@houat>
References: <20220428183010.1635248-1-stefan.wahren@i2se.com>
 <20220503145804.b2xz4etzc6kpr3fk@houat>
 <ee39ddd1-bfce-012d-5e04-448d779ed995@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iiuqzltjsvoixdta"
Content-Disposition: inline
In-Reply-To: <ee39ddd1-bfce-012d-5e04-448d779ed995@i2se.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iiuqzltjsvoixdta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 07, 2022 at 11:26:28AM +0200, Stefan Wahren wrote:
> Am 03.05.22 um 16:58 schrieb Maxime Ripard:
> > Hi,
> >=20
> > On Thu, Apr 28, 2022 at 08:30:10PM +0200, Stefan Wahren wrote:
> > > The commit 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
> > > accidentially breaks the behavior of bcm2835_clock_choose_div() and
> > > booting of Raspberry Pi. The removed do_div macro call had side effec=
ts,
> > > so we need to restore it.
> > >=20
> > > Fixes: 09e3b18ca5de ("clk: bcm2835: Remove unused variable")
> > > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > I only found this patch after debugging why the HDMI driver was
> > returning -EINVAL at probe on -rc5.
> >=20
> > Acked-by: Maxime Ripard <maxime@cerno.tech>
> > Tested-by: Maxime Ripard <maxime@cerno.tech>
>=20
> Thanks,
>=20
> does this go via clk-fixes?

Yep, it should.

Stephen, could we merge this?

Maxime

--iiuqzltjsvoixdta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYnpoRgAKCRDj7w1vZxhR
xXXWAP4unHPnJJ+pfUOyHlW0LlgxC5dGW9PKPQF5+/AGot2oNAEAgBckc8lfPpYH
RQ67UzgFYAKV6AlepFjtnRlbxpQRJg8=
=yS+i
-----END PGP SIGNATURE-----

--iiuqzltjsvoixdta--
