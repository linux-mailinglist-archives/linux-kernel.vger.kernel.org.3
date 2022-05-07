Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D197551E590
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 10:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383672AbiEGI0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343649AbiEGI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:26:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC9D515B1
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 01:22:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nnFhP-0001e9-Sq; Sat, 07 May 2022 10:21:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nnFhC-000rlB-SI; Sat, 07 May 2022 10:21:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nnFhA-008825-Qd; Sat, 07 May 2022 10:21:44 +0200
Date:   Sat, 7 May 2022 10:21:37 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     lizhe <sensor1010@163.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lee.jones@linaro.org, fthain@linux-m68k.org,
        akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
        freude@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, zbr@ioremap.net, perex@perex.cz,
        tiwai@suse.com, bvanassche@acm.org, dan.j.williams@intel.com,
        srinivas.kandagatla@linaro.org, wens@csie.org,
        colin.king@intel.com, hare@suse.de, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH] kernel/drivers: Remove redundant driver match function
Message-ID: <20220507082137.i23gbxkbjwt36ggd@pengutronix.de>
References: <20220506045952.136290-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ycnnmzk4hzrnbozs"
Content-Disposition: inline
In-Reply-To: <20220506045952.136290-1-sensor1010@163.com>
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


--ycnnmzk4hzrnbozs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, May 05, 2022 at 09:59:52PM -0700, lizhe wrote:
> If there is no driver match function, the driver core assumes that each
> candidate pair (driver, device) matches, see driver_match_device().

I wonder who is supposed to apply this patch. Either it should be split
by file and go in via the respective maintainers, or it goes in via
Greg's tree? I added Greg to To: for him to chime in.

