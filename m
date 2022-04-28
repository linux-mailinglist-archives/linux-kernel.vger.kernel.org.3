Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C024512F25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344830AbiD1I7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344891AbiD1I7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:59:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D542A729;
        Thu, 28 Apr 2022 01:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1651136123;
        bh=/SVF4atjZnUZPZ6or4RTo2SDRpctHhG+DQ/FLVQqUBg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=iwGwqXjh5Fbm6UEpQaRmnfup9aDxA8ACV6lpYhKJ+iXp/rSdUXgGUV08nKyAPzO8j
         Vy112wAE9UObX/iKQ4mf8Tj0Nm8y57gn1rdPK1bhkmkZAtuview18+44xcNLj+kojF
         aRfLKgeGdGQo+fphwPYy9nAyNHZjvvdpSZNyEbhU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvrL-1oMteB48q5-00hNta; Thu, 28
 Apr 2022 10:55:23 +0200
Date:   Thu, 28 Apr 2022 10:55:20 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4/7] dt-bindings: clock: Add Nuvoton WPCM450 clock/reset
 controller
Message-ID: <YmpWeOb3oetvqyvl@latitude>
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
 <20220422183012.444674-5-j.neuschaefer@gmx.net>
 <31cb9af1-173d-bef5-64da-ccf5a01f2485@linaro.org>
 <CACPK8XdRYvike9Z98JzfO1r0W2jfkESr8xMGSH4kkigwZ_MkyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GfjnlrXCmbggFVO5"
Content-Disposition: inline
In-Reply-To: <CACPK8XdRYvike9Z98JzfO1r0W2jfkESr8xMGSH4kkigwZ_MkyQ@mail.gmail.com>
X-Provags-ID: V03:K1:vDtCw1Xqk5WwFlslQt86xYSwXrubTIv3D0/ZX8XF0n41y4TsV/g
 vdzerk1EQZUuborMZpzy7oVBQ6hWJwjTkRzK+ITa/ze+Md6ns9/+gTmPLyk9ITEx7XAR+L3
 WsWvnGsjqHoF1as+Uy/rtQQ0yssil32ujMeDmsKBlxmHl6ek8pWVcDHND44cTNRQQomIKrs
 jAYXRVtG5Qxg/6fCWeDCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BByf02oW4YI=:u4M/RLZzldBz6Nn+6AuIJg
 XFSyqh6DA1pJWizob4aPCGfNK0mzAiDQAXfnSK0MnzE2Fh3+h0TuyopeZD3m/CjfWsqcLmkc4
 S0wKl4YASO5JUNIgdPoqrZulRMGjfrFM5buM84mwOZT3cA68s/4hX6o/kVNBPVDnsWKeUZqki
 sLkXgxisM59qeABrwqpLJ9JS18cwYzmDe5NKJuXPLKLw7aH0Xo3abnxSAjf836c6zeNgpiuLY
 lR4iVUbC23Q5luTONAoWGwpRk++LE0fNozCMFFshxaR2XfESLCpsdd2SBaAuA98LhnIpDb2OT
 /7+LW+mjIJzgxmqgqrHTqggW0cgtSx0RyUBRdY93f40apKuNzQlDmJcqJKDU0E5wlAAVlAqtO
 0AfVx7ZtiEyvMPun0rVT+Q9a1UD9HmqevComkc3nxB8zAFrqpsRV/cBSw42BPFLLmss0Htloy
 76r7jLXSH3zsjFjyJWZiin7C7f688Qgnzyw4NluetTLAPZfBy5cb8R5UdjE1wd5UejdKBRgJh
 ZZNqIDXFzko5WAkN7KgpHqBm5GHLvHt6GkPUHUiKH9YBzF8lZ4q4VUkyCAhbx63XVDwB4QTLO
 u6MT8ejEJH8aqOQsbJch7RTAGyKSzCxU2TwARmBQau5oDrfWKTOv/UcGOAyiuq0fwb/+wPPnG
 r/1RkaUFOh06MLuRlQDv0QfKwnhBnzmZ3JECGAVCbj6gJF5YjTnAofKkNxvUEhDEUAkBZCbtN
 s36fjUUI5Jss5OwQTqSdWUaQBxaGsl5TQVsWSszb61+QF4JWF7tavG4De5LCzTZ89gF/zwoOV
 cU/NlEpn+3IDyzmfK1+ntCKu6RmACZar/wCOJqxOWmz7uGFanSaFwUXXW6gIbPOVfjzVCGrMc
 855EZoF7wFoJlXu06Co3A4eMIDHk+zWyvqT2ec+h4l3Np6l7l1Q1RGtuFlt6aoh64smk1u6Ro
 W/h6v3T4E3MDVhREix+bQTUHYvO456H1ximnFgRuHhHFJu3uTn3zDbpPcR5jf0dqXMa+UcVS4
 TjOTtZG8Cf5Bpik0xJopRuHGQV1WMiBjyym36xdc9wHx+B0opgBHpdONINRw1Z8X9oWuGDPWx
 sCI7F7ptieIBdA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GfjnlrXCmbggFVO5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2022 at 08:35:43AM +0000, Joel Stanley wrote:
> On Mon, 25 Apr 2022 at 07:59, Krzysztof Kozlowski <krzysztof.kozlowski@li=
naro.org> wrote:
> >
> > On 22/04/2022 20:30, Jonathan Neusch=C3=A4fer wrote:
> > > The Nuvoton WPCM450 SoC has a combined clock and reset controller.
> > > Add a devicetree binding for it, as well as definitions for the bit
> > > numbers used by it.
> > >
> > > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > > ---
[...]
> > > +/* Other clocks */
> > > +#define WPCM450_CLK_USBPHY        32
> > > +
> > > +#define WPCM450_NUM_CLKS          33
> > > +
> > > +/* Resets based on IPSRST bits */
> >
> > All these defines should be in second header in dt-bindings/reset/...
>=20
> I disagree. It makes more sense to keep the definitions together, and
> it's all for the same hardware and driver.

It's for the same hardware, DT node, and driver.

I could imagine splitting it into

	include/dt-bindings/clock/nuvoton,wpcm450-clk.h  and
	include/dt-bindings/reset/nuvoton,wpcm450-clk.h

if someone insists on it.

For convenience (being able to see all relevant definitions for
nuvoton,wpcm450-clk at once), I'd prefer to keep the definitions together.


Thanks,
Jonathan

--GfjnlrXCmbggFVO5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmJqVngACgkQCDBEmo7z
X9ue9g/+P4ECjYmwtgmxnY8aEuQIf5yQn622vliBjNoRr4EraBUuEfits2QCcitI
R2Y34KdwIryYwTuA1iTKPY7jxY4pMEXU/OhhnJ92yYz7KspcVyQDrxeGsY01PYgw
x5YWib5keVy22f76rbuTd0LROzC2tP/ubLBvu9+4hVU3HDp3WsVhAeLEVf3gcavU
fmS502AAHFtbWgMDHutulyeWwJmmVfYmAvxbC6BoNuitSSzuQZDbNi86hrLh2ytv
tXmup5bVOmiXx9oakQuoNBE3f50tQPwYTdQLRX1yxzfiRhpY+UvybdRpUZvzGgvn
qyJEqgWWcpTsbLtHK+65LMbBhO3EwYxzPsrtSDmc/rwPcgrT2A1y7GwNbBQhNvJm
PRhJtrZ/w4fgzGhkfzidXHlpsMR3BcieWZEUaRx861KDOT6ilzCHf1/7CWDel5u5
M8aNJggId/aycnjWYSUjdAZjpME090eKku2pbD1HUu9ks5rUZhhTWX+5FYYbufAK
wi2W5jxUOfroRwHdQF2XQXU97LhcZC3afA3u4UAGR9yWZzfasFDDg/Z0S7sZIJ9q
evrCyV6VT0WaqlKBPpCLf3Zav7Kic9cdDGbGbKCL7yTBB1kCsD7klQa16/dHCcYE
ZrzJBoMgpZ8oEuGNBvTUnSr4bL8aKfS141ZhZiZ3xtaTXWZxYYo=
=lG9e
-----END PGP SIGNATURE-----

--GfjnlrXCmbggFVO5--
