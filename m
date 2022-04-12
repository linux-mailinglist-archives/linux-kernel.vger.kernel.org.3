Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62BF4FDF70
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349993AbiDLMXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353032AbiDLMVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:21:54 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62516BDD4;
        Tue, 12 Apr 2022 04:29:00 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 21D1A3201D7C;
        Tue, 12 Apr 2022 07:28:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 12 Apr 2022 07:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1649762938; x=
        1649849338; bh=hmx3CXYkh1Oh1bDxGnmCu2plVugwIF7Jz+ICzWddkZY=; b=T
        Vn5xWW8C9i3U+Pq3Wjzan8ABjdCrHHzpvnwv1MwXR804Lpgh6Gg+alqx5LLqahgg
        KYbrA/togZYG21pHlSgpJ9TqId+cg+Y3sHWivhyEcjh2nTu8SHK7wgCNG7y/ee2h
        wEbTtICZuK8vQ5zHknViub2xCMKSt1qtcTt2IrDXE6SFk/Y2uuXmuDrWOmUAsWCA
        6w6WJD35W60U0Qn7Y8XPqTe4YLgBG2LJUOoWy7ykCW2PuP8s4EVaVuun8IJigz5y
        EtiHljew2hSFKUsrIY9eEqw9xWxD487rGTgS18/OjBE6z4PBDgPq9EgQ/+IEnmbj
        CuNZvE3k9eaUbNQD4nd7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1649762938; x=1649849338; bh=hmx3CXYkh1Oh1
        bDxGnmCu2plVugwIF7Jz+ICzWddkZY=; b=OwvMCGdaWjWvshsRZx3aJicwGwIOX
        NGRWz5RkX/WZfq32pu6UWcRwEsqh+VdgwRKezDoIcWDLFzVCWI+vhjc8u7stS+x2
        BeuwgrvFqNQy6g+Zp4DAS72dDg4D1zo4ya117kU0OANerdISjShWBDRgAL0WzoFr
        5Dv3g//QJa9LmhFFq2F6wCn5sMlyzkciH6FuA+C127wWDvqXvfPyH25QgIu0/Zpk
        ie8ILRnoP2I1p/zXcktxzDWk2QtyyT0OouHtn/QpDEI2M+eW4UlSz0DZnASoFe5D
        sKx8XRIVfekRxug5Dn8cCQ0Chuorh5kd0/Qi7PTlQItzIbX0tkd+4JlgQ==
X-ME-Sender: <xms:emJVYkA74lULjSDFY4lP-Uj_ghG6GY_YBZ-TXhaYd9g8CGJ6kf2W4g>
    <xme:emJVYmjWhDnYQaoglBlN4UI0uD4r0S3x-FM_yHDn5MTTCTM7BYyhL8pwgLBwhk4fh
    ceJalRLS76vmDc4XC8>
X-ME-Received: <xmr:emJVYnkScaVuktUnsH43OSKPsZfJVmw15TUHXzCs8G7UGvdeOhPqg4uVietKpeCQ3TgnVfHZ0GaoVIWepH3GILJ2iExAFkNVEWUpOUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:emJVYqz_LELs1QevKCIOKQ5urphlqSlO3E9_0pV6EXJoNBUKqhe0hg>
    <xmx:emJVYpQosbGcmIY1NPYYoTGOtHCm2GMUDzCz_J8scKwtp_Yx4to4lw>
    <xmx:emJVYlbbORTnL9c2vMa3jR83OAZrZQ8E2TF3So46I8bH9pQMHZoHkA>
    <xmx:emJVYoLK03BLlDGJbeT3qKMYQDHTvQfNj0gQla9eiO_0DGyqYk1hcA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 07:28:57 -0400 (EDT)
Date:   Tue, 12 Apr 2022 13:28:55 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: display: ssd1307fb: Deprecate "-i2c"
 compatible strings
Message-ID: <20220412112855.uccrkoqgjim2dbts@houat>
References: <20220411211243.11121-1-javierm@redhat.com>
 <20220411211243.11121-2-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220411211243.11121-2-javierm@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:12:39PM +0200, Javier Martinez Canillas wrote:
> The current compatible strings for SSD130x I2C controllers contain both an
> "fb" and "-i2c" suffixes. It seems to indicate that are for a fbdev driver
> and also that are for devices that can be accessed over an I2C bus.
>=20
> But a DT is supposed to describe the hardware and not Linux implementation
> details. So let's deprecate those compatible strings and add new ones that
> only contain the vendor and device name, without any of these suffixes.
>=20
> These will just describe the device and can be matched by both I2C and SPI
> DRM drivers.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
>=20
> Changes in v2:
> - Drop the -i2c suffixes from the compatible strings too (Geert Uytterhoe=
ven).
>=20
>  .../bindings/display/solomon,ssd1307fb.yaml   | 37 ++++++++++++-------
>  1 file changed, 24 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.=
yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> index ade61d502edd..6b9d0c72739a 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -12,12 +12,23 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - sinowealth,sh1106-i2c
> -      - solomon,ssd1305fb-i2c
> -      - solomon,ssd1306fb-i2c
> -      - solomon,ssd1307fb-i2c
> -      - solomon,ssd1309fb-i2c
> +    oneOf:
> +      # Deprecated compatible strings
> +      - items:
> +          - enum:
> +              - sinowealth,sh1106-i2c
> +              - solomon,ssd1305fb-i2c
> +              - solomon,ssd1306fb-i2c
> +              - solomon,ssd1307fb-i2c
> +              - solomon,ssd1309fb-i2c
> +        deprecated: true
> +      - items:
> +          - enum:
> +              - sinowealth,sh1106
> +              - solomon,ssd1305
> +              - solomon,ssd1306
> +              - solomon,ssd1307
> +              - solomon,ssd1309
> =20
>    reg:
>      maxItems: 1
> @@ -136,7 +147,7 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: sinowealth,sh1106-i2c
> +            const: sinowealth,sh1106

I think we should have both in the condition here, but it looks good
otherwise.

Maxime
