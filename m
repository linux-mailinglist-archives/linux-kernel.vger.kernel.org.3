Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133B250DE17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbiDYKos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDYKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:44:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7157839174;
        Mon, 25 Apr 2022 03:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650883294;
        bh=eS5xgqerK1TiBIx9t59uxIQwu9PVi7U3ty9Nd3fK92Y=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CraBjXnwikjdKu7+6znmXNu8P1Kh4QrEMvEWyl2snKBvnLXVstCUARaLcOzJaDO4t
         ZSiw7aQaWsEuXYRNqnSAU19HjwZnu90hF5+RbVscjGqqrBTlYPLGbFF1ZFZrnewPU+
         PpjhZX45Y9wwjRVLF2/tza7MWrReKkuLbGvcFK5Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Wyy-1nmDwP3yHU-005WbX; Mon, 25
 Apr 2022 12:41:34 +0200
Date:   Mon, 25 Apr 2022 12:41:31 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2] docs: media: uvcvideo: Use linux-media mailing list
Message-ID: <YmZ623/GyPf4XPcn@latitude>
References: <20220315221007.1045878-1-j.neuschaefer@gmx.net>
 <YjEQz1GhLV0Kf3mO@pendragon.ideasonboard.com>
 <YjESZwTHRuD4pBkY@latitude>
 <YjEVzF1NMWJZ1MQw@pendragon.ideasonboard.com>
 <YlrhavU2K3neXNEy@latitude>
 <YmXS+2co6XGEDIDm@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kCejIUofgrTY23p2"
Content-Disposition: inline
In-Reply-To: <YmXS+2co6XGEDIDm@pendragon.ideasonboard.com>
X-Provags-ID: V03:K1:x2uV9GpYUBu/QLpjOhHhx8gG6ofbBeKj5cNda7QKN1y2Th/MtCK
 mIYmxYI0XctqyMU8p1ZSBCfJ7NRgXJ0yV+a2YpaHIREfybayun25d1J9rVZUE6TD7/asKlL
 o6BcJkIkHnZ2w6Nh0EJSyUM/jqCd5ZgmlLGsq+cNf0WB1r0te9SQgU0INgGLXpVoJxD3JI3
 W4z1uEdooId8PJTIiJZYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f5o7mwFOnWU=:5ghxKSst1SS6P8U1/0LJ9Z
 su7WcLSMfPkWqiD229zLLqRd3Ph3/fe1d2NRmBjule2vL9uodVrkGbq82nr7ZSXyC1XmBbRQp
 v2Owdjx0kNauTBKqXFttYyZ2ay8VKLDbcwlQ1Uuuj3vAy7paqv8zv2WcqSV4crDVQdUOonE36
 aV4BQt2Whk7mHePOg2lIVfrekqJ+pawM4z4cnmTiDzfUu4mtE2yYFXkLzlCwbfsveceVLkvNS
 IFtSa+/0z2fZfYneylX54AqlNujdRrKMKy7kjujQgg7fUE76pMu75YkkW4yLyOiGPVKkY06Nl
 IF7deWkFBy6thhlplo7ONVJDl/mLAIdsFKBcQMr0z+fUa1B+e9OTaJEtqlTNVlHBZgTN1w84b
 sDu+R94K97VxxrMSctr/+Zgj+FvVwE66E0AAdj+p0AF9ndblv/zPS1w1Ty4WgtuvslVff67Ed
 GKRZj2wv44uUYYSso1fIpkZ9/WqWGe1uj8JpPqw+0I1s8Jk8KBOv2ET9okSYhYlaNHWoEmjrB
 nbTs4mi1LtHEuwe4QRxIqeExHp+Dlq1IeKeOLM5H62hsvLa2wv6zs3GiwtU6nH/ZJu5GBC6rs
 +e/Vx0M36K6KApAgBFDxx2KE9TnIGxw/9K8GeOL4xs8y9H89XzPo5HexObPkdHSRLMYKyNq7x
 5ztVMS1Rwua6hVqpYuRVeVG7zfKsjk2grwk2wsiR4Ks3GAP1iShw3aHT4Si4uvc8XGHtp+78R
 SUqKCehgGtFju38+onA709uWrqtQ5cjsQQe1XootuAmiOvW0UgS73xRtEj9ihwBHtiH/1DZhu
 8GQe1agJp8b/PhtUcW7Lz6YepThTf8pA4Wz6JF1UK1uU9nPKVfztvYexpeY4D2eMTjuwbw/wD
 Oh8JKUpeAmA6DtAuf50IeN7uEB6k6qQnesI++5ybuhtbu3QNsu36ydAB9YoIptli615bdQI6X
 Qn7mBBokXAg2WCSnOd2FBk8o2oJiZJBleMtzhxIkiR7da2Fj4VA7y2bPA7Tx3hAe3pFpZwi6D
 63x3Y/rx8Qm0tI4UqdpAV7D32iMqmc0spJ7jkRUuRRWQob7GR7QxSpD/84whwXqu7IizA3/Oj
 tGoi2FYmHt290E=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kCejIUofgrTY23p2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2022 at 01:45:15AM +0300, Laurent Pinchart wrote:
> On Sat, Apr 16, 2022 at 05:31:54PM +0200, Jonathan Neusch=C3=A4fer wrote:
[...]
> > Ping =E2=80=94 I don't see this patch in linux-next. Is there something=
 I can do
> > to help?
>=20
> I've just sent a pull request, the patch should make it to v5.19.

Great, thanks.

Jonathan

--kCejIUofgrTY23p2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmJmeroACgkQCDBEmo7z
X9uS8RAAjuwukWerNeVsngMxOIZJqHZZ4TZ+wrGbvTrkyYa1/oZozvcgX631PHsv
ajUiaOHPS+UIizJ3cAj3MAlqxdIAW4KQXal044zXF3Isc6Ej9UYl2b1dqlZJqFAl
8g5cqHbTMMG6+WzqExHXf8PfWEiib+QOQoY/+Z16d8ystk0VvlBY0sq8OZkZ/C8Z
pLf5U5fiuZA0GfaQuKgRbFgPqyAgP0wCrTyCMtKjDUPI20BHl+/XbRlnkH+5YpSF
jtjDa22oXIBY38vnfHFplFQok7jb4hzcziTbhlwRuOOhaRei0qD2M3f0dyWZL4tp
oBC1h+o8RqyJm7qxmLCw06NiHhrjWaRQbYfg/6a4sdBJ2AakBC9cel+2H+EecqZq
qjiH9YqUA7hK3Q9b9Cm6836XF5kmoh279kjTxCz24w/wlrLM6PbMOw1/o/AxLtNC
KntyeX7JyvZ9Bc86AzF83JAfahPQkDgJ8E5A7yw6PZqM5Ajr6uy18TUzfR+Jb8Ah
2moVslSt942OV0nZSHkTo6rAd2gtYtq3Q/zBKXydZdJSxSltp815CmJZmVGx70k5
VIg0mKeU7m9PjxC81TCbEN9tCgwbheDyPcONBrUhTZ/yipIVekoudRUBbVWOIbGs
6GN7IuiyNcEHmS2bNAXt3A9CkVncQySSrq6OsveezuZRxebS/8U=
=ngak
-----END PGP SIGNATURE-----

--kCejIUofgrTY23p2--
