Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBAC53E7A0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbiFFNm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239142AbiFFNmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:42:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D1E2497C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:42:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4A04032002FB;
        Mon,  6 Jun 2022 09:42:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 06 Jun 2022 09:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1654522966; x=1654609366; bh=45Gfr3inFH
        9BeaLjl/yNEArpn/SIzL1LRhq2ulFzT50=; b=FpgXV2txJMebnxi0z5IpgJA/wh
        m0Holm0r0ygOAAxUMdxAThh5nb4i7gdoIEpADiEL2qIT+qei1D1V861Ce5xfe6xP
        t8TKNCtupHJKLYItc1wt96a/Red25VsRTSp7fyiXKSEA+NhYQxkWCXe16uM6cdBe
        0HbYG1vFm84aCxe4M0+BfkgN87e4arUsVKiSnzz+GvdGf18+fP0FMkc2FWlSfW1X
        /E0xrZER7SBJRakGX4ISxJ+vtqZNdtYK5CDWBAwXYdLtlC9c0CA6Hs3uCJUrUQLk
        278gPMInGtpgiNcuVjYoqzfCVgPtBscDx6QBf60R1VGFLHXeMMB2hg7ShUYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654522966; x=1654609366; bh=45Gfr3inFH9BeaLjl/yNEArpn/SI
        zL1LRhq2ulFzT50=; b=Qn1rkyZZGY5y56FLKg2vzeJ8EMF+ED3pUYT2B+3CzTZW
        epggyMvlKmw+kqtSZDln5CTsAwwYniy4T9T2gN12xS9RWau3eWwsALMuysmCwn8f
        zvjggfWr3LHmyyTBpi6++Uvi71HZnRiUjioAjjXvc6/vIhuNsl1KV5tdcDCc17a5
        c2Y3b0YTVkRGrsmT3joBSdjrZ7VnMwO8igY6OVR2bKZh2lJaHcnvxefdIvd4Yy/0
        i0kcS7d6WZLBlIXek7SRPZfAFcB2ES3NDa4gxjJ5QKw4PMEuDEjujw/r4oWCl47X
        uI+ztZG++ggPHKJq85OLjBcRcVPvpWn8YDE8W6T8Uw==
X-ME-Sender: <xms:VgSeYpYKOrw4gI02xlpFQhClMeOzjHYXblJUKvrd2SLImLLQbIYUyQ>
    <xme:VgSeYgZid2jJ7TLdVC3IvPfdgWSwwoX6srxs5fCR96bXUAa_pB1MSonx6yxn2TbYv
    Zfq5svHZ3_Tj_km55w>
X-ME-Received: <xmr:VgSeYr94zkX8yCAnsQpWhoBW5fngvx3TaOaoccJiDbKq06EHvfXIetuKKB8HCXGzcewjtuEDdaesSOVg4uKPaGl7hIq3ZkCKFjon82o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddtvddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejveefheefkeeiffegveelveetgffffeektdefuefhtedtgeejhefggedu
    ffffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:VgSeYnpvXHBNTCInimcQ4hNdd6VV-BMMJB62KEfcNIIag40oU-jAgA>
    <xmx:VgSeYkrXPrBt4TTOYAdbEGr6wDg9ffh9VUphi7oHqJoESk9DWvjDgA>
    <xmx:VgSeYtTCTKUCEnDMaa_aL6YObwhbI2uPyi6CaNteZN1ODPpLy2YCXA>
    <xmx:VgSeYr1itKC1cmOOd9mQezji3dTodUcHXWRF92STzpFw9qjQ-ZFdnA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jun 2022 09:42:45 -0400 (EDT)
Date:   Mon, 6 Jun 2022 15:42:42 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     javierm@redhat.com, davidgow@google.com, dlatypov@google.com,
        tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb332()
Message-ID: <20220606134242.h6kuqn4zbpmc2rql@houat>
References: <20220606095516.938934-1-jose.exposito89@gmail.com>
 <20220606095516.938934-2-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nmupzpdydlfrfe4r"
Content-Disposition: inline
In-Reply-To: <20220606095516.938934-2-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nmupzpdydlfrfe4r
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 06, 2022 at 11:55:16AM +0200, Jos=E9 Exp=F3sito wrote:
> Test the conversion from XRGB8888 to RGB332.
>=20
> What is tested?
>=20
>  - Different values for the X in XRGB8888 to make sure it is ignored
>  - Different clip values: Single pixel and full and partial buffer
>  - Well known colors: White, black, red, green, blue, magenta, yellow
>    and cyan
>  - Other colors: Randomly picked
>  - Destination pitch
>=20
> How to run the tests?
>=20
>  $ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/drm \
>          --kconfig_add CONFIG_VIRTIO_UML=3Dy \
>          --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=3Dy

It's not clear to me why you would need VIRTIO here? The Kunit config
file should be enough to run the tests properly

Maxime

--nmupzpdydlfrfe4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYp4EUgAKCRDj7w1vZxhR
xdD/AQCVKUFsKCwDjplnL7J+4MZC7u9BvBuBbUwiUaBES9UgqQEA+JV0l+OYLBD+
6FCuKDewDOpOGvmYO3+pxyijE6tjnws=
=aLxf
-----END PGP SIGNATURE-----

--nmupzpdydlfrfe4r--
