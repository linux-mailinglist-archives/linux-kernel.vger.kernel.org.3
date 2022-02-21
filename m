Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AB74BDE64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347127AbiBUJFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 04:05:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347817AbiBUJB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:01:56 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E7729C95
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:57:10 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4757E5801E2;
        Mon, 21 Feb 2022 03:56:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 21 Feb 2022 03:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=rV0onRkyB9Sb+qdoUIaev26Q4kanvpPZw1uB8x
        g/Vqc=; b=t31vwVrZcZok6pREJ7DhdA81UGYplH+M28IcWy16ncsOlGK94wM2iH
        XN4SrsMMft2PeCIkUzS8DEE853DqVW1bH4IiJJSxpsNYsB1wb35LGVfcdkU+YNtD
        aDVL+IgPeBz9UY3tmOpvPBZPs9mh55DZrPIqj3hjlGLgFmnV4IMWbcmfazWFIfmO
        iW6D3e+OkpR+j49DnCHuUZJi6yLAd0v1Sypde8/KqEpl4sh9N/3zQwUNOqziAK/w
        kESBIVMOUKV8XRSXU+hscGvlJwVzsSlwRA61CnzH+DXqb0dWQp+/TxGKAvvgUlVq
        uliNIOeCV8f9NYwCIO0HCImhZVCCTIYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rV0onRkyB9Sb+qdoU
        Iaev26Q4kanvpPZw1uB8xg/Vqc=; b=HN8Qn49F6dCNISZxdBRHlVFYmQNz5NUCH
        ufY45eVJNKntKTlp+ZlVv54R36t6AheiqZGxAyWuOLL83TaoFYek8VSkX7WYNhSa
        fvJbxw04BXGRVlR2p0k6+sOcm7gqq5Dgywxk25S64ldfBul8jLtcXotyHPucNQ2D
        l7s5cE6T8sMVh+fx45hV2A/DrCzaWwwQNQNl0Iftl+Ts6G8bR7JSKY11tHgejq0A
        4IgeXYbR5jli80jqkZBvsmpECjV08+1xUg0lPKhiTzglBrrN+a+yj6bMSGENTWON
        aOPA4Sd61g34IxHuSUCq0uig1ql8LE6cVlWKwqZs4kWumzemNNwPQ==
X-ME-Sender: <xms:zVMTYtUCwDRSqgwMjfQiv_cQB_rKzt01EpJ56hJMIXSDB4Wqoiwn0A>
    <xme:zVMTYtmunpKN7uJpk5fzmfSSJL1COx_QnsNthxFmGAaSjVdYDkgG1k-kno08_ffEO
    cTXUPQ-mIGDa5yoh9E>
X-ME-Received: <xmr:zVMTYpbAE1RquV-s4bN_ayPNYemH-dG_FrbNlqRmjkxYZDK6F-CdFI5DAvTnO6oMLyir8bs8Kgl9l625DvW83JPNWId23B1bcOaOSFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:zVMTYgUwm26utO2i-Gl-U-OukjTyZV4tzXOA5KmrfgCI08y9XBJ47Q>
    <xmx:zVMTYnm0F1wiqVzgWhhZD1sDU5LBzfd8xbJu2AkHIMQXWSE3d6tsgw>
    <xmx:zVMTYtcpr1AySdcA0grOQ5gxVHArNhidWaXuVRyCJajh_PDgUsmPFA>
    <xmx:zlMTYq-y2OkI2LmLzGYrIwD7tqO0Ed_MdHfzS3EXX7-rOv3LhyfJ1g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 03:56:45 -0500 (EST)
Date:   Mon, 21 Feb 2022 09:56:43 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     jagan@amarulasolutions.com, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        lgirdwood@gmail.com, broonie@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: chipone-icn6211: switch to
 devm_drm_of_get_bridge
Message-ID: <20220221085643.b7klu7heomv6rubv@houat>
References: <20220221074224.12920-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tnwm4b4cxcark33t"
Content-Disposition: inline
In-Reply-To: <20220221074224.12920-1-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tnwm4b4cxcark33t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 21, 2022 at 08:42:24AM +0100, Jos=E9 Exp=F3sito wrote:
> The function "drm_of_find_panel_or_bridge" has been deprecated in
> favor of "devm_drm_of_get_bridge".
>=20
> Switch to the new function and reduce boilerplate.
>=20
> Signed-off-by: Jos=E9 Exp=F3sito <jose.exposito89@gmail.com>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--tnwm4b4cxcark33t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYhNTywAKCRDj7w1vZxhR
xTtuAQCprGUCNS9tWr+AVZudDW1KRe8XlHGtfaOfFGCVkKeGKQEA2zQWmnLX9iCL
nO4m1PYJ5acWqg4zi/cwx9Z5lpEu9A8=
=RDGJ
-----END PGP SIGNATURE-----

--tnwm4b4cxcark33t--
