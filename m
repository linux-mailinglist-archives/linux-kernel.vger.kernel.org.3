Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845FF4F8FB5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiDHHnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiDHHnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:43:22 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FF11AE3F1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:41:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F92D5C01D7;
        Fri,  8 Apr 2022 03:41:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 08 Apr 2022 03:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=5fojcFgxs4Mgqd5Vt1YFmWSTJwRBAlJv2PCvUi
        CR6NY=; b=FtilK2SV34gl1GkOPXn0+vx/ZIPinse01xYI4onzVZECjMubFcrT/V
        UxWkN7MBlnGA+x4Ur3K5arRIoFg8h7xJo2/WeLgF9RAETQn+0FU5MpYWA1Xr2NYr
        JDGvMEibayzbEeDm8ca6z6qSRF+yxYIv5Ict5r0P37NuAb+/OrodzYS9VEAQk+Tx
        J2taa2iiFBE4QLDiP6GXzlGf1F3wgP1rd63Hztva5mi2KfE1p7ds6B88IBfQD6BT
        Y1A2JanDC0ygBLK3jV678UwFk62y+8VPqKFXEorFoExl+r5/wkrlN8AOad01POLQ
        KLgKRC/klH5bE76re2Yn7O3bCZvIj1gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5fojcFgxs4Mgqd5Vt
        1YFmWSTJwRBAlJv2PCvUiCR6NY=; b=cYH/LlNZy9f1ipzgnbKoZBbfka/omzyVB
        +hGka493EsoPVXB4+jn/dOTE9rFmN6EMqnj2XBWlN2aAhBmwznyEbGUMQlcg5ubf
        lrDHelYYEj0lNkf+xH2HnyKV/J0GyeAYJe62JkSxQe2XjhuWAuR/wu35bbLYoa/M
        6Znt4uwQ7ArQ1/Ar5oL7U6VR8lRDiu+0jgn2ORiAvNbSVO4JFlNIGBohKxjMc0P9
        84r1DRow64mV7q7sc/y5BLwbiTgCl7GMgrsESdXoKT9i5oP+NKvvdobonfb/9oqy
        xD+2SNZiAIs3K+wXwq+VdNl3h2gaDa+wFSeZZRSaBl0iBXAZRAEzQ==
X-ME-Sender: <xms:GedPYqr08O8Pd1w3dBMw5a5uO8vUhgIVyImzCytNpg4WuXwZZe3GHQ>
    <xme:GedPYooEF-aG_KX637PdH0boxYFyNxRubSOWcyT5wxwbrmHayszQazxWSuSiMckOE
    EhstnSpaUv-Xt5WZR8>
X-ME-Received: <xmr:GedPYvNCeXhMEQzJnCUJpLU8AoWhJMw1DAjnKYFy3hBV2YXJPGZSeNLY75z2DZOGYrkh96aNOhcp-cN7CVxe8D6NX2K2Fcz4OAfVIFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudejledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdej
    vdfgveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:GedPYp4_r_QIDkvLsNbnrKrGdvN6UAtYM5Ze9m0mA9qAUab2hM_2mQ>
    <xmx:GedPYp7OsYdSCPN_UvcZzokD7bOocpfDg9qb4dNE31MjxXkjDScD1A>
    <xmx:GedPYpiJ5YTJuXujrFgAogws8Z7R2W0NB30dtfdArWau0r0Xf8wUzA>
    <xmx:GudPYmvYjBagitjTEpRhOdK9OSCTEWa-ZEhBnA6Ui7QwURGH2D-AWQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Apr 2022 03:41:12 -0400 (EDT)
Date:   Fri, 8 Apr 2022 09:41:10 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     emma@anholt.net, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/vc4: hdmi: Replace drm_detect_hdmi_monitor()
 with is_hdmi
Message-ID: <20220408074110.bz7jne46k7zvrizz@houat>
References: <20220406165514.6106-1-jose.exposito89@gmail.com>
 <20220406165514.6106-2-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tcuh5kewzo3wuhop"
Content-Disposition: inline
In-Reply-To: <20220406165514.6106-2-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tcuh5kewzo3wuhop
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jose,

On Wed, Apr 06, 2022 at 06:55:14PM +0200, Jos=E9 Exp=F3sito wrote:
> Once EDID is parsed, the monitor HDMI support information is cached in
> drm_display_info.is_hdmi by drm_parse_hdmi_vsdb_video().
>=20
> This driver calls drm_detect_hdmi_monitor() to receive the same
> information and stores its own cached value, which is less efficient.
>=20
> Avoid calling drm_detect_hdmi_monitor() and use drm_display_info.is_hdmi
> instead.
>=20
> drm_detect_hdmi_monitor() is called in vc4_hdmi_connector_detect() and
> vc4_hdmi_connector_get_modes(). In both cases it is safe to rely on
> drm_display_info.is_hdmi as shown by ftrace:

How do you use ftrace to generate that?

> vc4_hdmi_connector_detect:
>=20
>     vc4_hdmi_connector_detect() {
>       drm_get_edid() {
>         drm_connector_update_edid_property() {
>           drm_add_display_info() {
>             drm_reset_display_info();
>             drm_for_each_detailed_block.part.0();
>             drm_parse_cea_ext() {
>               drm_find_cea_extension();
>               cea_db_offsets.part.0();
>               cea_db_is_hdmi_vsdb.part.0();
>               drm_parse_hdmi_vsdb_video();
>               /* drm_display_info.is_hdmi is cached here */
>             }
>           }
>         }
>       }
>       /* drm_display_info.is_hdmi is used here */
>     }
>=20
> vc4_hdmi_connector_get_modes:
>=20
>     vc4_hdmi_connector_get_modes() {
>       drm_get_edid() {
>         drm_connector_update_edid_property() {
>           drm_add_display_info() {
>             drm_reset_display_info();
>             drm_for_each_detailed_block.part.0();
>             drm_parse_cea_ext() {
>               drm_find_cea_extension();
>               cea_db_offsets.part.0();
>               cea_db_is_hdmi_vsdb.part.0();
>               drm_parse_hdmi_vsdb_video();
>               /* drm_display_info.is_hdmi is cached here */
>             }
>           }
>         }
>       }
>       /* drm_display_info.is_hdmi is used here */
>       drm_connector_update_edid_property();
>     }
>=20
> Signed-off-by: Jos=E9 Exp=F3sito <jose.exposito89@gmail.com>

I think what you're hinting at in the cover letter would be best though:
we should just remove that caching entirely and use is_hdmi everywhere

Maxime

--tcuh5kewzo3wuhop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYk/m+QAKCRDj7w1vZxhR
xXEvAP9UGxJOBJyJT6vpqcnrX2SXVEfMxuvbUI8PJixDdrFQswD+KZRZ0ot8b8Q9
XpvzExxXXWp5s2rqKMqtSODhjDPo6wQ=
=YOmu
-----END PGP SIGNATURE-----

--tcuh5kewzo3wuhop--
