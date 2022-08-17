Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD208597384
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbiHQQEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbiHQQD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:03:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F97131EC3;
        Wed, 17 Aug 2022 09:03:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c28so15529306lfh.3;
        Wed, 17 Aug 2022 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=jVtXdyIgujEW9yCQqJi5T2OfpGkjooy3feMVnemJH3U=;
        b=oPv17D58CBHupLx32DQ1PHSFijpvfIr+xBgBSG6ogNOD6KohOmMk5sLkkt+OMj+cGv
         bkzkZTkJG94qz37+RqLKbo7nga7PTtMmvuIB8H6JcT8AtYsoWlEQq8hbAVE6B1DkOw6i
         I1x0H7gTONtP5KaX8doFoW5pmgAkf1YyXoNnre1c4Z0/wXXR6apGvYnwHjV0evbfF1uK
         walVrQ785N7fLJO+O8G2vjUA8p82yp5cgBSiU5wYlzuU98lEVFAr4xYlNKs1wr/izTl7
         O3YBqlQsA/+Gsst3EYzSMioutsN6IWgb7qfBVvZBTLXMBu5Wmzo8RMc1w60W8nFBxKUu
         mjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=jVtXdyIgujEW9yCQqJi5T2OfpGkjooy3feMVnemJH3U=;
        b=wUtSfrIRGYKuceRziew1eB2or5QHnN6uXazOdw98XoXAJ+THMiofOSszANUMijhRol
         KbEb4OgVpRLBg6sBqOXVXMYvFHHTGiEKn+snk1pCCfBOKS/RnXEvQoyh58SgpO4WIi5O
         8yA16j+0XFLCPQmPvSfcd5xT3FaVwYQ7kzdp8bM5o6QJDn/QwYsQf/cTsisObJe7oFJ4
         8qWatf1Tw/BB1s7gPNpgDgCV+Wu3r4zQvoZueZc6wx/UmdiTvQec0PfDCNtu+sGDBOB+
         FwtNUK6NVoTc3Ij1qoH1odGaPNM/g6rCXNRku//AyX82BdGNOoY85f8b1dK75x2RZ88i
         Hi4A==
X-Gm-Message-State: ACgBeo1eQw3R21Lilz4VPMtus4dATR1zh9mVgDIRUeLaprrBvaFyuHmA
        RG2yXotuPilWkXKutHhr1X8=
X-Google-Smtp-Source: AA6agR5BahLaInyCk5qBo4MT6CcZ/iPJ7DXGEc/Dm1fWRm51euvuBkasFGHzXiVRIOJA5tDmUBURzQ==
X-Received: by 2002:ac2:549a:0:b0:492:adc8:106c with SMTP id t26-20020ac2549a000000b00492adc8106cmr423608lfk.90.1660752191037;
        Wed, 17 Aug 2022 09:03:11 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id u21-20020a05651206d500b0048b0a5293ccsm1729891lff.78.2022.08.17.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 09:03:10 -0700 (PDT)
Date:   Wed, 17 Aug 2022 18:08:04 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] Improve MCP3911 driver
Message-ID: <Yv0SZG8vMIz7oF64@gmail.com>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VE85pcEAIHvs5F5g"
Content-Disposition: inline
In-Reply-To: <20220815061625.35568-1-marcus.folkesson@gmail.com>
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VE85pcEAIHvs5F5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 15, 2022 at 08:16:16AM +0200, Marcus Folkesson wrote:
> This patch series intend to fix bugs and improve functionality of the MCP=
3911 driver.
> The main features added are
> - Support for buffers
> - Interrupt driven readings
> - Support for oversampling ratio
> - Support for set scale values (Gain)
>=20
> Among the bug fixes, there are changes in the formula for calculate raw v=
alue and a fix for mismatch in the devicetree property.
>=20
> Another general improvement for the driver is to use managed resources fo=
r all allocated resources.
>=20
> See patch notes for more specific changes.
>=20
> General changes for the series:
>=20
> v3:
> - Drop Phase patch
> - Add Fixes tags for those patches that are fixes
> - Move Fixes patches to the beginning of the patchset
>=20
> v4:
> - Split up devm-cleanup functions=20
> - Cosmetic cleanups
> - Add
> 	select IIO_BUFFER
> 	select IIO_TRIGGERED_BUFFER
>     To Kconfig
> - Add .endianness =3D IIO_BE
>=20
> v5:
> - Drop remove function
> - Split tx&rx transfers in mcp3911_trigger_handler()
> - Moved Kconfig changes to right patch
>=20
> v6:
> - Go for devm_clk_get_enabled()
> - Cosmetic cleanups
> - Clarify the description of microchip,data-ready-hiz
>=20

Marcus Folkesson (9):
  iio: adc: mcp3911: make use of the sign bit
  iio: adc: mcp3911: correct "microchip,device-addr" property
  iio: adc: mcp3911: use correct formula for AD conversion
  iio: adc: mcp3911: use resource-managed version of iio_device_register
  iio: adc: mcp3911: add support for buffers
  iio: adc: mcp3911: add support for interrupts
  dt-bindings: iio: adc: mcp3911: add microchip,data-ready-hiz entry
  iio: adc: mcp3911: add support for oversampling ratio
  iio: adc: mcp3911: add support to set PGA

 .../bindings/iio/adc/microchip,mcp3911.yaml   |   7 +
 drivers/iio/adc/Kconfig                       |   2 +
 drivers/iio/adc/mcp3911.c                     | 372 +++++++++++++++---
 3 files changed, 321 insertions(+), 60 deletions(-)

>=20
> Best regards,
> Marcus Folkesson
>=20
>=20


--VE85pcEAIHvs5F5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmL9EmAACgkQiIBOb1ld
UjIUog//TMw7AQhWvpdobTQEqL39MmUf8RHo9kPnosQykuIyfQ/NTe0kftmWM9II
+pCslZDN4ag29bN2c13ZAqwiiIAr+xOmKNQBzVoC1fI4cJQJAA3v4bsvvfWJTXhg
gHsRlPp+6vcn2BCtyGJWZuD0bkLr2Gdx1hXmgJrh+SCNtNr4/bBFInVQ6ufYx5Ur
d+UWG6hNvmKJSpPwxRqUkGogbaWa7gd6BTx463olRPmXmxSp3MBLloGPa9MGxNir
9S2D49VSpQSRDKBiiKTnao9mX0CgP7fM0Tq+xEuXtue2hnSpHwKUe+IjJJBp1m5v
qAJmKYt5HJeOAHpjgGS6n/IpZL+3yaALPxW/dOzhBmBRNv7qP5oJCFaTamAWN0gl
KSvtqKzo87SoGPpW5/Wr5l6p0eMA94ruPziHdbWQgggboV47wX21VCyGg32m7h/J
IRKIDv9QbzegTZv8nDYWC1oxL5xcd8qT5uNqxWH/Q4xAdfcMs9k33hQKILr1TZRC
KoNJa3/3HaVq/Q1RpygFtvhBoAWTT3z3QzIeNBHxNc1JyEc/xomxhXuk0V5OSxh1
+XyvXhpqR4CpMLHJeleW8fez3Elw8W+jipB7QyPFSHilZUEeQZMQjfxtJVxu2r22
DO+sHrHm0KrfW7K6q9Rhhr62WcKgioSWSy5llNKPKie7rC9Z0CU=
=uBb4
-----END PGP SIGNATURE-----

--VE85pcEAIHvs5F5g--
