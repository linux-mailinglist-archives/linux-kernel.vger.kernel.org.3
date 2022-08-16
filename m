Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EB8595EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiHPO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbiHPO5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:57:23 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB42832CB;
        Tue, 16 Aug 2022 07:57:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id e15so15323675lfs.0;
        Tue, 16 Aug 2022 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=DJpIhHSmwiUl0PVEL5w9r+ENFQO/Bo0qgvVnXHe+ILo=;
        b=L282jd9/OJMbXjdVbGZ/ItWw29PVOL5oeUoysdLtcOkJXNf+yO+xTWKNg750ESjxPn
         ITbu5qBzzdnDhXDt/lhB0scNeLuDr0HgD5PWOmDKnBoWOjphYu0Kb1dwEDiBj0XFZ1G6
         tTiIh/0P7S+Jgim6ZeC2MBj3iE0aplO9lcZIftF+bI2bokna6TWXKmkRD0FBLb2Qerr0
         9kyUgJ9kFuJGsmBBZj9boGdv/vliPzwwTqP5spvqjKpYk28SECid/4NM34A9qTNf6WaH
         Hx8q58KGRH9X9M4bEPVcuiD6o7Bcp8qN+RdI6daE46LdWEKYNetbs4QReXWF5zPdAT/p
         0DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=DJpIhHSmwiUl0PVEL5w9r+ENFQO/Bo0qgvVnXHe+ILo=;
        b=VTvSBywehVyFlOh/t0JpgpYXY5cBREVyh+tSETl7RZ0sK1gL5zqm958pXcjv9KUwFM
         0RKrsZthCj4f3L/Z0AghRT9mLfJUyLxVm3e5eDWHDzI0UaVMVRehJVgZGUGJ3uUySh0O
         iuaREiatgmBcKJJXzqycm72CgZmzWiNj0c8B36w7DEXDYSYKO/jA1Gaa/yVLtgUJg/WR
         ICgpqdF9zUm4jjZ8zOU1sn26jlZtTGefLKMWHA0Es/sGugPdmuD2zUvgRRaqjZoLpJJU
         BXiaAYmnq6pVU3Zn9SyxOcElBoJs8g7DVCr/VN6Opj7AkRZDk1ImkvCMNi2fNfbpePJo
         /WzQ==
X-Gm-Message-State: ACgBeo3QUDhA4aiKpTgfMK1qNgHHMuNc5ZjMHuqfPLgwqeP29bC1YoVX
        s4lIkee92NY4ZeEMkYbJQ30JSkHoxVi+nQ==
X-Google-Smtp-Source: AA6agR5n64pSYAYjJ3psI1/OGPnDHkFnVFQuqa/IHrtSvNgvBQbpBe461QAVeNPqV5N7o2KBBc+d1A==
X-Received: by 2002:a05:6512:39cf:b0:48b:443:dce2 with SMTP id k15-20020a05651239cf00b0048b0443dce2mr7098507lfu.604.1660661840412;
        Tue, 16 Aug 2022 07:57:20 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z7-20020a2eb527000000b0025e337443dcsm1821369ljm.87.2022.08.16.07.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 07:57:19 -0700 (PDT)
Date:   Tue, 16 Aug 2022 16:57:17 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] Improve MCP3911 driver
Message-ID: <YvuwTVlgTeDvCTi+@gmail.com>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
 <99d7784e-e59f-b4f7-e275-935836e5d406@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DwBAA02a1nzZgzSv"
Content-Disposition: inline
In-Reply-To: <99d7784e-e59f-b4f7-e275-935836e5d406@linaro.org>
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


--DwBAA02a1nzZgzSv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16, 2022 at 01:22:31PM +0300, Krzysztof Kozlowski wrote:
> On 15/08/2022 09:16, Marcus Folkesson wrote:
> > v5:
> > - Drop remove function
> > - Split tx&rx transfers in mcp3911_trigger_handler()
> > - Moved Kconfig changes to right patch
> >=20
> > v6:
> > - Go for devm_clk_get_enabled()
> > - Cosmetic cleanups
> > - Clarify the description of microchip,data-ready-hiz
> >=20
>=20
> Please include the diffstat (format-patch does it for you, but if you
> prefer to use other tools - it's your job).

I'm sorry, I do not get you.
The diffstat is included in the patches, should it be included here as
well?

/Marcus

>=20
> Best regards,
> Krzysztof

--DwBAA02a1nzZgzSv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmL7sEkACgkQiIBOb1ld
UjKs/A/7BP7wFsxdmgbjUPjdcgbp3fxWSePvKM/TmsACZFj1Zwwux3q7SgrQLiOB
n/FXcXjdY8riBJIthPJmVYRhRZ1O++YjQNkqLYPaGKbZRgbaJEtNmYK6go7i7Wz4
lluK4BFyamxoz2GZsgr+8FM5SOxAsXS6QmFlKf+X8kBGRSBahfhs/FlJyRBuhV7f
qkDbzTMm55WIwpz5/oZA5colUhEATf3toUEjMG1fuczv6aJ2yX/19KaKc7QjqhNA
bWHxpDGeF/WpFOl6q3olvlK6j2kMxKS9BAoNI3ly5jq42++6+mDlRiP3CgwozB9K
sgbxSUufJt/2d2ewVP+SUt42mrVenznUB+dDGdnTA5UJU/xhcxNiEANZpd/MGqEq
b1ZWdOkSL2xXjsDkGK25PGVmYomglXQ0njyP8rgqIauP6QWYDXg7iLs/Gs5WTrqF
vCdZfWuAzBi7zxh2x41QglQYxndryyYtoorJ8/fk7rBDAU+sP6OhHASm4ybDy4ND
3I+pdVmbv50IEc1ayCvBiYP35Y8jbt1uB8OBg/oEgmfwrqMqcBZVjTFxcUEzEFHM
B08lK52MUjQUeCai9t7p7xvnTJ4z8QJZXmIrvV8IeABEKgrMdqgq0oDa9mikwkxM
0LgrNLxxECLK1RIb/dDT6nv95xcJNS5ZWK+v1WyFom2W/1RDslM=
=eTW9
-----END PGP SIGNATURE-----

--DwBAA02a1nzZgzSv--
