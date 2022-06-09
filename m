Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6954534A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345101AbiFIRpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345073AbiFIRpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:45:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CC52A1D65;
        Thu,  9 Jun 2022 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654796682;
        bh=aAGWS5nsEjumC36D8Oj4xKJFjI8cDGKi0mv38ijyKvU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=iglfxQwW7H2DsRtidTWRvPFWgQlqhaWIYH9JVcg4gFlV+XkI4j8PLqDe+uFhmyIyY
         EKCS0Jgd553PG8W8DZfmU8/QU93j6q1OvbQreIlh7MapLt/UmddRKb1PmDiHYAwXAd
         OWnxDsMfQhsyusJEXGHD7w2NsIGCtBq3LTQdnVfk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3se8-1nZ8A54288-00zqaM; Thu, 09
 Jun 2022 19:44:42 +0200
Date:   Thu, 9 Jun 2022 19:44:37 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 06/20] dt-binding: clk: npcm845: Add binding for
 Nuvoton NPCM8XX Clock
Message-ID: <YqIxhWeUbEAo3Jam@latitude>
References: <20220608095623.22327-1-tmaimon77@gmail.com>
 <20220608095623.22327-7-tmaimon77@gmail.com>
 <f4899b6d-fec3-5940-709a-f5fbc7ae6233@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="32Ze5EV+vj+4NHJh"
Content-Disposition: inline
In-Reply-To: <f4899b6d-fec3-5940-709a-f5fbc7ae6233@linaro.org>
X-Provags-ID: V03:K1:jzzTW8LVcmmU+9aQiJW2YIJKQAtbyON9+tJYiHXjrPQeLMigfIM
 6Z40D5jT0qAvqfZZWiSelFOZwlcmtKRJAbAIzd4yNVVJ87qwrLiUr7zCoG9bi9LI5DEkChj
 M6R/8AlnrbtbrhVB3r/5UAtTOEkAR9TFpi1jXVbbZBeJJ/A7oMYRyWVb9CwlhiegbIxF+LT
 DzFzENR5xVvura4eu0iew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3dUJcptKLkA=:IbJCdExBzHM+v+boTuHr85
 BShd2H0KfY7rw9/BR1QVjRpCffF84AUGG9XgGajnpXxfFBQVxs0aRHhYRFSGziJqrXJ+hGDlr
 yWM+w5ZPnlR3Te1mMLW33eCQIR11kK9/t0xB0uABoQUsR+bRjiZmPNC26NJcp5WlQhnvuJmR3
 ywN6iueU7pGt9jMpDTKO9pvQKQ4xxL6xd1u7FYVihI3ee77JrFn45QQujsA88iaeTBzvOw+Yt
 mXavbUEs1rjR/JZUukIp4Fi/mWsYo7iFIbnEKAFuMHa7JSWv2XB4Y6hxzl8j4uvnQcAvIS5af
 NhnTWutnnxdiATBFoJGLqlmePx8Xy8ysQDaImMp+/REDBlH6wFTwYC1v9IA0gsZMbSQ/gBDZq
 Wrz1/e5lhi/WtgqSWALIJNLVA61D1Vo76S0Jr7m2k5fPemguTW+GRe91zNXwm4n282LbucxLw
 vNxT26OsoTGlNjhguMIiNSsPSJmCIDdabs/S8Sr0V0gtZmdcxIT+TJTbR/+VbB/dHU/dD3FbW
 rpVgmCRMRnBorK1F0GCv3LxaxiI29AjON7yo78RF3vfxRGhf8sIT8KJmvTWvrBdLUZEgiY9MJ
 9jaWw0OBwl81G49BNxsAsUnPr9PM6Fyfa8Qa+cHQN32RXMmnzdyokFm2fsnyTTmQrIyVlImwg
 fIhjYlZsXPbR6U47PtcS3wjfcE6V76RKxizu8PaS29UVVg00OYhZyk6QgBzgdUM5rDL33s6qu
 acYIfZX1e/zMRZ4evGbwZdF0QUqEdCTo9IeqnzWYbZyD8q7GDpRM8+2QQYeLEEg8e5Kfyih5s
 6ndecLwf/kRWkxn9wKnuaukmKrP6KmqzMlPXjQNI2FfYid8enDFPiDeRckBdk5XmLh9R9Rw3F
 KotEMyJ0xZ4QlgU+QqqzicJC27JznOO/10tZZxB21qxDWii5KP+4evEvVksEijFshL9jCt5U3
 J7/icxxq2HS1X0Rs1tfhUq4NuHHaIKXUDfxJYRQ3432fsND5ra90dX6Sax+m8WDUrJWtysnwZ
 befrBiVXRduCh4iudct1R0Xz9mKcSTdVwxpFkZoLr/ihh2m9wh3FCxJIWEkZxJZseBGSfIJUu
 KjJSGnqwWs+ZrUY6r4UUJmcNrWLd2RwMb6h2q1CO/xT5z86e2NliQx3Qg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--32Ze5EV+vj+4NHJh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Tomer and Krzysztof,

