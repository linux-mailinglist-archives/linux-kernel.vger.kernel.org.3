Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6FF4B777A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbiBOSJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:09:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiBOSJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:09:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F5F11942F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:09:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nK2Fy-0001wD-JJ; Tue, 15 Feb 2022 19:08:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nK2Fq-00GnTY-RA; Tue, 15 Feb 2022 19:08:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nK2Fp-003OCR-H8; Tue, 15 Feb 2022 19:08:45 +0100
Date:   Tue, 15 Feb 2022 19:08:45 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Lee Jones <lee.jones@linaro.org>,
        linux-riscv@lists.infradead.org, Vignesh R <vigneshr@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        bcm-kernel-feedback-list@broadcom.com,
        NXP Linux Team <linux-imx@nxp.com>,
        Jeff LaBundy <jeff@labundy.com>, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 00/15] pwm: dt-bindings: Include generic pwm schema
Message-ID: <20220215180845.vzzqwdaiaj7aqxry@pengutronix.de>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
 <20220215074030.3nugwproxjh3lwhl@pengutronix.de>
 <CA+Eumj42Hojp1m4deuWnqMOaaNaupTSkzPaNbL_0eyBL-aDi_g@mail.gmail.com>
 <7df71f8d-cdc3-4b2e-cf0a-7112eff28142@canonical.com>
 <20220215094106.k35pmoxt2nk44dsj@pengutronix.de>
 <20220215104952.3z7y2t5udwab64kh@pengutronix.de>
 <d042abb2-e5df-42b9-824a-6fc3b9c6df6c@canonical.com>
 <20220215125856.es2euyoqo6mp4y2t@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgr56zm67yyqodt4"
Content-Disposition: inline
In-Reply-To: <20220215125856.es2euyoqo6mp4y2t@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lgr56zm67yyqodt4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Feb 15, 2022 at 01:58:56PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Feb 15, 2022 at 01:41:20PM +0100, Krzysztof Kozlowski wrote:
> > On 15/02/2022 11:49, Uwe Kleine-K=F6nig wrote:
> > > [... Something inserted a space in Subject lines ...]
> >=20
> > Other threads - not only mine - are also affected:
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2022-February/714=
311.html
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2022-February/714=
316.html
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2022-February/714=
364.html
>=20
> In the meantime I'm confident that mailman2 is the culprit.

For the record: Using python2 (which is what mailman2 uses):

>>> from email.header import Header
>>> h =3D Header('[PATCH v2 08/15] dt-bindings: pwm: renesas,pwm: Include g=
eneric pwm schema', maxlinelen=3D76, header_name=3D'Subject')
>>> h.encode()
'[PATCH v2 08/15] dt-bindings: pwm: renesas,\n pwm: Include generic pwm sch=
ema'

This is the inner source of the problem, mailman just does something
like:

>>> import email
>>> a =3D email.message_from_file(open('message'))
>>> open('message-mangled', 'w').write(a.as_string())

So we just have to wait until all mailserver admins migrate away from
mailman2. I bet this will happen no later than when Python2 will become
EOL. :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lgr56zm67yyqodt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIL7CkACgkQwfwUeK3K
7Am22wf/QGAYOVL7Or/wGAw+w38cz+S2A17cswpSeUgQ9tVBFPsz54e2W/VEZWVo
dXdS7jXz+yJ994+aOj0azyG0HVLpSFWm4w6bMQwUF/mKMDTBmEQblGYTgRA+ZKog
LS2KEE3tSItn2cgXgzDvsS3jj6ONyOGipMEfFU3o/3Wy9FnTrX/bAy6kxDIDwTVH
KfTm1YMQFP77eyXEueSNZl9ALHubGZqGXwNJ0Fy+IBE/OydoX2AC3oNzslvrPrMw
7dy18agIIqzJ0as+OMD8kpIzxLfU/r4jcqmfSWHF7WNYfE5kfL8A7i+c/JiWtJaO
y4RH/KCKM0Jmb58rB6611pS1iRadyA==
=AUvf
-----END PGP SIGNATURE-----

--lgr56zm67yyqodt4--