Best regards
Uwe
=20
> Signed-off-by: lizhe <sensor1010@163.com>
> ---
>  drivers/mfd/mcp-core.c             |  6 ------
>  drivers/nubus/bus.c                |  6 ------
>  drivers/s390/crypto/vfio_ap_drv.c  |  6 ------
>  drivers/scsi/scsi_debug.c          |  7 -------
>  drivers/target/loopback/tcm_loop.c |  7 -------
>  drivers/w1/w1.c                    |  6 ------
>  sound/ac97_bus.c                   | 11 -----------
>  7 files changed, 49 deletions(-)
>=20
> diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
> index 2fa592c37c6f..281a9369f2b3 100644
> --- a/drivers/mfd/mcp-core.c
> +++ b/drivers/mfd/mcp-core.c
> @@ -20,11 +20,6 @@
>  #define to_mcp(d)		container_of(d, struct mcp, attached_device)
>  #define to_mcp_driver(d)	container_of(d, struct mcp_driver, drv)
> =20
> -static int mcp_bus_match(struct device *dev, struct device_driver *drv)
> -{
> -	return 1;
> -}
> -
>  static int mcp_bus_probe(struct device *dev)
>  {
>  	struct mcp *mcp =3D to_mcp(dev);
> @@ -43,7 +38,6 @@ static void mcp_bus_remove(struct device *dev)
> =20
>  static struct bus_type mcp_bus_type =3D {
>  	.name		=3D "mcp",
> -	.match		=3D mcp_bus_match,
>  	.probe		=3D mcp_bus_probe,
>  	.remove		=3D mcp_bus_remove,
>  };
> diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
> index 17fad660032c..72921e4f35f6 100644
> --- a/drivers/nubus/bus.c
> +++ b/drivers/nubus/bus.c
> @@ -14,11 +14,6 @@
>  #define to_nubus_board(d)       container_of(d, struct nubus_board, dev)
>  #define to_nubus_driver(d)      container_of(d, struct nubus_driver, dri=
ver)
> =20
> -static int nubus_bus_match(struct device *dev, struct device_driver *dri=
ver)
> -{
> -	return 1;
> -}
> -
>  static int nubus_device_probe(struct device *dev)
>  {
>  	struct nubus_driver *ndrv =3D to_nubus_driver(dev->driver);
> @@ -39,7 +34,6 @@ static void nubus_device_remove(struct device *dev)
> =20
>  struct bus_type nubus_bus_type =3D {
>  	.name		=3D "nubus",
> -	.match		=3D nubus_bus_match,
>  	.probe		=3D nubus_device_probe,
>  	.remove		=3D nubus_device_remove,
>  };
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio=
_ap_drv.c
> index 29ebd54f8919..0a662c451f2a 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -172,14 +172,8 @@ static void vfio_ap_matrix_dev_release(struct device=
 *dev)
>  	kfree(matrix_dev);
>  }
> =20
> -static int matrix_bus_match(struct device *dev, struct device_driver *dr=
v)
> -{
> -	return 1;
> -}
> -
>  static struct bus_type matrix_bus =3D {
>  	.name =3D "matrix",
> -	.match =3D &matrix_bus_match,
>  };
> =20
>  static struct device_driver matrix_driver =3D {
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 592a290e6cfa..8107489b36e8 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -7844,15 +7844,8 @@ static void sdebug_driver_remove(struct device *de=
v)
>  	scsi_host_put(sdbg_host->shost);
>  }
> =20
> -static int pseudo_lld_bus_match(struct device *dev,
> -				struct device_driver *dev_driver)
> -{
> -	return 1;
> -}
> -
>  static struct bus_type pseudo_lld_bus =3D {
>  	.name =3D "pseudo",
> -	.match =3D pseudo_lld_bus_match,
>  	.probe =3D sdebug_driver_probe,
>  	.remove =3D sdebug_driver_remove,
>  	.drv_groups =3D sdebug_drv_groups,
> diff --git a/drivers/target/loopback/tcm_loop.c b/drivers/target/loopback=
/tcm_loop.c
> index 4407b56aa6d1..eeb63deff94f 100644
> --- a/drivers/target/loopback/tcm_loop.c
> +++ b/drivers/target/loopback/tcm_loop.c
> @@ -83,15 +83,8 @@ static int tcm_loop_show_info(struct seq_file *m, stru=
ct Scsi_Host *host)
>  static int tcm_loop_driver_probe(struct device *);
>  static void tcm_loop_driver_remove(struct device *);
> =20
> -static int pseudo_lld_bus_match(struct device *dev,
> -				struct device_driver *dev_driver)
> -{
> -	return 1;
> -}
> -
>  static struct bus_type tcm_loop_lld_bus =3D {
>  	.name			=3D "tcm_loop_bus",
> -	.match			=3D pseudo_lld_bus_match,
>  	.probe			=3D tcm_loop_driver_probe,
>  	.remove			=3D tcm_loop_driver_remove,
>  };
> diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> index f2ae2e563dc5..a6ecfa1b3417 100644
> --- a/drivers/w1/w1.c
> +++ b/drivers/w1/w1.c
> @@ -58,11 +58,6 @@ MODULE_PARM_DESC(slave_ttl,
>  DEFINE_MUTEX(w1_mlock);
>  LIST_HEAD(w1_masters);
> =20
> -static int w1_master_match(struct device *dev, struct device_driver *drv)
> -{
> -	return 1;
> -}
> -
>  static int w1_master_probe(struct device *dev)
>  {
>  	return -ENODEV;
> @@ -174,7 +169,6 @@ static int w1_uevent(struct device *dev, struct kobj_=
uevent_env *env);
> =20
>  static struct bus_type w1_bus_type =3D {
>  	.name =3D "w1",
> -	.match =3D w1_master_match,
>  	.uevent =3D w1_uevent,
>  };
> =20
> diff --git a/sound/ac97_bus.c b/sound/ac97_bus.c
> index b4685c53ff11..c7aee8c42c55 100644
> --- a/sound/ac97_bus.c
> +++ b/sound/ac97_bus.c
> @@ -75,19 +75,8 @@ int snd_ac97_reset(struct snd_ac97 *ac97, bool try_war=
m, unsigned int id,
>  }
>  EXPORT_SYMBOL_GPL(snd_ac97_reset);
> =20
> -/*
> - * Let drivers decide whether they want to support given codec from their
> - * probe method. Drivers have direct access to the struct snd_ac97
> - * structure and may  decide based on the id field amongst other things.
> - */
> -static int ac97_bus_match(struct device *dev, struct device_driver *drv)
> -{
> -	return 1;
> -}
> -
>  struct bus_type ac97_bus_type =3D {
>  	.name		=3D "ac97",
> -	.match		=3D ac97_bus_match,
>  };
> =20
>  static int __init ac97_bus_init(void)
> --=20
> 2.25.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ycnnmzk4hzrnbozs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJ2LA0ACgkQwfwUeK3K
7AmOdwf/dC+dAM+BltGJiDFPWGLkkBGAxLj9besnCp+NoCMvoCM45EG1XlH6ATBe
5C06EJYaUBC4IUD8hZBtVMkru8YOtiZji6v1TY6o8XcCoG1AZeYnw9KzNDN42QZO
TnNQaenEo7hNiLsxTa3r4K1Zbab8SbmGkKhnN6FSoCyl1ICbxTM9E9j4Y3kcgDn5
pv22/aezYEAHd7GoYi6Ql0DPq7why9QVrP/ReIhOwfnMEOJ4f8Ftd/W6gMUY+75F
TW8hr0G9bGs9HXK353duMOiQkWg5JVZAgZwj1JrNdNeMgY0ntXf3UA/Fldfnvnkp
KHhDVCXStiC6qUIR1yrghlB1rtKmpQ==
=+bph
-----END PGP SIGNATURE-----

--ycnnmzk4hzrnbozs--
