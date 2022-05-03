Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60DF51897C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239275AbiECQSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbiECQSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:18:24 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CCD3B29F;
        Tue,  3 May 2022 09:14:51 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7EB60320094C;
        Tue,  3 May 2022 12:14:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 May 2022 12:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1651594488; x=1651680888; bh=eE6eGyd0dl
        PvEc94UVUT/f7gT2Hb5vI5mPIwodd+6xY=; b=MHJ7F2iS0dRh6TQQrhw80qfulK
        aCyBP4HU+m3J5VECiyqYDVzjxopYt33olDf4huoqTjyotocx0DCV0xWL3wbXq16P
        mUxelYPlq+FpxMW0k5FexTdSutoacfEqiShu13p8rK88gwhiNASlNbn/6wQZqJAQ
        36ixkM0rxj1lnLcd9qSojHBQIXtOTFDWowLTaRRZ+mDaP086pouGSSVCJyipULJm
        U/xW4IfF2jeP2aGfbS3s32uyom9j5MaQlfpgftM/v4FumFvqZLo5kv82RKJG0GGU
        2xhIbcr7Ryd4tR+nBJUv58ma0dQau3Hgs6RMDdySpkHllfqj++OdcPYjNBgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651594488; x=
        1651680888; bh=eE6eGyd0dlPvEc94UVUT/f7gT2Hb5vI5mPIwodd+6xY=; b=o
        RwkM7FSUhkbCGGCrwqSynOQJsGCqU5G51BiDRUD6uBoo53i0Bmzv2zCB5xEbdH/U
        OZAH0akcjpp0tydSg0WLa9DfkxYBkeT7tkLYarxYO0VbPv4qdoTpLrBqO7Uoo+Az
        1Pb664/UQF060KPTEjU66YI7Ilf4mewUi3hZGsyNIsqM3MLR64ZDxYFZfTnh4HKF
        4kuv8ZuXhuPV+Wi1SOUkCSaY7Y5wC2VF9vsWukbBTJdiu7dUDAM0WkGvUPLIJJc1
        HYKRLknmI2uLyICp/KRtMtlFT/PqmeyDBxz78alKEFQdJ4KipF6WuzkVGz0W2828
        eKNu2u2QRRVjSxofedOIA==
X-ME-Sender: <xms:-FRxYuyWVZehrcvrb9cR0hhjcLq3-bj_OlfH9jWMMwp_pzjJsdr_NQ>
    <xme:-FRxYqRmj2aALivmWhsom-bDosv8ccQsnUaHbF9RJ9slYG7OK9kZkgd3hEO6DlGvx
    VCLAULoMvURO3MYzqQ>
X-ME-Received: <xmr:-FRxYgVk1k9Kn9fmhRmC__Sc3Clfn1BjrznXpYmRzdFUn2L2jm87uO1I9DzxSTFccpXFz_ATXS60giV2VEIVi7iEROaIVXG5QNIGzOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepteefffefgfektdefgfeludfgtdejfeejvddttdekteeiffejvdfgheehfffh
    vedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:-FRxYkiApGu4RvKI6SvOMNYmv2WQC6KS-n5wv0rs_KI8kezSh72CkQ>
    <xmx:-FRxYgAT7461MCUbdBcY4ByDQ2O5KpFteBv8BWnKqC6wQlI_LgjYjA>
    <xmx:-FRxYlKzw6sjuQC53yBNWFGO_9iJqK1MM-trIk-ZK_j4JWaCFqjtwg>
    <xmx:-FRxYgtDetsZCD8M60OmlUh-_NpvnzPHCOqVRzapvqMhkgFsjQuDsA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 May 2022 12:14:48 -0400 (EDT)
Date:   Tue, 3 May 2022 18:14:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ruslan Zalata <rz@fabmicro.ru>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
Message-ID: <20220503161446.tl3qoqqnkzq2f3hn@houat>
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <20220502110010.q7vvdkdpaiz5acjl@houat>
 <7433B295-D896-4BF8-87DF-87EB89D7A550@aosc.io>
 <20220502112112.3ne7zy4b6gggxzoo@houat>
 <4aabfd63-18e2-65c5-d1c2-d7600afc1c40@roeck-us.net>
 <97e3af18e947492b1ac968c058ba509f@fabmicro.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q53czbjv7t5deybk"
Content-Disposition: inline
In-Reply-To: <97e3af18e947492b1ac968c058ba509f@fabmicro.ru>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q53czbjv7t5deybk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2022 at 08:26:18PM +0500, Ruslan Zalata wrote:
> LRADC does generate continuous interrupts as long as input voltage is bel=
ow
> LevelB threshold. The max possible LevelB is 0x3C which in case of A20 SoC
> is close to 1.90V and that's what my driver sets LevelB to. Perhaps this
> needs to be documented more thoroughly.
>=20
> It is possible to implement this same driver for IIO subsystem, but I wou=
ld
> prefer to keep it in hwmon along with many other simple ADC drivers used =
for
> temp and battery status monitoring.

If you can get it work reliably enough, I think IIO+iio-hwmon is still
the way to go

The main issue here is that drivers that are decided at compile time are
kind of a pain as soon as you try to install a generic distro.

At the hardware level, I'd assume you would either use the LRADC as an
actual ADC, or use it to drive buttons, right?

So, you would have to change the device tree accordingly anyway, to
either list buttons and their associated voltages or use it to probe
whatever signal to have there.

So I don't think a new device tree binding is such a deal breaker since
you have to describe it differently anyway.

Since that would be a completely different use-case, the IIO driver
doesn't have to support input right away, it can be done later if
needed.

And you could have the two drivers compiled at the same time.

Maxime

--q53czbjv7t5deybk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYnFU9gAKCRDj7w1vZxhR
xWCtAP48uwYuvDG3xl2RWzF5C2D3hGwJp2/yzgWFxZrWWCibeAD/Wsgdx1c84HUJ
tIvyginSC9xJNYtGNE897hcLT6NaGgg=
=TR7u
-----END PGP SIGNATURE-----

--q53czbjv7t5deybk--
