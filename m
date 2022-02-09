Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B1C4AF668
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiBIQTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiBIQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:19:29 -0500
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D9BC035444;
        Wed,  9 Feb 2022 08:19:15 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8395F580206;
        Wed,  9 Feb 2022 11:19:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 09 Feb 2022 11:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=55OcdTedgkHCnbbZ2TtGyVZyNIMSUAAyr5X9c0
        GKBAo=; b=v4uF0DiPVnte+ne88sk9qzpOAVX01TfYo6w65K0GaERxBknbIBSpOj
        xvkQ4x4ZF7Ib5pRqxvDw8S6edUrRP9YEXydxX8H1KPGe2KRTsVGyJiwR6g53YOFs
        14ZZgZChtil8NH3pBopcVOS2rS1Oo6+UXNG1aCfxdVraU1uK86weFB7MjrQQOgWm
        zy9vI3MJ7dIP4LGHgNadh5bzArL7G1tVj5tOiDyyshfPvmHsYC/HV4FTbnTQslDP
        N/SuEdE0b3JsgtfLUEOQeTZTIOyZNLZvaS/44VtfE7gn8j2V2BP9GqLpm3oZuI7D
        vv3XUiY2KwMfPdBHzocgIC+lvn1Cz7pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=55OcdTedgkHCnbbZ2
        TtGyVZyNIMSUAAyr5X9c0GKBAo=; b=QKx7tcdhSvKwrYqcqgNqoDzaNSr7aatII
        r/AZAo45FibgSdw54iu7sHS8XbJzcAe/cElcNy95RG9Fd2DgL/exIF+Qp1gSpNzb
        yLlaRnmaEHQp6969YQgV90nR48DPBBNJJHq1lhmO/ezw3ry8GBJ4Jf1Enm+bwIKS
        zRTDF/hWS4OoQfO5twepq9lI8Qri+NPoBhyfxALjvYGvTN4snJJFi6lThDUdaFH4
        BJ3oE5Y7QEjWsbdq+itBmJqNbNCmPIMEzYyZ3H2qKyRGkQ2CL3IEmrcFJJe+PEBg
        UlZXxa+C209sMipZKe9BAPYDqcWUhvxkKFZmNVCL2MZCDzV04Hwtg==
X-ME-Sender: <xms:gekDYkeuA58gXxQ0wyORseyxSG8qm4NKR8QqXs4RBCSCbzzc7qgB6w>
    <xme:gekDYmMaj4bt8CYNBC3mmXNYRFB5dtqucfqSg-pYKguhQo1C612oTiSIGST9aR8mD
    Dcc_-ulJBRs4CU5mLU>
X-ME-Received: <xmr:gekDYliGRwG8Kx3PxCpDc2PpXi3ba9mMWYnhR4NLJ-bRWw-hx-prNSaDfmMmTm_1f6pgtH0hOv3EbGPRveIuPjZqLYM1W95fLlLdFVM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheelgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:gekDYp-vKjx7qfo0DnVHWJw3zjqPaQ-nwNJ3_72oh8v28CWeA_DbXw>
    <xmx:gekDYgtlzfycRTJFU0cyWdcdAXshxgYOoR9kAB-oRuneEAFSjhUHYg>
    <xmx:gekDYgGERl31H7ez-Xu_vcirfybh7cv_tPpHqYjGU77bKVycMX6d9A>
    <xmx:gukDYgQ0EWj40OfKWnf76vkG2LbPdongTb72ops65mEaW_tMIhd5Fw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Feb 2022 11:19:13 -0500 (EST)
Date:   Wed, 9 Feb 2022 17:19:11 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display
 controller
Message-ID: <20220209161911.eififnhc2csg4y46@houat>
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat>
 <f5381561-25da-61e3-5025-fa6dd61dd730@189.cn>
 <20220209084331.fpq5ng3yuqxmby4q@houat>
 <def50622-fe08-01f7-83bd-e6e0bc39fe1b@189.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ss2ssq6u6ix5jfma"
Content-Disposition: inline
In-Reply-To: <def50622-fe08-01f7-83bd-e6e0bc39fe1b@189.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ss2ssq6u6ix5jfma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 09, 2022 at 11:41:06PM +0800, Sui Jingfeng wrote:
> > Then, you have "modeset", and I'm not sure why it's supposed to be
> > there, at all. This is a modesetting driver, why would I want to disable
> > modesetting entirely?
>=20
> Something you want fbdev driver, for example simple-framebuffer driver wh=
ich
> using the firmware passed fb (screeninfo).
>=20
> besides, text mode support.

Then you want to use the generic nomodeset argument.

Maxime

--ss2ssq6u6ix5jfma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgPpfwAKCRDj7w1vZxhR
xRuMAP9hV9LEuGnyc5HgLOl062hnV9Xm6caWfQUzcStzgYP4/QD+OgIBr59jS/HJ
IZmuqee4UGRHzgaXB+crDV4SBZIVFQA=
=hzlD
-----END PGP SIGNATURE-----

--ss2ssq6u6ix5jfma--
