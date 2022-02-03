Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735A74A8026
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244762AbiBCINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 03:13:41 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:46103 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231836AbiBCINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:13:39 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B3BED32020F0;
        Thu,  3 Feb 2022 03:13:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 03 Feb 2022 03:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=h+F9A27NvIA+GKJCYuxpPOGt5GYFFmLQcgR5pl
        DO8E8=; b=Cdsyg0Pn3Ab6xErlAntB5MyGCgXAkk+uF09GN826cSXJp1nX39LKSn
        QnpArFTJMqTf90vRHT5lV7nBTPMKViGa6U9Ca5eTl6lRrC5qOkI5+qDXohCcvuet
        SZu/A3BzcDV2ID/A8L+Xxt7/92B2cYliI9OJ5XgRlhNatuH0XlgZK0pGHt/G3TRh
        ZuCm6YNwGCheBVSTUkv2M37YxzxwqX/w1tE0GMqSA1D577Y3IoI18qvL/uf+duPO
        imVwS5NCmigRFxxqWquEukcEO2Jbbyb3kD+ywJd05tLun7CESMeDpbTlARXY1NTI
        S6TQRmVh3UlfXo6yatYJqJxQ1ZMXrOkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=h+F9A27NvIA+GKJCY
        uxpPOGt5GYFFmLQcgR5plDO8E8=; b=F5AFmheXYgFSOpakvoALGRVa0zVirxzRR
        k5gmm198NMnClY00YwdSrF8U/CvukeyjO3jFSGbGSNE3eiNASVktWwkONMuj1JXk
        crbBfwz5/Gp2gMhzst74OeTI9kWnSpPEz0swHxrSgANbwQcq7q/kXWMQZi69E5kF
        LivQDWE9TPOpqlCuSL4/Mb0kJJDXAl7Jb+ftvFd6O03KVY5+9n4AtJc3t23XPYcy
        +sKDk1/Z+cxpIlCK+PIh23yxFc7Uvk0IJFi+FliRQtpXoIoNIBRrijsvAkaB4smu
        gAG0uZEvgN87ErXQECWNDckFLUC3S5gAcwZdgj3itvt3QPXPXNE1g==
X-ME-Sender: <xms:sI77YcxhL75k8W8K0u04e4pYItRNKXdRVgwHRB9jGO36bUbCaKdfuw>
    <xme:sI77YQQIEOR0oDxF1FxJxVY89vs-YwmbaWdJrzU5j8h4Mf_Gb3y3vOBIyhO52X2sz
    IjmyS7APSIFu0-wX3c>
X-ME-Received: <xmr:sI77YeVZF1UoOeRktb6FzpQFiSfd69_8E7mQBKRgPyRhjUoDWeqjn3QFH0oan7fRFUbVPSyKb3jcYxRXbueXhQhtHLf33T5fuFWt9hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:sI77YahwtO8cMS1cPg9153h7U8dRjBbntU9a4j9SNcpsAyYJSlCrAw>
    <xmx:sI77YeCrLvRZ1BOkBxWuH14FkG8K3uy-dpiV6xAh0aC48g4j6DbZlQ>
    <xmx:sI77YbIKsRmFJlXWevFcNV-I6BhsqT4FVcpRS_MALk1xuO-2Cyxsbg>
    <xmx:sY77YUCbWxw9vejeNnCW4z_95HC7isoQxLBb-OvfhHE7zfvD9yzvBA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Feb 2022 03:13:36 -0500 (EST)
Date:   Thu, 3 Feb 2022 09:13:33 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: SID: Add compatible for D1
Message-ID: <20220203081333.au4iblrlktqixgwk@houat>
References: <20220203012502.10661-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jikoomnds2xtwx5p"
Content-Disposition: inline
In-Reply-To: <20220203012502.10661-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jikoomnds2xtwx5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 02, 2022 at 07:25:00PM -0600, Samuel Holland wrote:
> D1 has a SID like other Allwinner SoCs, but with a unique eFuse layout.
> Add a new compatible string for it.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--jikoomnds2xtwx5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYfuOrQAKCRDj7w1vZxhR
xVwcAQD18T5ARVFWMMXn8UrNE5dT0w2s+SM2DU9z03hLPLFilAD7BAezRRhjaUDk
fKpizMoqTnZEnuFb6nepiOHApT7MfQ8=
=fo+u
-----END PGP SIGNATURE-----

--jikoomnds2xtwx5p--
