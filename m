Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FF24B2AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351638AbiBKQlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:41:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbiBKQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:41:44 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3F6BD6;
        Fri, 11 Feb 2022 08:41:41 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id 309EB2B00073;
        Fri, 11 Feb 2022 11:41:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 11 Feb 2022 11:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=VxxIdz+/WKW+Venkr1DbRCwqE+GqaHFjtMkywh
        RdVmg=; b=LPsbn8ecDu15ndgNyjUooytAdW9uEGgbZ/NodPnk90frcRI9iGBGSE
        oC+KZULT8limIb3U6PjCtMZI4IeBUp6yYkRVAwygHEVbSAzkLbovFsQdLvfgx/J/
        RiHh/DoVF3/CimxucPNJoWXRR/+QzvLeeZILDFhUzbDbEIwCXTVNtb6kiY5VJDjk
        WfXrbWx85HklHGn45uGQyXJIXX0zx9AsZek6kmJ8QvHmRTp47Lx2kXLd3MdoLLXj
        6SnUU2pm8EeavnVYResWOY6mH2+u7u1oCwTCCjr/wyw0XyXO4YHRaFw+tdPHYihU
        JWPAQ570uw5jbY7tIdYY4W70WfwczN9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=VxxIdz+/WKW+Venkr
        1DbRCwqE+GqaHFjtMkywhRdVmg=; b=P7cLe39mwcd30tW0fg1aEuE/oVUvdajko
        X9G1D3dmzwwZ9CHaEYALKahudqH7Eu5IC/MS6yIg2z16gDYo03QaRFIu4ricvyDA
        zbAJ/1Zz7Oip61CvHPQzb7RG3fIZD6UsB9AnAD3wbz29NUFEipqPS+aDI3j1R2m9
        qkBJ9is7q8YEtw42I7zeBU/AeK6a3+31bg859CycXVxIB2rh2ncSjqhcBHUp7hii
        g+2VzrSYvXJlLKWfRP5o/oyTTLCOpyNLcLj14pZUONhg4+KVsF5CA20LAIezNXtP
        VlaFMOUpLy3ry7qLhBtnMcUVhoJ/LkRCKtWGej2NhHCnmkfe9NpeQ==
X-ME-Sender: <xms:v5EGYhXiUroDrfuYgLdtROAq2YYzg9him2WoCD7rq5wTdDVpBLhxLw>
    <xme:v5EGYhk9u7XPyPzTRZQvEsiJJR_XvKQEGwl1WkNu67aTTGQb34gxJ6ruiCbhiktT9
    ky0tqLNVVm9e77RUM8>
X-ME-Received: <xmr:v5EGYtbRCZIwQLAbt46L5dgdWZ2zSbwNzTP1JV8v1Du43Y0mjHFvn2Pdco2S8m5RgMIY87KUhMx0TsWmH9DWn1ffGomAanVO_wPeqPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:v5EGYkUI4Eplm_1r-YvryznxfK6ORJXh_yALtzCxMiV9jIve5JduuA>
    <xmx:v5EGYrlHsdobauYgL9jgLhLROGGbQfMKBo0D2tMvI9T75mmwWnCFuQ>
    <xmx:v5EGYhdcXnHqF_Dueovm3vo3fkfME7cAfWUU4pINSbJIegKhyGDnFg>
    <xmx:wJEGYqeNrvCSO-nbw3xQ11-IDWlPD4IkStwXeknu0oleIfrCYGOniDOnwLw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 11:41:34 -0500 (EST)
Date:   Fri, 11 Feb 2022 17:41:32 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 22/66] media: sun6i-csi: Use runtime pm for clocks and
 reset
Message-ID: <20220211164132.pt5ewk4aklkcokal@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-23-paul.kocialkowski@bootlin.com>
 <20220209092203.3fieqs4mbip6heug@houat>
 <YgaIXXPHBMXWwPtO@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2tzp6er3oul7lsr4"
Content-Disposition: inline
In-Reply-To: <YgaIXXPHBMXWwPtO@aptenodytes>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2tzp6er3oul7lsr4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2022 at 05:01:33PM +0100, Paul Kocialkowski wrote:
> On Wed 09 Feb 22, 10:22, Maxime Ripard wrote:
> > On Sat, Feb 05, 2022 at 07:53:45PM +0100, Paul Kocialkowski wrote:
> > > Wrap the clock and reset preparation into runtime pm functions
> > > for better organization of the code.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 94 ++++++++++++++---=
--
> > >  1 file changed, 69 insertions(+), 25 deletions(-)
> > >=20
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/dri=
vers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > index 2355088fdc37..b53b92b70a89 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > @@ -152,40 +152,18 @@ int sun6i_csi_set_power(struct sun6i_csi_device=
 *csi_dev, bool enable)
