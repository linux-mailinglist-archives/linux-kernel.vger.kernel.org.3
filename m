Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE5E550CC5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 21:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiFSTfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 15:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiFSTfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 15:35:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8028B31
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 12:35:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o30hv-0004rB-Bu; Sun, 19 Jun 2022 21:35:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o30hk-001VMw-FN; Sun, 19 Jun 2022 21:35:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o30hl-00HR4H-4a; Sun, 19 Jun 2022 21:35:29 +0200
Date:   Sun, 19 Jun 2022 21:35:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>, kernel@pengutronix.de,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] mfd: tc6393xb: Make disable callback return void
Message-ID: <20220619193526.hyihizoxmaxlowrt@pengutronix.de>
References: <20220619082655.53728-1-u.kleine-koenig@pengutronix.de>
 <202206200102.cUbYiyCL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pmzf5n3f43nr53dh"
Content-Disposition: inline
In-Reply-To: <202206200102.cUbYiyCL-lkp@intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pmzf5n3f43nr53dh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 20, 2022 at 02:20:57AM +0800, kernel test robot wrote:
> Hi "Uwe,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on f2906aa863381afb0015a9eb7fefad885d4e5a56]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/m=
fd-tc6393xb-Make-disable-callback-return-void/20220619-162855
> base:   f2906aa863381afb0015a9eb7fefad885d4e5a56
> config: arm-pxa_defconfig (https://download.01.org/0day-ci/archive/202206=
20/202206200102.cUbYiyCL-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/e2b80b7c107cdbbff=
99189431a614f791435ebfd
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Uwe-Kleine-K-nig/mfd-tc6393xb-Ma=
ke-disable-callback-return-void/20220619-162855
>         git checkout e2b80b7c107cdbbff99189431a614f791435ebfd
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-11.3.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Darm SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    arch/arm/mach-pxa/eseries.c:47:13: warning: no previous prototype for =
'eseries_fixup' [-Wmissing-prototypes]
>       47 | void __init eseries_fixup(struct tag *tags, char **cmdline)
>          |             ^~~~~~~~~~~~~
>    arch/arm/mach-pxa/eseries.c:76:5: warning: no previous prototype for '=
eseries_tmio_enable' [-Wmissing-prototypes]
>       76 | int eseries_tmio_enable(struct platform_device *dev)
>          |     ^~~~~~~~~~~~~~~~~~~
>    arch/arm/mach-pxa/eseries.c:89:6: warning: no previous prototype for '=
eseries_tmio_disable' [-Wmissing-prototypes]
>       89 | void eseries_tmio_disable(struct platform_device *dev)
>          |      ^~~~~~~~~~~~~~~~~~~~
>    arch/arm/mach-pxa/eseries.c:95:5: warning: no previous prototype for '=
eseries_tmio_suspend' [-Wmissing-prototypes]
>       95 | int eseries_tmio_suspend(struct platform_device *dev)
>          |     ^~~~~~~~~~~~~~~~~~~~
>    arch/arm/mach-pxa/eseries.c:101:5: warning: no previous prototype for =
'eseries_tmio_resume' [-Wmissing-prototypes]
>      101 | int eseries_tmio_resume(struct platform_device *dev)
>          |     ^~~~~~~~~~~~~~~~~~~
>    arch/arm/mach-pxa/eseries.c:108:6: warning: no previous prototype for =
'eseries_get_tmio_gpios' [-Wmissing-prototypes]
>      108 | void eseries_get_tmio_gpios(void)
>          |      ^~~~~~~~~~~~~~~~~~~~~~
> >> arch/arm/mach-pxa/eseries.c:141:21: error: initialization of 'int (*)(=
struct platform_device *)' from incompatible pointer type 'void (*)(struct =
platform_device *)' [-Werror=3Dincompatible-pointer-types]
>      141 |         .disable  =3D &eseries_tmio_disable,
>          |                     ^
>    arch/arm/mach-pxa/eseries.c:141:21: note: (near initialization for 'e3=
30_tc6387xb_info.disable')
>    cc1: some warnings being treated as errors
>=20
>=20
> vim +141 arch/arm/mach-pxa/eseries.c
>=20
> e478fe4cd50b86 Eric Miao 2010-06-20  138 =20
> e478fe4cd50b86 Eric Miao 2010-06-20  139  static struct tc6387xb_platform=
_data e330_tc6387xb_info =3D {
> e478fe4cd50b86 Eric Miao 2010-06-20  140  	.enable   =3D &eseries_tmio_en=
able,
> e478fe4cd50b86 Eric Miao 2010-06-20 @141  	.disable  =3D &eseries_tmio_di=
sable,
> e478fe4cd50b86 Eric Miao 2010-06-20  142  	.suspend  =3D &eseries_tmio_su=
spend,
> e478fe4cd50b86 Eric Miao 2010-06-20  143  	.resume   =3D &eseries_tmio_re=
sume,
> e478fe4cd50b86 Eric Miao 2010-06-20  144  };
> e478fe4cd50b86 Eric Miao 2010-06-20  145 =20

Oh, indeed. I forgot that this patch depends on

	https://lore.kernel.org/all/20220530192430.2108217-4-u.kleine-koenig@pengu=
tronix.de

that Lee already claimed to have applied. This patch removes line 141
and the problem is gone.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pmzf5n3f43nr53dh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKvensACgkQwfwUeK3K
7An82Af/VbnrOfVBah3nqCQxuAtM9MNBqEtnq39L5tHy+A8arHXkS3ye5E92KYJW
umIk7JLV+a3RdFAlMDsuwsbdJNNhCOBT6zlF2zrw0xzMaP4rtskUh5AUXWy3olM5
K7Koce9GteGlGHQaWRwS86ayehoXxTPRFflq1FVRzXK4W478CH2Bn8/iKgoewgpr
iZp4I/Z4+BBYdqP//sww0AhoT65o3d4UpaYzmI+3IvljDNfTnGT76VAzmjkRmlwM
D92bH9KrUNdtrqmUItTdOJZg1EjkSkG9YmkUe5OwEruA7+Va9stqRJQesKulAfvK
ffbMdkH6hBYVNUzXVHTr2T2dnNT28A==
=sC2Z
-----END PGP SIGNATURE-----

--pmzf5n3f43nr53dh--
