Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7DE4AEF6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiBIKif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiBIKi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:38:27 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9D9E14863A;
        Wed,  9 Feb 2022 02:25:56 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 38A962B00247;
        Wed,  9 Feb 2022 04:25:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Feb 2022 04:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=x4Xau9jrPr3sDVwybOpIK/b9w4fMNltmY/7C4T
        ItDic=; b=J4B8JsReMPvjhSXfJVGjFz1AaL/WkJPBJnXV+IttUCvxfZEXOsLIcR
        jbU49jDoqI5qC85ZyeMsi/RQEQNuUOZkyOTvi7CCEJzUvMpPSu+oT12/xdch0j+a
        0aDepsdqsrCJUMAXHUyMQ5UoecX5dD93CrMdUlmCplh3JBLMmrwSqjBVFG5nhJsu
        sQkZEJ2XfG8UgOzF99+bN0VNjWksVUp5f4dbEm3raaRRKudNsHcCgxc+ix7vhWpD
        qGjTwlbcqu2Mpdx9Eb5KbhDbM2oTh/s9MUV6dqcpMnrq5AGkQMADkbpWak2CmsKB
        oUdbTOibrIh7X0k4DlRWCHkL3YCRLqBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=x4Xau9jrPr3sDVwyb
        OpIK/b9w4fMNltmY/7C4TItDic=; b=YBcYshvng8UgNDtkcDFi0gpR67pJXdhD3
        le2+tW7W6J3jDXB/GjgRPoqFAw80xZzA9+YgnKg0Hw7jxm7aI4atOXcyV1bmF3eJ
        VMv0M1Fkr+ygHvAy4elQ70dwhHVfuoQy5AsMsGxR8RANab+EEPPcXMricE4bW4lC
        VXzGULhdWA96v4R5tep28Do34IPooDWBJ2J3L7DocsvcT9XOFryPQ06IaUSh+uah
        U/Ww9w/WwH5Xrc41K5/48gSnBQKNyHlx5UeRGVsftEctPPV+ybccHk9YKeyAz+4B
        A+lUhSOo2tVqfj/cDlwvey8/3qS80l3aPilI2bsnsvDoNtOuI9ehg==
X-ME-Sender: <xms:fYgDYuSG2RqsldPgJ8LAjOrkhoQxqXzx06MQLRu8sgovF10__slpXw>
    <xme:fYgDYjxj9TdYQhpZeCNzJhSntJmG9dzGx2VYUCjUHMl7AzlCss-ytS4jYlKhmCxvR
    -STOyMZa1lKlYUhNpU>
X-ME-Received: <xmr:fYgDYr2AU8Ufb6MESoMg1Lt6KB9wI4zbi_01BjSwMPojsGGwpdFi7v9BnkkALSLJbNHv9S3aT5-p4rE931PZTp6wtCikXL40Qswwu0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheelgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:fYgDYqAKV-PJdzNcm1mBn9QCSBqB4ztAGmpuX1LBDxETJVyqtP303g>
    <xmx:fYgDYngKX8f1JKy5qX_NEPQMTKkatiFk-1oD9mg_yra1eQsFvSFHsw>
    <xmx:fYgDYmrhZX7QMu8idRpw_Ybfymhf4uejz3yT8gv7EaH19Wcwqv9PtQ>
    <xmx:fYgDYgZvlvKSi7np5DClAmFgvYoXiKxz8lxmzIT0ivVVPtFWrw77I3TCbPs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Feb 2022 04:25:16 -0500 (EST)
Date:   Wed, 9 Feb 2022 10:25:15 +0100
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
Subject: Re: [PATCH v2 31/66] media: sun6i-csi: Rename sun6i_video to
 sun6i_csi_capture
Message-ID: <20220209092515.nyalysvt2v5ult5k@houat>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com>
 <20220205185429.2278860-32-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7cbfwnza7b5aieih"
Content-Disposition: inline
In-Reply-To: <20220205185429.2278860-32-paul.kocialkowski@bootlin.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7cbfwnza7b5aieih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 05, 2022 at 07:53:54PM +0100, Paul Kocialkowski wrote:
> In an effort to distinguish between the core csi engine (to be
> represented as the bridge) and the dma engine (the capture video
> device), rename the video component to capture, with the appropriate
> prefix. No functional change intended.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--7cbfwnza7b5aieih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgOIewAKCRDj7w1vZxhR
xftKAP4miEyof8oD/yvVrwqUj4Zww2YXKzBE0vFPaaycjTBX0QD/QIF3PwzdOeVr
DGLkjg4EMpcEbPj9fHzxVuaaXf0xugo=
=5ZtM
-----END PGP SIGNATURE-----

--7cbfwnza7b5aieih--
