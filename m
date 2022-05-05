Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B884651C203
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380426AbiEEOPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344310AbiEEOPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:15:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CC55715B;
        Thu,  5 May 2022 07:11:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1CC101F45775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651759899;
        bh=ohZ8s4Sd0+enIRLuka7M6eDqtjDg40errnz28w6Y6ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hMvxJdrbFacJ4zap3HqiVHXH2QG96fsoEwFKUM/OSwavLEIB/gSLowcCo2L/c6PcA
         hxiPEmCs719r1ZyXHS6N7kqB8ALISw8+NXso9NqlZgbmEuiaZzQcPhOgiIRQyd96oT
         jcXVTDLvPO92diXEjhu2yzoVbWF7kEmMm6Y5iEgQoMQKBq5LUc5bktRl5RXDyOOUHC
         eD8DlF9lTnKgsWRPfIRU/VwB9IQurHwCyem/b3SKPjaq76ZntH4dfmoPnJKZ5If/y5
         Sbs4/P+d0KYxNJO/e1GkWfK6uRCuzjFKqKjRNadwfnfFwrf30nS3HECDtc1ZhvNFcB
         ThFk5j4sSZcrA==
Received: by mercury (Postfix, from userid 1000)
        id 6A6561060437; Thu,  5 May 2022 16:11:36 +0200 (CEST)
Date:   Thu, 5 May 2022 16:11:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Jianqun Xu <jay.xu@rock-chips.com>, kernel@collabora.com
Subject: Re: [PATCHv2 13/21] pinctrl/rockchip: add rk3588 support
Message-ID: <20220505141136.yglo7ggm3styrtfo@mercury.elektranox.org>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
 <20220504213251.264819-14-sebastian.reichel@collabora.com>
 <1792093.MYTQk1Oth5@archbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zebz5ifrjpsgyo5o"
Content-Disposition: inline
In-Reply-To: <1792093.MYTQk1Oth5@archbook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zebz5ifrjpsgyo5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 05, 2022 at 03:51:25PM +0200, Nicolas Frattaroli wrote:
> On Mittwoch, 4. Mai 2022 23:32:43 CEST Sebastian Reichel wrote:
> > From: Jianqun Xu <jay.xu@rock-chips.com>
> >=20
> > Add pinctrl support for RK3588.
> >=20
> > Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> > [merged in downstream fixes, simplified register lookup logic for better
> > maintanence at the cost of a bit more static const memory and fixed some
> > incorrect registers]
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Hi,
>=20
> a heads up to the maintainer: this was already merged. The cover letter
> states
>=20
> >  * Dropped pinctrl and mmc binding patch (applied)
>=20
> so I think this was included by accident.

I missed that the driver patch also has been merged (cover letter
was just about the binding patches). Apparently I also accidently
forgot to skip the first two patches, so they are not dropped but
just moved to the beginning :(

-- Sebastian

--zebz5ifrjpsgyo5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJz2wwACgkQ2O7X88g7
+prF7hAAiSvKyrnjIzT6oufYFiLf7wuR2gohA4ENOVnLvm/9VfBwGHLgbrlFQBXc
veEG+uDocd6gDzI/tFNV8FV85OMalLfil31nr9Gwc4hwK6aMqBeBOTZukXKXzCOV
29ASi/JaGKhxcoP5aMVKdyqcoNb3oRhW/Kw0YT0rSScJRYCe6CzKmet5kN4EnNQN
7sqxAmwZWWa2RhurrzjvfCZ8CBAXVzsZ7l+tqnNHccdvowHKNB/DAPnTzo3oQ/sy
1RfNviR28t/f4t1OunQYIt8lcBW/rkjl1NDnNcIYlhmpCkGYJ8R5QYt0ncuK9ldP
jDCNuC+hrHEP8jC278/IzVtvHCaEs4A3ICflu24vO6NI1HzsxlO+kcbMDRgSSL9T
6NSedvgYOwYVYZtJso9z61rS7fmha09JUTrkr0EElIaxu8A66aHNXqMgvtcMNRom
4LhQAFy7Kstq2q6z9G2j7qcDt6L+w17me90r6XH24DvMw4cssLo/j6qQLHaVRPPS
ZcR1Wd8Z8+Aid971oW96yXOS/rZgbWqKi+8Vv21cG45xgJVTc6HUCSxJNupnmrwI
lFZtctVp12zHo/ex7monZSC4/7AcIvE8wJmS/qd60xyfmDsQqAxAQUOAvxPTbirs
KAB+xkO1VpBgoBLtqTZRxQX2kSfr245V3WY2VSmLLumrSkPYh9E=
=ksr3
-----END PGP SIGNATURE-----

--zebz5ifrjpsgyo5o--
