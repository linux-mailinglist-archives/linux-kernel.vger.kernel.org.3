Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA9592941
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiHOGCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiHOGCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:02:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085D0167ED;
        Sun, 14 Aug 2022 23:02:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c28so5314373lfh.3;
        Sun, 14 Aug 2022 23:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=TUs92hFJ6oAIJwA9LsbBF3pLnj/tNNQ0KC/PJkq1Csc=;
        b=AjWZediW3o3RxM/n9qb1ll95DeK79BVs3OHyvt2BiAIGO08Vq/iabkpR8UzFWQvDSf
         K8V264bpAqyvad9WEEs1KoaC02B5GD9Inrf02bfpPG285eyN6+qhd6gIG3ExO5cKnxWm
         tHM/LKsIl1UPQSdVcXmkB6PgZLXbAoaBe5AlTh3CxMLQAbMKgkJS1luxeo8aLsE1zsB7
         tuqddLYtAh0gugbbgJ6n24Glcmcv0mcuT3NvYim71XQ1RlvZbcADxG7Fa2oZbhD0B0gX
         LySPLXo7fIktEa8qjAKOtIwW4GrqenF2dLLlpuwzD0asYdEVOApB960xL50CWvWNZHvN
         GfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=TUs92hFJ6oAIJwA9LsbBF3pLnj/tNNQ0KC/PJkq1Csc=;
        b=VLSYEwMcd+N1IdYnllDeWOuCc4u7YzPVW4uwl/0eB6o2BsQRoROp4rqzcbFe4l9E7E
         nYNv7y67FbM3LSlo47CFt3wmTzm0hYVe5ayFIsxotJztegPl9ZBmsDSyjsDvQLsGUrr8
         3tmYz6rrA7Cpt6YtL5ftkyP/KhGFjao12Z7aDNohiuKGAXfldqT+NTTOOmCTDMrz542I
         028xc6WA9o9MMSsQDST8L0vXdpPZM/jMue2W4AarXDsPt/ARK9kRx1UaukWIKhbXeg9r
         HhQdt6kRkpqDQXFTDQUF41MI7GWt7OvxLQk+4HKb3Y8UgG3L6aqewpdgWGn3UAIh16g7
         LPcg==
X-Gm-Message-State: ACgBeo06zGB26lkRwWgeRHQzF8mZ9846O4h8Pq6IlBOfOkNN4askEu3u
        9g+AjAO9+JxOSJlIhmhE6jTw/IGIIEVMZA==
X-Google-Smtp-Source: AA6agR6FLbcub2PeWAS/l3ApEYE1qJp/ftj/roMFtswOsiTvKcdSpH1hbD/01OFAacY98YREjXUFjw==
X-Received: by 2002:a05:6512:b28:b0:48d:b55:c061 with SMTP id w40-20020a0565120b2800b0048d0b55c061mr4767950lfu.302.1660543334226;
        Sun, 14 Aug 2022 23:02:14 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id f11-20020a05651c03cb00b0025e0c352465sm1303773ljp.82.2022.08.14.23.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:02:13 -0700 (PDT)
Date:   Mon, 15 Aug 2022 08:07:01 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 7/9] dt-bindings: iio: adc: mcp3911: add
 microchip,data-ready-hiz entry
Message-ID: <Yvnihf6y1qGEOWq7@gmail.com>
References: <20220809073648.167821-1-marcus.folkesson@gmail.com>
 <20220809073648.167821-8-marcus.folkesson@gmail.com>
 <CAHp75VerfFgNKRbE=f0LnpRBr1o=qNwSnUkzq69BeECJFY9Vvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="swltbkbSHetuPsfS"
Content-Disposition: inline
In-Reply-To: <CAHp75VerfFgNKRbE=f0LnpRBr1o=qNwSnUkzq69BeECJFY9Vvw@mail.gmail.com>
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


--swltbkbSHetuPsfS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 09, 2022 at 11:57:19AM +0200, Andy Shevchenko wrote:
> On Tue, Aug 9, 2022 at 9:32 AM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> > The Data Ready Output Pin is either hard wired to work as high
> > impedance or push-pull. Make it configurable.
>=20
> ...
>=20
> > +    description:
> > +      Data Ready Pin Inactive State Control
> > +      true =3D The DR pin state is high-impedance when data are NOT re=
ady
> > +      false =3D The DR pin state is a logic high when data are NOT rea=
dy
>=20
> Wouldn't be better to move " when data are NOT ready" to the main
> description text:
>=20
>       Data Ready Pin Inactive State Control when data are NOT ready
>=20
> In this case it unloads the list and moves focus from the part of "NOT
> ready" to the real part of what you pointed out here --
> "high-impedance" or "high".

I think I will put it as

Data Ready Pin Inactive State Control
true =3D The DR pin state is high-impedance
false =3D The DR pin state is logic high

As "NOT ready" is redundant is it is a "Inactive state control".

>=20
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

--swltbkbSHetuPsfS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmL54oAACgkQiIBOb1ld
UjK5/xAAjXlhTbU0FzS0A7Zdh2V2zprGvzUFGqzLCI0u4n9lC8beI/o9b/uRWR/9
Bz8J5MWTGLS1s09nYsk1A3VseA+M1HSABjd5QPaHf/+tjPqrzO5TJyVQ5nRTXy12
haS8YDOCLoytgNVqq0S5ZRVKjogsJCfJ8Zwf8PM4PmyJJGXVYBPJs66aTWvnuxvH
LuvXsODDE1YtVoOn441oigVQfY5MvrrTx77KmD7ekb1A8/qyZV8NHZ05hAiKsYWn
JYFt4hdHeVec3UxzMaJsgVekrizYwb1CKp+hlDuMMb92CJq1JD5hLmrmAFY/JtGC
IeyZWmPL8QLiHwqTd2xAuWdqsCJxlQbWo9l0lujPxpFADpqVKcpvCQfPfYFJAuba
oAjNpR8ypnApsAoz5RoyKcXMPAEGE9xw7euqu1BDbKGUEUL+X7Zm/9acv4V7uaMv
1fBcqolDncboQqYmW/Dp+fRpU1ZVVezsBQE5+Vy7jwowMWL6XE78PW2fXBUqvLqL
TPut1yjGhDAfSloP2on8yb9geRLqbWKdpIo2ovCN0ebUFdM5JZdKBZYM94yJwveE
KTpZIBGpyS57MKCVI3wbPSDB8qzHNuDCZ2OdNcbL8OvFP72TV75P9tDkr5LMdF+J
rSsF88ds8qOzAz7lU7bmBIS2WuKU+dpLThw+/kgcvb40j12hGA4=
=MRCF
-----END PGP SIGNATURE-----

--swltbkbSHetuPsfS--
