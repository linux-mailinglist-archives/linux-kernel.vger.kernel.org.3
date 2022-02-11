Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A4B4B2ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbiBKQoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:44:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiBKQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:44:06 -0500
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE955102;
        Fri, 11 Feb 2022 08:44:05 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id A17F12B0013A;
        Fri, 11 Feb 2022 11:44:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 11 Feb 2022 11:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=ufGFnpr7sURnSIynd9rsTHgA0vYHEgxxVeCjWO
        TqPFE=; b=DPLFx3pt0hR902PHT4xjUPd2AsKbnV2Plr2ZZhMFmL8rsJohPxWjO+
        OLnQrI+QFzlEeOa4b7NXnFWofkh+4tLxK3CJF9+AUk7bEUW4hQj6clVovOP6ECk1
        CgVuYFGvuEhQO22C2ImalqqOxJ3QLNe3yRQ9pirmVVeesXW2oV3I6y2eTDeKPQG1
        z4j6TTvFC0wTbkVFkM06LT9GQfmtCST1v4q5W9iMRu1YCxs2GXCqJEnAClxQavL7
        HhP2G7WBKvHYx+2QGOBHP9t+Oquiv7U9zDVpXCOrQHmOTm8LhFEXVii3yFSNeNlT
        c6gjePfuzfRRGKgQUglB0q31CB7dkHiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ufGFnpr7sURnSIynd
        9rsTHgA0vYHEgxxVeCjWOTqPFE=; b=dTNlyGMFEs90slxYGRRhPUr43pbBHp161
        /zAifbSRLtO9AEGMtH+go+SL3ey/MRHEn+sdrwy2naxaneReAXqQ7J03Tl1nZuwX
        GLHRgIG5AQQOJR19+4/2kk2f8fML6CoCUi30EGj2ZtWMzh4IqEAwH0eSYfTOoi0q
        coq8P9jeF1yp7Te0dALiSoib6BVMpZSvpuPMs+gbWNZ7Gbv/i3dl2vtOhx0SheCg
        RevV/vyMULSA1r4CI0nMq/AE1NnsrSnpnE9LpG1znBmBcXsr3PVpV+zXEJxJq2Kc
        HLjnrP7quO/o5nj4SLuNUCCFd98NurK5kPHAUVVH+qP6lNYrUnSWA==
X-ME-Sender: <xms:UpIGYhrMuSxOQdzJG75Qq-RujOVne0fDn5y9AgO_tMB6rEVJhsLWaQ>
    <xme:UpIGYjpfafTjW6cjTPOhcfnFzSTMGCJBzukO7aFnzQLnnWB-O5zaqWzEMTGifQCez
    dr0fPbAZ3uLAel50u4>
X-ME-Received: <xmr:UpIGYuP_Q8lJxK06tFjq-OmPa3lURdA4A2gNuEsGQkKaJ_EhZKvcL7-KjwyU2XIU05kwa9qAtSSzWP4jZ0aL__3tatyxVoDTqwb3_DY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrieefgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:UpIGYs5RAc7Wt6K3FuFO0Bk_sMjPLB17jeIdzBHYpxJHUuy2LqlWLA>
    <xmx:UpIGYg6tOjCuxkxayoVde7o8wcsUtb2EofG194h3fknc6HCczlnPyQ>
    <xmx:UpIGYkjfRG6hygHsXDpmdU5AF0clTcliuKu_AU9TgJOunipGWrJsjg>
    <xmx:U5IGYtwPDu5_9M8QxmjFAvA89YFYvswqzP6MVmzEaTv_Ek-Y0YXf0FIwDic>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Feb 2022 11:44:02 -0500 (EST)
Date:   Fri, 11 Feb 2022 17:44:00 +0100
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
Subject: Re: [PATCH v2 30/66] media: sun6i-csi: Add bridge v4l2 subdev with
 port management
Message-ID: <20220211164400.ccp4j2puryhurvzd@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-31-paul.kocialkowski@bootlin.com>
 <20220209092419.i3kver4f2am7mnow@houat>
 <YgaEN0ziZx5X7tQe@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xqbsdqvt6owp5vdi"
Content-Disposition: inline
In-Reply-To: <YgaEN0ziZx5X7tQe@aptenodytes>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xqbsdqvt6owp5vdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2022 at 04:43:51PM +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Wed 09 Feb 22, 10:24, Maxime Ripard wrote:
> > On Sat, Feb 05, 2022 at 07:53:53PM +0100, Paul Kocialkowski wrote:
> > > Introduce a bridge v4l2 subdev to prepare for separation between the
> > > processing part (bridge) and the dma engine, which is required to
> > > properly support ths isp workflow later on.
> > >=20
> > > Currently the bridge just manages fwnode mapping to media pads,
> > > using an async notifier (which was previously in the main code).
> > > The s_stream video op just forwards to the connected v4l2 subdev
> > > (sensor or MIPI CSI-2 bridge).
> > >=20
> > > The video capture device is now registered after the bridge and
> > > attaches to it with a media link.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> >=20
> > There's a bunch of checkpatch --strict warnings that need to be fixed
>=20
> Yes so it turns out these are adaptations to the existing video code
> which has these warnings already merged. They are cleaned up later on
> in a dedicated commit, but since it's not the topic of this change
> (which is a logic change) I kept the code as it is.
>=20
> What do you think?

+       async_subdev =3D v4l2_async_nf_add_fwnode_remote(notifier, handle,
+               struct v4l2_async_subdev);

CHECK: Alignment should match open parenthesis

This one at least is introduced by your patch

Maxime

--xqbsdqvt6owp5vdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgaSUAAKCRDj7w1vZxhR
xXGWAP0VX30FCSaxEfCylC0wvIQbV1OfNYW4aaL8aT/WKEZPGgEAtehwn0huoPF7
uno2SSUQZBowBDAPo9fxBKol2O9KAwQ=
=0iKA
-----END PGP SIGNATURE-----

--xqbsdqvt6owp5vdi--
