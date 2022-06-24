Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9583C55993E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiFXMJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiFXMIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:08:42 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5770A8124A;
        Fri, 24 Jun 2022 05:08:41 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a2so4124436lfg.5;
        Fri, 24 Jun 2022 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=opz5tYqROCadOn1rTVDM2+Qm22g1iuj+39fMsI/vnic=;
        b=HE/vBhYST9BZ6cYOcgQRbu/4xMr4Y0DfHmubIAE4XpfQTE04ykvKvIJ0ex4Z1LHPtG
         EEHM+d4rKaZyCHx2xaHrQ5K6xqcmnqankJJ13uHFfhWsxiMkEMfBtOKYOHHEnfpj224k
         bF6NkoAR5VOkMllJL3CauDw6UvHB6Ue8Tx8WOmqQ71scmjLuG1XQ2k2MAAsXqjGp/sN6
         DO7TQv71Yedbl72jDKiLt/PjpITVvidmEM/0/IzysYPpDpOsLIlw+MkuWAZyBbuiJoi5
         GGhmkVXfcwfHaLDiUNlKMWLJsBgoOV5HXKSUuH58BrJJhym/FH6HDZvG9GxQzdUs3fl6
         d9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=opz5tYqROCadOn1rTVDM2+Qm22g1iuj+39fMsI/vnic=;
        b=dBxk7ePZyctVWR+qcRjx1IFp8EoZe+nCrMbpbumyS/ttjfYp5q9dhsUknr6Gtcn22i
         Rxx3eUJFIVlElkMn5TWMhKHO8GP5GRZVRUBlCdi2nPMUqrpNnkt5yORtNc7YF41eHgNk
         IBZ7rYH/cL0WsbhbWPKP6R7Ym8MGkOduhAMCxY4gdjDx+YkFZG/BvQg00/iefYEr9Dl7
         ppnhfrHEUcKTF/1m0STnmIObjXu6S8ui1NKX2hWWSUy864r9Cekzkt9ADCy764L+JvZb
         cZXU6rLlQHq2RHda9sp5AFJw5E5tSGbgT651HIzQuC13QjZ7yxKmbRjvJsrwvCOlXZ7b
         2cag==
X-Gm-Message-State: AJIora+XjBkby0wjx+bmNNH/OHqlRVjPKPK6FyjHYohsJBiMx+oIWZoj
        glzpKwCplbksyx3jQ9aiUcM=
X-Google-Smtp-Source: AGRyM1t9k0afR23zcetUw4S0zjC+fF7Xymatl9u9QfjVjdRgDDPkLJFolTLpcUi5+7fRsTnd0r3LYw==
X-Received: by 2002:a05:6512:3c91:b0:47f:aa00:d39b with SMTP id h17-20020a0565123c9100b0047faa00d39bmr4527833lfv.81.1656072519688;
        Fri, 24 Jun 2022 05:08:39 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id p16-20020a05651238d000b004790ef191e3sm335897lft.216.2022.06.24.05.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 05:08:39 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:10:29 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] dt-bindings: iio: adc: mcp3911: add
 microchip,data-ready-hiz entry
Message-ID: <YrWptbzVzM6fszLH@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
 <20220623170844.2189814-5-marcus.folkesson@gmail.com>
 <789e8a4e-f5a3-9e92-da2c-22145ba272d9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8dCobV3nYVqH0LOT"
Content-Disposition: inline
In-Reply-To: <789e8a4e-f5a3-9e92-da2c-22145ba272d9@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8dCobV3nYVqH0LOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 24, 2022 at 11:54:58AM +0200, Krzysztof Kozlowski wrote:
> > +  microchip,data-ready-hiz:
> > +    description:
> > +      Data Ready Pin Inactive State Control bit
>=20
> "Bit" of what? Do not describe the programming model but the actual featu=
re.
>=20

You are right. I will remove "bit".

> > +      true =3D The DR pin state is high-impedance when data are NOT re=
ady
> > +      false =3D The DR pin state is a logic high when data are NOT rea=
dy
> > +    type: boolean
> > +    default: false
>=20
> You do not need default for bools.

OK
>=20
> > +
> >    microchip,device-addr:
> >      description: Device address when multiple MCP3911 chips are presen=
t on the same SPI bus.
> >      $ref: /schemas/types.yaml#/definitions/uint32
>=20
>=20
> Best regards,
> Krzysztof

Thanks,
Marcus Folkesson



--8dCobV3nYVqH0LOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmK1qa8ACgkQiIBOb1ld
UjK10hAAr40LRKfXxY293jUkq59OTM1O9R0P5rQU6QH5059uMNimRckocoUmRfwz
p3zVsJU3/Nr5yFXgH8gVUoK9N87iCo6tEIbA7KNUHKVkBEE+LWKsA8qqMsJV0T5V
S9Y8p959zp9bzy+Og31jhWDu00GiREUTnkxq7qPz6Bn+u7W0KMn4Mc1iqCcgspMo
rm+bGwPPhq6t3Bx9NYVOGybf8BayK4EqKdTzVH/vq9llGEedIGERnJkYnxJ/PWiD
kkI2lGAaNF0udUTprOifwDo1oGaVaEPh4FTJ3VX3WTNKMvHokMKeNA8hQ1Fdo8T8
mcJVXKRcoVtgwvOJHuJaVvM4aRGILTK2dmrJKss2n/q7979xtminhdyx3sAw4EuP
PeMprXH/ClBZTy25c7bYshd9QPJ4oFEGWByerqfeqAb41RTpablK/B2tL0eIwxJx
QFwIP7Gb+Gcz8Xwf9OuO7ul1c5Qomj7y2rjXj5a1snSSqRixfv4WQKdalgJpyJon
GUa/978si2oKM66jbiCCrW1YuKxUPkcppJ7/gwCXz2Xp7pWygqZDN3Anb1jZUvVq
LKVExxB9tGaabgB32pjNBi151/Ew9o4k5mRJV9hZEfJlj5SZO7HCWGbl0GTmv5SR
6n80U1Y/2hXsJJ92b35dof+rlEWI67U7MI4VO0SrRTRfotcs5Mw=
=IsvN
-----END PGP SIGNATURE-----

--8dCobV3nYVqH0LOT--
