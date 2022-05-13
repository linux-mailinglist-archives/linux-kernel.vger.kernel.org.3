Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A86525C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377834AbiEMHjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243152AbiEMHiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:38:55 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6DC14B660;
        Fri, 13 May 2022 00:38:52 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AA0715C0262;
        Fri, 13 May 2022 03:38:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 13 May 2022 03:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1652427531; x=1652513931; bh=KRAvyTFS43
        NeTMqUA+krLdjjMY0SMM08oC6POjRC5tw=; b=H7MRj1BdzojzgarfxGnFmUE9EJ
        5GPYHMvfs5ELhY4gxaYlae4gFn58ONndv6Lwcl9wMa04DpAUA0dpfRnMHnM0bKGb
        YG4btr2ewrrM2ktAE3QqsZKi1l7aPRv77Mfa+iVhy4snG41DV0mPOKbiWl85s4C9
        ClK+gR2aFc1QYN5+RM9G7PceuZuhx5Luw81WWG1kH0nH4w3Xd6lfhy33v48C5Ueb
        vAAwWhzAzuUNz4Buejh7/S/0Wuxd65VQYXnm49Ljo11SAM1K5DOIgzifIiIdDc+t
        1tdubXSlgJh+lYWmL8IaO1+ZPMaKA1Koq3/1LWjjlFBH5UMhdxjunuj7NoWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652427531; x=
        1652513931; bh=KRAvyTFS43NeTMqUA+krLdjjMY0SMM08oC6POjRC5tw=; b=z
        Zk22c954gzlfH/u3ebLq8E6alYN6onbXCZZGApZVuSr9K0YmgJ/sR4RlkpN6Jkjp
        TC3VRapOhTomdAiuIMUnNI8f92uwxoYHrqufojwQxKC6n9T92TqhZmCftvWBoeb6
        C9M/PtD9i62fZxyIcXo/LdQwszXBJwQmTvIrMOmXWDwaC5CPB56k7zknP+A0zFW/
        z/HrcclFwOlJx7N31AmZ1aBBW8EQywDtbb6VJBwWv7UZDIE90+Fi2WH3luHaxmyC
        Ap/pHxgMczFZDT4Q4cg+TVbiYKCiI9nop3eo3/l+Ggp55gYrCXoFWwByHIklrgAE
        PmLAZeLvPna+r9soNvMSA==
X-ME-Sender: <xms:Cgt-Yv5bqAO52TAaGlqIzAbr7UU0h_qOduojqL8DtnkQv47f7UdLGQ>
    <xme:Cgt-Yk57cytgvkYWESMirvK-XMZ99xSLstGMXAU1ycXhAcAWgRDusaqMmDCQeYg7L
    vHy18eIgP5-8ZyPVs8>
X-ME-Received: <xmr:Cgt-YmfsO4jX5PMSg4w7J6PDHKR3XRx_cLirfdJ1DH6kCZwJdjrOJeu22K_wheXfYryZjY8h9_osb91jMd7QXZbV4-PjxuOMaDeLvRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgeekgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Cgt-YgKev10iIx9fPlZhrDLC50Gi-j_QCgSfsdQzO2pG1jtSfVcLXQ>
    <xmx:Cgt-YjLXp7RS8wel7-bYKqRjaDl8yJ1RAbOf4WIn9O2-gTu6JkmxRg>
    <xmx:Cgt-YpwozPXysW0DgrUjRhmHrNqLWX6j3TTAwm98hitsK2sOoXYVMA>
    <xmx:Cwt-YkVD4MLVTKIHfjJNAQvzI9dtzjLxPgTic8GXy55IdFS-WDtmDQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 May 2022 03:38:50 -0400 (EDT)
Date:   Fri, 13 May 2022 09:38:49 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     qianfanguijin@163.com
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ARM: dts: sun8i-r40: Add "cpu-supply" node for
 sun8i-r40 based board
Message-ID: <20220513073849.cu4jzykefat2sepg@houat>
References: <20220512071858.10805-1-qianfanguijin@163.com>
 <20220512071858.10805-2-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zxcrkptjti3zcqyl"
Content-Disposition: inline
In-Reply-To: <20220512071858.10805-2-qianfanguijin@163.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zxcrkptjti3zcqyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 12, 2022 at 03:18:58PM +0800, qianfanguijin@163.com wrote:
> From: qianfan Zhao <qianfanguijin@163.com>
>=20
> sun8i-r40 actived cpufreq feature now, let's add "cpu-supply" node on
> board.
>=20
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 4 ++++
>  arch/arm/boot/dts/sun8i-r40-feta40i.dtsi          | 4 ++++
>  arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts          | 4 ++++
>  arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 4 ++++
>  4 files changed, 16 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm=
/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> index a6a1087a0c9b..4f30018ec4a2 100644
> --- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> +++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
> @@ -113,6 +113,10 @@ &ahci {
>  	status =3D "okay";
>  };
> =20
> +&cpu0 {
> +	cpu-supply =3D <&reg_dcdc2>;
> +};
> +

This will break bisection on those boards. Indeed, you added the OPPs on
the first patch, and if you only apply that patch, the boards in the
second patch will be missing their CPU regulator. The kernel will then
ramp up the frequency to the highest OPP, but will not change the
voltage, resulting in a crash.

There's a similar issue for all the boards that don't have a regulator
in the first place.

The way we worked around this for the other SoCs is to have a DTSI with
the OPPs with a frequency higher than what U-Boot boots with (1008MHz?),
and only include that DTSI on boards that have a CPU regulator hooked in.

Maxime

--zxcrkptjti3zcqyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYn4LCQAKCRDj7w1vZxhR
xUebAP9qYzZ/IfkEzAu15CJHZ6js7mUi6RdbUoNXxKfPggg5ogD+Ni0yIfCamB1z
NywiFR5KnVB6qmwQCleCMfl/hditBQs=
=5Se1
-----END PGP SIGNATURE-----

--zxcrkptjti3zcqyl--
