Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CDF4B3044
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354026AbiBKWTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:19:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349957AbiBKWTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:19:42 -0500
X-Greylist: delayed 194 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Feb 2022 14:19:40 PST
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A65BF1;
        Fri, 11 Feb 2022 14:19:40 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6208D3202152;
        Fri, 11 Feb 2022 17:19:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 11 Feb 2022 17:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=RTc40DrDIwSBEwSKbaE6X7bElwvJ01jh9SfVla
        ee3V0=; b=i7AsSyZjLcSEF+5Hu0j8R6hc3REOMN+3DwOB6Jc5BH6hv7g9/leVPD
        NCtf7UC4CjEvQQBxXD9TIxq/CQDnkHCwaQl/6438gvnVewTqedvtsnnKKJarxCid
        8W93S/5qKAgEjXEguQ81eiw8Z29eqEUymuB4W4WYHmYbcLHPmhohz5Y9bt/ZSnm0
        A0TWi41d2UNBLYjlRdNAwairhdKVPCBLRCmbA4PovJwKo/bE9eCo7UGcju/FfPoS
        MhTeX5434sM+hGpPXSSOGata2dWA7lc/lJ594gDgV4l6oy2YA8v1njhz+4mDZQKb
        RErBKfmO9x2RVZfY9y064QU8W9rtg/tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RTc40DrDIwSBEwSKb
        aE6X7bElwvJ01jh9SfVlaee3V0=; b=dy2oHKAS3X3UyXDWTFApsolPkUO11Ipi9
        KEg0dotznhG0QKAhz8x9PO3q2cJhR2i3KFg7mV06VwJGADElDDXyHTRjzx+RbS8W
        cMxOV5a8Mwl2Gk1DZBJFFPBuFw5IS1ldxGlAGWNpCZPIvc1N4SYhEy/cuiLOCMjW
        INafyvl9hWGNqPQjqmXnbMVl8ybq4nKd/FW1DHEiVXQv7Qcij51BHvyAXxF2Lh/7
        LurwVhdM7tIUcLOZHywLg7ruV21MYsn9WPKBHwiORS7//XvBxfsUiLEcT6zebKIY
        qdC8PpohXK139gbh4eUAenDXSBbGUVib+WBvzu/Qq+8BDkCJvvQGw==
X-ME-Sender: <xms:-uAGYnDKvdaCwFEgT89xro4hCiriuh172938UC2LkCXnD6x8bYcMgQ>
    <xme:-uAGYtjt5fla02LsKAZ0opi3pklL239h55HOH0jcraXka7Csc4upFKalsCJLRmG-P
    zX7fngyuWTDuQEUqeY>
X-ME-Received: <xmr:-uAGYimtFoUmV1p-bf9pfEbevvDeBAxD_rB1AC1GPWDaqSOSS2HSRj9pT_NtHKf7EyIGQU1EHRrrdw1aNG-vml7kw_7eIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvuffkfhggtggujgesghdtreertddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepgeehheefffegkeevhedthffgudfh
    geefgfdthefhkedtleffveekgfeuffehtdeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:-uAGYpz86X5lMT_KrnV0qcOp0lIJQWacait7yMz7w7kTcLuJcxzaag>
    <xmx:-uAGYsR6qKZ3UU1sPyLTDj1hhfJ_r8V-3N-tYdS2ZrylCU6yLhm-4A>
    <xmx:-uAGYsb5nvnHysL_dj2K3O9OtJvTRj1AJY9dzvlhu2nrKhvP1tk3-Q>
    <xmx:-uAGYrGr8mclckFYz2PPdcq-CQakm8OjmO4grOnwUQoXa_FcK_BG-Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 17:19:37 -0500 (EST)
Date:   Fri, 11 Feb 2022 16:19:36 -0600
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] arch: arm: dts: bletchley: cleanup redundant node
Message-ID: <Ygbg+KYK9qT90O2N@heinlein>
References: <20220211014347.24841-1-potin.lai@quantatw.com>
 <20220211014347.24841-11-potin.lai@quantatw.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JisbnzQp48fIKCGa"
Content-Disposition: inline
In-Reply-To: <20220211014347.24841-11-potin.lai@quantatw.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JisbnzQp48fIKCGa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2022 at 09:43:47AM +0800, Potin Lai wrote:
> Remove redundant i2c1 node.
> Disable in-chip rtc, use external rtc (pcf85263) instead.

A bit of "why" on the RTC change might be useful.  I suspect it has to do
with where battery-backing is for the RTC in hardware.

>=20
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/a=
rm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> index 946107bd8bc7..fb62a67cfeed 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
> @@ -205,10 +205,6 @@
>  	};
>  };
> =20
> -&rtc {
> -	status =3D "okay";
> -};
> -
>  &fmc {
>  	status =3D "okay";
>  	flash@0 {
> @@ -387,10 +383,6 @@
>  	};
>  };
> =20
> -&i2c1 {
> -	status =3D "okay";
> -};
> -
>  &i2c2 {
>  	status =3D "okay";
>  	ina230@45 {
> @@ -680,6 +672,7 @@
>  	};
> =20
>  	rtc@51 {
> +		/* in-chip rtc disabled, use this external rtc instead */
>  		compatible =3D "nxp,pcf85263";
>  		reg =3D <0x51>;
>  	};
> --=20
> 2.17.1
>=20

--=20
Patrick Williams

--JisbnzQp48fIKCGa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmIG4PgACgkQqwNHzC0A
wRkWMBAAqRxDw0dBdIcOs4dccrmlv1gPYZ2wzaS8rizHSpKm2gz1IIt7ConmzmSv
zYlkH4kioV4aBgP59r3CnyKObFARg7pTm4jelLYUoedzAidK6YgmpWDHslS835KG
OHza3ZFZpjROw+Yxc+Uj4d5SJ2eCva5znFvp1FukcmahTMXJDUT+OT1KeKoq3BoV
NVNlb1SXuXmJyCmooCiKQSO73xgW5KDUH3pVOzC9OsGc3xHq70uKIBmWd+1DD8ya
CgLf/s3mk2OKlFfz0tn8nq1oLdXxzjygm+ymXNtmr0NwdGVHoDLA6Irld9xfAjt/
mggDNLoYBcHw08eAydFYTRDkshEkxYiREWIK1Eb+b0Y7p0SWI8CYFE+eofdscwWt
RA6889EWvdWffOYJKKfBGHbYFGBbytSuwwyCYYc/wxJ3zgPgzcR/QtOUvVxLi17N
OpBnlyDZrPbpsVBGYoCL+ml+27UZAfVRtzkXTL05lMdZFVmg8lawiMcTtP7cb1FI
0JlT4xWFOPRhkr13eOUfHFVa3H9+TuSNAaUroHu0oAd7f77HNt06O85eSo8KndXd
nXsJkpnybmu29THPv2EHcvP1DUCbEpKL8I7ORwqigkLRnL21G+JwFJg7Y/sCDmpa
ZiHJoWWpEEnBkPrela3DH/bjBx6cNh8bkmleWg5mSm60K92A3tQ=
=CihP
-----END PGP SIGNATURE-----

--JisbnzQp48fIKCGa--
