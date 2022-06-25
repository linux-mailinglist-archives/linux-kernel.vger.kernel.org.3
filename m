Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD1755A80E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiFYIQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 04:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiFYIQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 04:16:37 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC62132EF9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=5V6BSymDH1McbiKZ/xluLb/pdnkM
        F+FkNit2fs4ZrCs=; b=WXjMsMmmRB5XqQ29xvQymoPX/rAdcvQEn00DGBnJyW+D
        uJpC6K414X9MPgRp8firZYv612qqVJPsp5ksBnWUrLiK4gwozK0G0CUkc1VcaQ8D
        wSonuzG1g4uQ7jD5NOYVmA+zAWHN1vrPJHDXxx5npDFrfBbUS3IFVWkAhArTH1s=
Received: (qmail 1730526 invoked from network); 25 Jun 2022 10:16:34 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jun 2022 10:16:34 +0200
X-UD-Smtp-Session: l3s3148p1@iT4LTkHiT7wucq2i
Date:   Sat, 25 Jun 2022 10:16:33 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3 2/2] mmc: renesas_sdhi: Fix typo's
Message-ID: <YrbEYbLkE4pk+oh0@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220624181438.4355-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220624181438.4355-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3FbAJhIAQpuHUDQY"
Content-Disposition: inline
In-Reply-To: <20220624181438.4355-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3FbAJhIAQpuHUDQY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 24, 2022 at 07:14:38PM +0100, Lad Prabhakar wrote:
> Fix typo's,
> * difference -> different
> * alignment -> aligned
>=20
> While at it updated the comment to make it clear that Renesas SDHI DMAC
> needs buffers to be 128-byte aligned.
>=20
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you!


--3FbAJhIAQpuHUDQY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmK2xGEACgkQFA3kzBSg
KbZN/Q/+NTB0ZETpR6A8plpIQaeCyq4O3v6ODzQvcoeRb1fg/ME1/C+1um++EUvm
voqBAzePAcnHzQ7RasVYaNFM/Tdm1uHpkzaYz0Fpow6wknmaC3rSGO/Vx/0igpJ3
KTsSXEVhvuv7po0ruuIhxqm3CAxPMwOi1owFFtHl77QY5/igRiaAH2aEQUKh2cWM
EmlvF9b7g65swIgkZTaWY2s20+vGsQnVAKWDJxX4ayb2RXLTw2H4g/jNjR+tLXU2
ooj4sqrGyees7jYqdYyENZI9odLnD3HK2+ulqsnE03aI9htLwa/5pK+x6/mgsDSs
4/S3EeXCZ4cqvADCe6LAoz6x9gmoEEd/0YMqqfTFwuEEMwlxSQ0ptYTIsePuHAi/
xjxLRX/2LNDKTDAY2ID7kcUK2SJN16gZ7FMsptDc1p8WG+TIMXw9MXuWZcOsL7uP
fITP4M+QS77LF+I2fQMISfQtfaQ0h76I6+o4yW3ncgooptKdh4TIx23g2lIKZCwF
c8dS90YG5H/YZf8UuI+oaVwgWFLNGs7zODTpB07ikhTTBgDV23PulPWgr50k1m2Y
HN2yngTjjuJBxp1eMQZSo1tQZ8FvYxbxd/FMeWL3u2f2rONO/EGiQptVDPc27cCR
B6dBLP0UzjXkX83M8n/19A5qV46bBzwPXIBvb/4cS5YrSespx4U=
=oXPX
-----END PGP SIGNATURE-----

--3FbAJhIAQpuHUDQY--
