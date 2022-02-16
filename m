Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8731E4B8423
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiBPJR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:17:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiBPJRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:17:25 -0500
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5FD1162BB;
        Wed, 16 Feb 2022 01:17:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 7E5F72B00254;
        Wed, 16 Feb 2022 04:17:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 16 Feb 2022 04:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=UXu5vsk/l0EUSVSmeiSK+Q8Mmn+xZSxm91p5Ts
        f4LNw=; b=IucJBwVf14xUptUAW5CP0BI10KbRGVKEJtV5TrA8hvPEU0x8mfUw0v
        uTn22qXEu7yz2A/zNXn5nN/BWv8PKw9lhNutbEDUYV2mQTsZEhmM+iJCD3FQQApz
        uiAivepQPhAIR+aVfQffzOheq24ZktH3AU2Q3tkvcJsia/xHjdoFz38hnN6o3TxR
        /dEbXN6VRMz9nOc9RreVmEtfUTlavF1Fg67GqZ7VO4vj7sz4etwnpEdd+5wrCZA0
        i1avqdlW2nfC7RdMBC6ZTHwOXTVdgvxU98QRL5hz9l+JT9FCCSmvH5aLbZG8uesx
        VD0eDB/GZ3r2Q8BqaTwd6KH+R4nAFYCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=UXu5vsk/l0EUSVSme
        iSK+Q8Mmn+xZSxm91p5Tsf4LNw=; b=JfG7XaC+pXNUOgQGpDCZZginqHTBhCYEj
        4m2+MywMl0/JeQ4tOSck/Pzp63IGPQp6arYQby/8AasqygH9wYcLJRBzo59BYaZy
        1V0XOelXDMiJwIxJ8WaIKeXNukj2STIqmA1PCZD/0p3I27LOU661hcl4PrZymNs+
        Y7uSJTjzXutAVORQHo68vRqx+vOaHkJfRAL0NpzOv0Qopw8Qx2WOZKe+mfMcaHYg
        lXwolow5vd+dhbWgZ67tvR9PgM6Mqjlx+EaqMyQdqT2V9NCl8XMhfN/DDjfaokPP
        BzBM1iuLIlyub6vk0hqrI5vh7MfmERaviN4hRNJ850/yO4JBw4LPw==
X-ME-Sender: <xms:FcEMYqxsxvjnJcmpFeJ37o-fO4TxkcrupOpo_3t9JWmrN1f7STiPcA>
    <xme:FcEMYmTppNBo9PRHEpHsmaU0bNOYaC06M0fGq5plgXi7I3TbQ3HhK9m6AlcuGo9xB
    hsiB7apNIFkHmB3s0Y>
X-ME-Received: <xmr:FcEMYsWPd9cbNbLPGfhsEUj2rqOKSu_X2SNA9GMAQ39jqLpKAW2538yvoRdpr-kZRRAt3GzIyQq80WFFelaSfdr9tzKUxJC13YZqKew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FcEMYgihks0JWsp0hgUnecQdDc5lAET84-COFj653tYAfCIHaSfVxA>
    <xmx:FcEMYsCEv-PLkkNWisYs6AtfriivsXGzuUL2HqjYEwdckYvQygH8lA>
    <xmx:FcEMYhKitmtalbcTehwcarPzj4d8Qou79VGaivHI14YL1hls18MITA>
    <xmx:FsEMYg7HEApalddikAkkUDy7sj_Oczt_xZi-6xk_795devAS-tayM1xleqM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Feb 2022 04:17:09 -0500 (EST)
Date:   Wed, 16 Feb 2022 10:17:07 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v6 4/6] drm/solomon: Add SSD130x OLED displays I2C support
Message-ID: <20220216091707.mcksgnixsthhukbu@houat>
References: <20220214133710.3278506-1-javierm@redhat.com>
 <20220214133710.3278506-5-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="itjny65slsswpw5b"
Content-Disposition: inline
In-Reply-To: <20220214133710.3278506-5-javierm@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--itjny65slsswpw5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 02:37:08PM +0100, Javier Martinez Canillas wrote:
> The ssd130x driver only provides the core support for these devices but it
> does not have any bus transport logic. Add a driver to interface over I2C.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Maxime Ripard <maxime@cerno.tech>

Maxime

--itjny65slsswpw5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYgzBEwAKCRDj7w1vZxhR
xa/zAQDLWjXHyVD7xrAe7dFXSlShr+dp1ucfwRA0ExL2tKSeqwEAkFUb+GVIXtLv
XzGX/xvwj/zjb2/D5JymdxE7LtoVywE=
=+JCz
-----END PGP SIGNATURE-----

--itjny65slsswpw5b--
