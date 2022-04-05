Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D29A4F2238
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiDEEtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 00:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiDEEtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:49:11 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298499FDD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 21:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Cbu5imkSxmYw8BD7MxQU3rR2N6h6
        Y4uRLJS6hFCxJB0=; b=uroHnEP3KHV/eYhuNvbJOVEou/nJHePNgdHzii+CfUnW
        DrOF4BRUlcjVXePd9soij7tZg5gwyUoyiFcVicC4pcmU4uLK7CTT4VtezkmHUB/c
        /grlmS+lCSMPyZ1Z/K4xpVkHdRYvRCmlTGqGck35EsxI2Vv1yLMWyUJajG0+raY=
Received: (qmail 2125024 invoked from network); 5 Apr 2022 06:45:22 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Apr 2022 06:45:22 +0200
X-UD-Smtp-Session: l3s3148p1@Diph6eDbFNwgAQnoAHlrAKkk7l/QScWc
Date:   Tue, 5 Apr 2022 06:45:18 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 2/2] mmc: renesas_internal_dmac: Fix typo's
Message-ID: <YkvJXu7Y6Tc68U9e@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404172322.32578-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Yks3Q75ZrUkXSjwz@ninjato>
 <CA+V-a8skF4h6yhjSFw5PXQEbgKEQt6kMs9bEsO3OCNfE1hu46A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XGw+3cSwhZWV2vXx"
Content-Disposition: inline
In-Reply-To: <CA+V-a8skF4h6yhjSFw5PXQEbgKEQt6kMs9bEsO3OCNfE1hu46A@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XGw+3cSwhZWV2vXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > > -     /* This DMAC cannot handle if buffer is not 128-bytes alignment */
> > > +     /* This DMAC cannot handle if buffer is not 128-bytes aligned */
> >
> > Well, as we are here now, I think this can be further improved.
> >
> "The internal DMAC supports 128-bytes aligned buffers only", does this
> sound good?

I'd think it should be "128 byte aligned"? But I can't explain why, just
a gut feeling.

Otherwise good!


--XGw+3cSwhZWV2vXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJLyVoACgkQFA3kzBSg
KbbStw/9FM9rKMQ30IKzCdiUkW37SCGDxC3zsb4B8ekiSgarbLM4gTKacYLVB0SE
N8CAHx/Zc33WxgmVXx0UOWmrzN24zEBq1NtH20I0+Bvspl94UZ7XbLq3eJ53fbx+
1d5vnZFyo0Je5lFGlUy9aKAsMfKG+Jk1lI6uAFsJR8t/D7e0s1b3i9ZUB4U5bFAl
fHAXT/ZvTl3cnX9vLcoeH+DWZjBYqU42JI4qqof5aVdN+pbDialUOuZvqUyvKHUM
t9FHV/mKnnGsMOycEX6Cb4hGEB9xNOJjuxXu3gw93WZHH52UQAKG80OFbtdggT/e
78rIpPlzwDNmYd5QXc1aGECHRfH2jCu5pDitk/8uRjSxs3gKyHe6noaQ4DnYNi8c
JKG9X6KsQlf+5M3OBgOdRM2Q9sMTv00l07av9dxfTiS52fPEBxIbRlhnoJ7XKEn8
4NgcNN32sQ5hu2pKQyKpT+o1LQ94K/1m3UHSl26/ggtrWvr3P+ybCKG6lUpElsnm
q6QV1lBjY+8Iq4Dgx9OSh4a5ZxfTaSjeq/SrDgzkTRiD2nyEs7NCnNrcdZwIbYWA
q0rSBHDedP0Oqe6JpgcJfOJxTPYPF9T1PItSpp8fYIgVBFmOnzScmp7nRG/E7aPg
DOSmkYW1svjwtJsWXLvfV7gFs+q847A3STZexo+A8BHc0JJVTVE=
=lfpM
-----END PGP SIGNATURE-----

--XGw+3cSwhZWV2vXx--
