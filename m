Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9AE5598ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiFXL76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiFXL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:59:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6686F79A;
        Fri, 24 Jun 2022 04:59:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z13so4010067lfj.13;
        Fri, 24 Jun 2022 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iZCsld/Kwu7GK8ETue9xYaG0XWT7s0wsxnFfMbbKZpw=;
        b=q5GFNawCB7XD7hhK4bKucbqihbOQVduc4fBNFokKiL9iwTssnAnfwEeAvxMhnNHfhr
         pdZY42syRC7AUTNrsnZ8pBTpbswErIrN7Wf01LvwxrePY0LDckvuftmQqnMD2C4ZuxX1
         QiyVKAffeNqGlwuSVBZWzMMMZQAk79546oNQJHPntzPjAXSW2kQGg9E3K6oiqrdHG7WQ
         sZAe6hyg3epf46+llJNZryZ+XvKvQSS3Mm5fVFQEH3Q6/ZBeYkF3BkiBO9zO5qQp8ak0
         EXmvHEeiUCAwRBaBfQP7uiJn0925IlAnU8uABCbm7Z85rMYyn5AS2VM1v8OzoThDw2nH
         88HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iZCsld/Kwu7GK8ETue9xYaG0XWT7s0wsxnFfMbbKZpw=;
        b=BOPeL851R3tsIJI2qSIqrklsNgWnH5r4YfSgJPEED331TfE85R8bK3Oq+Nlsbfsdp+
         UrbGbJyLYUjxA73G6zbCDUd3MXaHcoCrQhel7r9vn8sBPawtZ2m4C5FQZxRbI2yKC87q
         kLPhxvD5wAGrugiU0cxJIje2evBEZaRVUw3BQZ96ifdXNu+/2rLQAS4R9JGzWJ+68NP0
         LaBns2WN69/50ysDv72fY/kOwi3M+ouBamQsjk9XXePHssafnd+JhkFods4bwff52sG2
         zjtiAU2xdVAxGw153uhtxrFrowxjCBobWae2yOrB3msbbS1XPeDVW2Sm5z8M+yCzE3fL
         SqDA==
X-Gm-Message-State: AJIora99xA4DSuqccUHdGhA09gJuJQ+vBaWwBgJZROYt3E8l00bc4TWZ
        3gKoQvgCGYdSEpmFYMaS/nE=
X-Google-Smtp-Source: AGRyM1sFbNItZpRs+PanpXqkVxryAqQQaTc2hSmSvHlaEy9mIvpaKCYqmgB14os3iTdcKVQkoOsXtQ==
X-Received: by 2002:a19:9209:0:b0:47d:bb62:9103 with SMTP id u9-20020a199209000000b0047dbb629103mr8845659lfd.314.1656071992959;
        Fri, 24 Jun 2022 04:59:52 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id e20-20020a2ea554000000b00258eac98baasm258521ljn.77.2022.06.24.04.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 04:59:52 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:01:42 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/10] iio: adc: mcp3911: add support for interrupts
Message-ID: <YrWnppnMcsqfFxaw@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
 <20220623170844.2189814-4-marcus.folkesson@gmail.com>
 <CAHp75VcMtz1ax3SEAwM8fCWqV-7ZZW6FWRB9v4W0k0Fi4CJ8-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uHkWNRERGs3Dz+ti"
Content-Disposition: inline
In-Reply-To: <CAHp75VcMtz1ax3SEAwM8fCWqV-7ZZW6FWRB9v4W0k0Fi4CJ8-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uHkWNRERGs3Dz+ti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Thu, Jun 23, 2022 at 09:04:51PM +0200, Andy Shevchenko wrote:
> Unwanted blank line.
>=20

Removed

> > +static int mcp3911_set_trigger_state(struct iio_trigger *trig, bool en=
able)
> > +{
>=20
> > +       bool dr_hiz;
>=20
> As far as I can see you don't need this variable, just call if
> (device_property_...(...)).

Fixed

>=20
> Unneeded blank line.

Removed

Thanks,
Marcus Folkesson

--uHkWNRERGs3Dz+ti
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmK1p6AACgkQiIBOb1ld
UjI4bxAAtxliZ5qiESZfQzSB1pwoRXxWZIKt87PbqOLd1Rrs/8hqyIfy0za/LqYu
x/NdKAEN9GaTUdSmFnxTPmMV11bIxS/UJwRd8EqiyOk+cp7riJS9u8ICfM/WSEj6
tn2SL/6pvIXoTrmu0pMHvYiVQVfJYVT4urJ6Xd/RktI/FbPi85lfvn69o7aLvqXA
vTD+3rkupbuIV22FOxr/V7PIS67d53QhbDhv+F14EqQEgK32HM2zFDDORAXSWwIz
5cVN7H0Ze+ejE5cIXUxKdwY7gFD5vkgSU4kZ5qGjtn2Vy5V7PmyB2t/bTxhqYoFI
maJ2nuBHaiqKE7vlQnOCk7VDw5Eloc+1HwH5/P4eZeKdcQ9b1RfDi/zLqrkesYtE
D874CkONDMXwgNxM1US0QGxQO1vltfnGOqu6k0j4NKIULADtXBoQba1ewj/KAB9n
VFOQxEuXqJ21RGqdMdxN+1UEn8k+ixbgWPYXovn3JtNYsf/2aO3leB7kNGUmqCr+
rhkFumra2F8k8G5VZsLeJ+9+8YBrx7V6P2cbXiOHbiKYxnPec2pyzUwRTaf8QvoC
6QVHPu0xnVyZ8bYatWtNYejPIFKHZsz8wFfE/KyvYA34TX2x7mRlllJIjPMfLlE2
TKkcGvA/Z5vxnZzUaP3cz3nuCwg4YuOj4O5zfbxnkH9PhxszIHY=
=5y0I
-----END PGP SIGNATURE-----

--uHkWNRERGs3Dz+ti--
