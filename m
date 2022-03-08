Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BAC4D1D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbiCHQZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348337AbiCHQZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:25:17 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7F44F9E6;
        Tue,  8 Mar 2022 08:24:19 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E0065C0131;
        Tue,  8 Mar 2022 11:24:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 08 Mar 2022 11:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=QiZzwEJwAsqLkGpP4XLt1jLF2k2PI6EZcrR+RR
        Jgmiw=; b=M4CAjyA4pm6JW0W/znqqC+gWsxAnPWz/iYfK1clA/ajl837M4BLw76
        Z3lyuVUVAueOzrrG/oVx4Rj7ypu24JeH7uWmnFGGkE7xFsf8JLhsN8Ib0vapTjDv
        5/mPq6PWqzV8p2CUcwiT6vf20Rnu3djGo8M89DqLVJZoTt0pjgG/DpXbzx6Jr1AX
        GHS2B1y9Yn6Se0+3BG1QveqQ2sTIifMPL5VQ90vTgYdawTyDIMUSp3TD0ITS63gp
        fYVmq7cLHPPe3XjXYN2X7paq92FkOPopi917qkLab9/4G+47hehX7mkiQqwyrZ6j
        bi6DIII1klI+BxqYwAg2sg7fWtbXz+4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QiZzwEJwAsqLkGpP4
        XLt1jLF2k2PI6EZcrR+RRJgmiw=; b=e7OtT2/4WpcMSH5Bm0MwUyrcIm6EzSOSz
        lVlSdOY+9egEcGT/xMbHvMQERP/3/wAWTU1j1298SNhhfS8mNOzZnunx9EJ+XUPd
        tQISGKIWySDX4rXYux1jOw+s/Xi9ZGgb1gZbJ+isHEqZ4ohrL6m8DGznAX0zJ4Fa
        Q1wB9GmtfF6+jcuArerDiefWIdz4vnoNKoOyynmrHD0Dzc5oYuFDzY5dbxncmFUu
        FVOHBuTewl+Gx3C38P3QQDj7N+Zb5GpE2EdetTL+Aul2u0jAoFUI5lBXgUMzG0BE
        syuREor9Up+XzAEidLo7M58P8F1cAW/Prouanx6p+leSqNjXxkgog==
X-ME-Sender: <xms:MoMnYjbqBQQ2exdi4X2-uGRhfZJEw1MLiGpdU1qRIHXoQ-C1pnMjDg>
    <xme:MoMnYiZZrwyRFQraVicdj0MCQtgemkcllu_MqU_pKRqPhDlKQT5dYQhUjFKAbk_ev
    PhkwkWuNemmrslYmWU>
X-ME-Received: <xmr:MoMnYl9xKQtD1Z6UreYSS3_a74rggNjjeWAPt0lfcleb8BOgRZ3-MV2Fhj3Gx47ANTEdusFnYZbpA_tDeZ7SbBtHLUIXCupGPgLfKF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudduiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MoMnYpoL-CYL5Lt70meY0YsoUeH5s7I9KFBm-ktzqthGGPf3iuec1w>
    <xmx:MoMnYuoQRexcfAlYC1YzqFzuoE-1Kw25PITCYneaLuXdrZ1hD4qMeg>
    <xmx:MoMnYvQLOat0fZLE6vh5kStxHyD1yZ6rc0y-NMzlngG2pXZxlbhG5Q>
    <xmx:M4MnYl2RBd8DG0o5RLDp4SwvJeb5RPeykirmE6wEh1B6Uc9Yh0mtcA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Mar 2022 11:24:18 -0500 (EST)
Date:   Tue, 8 Mar 2022 17:24:16 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock at reboot?
Message-ID: <20220308162416.xnrlys6utylzb3uz@houat>
References: <20220304104942.lypg3wvlgk2ywi2t@houat>
 <YiIfCDjOIBoM+KlB@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ofuk2vyimjb5u44"
Content-Disposition: inline
In-Reply-To: <YiIfCDjOIBoM+KlB@kroah.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ofuk2vyimjb5u44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

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

So it turns out the reboot stuck issue was a bootloader issue that
wouldn't detect the ethernet phy after a patch was introduced in 5.16.

So nothing to do with the lockdep stacktrace, really. If there's indeed
a locking issue, it doesn't seem to affect my system.

Maxime

--7ofuk2vyimjb5u44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYieDMAAKCRDj7w1vZxhR
xVjfAQC5pD7MyFRlK/jhH1bEioWD6ziYy5KSW+Zj/OG2mDN2sgEA3Ed+trkaED06
H7lSOp1zQo9aFaSBq6eSyNhep2RV/AE=
=u/9r
-----END PGP SIGNATURE-----

--7ofuk2vyimjb5u44--
