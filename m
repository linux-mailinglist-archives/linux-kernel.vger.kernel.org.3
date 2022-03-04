Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A744CDF74
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiCDU71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiCDU7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:59:23 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AEF419B5;
        Fri,  4 Mar 2022 12:58:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7F3BB1F469EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646427513;
        bh=hTgfC44JS9v44NLsD1sg7Y1pWVGJtaRJ7sUIWmhL94M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dyP/MFwpz0UOS7kMPEvfTweRCqsKtp7dZgta3bMnXhGcc+jkvVKQZ8QoYxmpAstfR
         aC/cIHqtWLAJK2PqednXw/M9h9nxt53MOuJhaw5vZaD54OeHllhS0Uqnu4EuOcvZbp
         ZyHIXeG2lWYIj4OI2MjYS2unJscfG8H8zz4hx+rkBpDxlg6dq8H+4Qb3MZqBAXfPpc
         KTrsDUAMx8fvgBrQhZpe4yHwRqADaJ/d+xM5w8yg7JMJCTIh+gfGnBmHZKcFQ0pjLO
         dWx3FpD/uZEt3jQ+pUCV+Hvy2m90r7ZzCmM5M65e/yI0Db1gCtGT65nfdk1x2bNYiU
         nDwMoTzuVWA+g==
Received: by mercury (Postfix, from userid 1000)
        id E1C301060602; Fri,  4 Mar 2022 21:58:30 +0100 (CET)
Date:   Fri, 4 Mar 2022 21:58:30 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        patches@opensource.cirrus.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: Handle error for wm8350_register_irq
Message-ID: <20220304205830.udamvgsngin2gib5@mercury.elektranox.org>
References: <20220304015751.367280-1-jiasheng@iscas.ac.cn>
 <20220304100011.GU38351@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nyivvc77cwjv2mom"
Content-Disposition: inline
In-Reply-To: <20220304100011.GU38351@ediswmail.ad.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nyivvc77cwjv2mom
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 04, 2022 at 10:00:11AM +0000, Charles Keepax wrote:
> On Fri, Mar 04, 2022 at 09:57:51AM +0800, Jiasheng Jiang wrote:
> > As the potential failure of the wm8350_register_irq(),
> > it should be better to check it and return error if fails.
> > Also, use 'free_' in order to avoid same code.
> >=20
> > Fixes: 14431aa0c5a4 ("power_supply: Add support for WM8350 PMU")
> > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > ---
>=20
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks, queued.

-- Sebastian

--nyivvc77cwjv2mom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIifXYACgkQ2O7X88g7
+pqrTA/+PuT7os9q1eAwQg7iAxaYXRN5lEODz98SiA0Sjphxskwj4xf+M8RRPYo4
N3Fswgl6df7KiiqCsRbCaappMjvRPkU2y74dAiavo4kxytPI63DuW/CPk0E0lagm
15/Zhqj5tLKH2wBzJC54lgH7AijtPkprPQTaoNc4v6IEjiu9sS+1AipHYtlvX0Y5
e0BNATEZoT4NUn64Q2zWXD8ZjjcD4AwLqVtCpWeSRWKffw5c9fKkr6X6Tu1o7KVZ
ydwTnuJUDfLqrvxfSyzVvC93vEmvqubBMyMB7XSeNlaFCWj06f0YF4B9qN4dabFs
BsQE7WuUiFs4aI70OoEHeBBVkxH17kVgrHyYFC00UM+D6XYGJ5gEhqV0jWoj8K9c
epNGfBSmxRqrsniGc4yKrBQFr0MC7iyaMS9omQOUw7Vy5mwI1TrfW3WRB49zfLIT
DiupIuawh3VajLjwHw4/KGjUNH3d4Pk8LiuYiJZn3y6yk0gy1G/4WcnTaqRnJkyO
UtWdqEHhmmsWEtaxtwL3ZpdocBXRvscPXJ6+SAtJP3XlEskSevzHF9oMunHvxzF0
s+8M9tDjGQ05Ywh1e8WhcHcTjL1cbOzMaXpgCPEgUXszpc5KkXyGyXYAwxknH/tK
pTPOGLL2kET4zrI9QdD9EkyWe8QWWgHnsUyMxj8bKm8GedcWj9U=
=ysUY
-----END PGP SIGNATURE-----

--nyivvc77cwjv2mom--