> > > =20
> > >  	if (!enable) {
> > >  		regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, 0);
> > > +		pm_runtime_put(dev);
> > > =20
> > > -		clk_disable_unprepare(csi_dev->clk_ram);
> > > -		clk_disable_unprepare(csi_dev->clk_mod);
> > > -		reset_control_assert(csi_dev->reset);
> > >  		return 0;
> > >  	}
> > > =20
> > > -	ret =3D clk_prepare_enable(csi_dev->clk_mod);
> > > -	if (ret) {
> > > -		dev_err(csi_dev->dev, "Enable csi clk err %d\n", ret);
> > > +	ret =3D pm_runtime_resume_and_get(dev);
> > > +	if (ret < 0)
> > >  		return ret;
> > > -	}
> > > -
> > > -	ret =3D clk_prepare_enable(csi_dev->clk_ram);
> > > -	if (ret) {
> > > -		dev_err(csi_dev->dev, "Enable clk_dram_csi clk err %d\n", ret);
> > > -		goto clk_mod_disable;
> > > -	}
> > > -
> > > -	ret =3D reset_control_deassert(csi_dev->reset);
> > > -	if (ret) {
> > > -		dev_err(csi_dev->dev, "reset err %d\n", ret);
> > > -		goto clk_ram_disable;
> > > -	}
> > > =20
> > >  	regmap_update_bits(regmap, CSI_EN_REG, CSI_EN_CSI_EN, CSI_EN_CSI_EN=
);
> > > =20
> > >  	return 0;
> > > -
> > > -clk_ram_disable:
> > > -	clk_disable_unprepare(csi_dev->clk_ram);
> > > -clk_mod_disable:
> > > -	clk_disable_unprepare(csi_dev->clk_mod);
> > > -	return ret;
> > >  }
> > > =20
> > >  static enum csi_input_fmt get_csi_input_format(struct sun6i_csi_devi=
ce *csi_dev,
> > > @@ -800,6 +778,65 @@ static irqreturn_t sun6i_csi_isr(int irq, void *=
private)
> > >  	return IRQ_HANDLED;
> > >  }
> > > =20
> > > +static int sun6i_csi_suspend(struct device *dev)
> > > +{
> > > +	struct sun6i_csi_device *csi_dev =3D dev_get_drvdata(dev);
> > > +
> > > +	reset_control_assert(csi_dev->reset);
> > > +	clk_disable_unprepare(csi_dev->clk_ram);
> > > +	clk_disable_unprepare(csi_dev->clk_mod);
> > > +	clk_disable_unprepare(csi_dev->clk_bus);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sun6i_csi_resume(struct device *dev)
> > > +{
> > > +	struct sun6i_csi_device *csi_dev =3D dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	ret =3D reset_control_deassert(csi_dev->reset);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to deassert reset\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret =3D clk_prepare_enable(csi_dev->clk_bus);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to enable bus clock\n");
> > > +		goto error_reset;
> > > +	}
> > > +
> > > +	ret =3D clk_prepare_enable(csi_dev->clk_mod);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to enable module clock\n");
> > > +		goto error_clk_bus;
> > > +	}
> > > +
> > > +	ret =3D clk_prepare_enable(csi_dev->clk_ram);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to enable ram clock\n");
> > > +		goto error_clk_mod;
> > > +	}
> > > +
> > > +	return 0;
> >=20
> > You've change the order of the reset vs clock initialization.
>=20
> Oh right. Is there a preference regarding the order?
> It probably makes more sense to release reset once all the clocks are
> ready rather than the opposite (so that would match the previous order).

=46rom the datasheet:

4.3.6.4. Gating and reset

Make sure that the reset signal has been released before the release of
module clock gating;

So it looks like the right order. it should still be mentioned in the
commit log.

Maxime

--2tzp6er3oul7lsr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgaRvAAKCRDj7w1vZxhR
xbzHAPwIE+pk/J7wGu6+MnLjeEnvN3TQMWxPJPnSfsNNUcOERQEAhiykH+iCarHi
HZiA7dU3jteJKmpx1FXXBnGnrAq9jgo=
=HJsC
-----END PGP SIGNATURE-----

--2tzp6er3oul7lsr4--
