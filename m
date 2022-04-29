Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC67514CBC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377240AbiD2O2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377232AbiD2O2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:28:13 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2C691358;
        Fri, 29 Apr 2022 07:24:52 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 35C48320095B;
        Fri, 29 Apr 2022 10:24:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 29 Apr 2022 10:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1651242288; x=
        1651328688; bh=9gHDquF0620vXHuRAV44zNwRhlnBP4+qdCr0yPXAJ9I=; b=n
        LC6L+MU4X/bYEQWo4BVTRJ6/ZbEcaEztOHaTGyaxWec0KCbu+a9pjwHMfy1H2ZlR
        5X1yCgpvFcOkvp1nMsfMurAKFqJLVGCE16uB8igyuXKdR7Vb9indKY7DFy63n1zb
        iS4kS5AF19lauLTxRcA9+Ba7DH6GHI0sMZHuoUz53+NG/h3AouGUiQODd452ghBy
        URtgJ4UVVunROTok3XPBwf4c34573DqU6qKDjcPTlpfyZ7cBdJUubgn1Pp0u1qtz
        9z/9PN2wq7jqqEZ0hHnfs/NQhG4foQGhZer4eccUaW7IvFfUc2yQSorXwGp3zeTK
        1+62XMHr5+tV4c48Dgrmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1651242288; x=1651328688; bh=9gHDquF0620vX
        HuRAV44zNwRhlnBP4+qdCr0yPXAJ9I=; b=Wz45439R4Skb7JbyeAKK10ppTC98L
        1JIHd1MP+Wg3YYww1M5ZrHa7IqpLA9gegNq9bzde2GJRumt4LvdsEdwxgfL635GR
        fzHk3eiyAyYq85UINAV060EFAV+hGXd43lh4h6noL2Ug8PPMoAdO7LXukJyxHVSn
        VpiYc8dUFJjx12QdV4gN/ZLqqdvm/z9keDXFMka7al7hyzmhChhS/EHU8b/GZuw4
        tNWXJsvfFTiGNvm22cyOR5rx+jqPk4p82/nBSJFvpgRhpdiQuUkC9k4UOLdN9zOm
        NBR73EhdtWwy4KgAM/I75ty1JOjzEqWwDED/OFVPygtRTDGgdhptzKPZw==
X-ME-Sender: <xms:L_VrYhAp8gxamH4PB3f6zruFuTY70tCyy5Z7JlhQpv0XtRoUvdLMDA>
    <xme:L_VrYvj3tRaVS5QDtmrlAljbdJZlCOHEmPqqSOIczP5WKaVuyTogokAs-IC2iy6GN
    aencRuYevp5LZD1hOU>
X-ME-Received: <xmr:L_VrYsm8Q8iDYl96jlqYWrHIa8da0bhHKmBbwb71o3wTyrQyPsZzLJXlZV_lC8_rrxHh-EpFMxg8YeeoMFTNe9ly_qEEeXcpj7z8Dc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudelgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefftddtueefgfffgedtjeffveduvdduhfdugeejgeekteeugfefhfehkedu
    hfdvhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:L_VrYrxjo7wlwYaVknZ1r7G4ZU1U8pA3c1dHFrC2gZ-TYcMdole-tg>
    <xmx:L_VrYmQjwFKxunRF_HNzckPPIvO4Z4TyXZt7loE4EhGfjv63Puqdqw>
    <xmx:L_VrYuaFsbRH6gin6nVzDNFdYB_jt5YePKYnNDM24NLrIQcE2fk61Q>
    <xmx:MPVrYrJWxpx_J8fTghDsP0SI1nZsOsqT7J6c0Sm24puDEHVrY2_Xzg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Apr 2022 10:24:47 -0400 (EDT)
Date:   Fri, 29 Apr 2022 16:24:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 43/45] media: sun6i-csi: Detect the availability of
 the ISP
Message-ID: <20220429142446.vzhmbay6hq7p4tpi@houat>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com>
 <20220415152811.636419-44-paul.kocialkowski@bootlin.com>
 <2029179.KlZ2vcFHjT@jernej-laptop>
 <YmpIjPe8pw+yvGyL@aptenodytes>
 <20220428081130.6deusqgnrsgqdp3e@houat>
 <Ymp98LBQySvpz8/j@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Ymp98LBQySvpz8/j@aptenodytes>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 01:43:44PM +0200, Paul Kocialkowski wrote:
> Hi Maxime,
>=20
> On Thu 28 Apr 22, 10:11, Maxime Ripard wrote:
> > On Thu, Apr 28, 2022 at 09:55:56AM +0200, Paul Kocialkowski wrote:
> > > Hi Jernej,
> > >=20
> > > Thanks a lot for all your reviews!
> > >=20
> > > On Wed 27 Apr 22, 22:07, Jernej =C5=A0krabec wrote:
> > > > Dne petek, 15. april 2022 ob 17:28:09 CEST je Paul Kocialkowski nap=
isal(a):
> > > > > Add a helper to detect whether the ISP is available and connected
> > > > > and store the indication in a driver-wide variable.
> > > > >=20
> > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > ---
> > > > >  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 33 +++++++++++++=
++++++
> > > > >  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  3 ++
> > > > >  2 files changed, 36 insertions(+)
> > > > >=20
> > > > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> > > > > a88deb8ba1e7..f185cbd113c7 100644
> > > > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > > > @@ -25,6 +25,35 @@
> > > > >  #include "sun6i_csi_capture.h"
> > > > >  #include "sun6i_csi_reg.h"
> > > > >=20
> > > > > +/* ISP */
> > > > > +
> > > > > +static bool sun6i_csi_isp_detect(struct sun6i_csi_device *csi_de=
v)
> > > > > +{
> > > > > +	struct device *dev =3D csi_dev->dev;
> > > > > +	struct fwnode_handle *handle =3D NULL;
> > > > > +
> > > > > +	/* ISP is not available if disabled in kernel config. */
> > > > > +	if (!IS_ENABLED(CONFIG_VIDEO_SUN6I_ISP))
> > > >=20
> > > > Where is this symbol defined?
> > >=20
> > > That is defined through Kconfig's auto-generated header, from the ass=
ociated
> > > option for the ISP driver. It is defined in the ISP support series so=
 this
> > > will effectively always be false for now.
> >=20
> > Can the ISP be compiled as a module, but the CSI driver built-in?
>=20
> I think so yes, I don't see any reason why not.
>=20
> > If so,
> > that would create a dependency from the kernel image to a module, which
> > won't compile.
>=20
> I think this would introduce a run-time dependency (sun6i-csi needing sun=
6i-isp
> in order to register) but I don't understand why it wouldn't compile thou=
gh.
> Could you ellaborate a bit?

Never mind, that was a brainfart, I was somehow thinking you wer calling
a function there.

Maxime