On Wed, Jun 08, 2022 at 12:03:00PM +0200, Krzysztof Kozlowski wrote:
> On 08/06/2022 11:56, Tomer Maimon wrote:
> > Add binding for the Arbel BMC NPCM8XX Clock controller.
> >=20
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
[...]
> > +  clocks:
> > +    items:
> > +      - description: 25M reference clock
> > +      - description: CPU reference clock
> > +      - description: MC reference clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: refclk
> > +      - const: sysbypck
> > +      - const: mcbypck
> > +
>=20
> I asked what is the suffix about and you replied "ck"... ok, so let's
> make clear. This should be:
>=20
>     items:
>       - const: ref
>       - const: sysbyp
>       - const: mcbyp
>=20
> or something similar, without the same suffix all over.

A bit of a side note on these names:

To make the binding as easy to understand as possible, I think it would
help to have every part of the clock-names reflected in corresponding
clock description:

- sysbypck:  presumably means system bypass clock
- mcbypck:   presumably means memory controller bypass clock


As it currently is in the patch, the "byp" part stays unexplained and
unmentioned in the descriptions.



Thanks,
Jonathan

--32Ze5EV+vj+4NHJh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmKiMWIACgkQCDBEmo7z
X9vEyw//UyXHHGnZqNSCU2vjJVfqb3xYR+6PkcHcT0S8zAQhF+r49qZjx2NHgU7M
UK49lMtTgrU3NtU+6zjY49TDUtBqImQtjshiTi1Ny8pk1EeILBOAtfs37Woh0RT0
/L0z/8MSiYSEiEFwMMQju9y0op3cBs+/7FraPBx/LlZiWvxmKi3U9+dYjKQnlzE6
i33Um6sHshnWKc3GUHRmhZcipbc06kgST4+iTJPGqip9l5p/HusyWfTB3HBHwV48
5oc4+0yPM3RksA2jkfwyPHSv5jaQ+Vli88tZC7NRQYGzVpMhrgjJ6tMszip//wsA
tIaIbAr2KBNOWsirnLya9y2lV/OHkaauS/wqn+WH+oliAu9NA0u4Wly8espADuVu
VeIa3jy1Lm1pYI+UmGJljRKDOWE07KMtwIsQ0XqloLXdYCAlCRLM3sQO6vztUPKl
eaLBbX2Oh2F5WLh9bkKzTg1vDusL/7YkAopmy9nejnayevRhpD1yApfQFAuOJTCO
1qvWxfbgzAMa2Ask0kaW7AIJ3L0KPJhRDVDVBqsGlQ4+gww7qoEeh6tOTGayfpXE
5QpbQzZNrHIpATf4nH+s+fyK9BgXftuoFQQBzi0FyxaIedlegtLymSFCxrhwY74E
5a7VDITbr+qiBNCkuH94zj0onqdpx8/4uWaraM3vvh3xf/z1C3I=
=CY1G
-----END PGP SIGNATURE-----

--32Ze5EV+vj+4NHJh--
