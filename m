Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F8E533CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbiEYMtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiEYMtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:49:40 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB8290CFD;
        Wed, 25 May 2022 05:49:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id C867D2B04FC8;
        Wed, 25 May 2022 08:49:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 25 May 2022 08:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1653482973; x=1653490173; bh=eaiu7WjY6z
        D40HP4rAo3IAZYmjjndrOI/2cEvX4csok=; b=hGkmkh40PbgZX9Of7alO0L4nz/
        u0KAEfygYZOS7i15rXim5Tk4gqj3x9aJAu1rpxD+TqKSS0pfly3qJ8sSHnoQPG9l
        T3fo+L5vovWHv1OCASPWKVvE/GFJd0anax4y2QI0avPsZIU6RAzXNKzEl7H0qTt1
        qDnjTXdNW9FhjeRZ8jfx0cvwtL+zvvZdzP9w/oQvWZ9r7PHY35y+R+aylG/Gbzuo
        s23Amv8bePoFhHfMInYOh+LVLvSocflrg4iXjXiTrrK/RUu1LBOtklRYs+bl7JbT
        xcKbrksMk+Va2gKioQ77h8Pi0x7GgVNmwNociaPlP9RSr6aiXNrin9fFvKjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1653482973; x=1653490173; bh=eaiu7WjY6zD40HP4rAo3IAZYmjjn
        drOI/2cEvX4csok=; b=BTsEsaWhS8WPM0Vt3HLBg0xiiXsVuvwHCHD/mYfULC51
        OGXa7NACfrD1NIBmkcngXBzPMXfPZQGwp0KZPVBqLzsWQ0wPYGrkgmCmZZ8mNG3s
        /olq6eMFMzZWAifGO12cYT1zYRt0p89fid+8eR124vldGNWxNKUQh45powm70WQ7
        1V/xPHBaWa2ZuLoaqw/44Ob9tAxXud4SnCFO5NUWv5EFiDjT2TISnci0bKM3Ec0t
        OL2yplu3bRCdBrNAaZLoSoBPPNZ4C2EaToPbEVKnAxWf5l2Sv1iGd7EzIEIDYCaH
        SbqYp6vbHYshtziMUvo9viX/j3uIRsdMoeCeUrfiLQ==
X-ME-Sender: <xms:2yWOYsmU3-YEvjZlChEY5l23_N3oJCXBeGrMp2qyQOexmoZnrKWkFg>
    <xme:2yWOYr0LIewrIqOfkQNFBzNn-hjZhAAG6qnODyOZgtWzZpkTWkzalMP9fmnAhueEv
    AwTPCJ4dMWYRmJgDLc>
X-ME-Received: <xmr:2yWOYqolOuo-7Chbr7kYEEVwEBKlliGyAD__t980v-zrWO8DBJSOCAg0pJ_mFg5eirtZqdRQ5eA6EGynVdQ2xCO6PYJtv49VmZwH1Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrjeehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepledvueduvdegleeufeetjeeuvefhieehjedutddtffekleekgeduiefgffdt
    hffgnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdr
    thgvtghh
X-ME-Proxy: <xmx:2yWOYokxNGLf2r_NPjo4tKepz-vx_Ffssh5GsCQzPjefA-MuzJgLhQ>
    <xmx:2yWOYq3xSWkbJp29jSovxWrqnYvZQeVqneOSQQiJedUMjPJV-uloIA>
    <xmx:2yWOYvvw_5WfOM0upiSlM8_i2rA2auiZ9kUe7KytAG57ukGC_Agwxw>
    <xmx:3SWOYonHU7I6BcZLdqlDu5zzUPBBgPp70dvVRO-pcBzItWWo48M9pWTQXV4>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 May 2022 08:49:31 -0400 (EDT)
Date:   Wed, 25 May 2022 14:49:28 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Helge Deller <deller@gmx.de>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v10 01/21] dt-bindings: mediatek,dpi: Add DPINTF
 compatible
Message-ID: <20220525124928.wtfzpxr6lm7bdc6k@houat>
References: <20220523104758.29531-1-granquet@baylibre.com>
 <20220523104758.29531-2-granquet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="caypywv3zyehybgx"
Content-Disposition: inline
In-Reply-To: <20220523104758.29531-2-granquet@baylibre.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--caypywv3zyehybgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 23, 2022 at 12:47:34PM +0200, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
>=20
> DPINTF is similar to DPI but does not have the exact same feature set
> or register layouts.
>=20
> DPINTF is the sink of the display pipeline that is connected to the
> DisplayPort controller and encoder unit. It takes the same clocks as
> DPI.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  .../bindings/display/mediatek/mediatek,dpi.yaml     | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.=
yaml
> index dd2896a40ff0..6d9f6c11806e 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -4,16 +4,16 @@
>  $id: http://devicetree.org/schemas/display/mediatek/mediatek,dpi.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: mediatek DPI Controller Device Tree Bindings
> +title: mediatek DPI/DPINTF Controller
> =20
>  maintainers:
>    - CK Hu <ck.hu@mediatek.com>
>    - Jitao shi <jitao.shi@mediatek.com>
> =20
>  description: |
> -  The Mediatek DPI function block is a sink of the display subsystem and
> -  provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel data on a parall=
el
> -  output bus.
> +  The Mediatek DPI and DPINTF function blocks are a sink of the display
> +  subsystem and provides 8-bit RGB/YUV444 or 8/10/10-bit YUV422 pixel da=
ta on a
> +  parallel output bus.
> =20
>  properties:
>    compatible:
> @@ -23,6 +23,7 @@ properties:
>        - mediatek,mt8173-dpi
>        - mediatek,mt8183-dpi
>        - mediatek,mt8192-dpi
> +      - mediatek,mt8195-dpintf

Weren't you supposed to change it to have a separator between dp and intf?

If it's no longer in your plans, the second patch should have s/dp_intf/dpi=
ntf/

Maxime

--caypywv3zyehybgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYo4l2AAKCRDj7w1vZxhR
xWKiAP9jtTFxn2122rC75otB3OE+m4SKrY6xBG/6lAdnXBI9owD/bSCJW1MCt4Ee
lpQaGgsPznT9oNA3vaB9Gk2SKS/dRwk=
=56gL
-----END PGP SIGNATURE-----

--caypywv3zyehybgx--
