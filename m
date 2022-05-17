Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E252A428
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbiEQODd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348339AbiEQODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:03:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09044C790;
        Tue, 17 May 2022 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652796160;
        bh=fNY2b38/lRCFmOcpmYkMr48xo1NJhCPqgD9dKQ1HrOM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MOD0wBu2si3IYs33eSdACwDOy4EbDCrJtxcvWgvDjQ4YslUMp4qkP1qhu6LJxjLkv
         AkAdijPOiSqwgwE0bMJtQtCeW/T9QIjmMcfag4cU/CHjBTj1u7Eg3PDgYVzmTfKDRg
         mHih7a+pc1Q2bcxwq7P0+qEpTUZfXoEce+X8jj5o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MaJ3t-1oMdpl1mqb-00WH5f; Tue, 17
 May 2022 16:02:40 +0200
Date:   Tue, 17 May 2022 16:02:37 +0200
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
Subject: Re: [PATCH v3 3/7] watchdog: npcm: Enable clock if provided
Message-ID: <YoOq/enI6YSplnS5@latitude>
References: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
 <20220508194333.2170161-4-j.neuschaefer@gmx.net>
 <6c22fe1c-03d9-3a7e-26e8-463b989a02b7@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vQZf1NsHbsdMxgvC"
Content-Disposition: inline
In-Reply-To: <6c22fe1c-03d9-3a7e-26e8-463b989a02b7@roeck-us.net>
X-Provags-ID: V03:K1:suSOJwDkQbNjA5mis1Bopb6tozdowhVxJzoa07b0zru4xZCWGOA
 tsoznaEQDds/YKVMaJzzMaGBODp04lLUdTyFHM9euL564w+DelOmCjgLJDDF3cVbQCO+Neb
 KOZQfLaSwI55oBzMeJ1q9ZUVKDCTcFqaDgvk9SgjR/aAim+tKhdVsllPF5BG/ZVozMGwhHh
 NvwlEx5YR05vTcEL1mbLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pHsyUMFlhB8=:JmoGOoA3kt1s/STOUO7LAm
 iXaHbERzSnV9p8zPELbsRLWZq7q/kFAm1pusIJAvuF4F9RlCIIEMwPs9vv72NC6wMfmg4PKTf
 ZLm44B7et5A9ShaSC7wkQKclQ7Tq0J/Ljp3L+m3GlHpMUPCtjJtWpU6foeNBFn8FqToKEIIw8
 8pCGGTCjE7EQ5vpbxjDptpjJr2qUaul+DTj6nQk3zxCrvnBOpDToYot8brs9A6RFzo6h8JxPs
 uKh1+0+tWAEp3CbaNIq0K4DyjtzMM/y6A1cS1lfgVSzeBd9Vvzqm8cj/NNJV026WhVa5V64Yk
 YBmJqzeFWZaRCoL0FgMTGxUN4hJaCnVTWVQuLBaeJGw9G7EMgqVik6agpozYet+wcMP29dw2p
 XFulvkK7Y8PcnMYSN/rP5N8DPJQ94Vrb0qJstF75DpIGE7daly2mZh15McNG5v1E3GIsfavwe
 qqoAB4mdml6kd7ms6T0k8gLihWItNHr+U3jPxqNC3Vskwp2sNPkOWq08O3HwJmbQ1ZjpjbNOC
 NQY7A9tNN9p4EUdfabmQx/+Ek9dGDVAw94fFn/wKmhHq3JMMSadL0nZ+sQ9f+7JjcDKlwWTg+
 xtYW85EKMkTpsjQgF4AOIVz0j/q0r777EWLvjTXTWDSlHZriB/q6XI1QVAW4UYpevMVBn92Aj
 ZSa2JZjy5gnlWPTQEjCBgJagMD/9WOrUdXjLQZOFA8rxEG5Ib6NHLixUEVnThRdJgGFAZ0ski
 IZrvCy7UhGS5IBvx/6xQu6wlNj1juyCob2CpBp3A5n9bp91FvjO9mosZhpGcTfqzXg6dhLnaO
 Tg4qqkf1tEUH5sQGZOyEh4/esDiBMiatOe0ICiqM2/8QULtOwegqzttPPGGmWq4Wb5IOJOALq
 fLmAek0MMrrIfolo/jWMyDwI0c4YvUqPtaYpRyfQWdrEfLHM4zmhS5ul2CyEQOVROyW16Rjsx
 8YPZPsHf6l9f2qKy9L8CYc9MAwp33iKDukhRC/kk1nyVlp8fBDoMC0dPNk+BK074ShiRxrA6o
 VrJGF5490T7KDxj/khVUP8itVoo0EENnlKApJtTlId381SyIqwNczj/O8Vd9W+mzGiPQQ36sG
 62cfBgLD30wSZGrOUjYHQMeg40N/gRqdjaGMvZfQiZEjIXHOrZUvWVR7Q==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vQZf1NsHbsdMxgvC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2022 at 07:31:31PM -0700, Guenter Roeck wrote:
