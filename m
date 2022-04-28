Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB3512ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344545AbiD1IoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344072AbiD1ImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:42:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7FC52B0E;
        Thu, 28 Apr 2022 01:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651135011;
        bh=Q4+3ChFfyhKA+KTPGoIQx0R1D0LMLWXJ6J60qMTKnAc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PHaGpcoZ3WPGPl13ST6Zk8WpnU1HwRAWva6B85NnDWN8fUn+CGlkwNQE27vvfLrK0
         aOIH8AtugWKH2+SxFNHyLGsY5Stf06uOtjX77Zqs2PETm9tOtrShe65I7usUpueheb
         b5V3i/MnxKlHgVZtrNE841yh2wEMrGzur3bltfsk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3lc9-1njiWf3chP-000vpD; Thu, 28
 Apr 2022 10:36:50 +0200
Date:   Thu, 28 Apr 2022 10:36:48 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH 3/7] watchdog: npcm: Enable clock if provided
Message-ID: <YmpSIFHTYDsuEm85@latitude>
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
 <20220422183012.444674-4-j.neuschaefer@gmx.net>
 <20220422183417.GB2637654@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3JafQPKgiRq88lVT"
Content-Disposition: inline
In-Reply-To: <20220422183417.GB2637654@roeck-us.net>
X-Provags-ID: V03:K1:p7i6FNHfF3FlpnhFKvMhXgLjFljWIjKMJgX4cNG3EwazOtlZlAl
 A9/tr/ov/cUpHkz6Bg5t0ni5NA6BknxyNVNd0m/B4NnYcuwu0Htmg4MLDdwaoCI8648pFVu
 n06WalmbWJ4P5vfDob6h/zirRlfnoXDRXHpm03nRrLFUP6VtjNLPUgcOkdebrLdC7eKaPcf
 ib6FcoTVFY76Fsz2S3fsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q6/F/sBWuO0=:DiOMmpBm+d61DOtlcby/Nm
 zuGYlHuDf/HK8+9VYtfu2zKMt6XjZj8gPYnUIkNNgP/whzdTUtOV67Kfclqz3xRg5Pn4WOgmX
 Nw5tbjCeMZWwLM3hRjCJhsbGK4niQHcO8xJwANvNi1AN5xDV6MeA5wUtEzFtKec9bhg2MC7dV
 6HvTeERhw9fxajcCa0Rysxlf8+hJekY4WlFQjo9L9oFjfHJTs8dchOy6lGGX3WDHISe2B4fBv
 QOSNPUtq/mwGQgX4Np5DXH13xjd5cUvTMzDGY5k0yA9HzT3YESQiJbO2HHFWJGUKpRJ1yWbul
 3fTi2gwywW53Pu7XKBqmDBsqKOpmftc1xVnk1lYV+wXWme1nQ2aP4KQyceLf07P4Psv6UIAEw
 KG4tQ4dI6/cJ8/+vM2p6rO77aYwYlzVmEa2ePpTKGpByk2WcDPnewmiGtjtQItIFCo/DTNxDB
 rdqA9N0byNxQuKE8dtiGFg76a/Qsg/ce1PUrBWn0DIq8xm/rdJXwM8fbS+GFtTS/OPnNhVnYM
 Lb1JmjB9oi/BbqQKszE8zDsRMmArEdoo5tASXHXb5rroVZ77HDdiTfMqVVrwfiPrK43rfJIR4
 npKB+3T/UvD7kUmC8hWWa/C3DOVtCZ47ub5EVkBobTsQkk3VlU+wZZtfdQd5xLcyjKs0YCk7t
 +kfDXQqLt4CO8zN+eXyPL+OUdvORZuNKWXezwTJ75nkSKKMbQBCmf4WqNqoBa89iHUf3FZvxJ
 EAH6yO7fOvaSMJoobpfUKdyDprQFiJ83OH2pyhEGZAXVLrtJEIAMdMeJ1kTNjPx0Pzvrmhjqf
 VGsCIyvV/bt/xFR5v7hQkQQkwOfkqsvjQzlQGNPev3jWIvNvH/AZTMUv1OhV0V+OMaWm4DV1k
 6CncbPWocgPLQNv4yAtwBn99a8UDhxZJPl+fTiIQ3Ue9UiXQMeiUhY/yoP9ou+rtWYpfUNYNV
 x7+Ea0t9n/UPKL57VIrJErYEhxADYY3ok+ESPxUKQpjECO7aMhp1ouHf9q5mYGIufhlcV4tTF
 Y/uq3aerx5n8kb6hQHS6RS8P1I0LtQDQhCwwrTygd1cE7uCYKgkjt8tJWjPmSi7JSb8r2nKUV
 3omH0tDPMUtQro=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3JafQPKgiRq88lVT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 11:34:17AM -0700, Guenter Roeck wrote:
> On Fri, Apr 22, 2022 at 08:30:08PM +0200, Jonathan Neusch=C3=A4fer wrote:
> > On the Nuvoton WPCM450 SoC, with its upcoming clock driver, peripheral
> > clocks are individually gated and ungated. Therefore, the watchdog
> > driver must be able to ungate the watchdog clock.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >  drivers/watchdog/npcm_wdt.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> > index 28a24caa2627c..6d27f0e16188e 100644
> > --- a/drivers/watchdog/npcm_wdt.c
> > +++ b/drivers/watchdog/npcm_wdt.c
> > @@ -3,6 +3,7 @@
> >  // Copyright (c) 2018 IBM Corp.
> >=20
> >  #include <linux/bitops.h>
> > +#include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/kernel.h>
> > @@ -180,6 +181,7 @@ static int npcm_wdt_probe(struct platform_device *p=
dev)
> >  {
> >  	struct device *dev =3D &pdev->dev;
> >  	struct npcm_wdt *wdt;
> > +	struct clk *clk;
> >  	int irq;
> >  	int ret;
> >=20
> > @@ -191,6 +193,13 @@ static int npcm_wdt_probe(struct platform_device *=
pdev)
> >  	if (IS_ERR(wdt->reg))
> >  		return PTR_ERR(wdt->reg);
> >=20
> > +	clk =3D devm_clk_get_optional(&pdev->dev, NULL);
> > +	if (IS_ERR(clk))
> > +		return PTR_ERR(clk);
> > +
> > +	if (clk)
> > +		clk_prepare_enable(clk);
> > +
>=20
> This needs a matching clk_disable_unprepare().

Good point. It's probably easiest if I move the clk calls to the
watchdog start/stop callbacks, then.


Thanks,
Jonathan

--3JafQPKgiRq88lVT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmJqUhkACgkQCDBEmo7z
X9utARAApLMgx0770Ai3h8mEawS8c5e/WFuzL9GGC8DU9yxUmSa6RlQk9H3O8lIf
hiOfIS4Kxvjtmy+mTcgqJK4R37I5eIFC8BKVmHbwqupZGl4Mdzhoa7mvAD/IytUL
HtRScJ1zyyb5Rlu9J2IHIIVNAUN8ErlA7oJ+evC0ygr+6JySBgdk/0UIfp3ks6Ke
QxzvAh/VvWNSmcRk2pg61q6VfKks7xr5DEURrUWPJFMpx7SrhdPbaFQ8d7pIAFI3
Xy/KTzAFwf5Qnpwr5nUkhkpZVPgkKSmTmVj0Ouknm73dt+cnr0XmQ+8mljtlocYs
Qa8QybxIXqU3leIx6OqbvxTFgBkj90ll3M15b0+Z2KWTrtjZ/E/ng/hzx3X4V5xv
ZEBgYVTCnZSzOOlU+okXvWwepzR7/w1Zf96TqrXhn/xhB5L6ME+02EVGREJUvT0b
/kyUXR7krD2tlute5lUQOPnkhgbc8ZecZ9PSWKQ1E/BojQKRxQ9F9GVojZox+9Hx
8Pgo1J1czreFcFhrAdYv9SR2fWfv8qggYp+cotvhgwTBPLom7ppUrgTPnUYDuvdj
srCV/12bGLS65rKL7BN6VpkF9hCyi8VUh7qw8XbaiH/rTilA1hWQch7+1MOTA/wG
EVuRYrnRbWSBOo5GUMtfCrJc8oOWhmWmADLRvO54oPkfjdlUFe4=
=Ep5M
-----END PGP SIGNATURE-----

--3JafQPKgiRq88lVT--
