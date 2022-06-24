Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173CD5598FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiFXMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiFXMAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:00:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F140F7E01A;
        Fri, 24 Jun 2022 05:00:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i18so4067252lfu.8;
        Fri, 24 Jun 2022 05:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J1XdX7mOs4PQCvPjX3AV+egf4qnkDx5R0ibjLDjwibs=;
        b=UKoCy6PQNnLbaiwtrlNx8qDRYYRIW+/RmEVjVX69sDkqGDyi4CYG2prmRse77pE+Rn
         jd5lu6z2rdDzKWxSkJBYHs3fQZGf5EgJeaWIgBVgT45ZDjwjFWSvIhIkfi/hFc0Q/M95
         bTHwdk0jXuUC/Qp9NUg4nJMOm+gwUpdJtHO4fAhvbYV82znCfMp8lY1qEX1mB7U6MQvx
         6ppaotQDGPGiknEQ3Ul/PNSHMLdXMrAgNnGGgxLtQTTXDURtPtaZqdWGpO+ZR04mWXX2
         Yz+L00cfW8ub+BMhNXlk8KbMkid1nvBy/ukyfQQyYI2pNtfzl/QkHHhGNHr+6uqtzfNq
         7aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J1XdX7mOs4PQCvPjX3AV+egf4qnkDx5R0ibjLDjwibs=;
        b=ueXay0lJht/+lVImvFdVWEs5ZfVbB00NHMvxfOhNEZN/wGpwvRF1TknZD+ccKBHxyv
         KwH2GvDZVC4jUQOmigMmN8PoeoDh+f0H6eRaagisDQWuZPjmemUiwCmvyy7YNSCDMNC3
         9sXKUaiLZVNOnSHK0astHOpXFFhHzjIfj29R43GAJCRiB4FLLNa3dWL0rGD71thh4uYN
         tiaSCHw190Q5Ub7lEWrhIx8amxGH6p24oezz4HkPzbF7TEROE7OSAB8Zj0upouzoSx8r
         MOxX6S1nMvqVP8e9lGm9TRDyavl5s+YPLdtPOnXsr2Y06SIX5KIrMBKYbVy9FpfyUCf1
         vMJw==
X-Gm-Message-State: AJIora94DIPME+YLNQzcXqmnMQp9nhqnIA9rqRNdgM9eAxdJ8gA16K2y
        TCqUCdR/IOpluk03TCEnJs4=
X-Google-Smtp-Source: AGRyM1u+LiVLlOxu1rGzTrm6JXEBuzVL6bEDjNHjy7py4Y0a2Hev3JC4qUfQD++9Zijsn+4QP17sEQ==
X-Received: by 2002:a05:6512:11c4:b0:47f:2356:8ce2 with SMTP id h4-20020a05651211c400b0047f23568ce2mr8515752lfr.365.1656072033321;
        Fri, 24 Jun 2022 05:00:33 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g6-20020a056512118600b0047fac765f39sm333119lfr.219.2022.06.24.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 05:00:32 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:02:22 +0200
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
Subject: Re: [PATCH 08/10] iio: adc: mcp3911: add support for phase
Message-ID: <YrWnzh0cH70rlb+M@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
 <20220623170844.2189814-8-marcus.folkesson@gmail.com>
 <CAHp75Vff8Avpxany=5j3e+4gmAAefJgDVX3riONN-=VLwj1HNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mGSgN1urBpJYjTZ/"
Content-Disposition: inline
In-Reply-To: <CAHp75Vff8Avpxany=5j3e+4gmAAefJgDVX3riONN-=VLwj1HNQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mGSgN1urBpJYjTZ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2022 at 09:07:21PM +0200, Andy Shevchenko wrote:
> > +               ret =3D mcp3911_write(adc, MCP3911_REG_PHASE, val,
> > +                                   2);
>=20
> One line.

Fixed

>=20
> --=20
> With Best Regards,
> Andy Shevchenko


Thanks,
Marcus Folkesson

--mGSgN1urBpJYjTZ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmK1p8kACgkQiIBOb1ld
UjLmTA//a76BF2w9eDtrW+vPPvplu0HpGwk7vkF4F+EfwS/1kfSOI2lY2/N5ufdf
AiPYouf0mNyCfjMf86DxGiBjIBoKEdo5d9AW5SYEGv/8kHxTm3gzdy5Y2GR5WSnv
Z0mVcmb3g1rSvHJgk8tKkpk/Q+SRuNy31rpwnLZn+nNAlFQ90dH8lrFCvrXvi47O
llYbO7kVLU5ZsA5rwv5cNfF0+XDXYjVwQ7ukxr47eHc41F+djhjn/Ozg32gdbuxq
3Pbb4RZOfI86NEzey3xlye990lQgkatFIzPRKqqxMCIBIfkJEcUNBdh9vTAeUimg
krEGwYjtZmMvluGtTbHMUZT5GxNxqpQNndiMsUb7l29EMwrnSsxon7UrPAL3zIq4
X0UMQAd6lDA5oL9s/IR8KT96EWutvLuoD6MQbBEArHBr2qEcAKsGMjvx/E3onFx2
nK7OIWIdXbNuosADCCv3of98nDOkm6ihDWnDudxAej8y2SFdwCiDwOzVkSPTP0/Z
ER4K35QrFawzdyUFwUEWry08WODwndPJIFPSSsDxDKBgbNGQGIgyTRE4N3H4atNq
0KEJ0Pk9BzjomNkS5qed13yIncbkz1K3RTuzpmuaOFKJ9/YswcL2i6Xv//uhDlKj
bAlsUopqWKPN0dbYO916HwDHEhkMXpi4qJt7/qdsQlcG4GxFc4Y=
=Tm0t
-----END PGP SIGNATURE-----

--mGSgN1urBpJYjTZ/--