> On 5/8/22 12:43, Jonathan Neusch=C3=A4fer wrote:
> > On the Nuvoton WPCM450 SoC, with its upcoming clock driver, peripheral
> > clocks are individually gated and ungated. Therefore, the watchdog
> > driver must be able to ungate the watchdog clock.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >=20
> > v3:
> > - Add enable/disable calls to npcm_wdt_restart handler
> > - Not applied due to the above change:  Acked-by: Guenter Roeck <linux@=
roeck-us.net>
> >=20
> > v2:
> > - https://lore.kernel.org/lkml/20220429172030.398011-4-j.neuschaefer@gm=
x.net/
> > - Add clk_disable_unprepare call, suggested by Guenter Roeck
> >=20
> > v1:
> > - https://lore.kernel.org/lkml/20220422183012.444674-4-j.neuschaefer@gm=
x.net/
> > ---
[...]
> > @@ -147,9 +155,15 @@ static int npcm_wdt_restart(struct watchdog_device=
 *wdd,
> >   {
> >   	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);
> >=20
> > +	if (wdt->clk)
> > +		clk_prepare_enable(wdt->clk);
> > +
> >   	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, wdt->reg);
> >   	udelay(1000);
> >=20
> > +	if (wdt->clk)
> > +		clk_disable_unprepare(wdt->clk);
> > +
>=20
> I am trying to understand why you stop the clock here.
> If the watchdog didn't reset the system by now, for whatever reason,
> you explicitly don't want it to reset the system ? If so, please add
> a comment describing the reason for stopping the clock here.

It was for symmetry with starting the clock, and in the hope that
udelay(1000) will be enough to reach timer expiration. (In practice it
does appear to work, although 1ms is not much.)

Upon reconsideration, I agree it's better to leave the clock running for
reset (with a comment pointing out the asymmetry).


Best regards,
Jonathan

--vQZf1NsHbsdMxgvC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmKDqtwACgkQCDBEmo7z
X9uEnQ/+PieUjR1LsgZzUOsXNS+aAubr0M4s9fyJdH14/eol2H39zy5/Y8ylCJIq
zzFWjUFI6PVXPKiZ/GkOMMNp25cD2a+vEfFzSaaN/yaeNGv8vkU6q1ABm5PVihpK
+44o0bPpuy0SHbIxKCy7pGMvBR3UrjVA5Q/1GSxQd5fLQxOMwoziLNzhfXqI3dJb
s5S1hx8pezpRR9WwAqIX4R6xiyqrwdL8KacjoAiNYQhLLrD/OOQcIlSijCLLnriM
au59vZK1FzFaYsTI8w5vRgq8C6LtiXQCZsXUT9TJ17hC4OQnzNIlxvls+0O9GHlL
e6MTmskpf/BLMbPiYUarLVvgFGqUE3FyVvuha3GUNK4nfBM5bjjyhtbDElvAs1j1
cgBsIyWKbMB2zH5XrTsdTPB3CfQx8+ZZ98sHhzZEYg4C3oynFDNf1Y8g735SZiAq
7bEqMy+nyrLXxPF55eEuh6AKm6FhZaVjZj9n5YqjxfAfeezDN4K8rCg9xWRy0Oyw
C16jjVdbEufJWQIWopPzw5zM2uvu3ZTMjYr3kfIULs3wIYwoa2+fW6tiK8yHWB2B
LFweECTpYkfBYkKGuxfnft4lgzTmSsSK7ggOnkkBjA0GiA0EgJN0JQ0SchBbzlhb
nOPyAKh9/4LFosqLlGiLyDdZJGX3yaqw3xGK7up7tgfWUiWL+F8=
=24UD
-----END PGP SIGNATURE-----

--vQZf1NsHbsdMxgvC--
