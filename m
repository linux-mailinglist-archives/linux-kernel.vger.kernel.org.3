Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88D5475E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245147AbhLORFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:05:54 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41917 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245123AbhLORFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:05:53 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A35EC3200E18;
        Wed, 15 Dec 2021 12:05:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 Dec 2021 12:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=OhgIRedfGWAx9cJ8qYxsz4LKwjC
        8GH8ThcJrbFThvzY=; b=ELptAK2glnmrEX/tlDCjsMGjva3Wo5hvNBMpqSxyIyK
        vIZ4Qe1hmZDhBiy/RJ2wrimEkMBC3F7C6cvc9nGrfWR7/yTYwIA5aV8h4rPmBTiU
        e++82RpaNl1bmqthgZSUcUXY+ZAfFgGktbyHii0NGwg+kWt4V9E1Pcn6kf3sQcgT
        5CyY0HHReDvVX+m9KA/+nQ85AT+h+2lUA6zd9S1oj/iwn8EZZOCm4Rk2203ZkEkI
        7SdM1kb/l7zayIuEu5UW8RcxU7twtFXDCnl0+/084FC6sD4CpC3g7boAxSiSHEuL
        Z2/bvA5Js0SowNRWrzAix82ycIyUwCdBZ5Bh5Kja3Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OhgIRe
        dfGWAx9cJ8qYxsz4LKwjC8GH8ThcJrbFThvzY=; b=aFV/ERaJbKJz0ym2JVR2XS
        8VJS+ayBjo9LdZF5Jt6pAl8hMEEdQyrkUOwDJPyxzn24NKJ2MoT++MQtGCRe91Ys
        /lcjm+YG+BokWHZ2h8eL7iSNjnVNGZcFntmcp1v9x7qkANMoIXKdIxruRoeRO6Tc
        ZEPZPHMmYnhYB2XSbb+TcFtb38MFIRWkNiX2Y8ErRzBanNW0F3jXD4ajKMpQr1j+
        BchR04euDyxvvvKJgaF8f74dIZX8K9SJ41/TXLonGbTSsDn+fyXga/fTxGw6Le+w
        k2eRpdcFiEtjWX/HVUt+57SfC6xv8ChZGvLGJyReDtMne+EoDn7ksGmCbG1mFhHg
        ==
X-ME-Sender: <xms:bSC6Yesq8s7EioXwCp0KqwA0tPgFfD3P5crdNtG-Kvi6gHuop0KnFg>
    <xme:bSC6YTeERVKpjw4vpFmo0bOiORtEln9gY1b_QDw9On2KBsr8p0a_Mhc_JHJCccN0n
    J52Kq3K4MM8eiHAKxE>
X-ME-Received: <xmr:bSC6YZwNdwjhPTn9hA5o9sT2JT2-SIsNw0gq09TFVc_lsRyplI3urRAwQyzFJXVVNkCzQuOuoBfT6P8OmBMkqbRomabrpWtn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrledvgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdefhedmnecujfgurhepfffhvffukfhfgggtuggjsehgtderredttddv
    necuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehsth
    iftgigrdighiiiqeenucggtffrrghtthgvrhhnpeegheehfeffgeekveehtdfhgfduhfeg
    fefgtdehhfektdelffevkefgueffhedtieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:bSC6YZNfnqlPaLfE0WJfreOdy721wA_ZhJXA1VYCebz_rNO7K2K4Yw>
    <xmx:bSC6Ye-HFFRdWLeqxtGKVARSXlKRnp_EArDzQx2vWgWbJ2QACm71Aw>
    <xmx:bSC6YRU3GVJQI04enPJ1HBtw_PXDcza37gmmr-Cnet_8s8JhEuJ6sQ>
    <xmx:byC6YVksty5ECBsl70hlQCRTxc5aYVMD_5AkFuU4eBTbJnpOdF4w9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Dec 2021 12:05:49 -0500 (EST)
Date:   Wed, 15 Dec 2021 11:05:47 -0600
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Lei YU <yulei.sh@bytedance.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        openbmc <openbmc@lists.ozlabs.org>, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH] ARM: dts: Add openbmc-flash-layout-64-alt.dtsi
Message-ID: <Yboga8RUoYrXoPB1@heinlein>
References: <20211210093443.2140557-1-yulei.sh@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tdFx5lleV3FJ2Qwx"
Content-Disposition: inline
In-Reply-To: <20211210093443.2140557-1-yulei.sh@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tdFx5lleV3FJ2Qwx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 10, 2021 at 05:34:43PM +0800, Lei YU wrote:
> Add openbmc-flash-layout-64-alt.dtsi to describe the partitions of the
> secondary flash for OpenBMC's 64M static layout.
> The layout is the same as openbmc-flash-layout-64.dtsi and the labels
> are prepended with "alt-" for the partitions.
>=20
> Signed-off-by: Lei YU <yulei.sh@bytedance.com>
> ---
>  .../boot/dts/openbmc-flash-layout-64-alt.dtsi | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 arch/arm/boot/dts/openbmc-flash-layout-64-alt.dtsi
>=20

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--tdFx5lleV3FJ2Qwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmG6IGoACgkQqwNHzC0A
wRmv4w/8C2hlmVW4VqsCt3oOE0NH7hh6aIlVIu7ju7PJosc9kAwljgt2be3ojI+3
+eUOGw8kkf2xv73lOf4RJWL6vQGE6R+AW6Ar1BLSxpdFkY65PVuUjq0ynnu+ezwk
W4fWFkJeFcGWEYs7ATqUfpQCSMywJtBESx4QgAyhYuY3G6EA0n7xfE38Kvgn27Sr
hi73qdg2bKnUi/yITm4c7PNmdYRKgZ1cgHIL8RgiCgDExn+OGaIPVJYxwDkKfMqL
NkriP6duCP/5LTEo9Esct/5/6LJRwLaQUuA+D+wcf0MP9e2Arja/kLeaWmeEbMFY
YqjxzQ5bnNb+5g4cTE+D4+RqRNGaeJoEbns9Bs4dUdK/Il1quovhxeRKNeDs8Lnc
3RT5o6Os+5XZe+4x5GnyxzHw4p6Dbbt0feDI84dv4IQ1Vr9J83yONzxjXXkyH82X
YKiPWxLHevLByHBzYo5FEEPKC5ePMrp/chgMEPlEOXh5zzaVm6FcG20MEeA9lCHs
878M5+UROY/+8gfx37D4JzhsjZ6FDjLi3fURJbpBuxMxFFbIQgc+lS8C+SlFlW4L
H/4puGQ7TvF84JYPnwvvBMHPJHZsrHMLO7+yrsQZuAS9gjFurtsTT21jkIVo/bZf
jwBVxAPiNWaI2Af4J6xdMHhBsi+aV8871pR5OqlSQdd/6jvKFNY=
=N7Xs
-----END PGP SIGNATURE-----

--tdFx5lleV3FJ2Qwx--
