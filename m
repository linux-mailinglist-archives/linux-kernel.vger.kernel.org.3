Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538DE574CC0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiGNMFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiGNMFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:05:09 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E31F5C372;
        Thu, 14 Jul 2022 05:05:07 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9BA655C0114;
        Thu, 14 Jul 2022 08:05:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 14 Jul 2022 08:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1657800304; x=1657886704; bh=m30tQ4rO6J
        cxVKQX3c4vUbcVqVnZtqCNGR90qL2rgJ0=; b=A4c5jD4STW1WQeSMFTdb0X7QKs
        WTim9GfmyycLprwmdqM4qiHI4REeW287xo4zlJ5hP6wREpNsCkDZTq+yByRmWDRL
        EgFauqXthrvZl33JpMhBsI0GAqc36Alv3DwzzAjUDcZCBjWkvoggbsn11JJmOpCC
        W+eMH9PiFW6rdmgxXkq6g5zgjvrmeoEbUCJOVYix8J247n7MPym1Tb3jKQNFdIK5
        G5Zg0DnFyMhGTBUirfrBWYXemOKQgOP/gmAP+6ek+SFyjRBAgSZFgMgEozIJWb/t
        1a1c9WFlf+R+BTs7RYd6g5QJl8TVhJPDvNBPJrCaQd2swIjXszdocaXR5wrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1657800304; x=1657886704; bh=m30tQ4rO6JcxVKQX3c4vUbcVqVnZ
        tqCNGR90qL2rgJ0=; b=pacqNrBm8LplaBP3Opxlrog92i+HsxBK2UsIZ9/KtDYf
        0Ehg6k4PV5GCkuhnk2Cw8tuRgcbfvecKZ5OZLJ/3EuOMr5xi/KmEbNlQ3AQEGdK0
        02tH9PPV0q85ivM32KVQGYxB+fwdTbC9LO8L6puqALF2R0YWGgpEpg3n6sPCAlQb
        qS8FamH9thtkids97dx3BFcxvcpMz9snjumNSkQY0uCRYtZqMVjhJrT1GCizQfXa
        goyNZRJqCQhQNIcLSzLo4xGpK2JemM+DKGXSbDTmFXNOs1lQL4TgdgaFwey7V6Xv
        b6P5CX0BP09gvmf6zBT6rtHRGzL1HKB6qNHGA5trLw==
X-ME-Sender: <xms:bwbQYkWnnpPxS0zKj8jBPhbuvXsFP71xKalqf0i0shFibFoMNL7wjw>
    <xme:bwbQYolSZ7bZqtZfoliqhFuAyySpQGB7F4kJ87J2jSugr9jxSPvShQZ4ZOm2OHvUM
    ZpvjxEt0YiQX1wF2Q4>
X-ME-Received: <xmr:bwbQYoaS0VlkJNqlZ1X6KfZCG8DrX8xzeWPQspfw_FEYNTx-6NSQoxqkQdEQlZhG3YsWrZkLA-AGTihIm9Itpj5e1tbYtQId2i2zL2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudejledggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeetfefffefgkedtfefgledugfdtjeefjedvtddtkeetieffjedvgfehheff
    hfevudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:bwbQYjUzSxQlaLAvc0xbeKZkXaIt--AtMuz7a2G_SPqRsYBvXjf58w>
    <xmx:bwbQYukvJpv17SGiXPBjZbUalf1uEe2Gx-SdEkyQddoiTx993aApkA>
    <xmx:bwbQYodYABj2OUIt9qU0VKIVb8GXQ636O-D8W0vIfyIZ6ekRhWnDSw>
    <xmx:cAbQYo4owk1kUQ0i96VUc6bYJw3kXFvIJmLIF0GbLlI03YKuvH0OvA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Jul 2022 08:05:03 -0400 (EDT)
Date:   Thu, 14 Jul 2022 14:05:00 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] drm/modes: parse_cmdline: Handle empty mode name
 part
Message-ID: <20220714120500.miufhnkzaomaqxyp@houat>
References: <cover.1657788997.git.geert@linux-m68k.org>
 <302d0737539daa2053134e8f24fdf37e3d939e1e.1657788997.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cphgueiqg6ec2b5x"
Content-Disposition: inline
In-Reply-To: <302d0737539daa2053134e8f24fdf37e3d939e1e.1657788997.git.geert@linux-m68k.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cphgueiqg6ec2b5x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 14, 2022 at 11:04:06AM +0200, Geert Uytterhoeven wrote:
> If no mode name part was specified, mode_end is zero, and the "ret =3D=3D
> mode_end" check does the wrong thing.
>=20
> Fix this by skipping all named mode handling when mode_end is zero.
>=20
> Fixes: 7b1cce760afe38b4 ("drm/modes: parse_cmdline: Allow specifying stan=
d-alone options")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

We should add a test for that in drivers/gpu/drm/tests/drm_cmdline_parser_t=
est.c

Maxime

--cphgueiqg6ec2b5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYtAGbAAKCRDj7w1vZxhR
xeI7AP4t2KrerCg+30mJU05ZCc7OVEHw7n2y2IWFX+d6zWDDSgEA1c8eVVk9fxHg
VdcJ0SwbZdaPq1KmT2RLi+IuImnDggM=
=WpoD
-----END PGP SIGNATURE-----

--cphgueiqg6ec2b5x--
