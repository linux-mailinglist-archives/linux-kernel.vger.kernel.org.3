Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4834CDF94
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiCDVK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiCDVKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:10:25 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513BD136EF5;
        Fri,  4 Mar 2022 13:09:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1FFFE1F46BEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646428176;
        bh=gb3rq07Izlx21XV0YSlrM6nV04Y199H1OUFAGCze3LY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gVGtEvgr6jMlbckXyO2j1RwW9FU+LKckLFCL4lm+2OAR4E+vdx6Ik4deDYo4E4Yb7
         dvM3qOtY7/CgHpd/pM0fbbawwhVXS22M+OVNIMtaVi/MMua2SAGkdomaY4vdEg43SC
         5e0Bv8UyilQVxoblxHhYS7AgOwfZTTuldcqCRo2fzYnzEv+EoM4VFxYvCYLCtbc/t8
         yEBntCxQdnQQ66Sv8/ATZa9nvfGv1lGICS3xM87qKFSpSLeQ8vgYbpKRWMMm55E97n
         3eWeCTuYBcNf5eYNCAwSjC/9HDOtLVZD68De/dzFiLQ1IsLCNPHR9CY11oPzt8cB/P
         PDez6jqIu4QRA==
Received: by mercury (Postfix, from userid 1000)
        id 7AFC21060602; Fri,  4 Mar 2022 22:09:34 +0100 (CET)
Date:   Fri, 4 Mar 2022 22:09:34 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] power: supply: ab8500: fix a handful of spelling
 mistakes
Message-ID: <20220304210934.bv52go7h4lah3ubn@mercury.elektranox.org>
References: <20220302130832.1076437-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="frwndulclmsff3ul"
Content-Disposition: inline
In-Reply-To: <20220302130832.1076437-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--frwndulclmsff3ul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 02, 2022 at 01:08:32PM +0000, Colin Ian King wrote:
> There are a few spelling mistakes in comments and in a dev_err
> error message. Fix them.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_chargalg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/suppl=
y/ab8500_chargalg.c
> index c9c7f7028af6..8842e51b8b1c 100644
> --- a/drivers/power/supply/ab8500_chargalg.c
> +++ b/drivers/power/supply/ab8500_chargalg.c
> @@ -287,7 +287,7 @@ ab8500_chargalg_safety_timer_expired(struct hrtimer *=
timer)
>   * the maintenance timer
>   * @timer:     pointer to the timer structure
>   *
> - * This function gets called when the maintenence timer
> + * This function gets called when the maintenance timer
>   * expires
>   */
>  static enum hrtimer_restart
> @@ -431,7 +431,7 @@ static void ab8500_chargalg_stop_safety_timer(struct =
ab8500_chargalg *di)
>  /**
>   * ab8500_chargalg_start_maintenance_timer() - Start charging maintenanc=
e timer
>   * @di:		pointer to the ab8500_chargalg structure
> - * @duration:	duration of ther maintenance timer in minutes
> + * @duration:	duration of the maintenance timer in minutes
>   *
>   * The maintenance timer is used to maintain the charge in the battery o=
nce
>   * the battery is considered full. These timers are chosen to match the
> @@ -1271,7 +1271,7 @@ static void ab8500_chargalg_algorithm(struct ab8500=
_chargalg *di)
>  				STATE_SAFETY_TIMER_EXPIRED_INIT);
>  	}
>  	/*
> -	 * Check if any interrupts has occured
> +	 * Check if any interrupts has occurred
>  	 * that will prevent us from charging
>  	 */
> =20
> @@ -1525,7 +1525,7 @@ static void ab8500_chargalg_algorithm(struct ab8500=
_chargalg *di)
>  				       bi->alert_high_temp_charge_voltage_uv,
>  				       bi->alert_high_temp_charge_current_ua);
>  		} else {
> -			dev_err(di->dev, "neither low or high temp event occured\n");
> +			dev_err(di->dev, "neither low or high temp event occurred\n");
>  			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
>  			break;
>  		}
> --=20
> 2.34.1
>=20

--frwndulclmsff3ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIigA4ACgkQ2O7X88g7
+pp+nQ//cmXXN8eo3gyK+glR4d1LVn2TZprrwXYsPvAh/hG8p0N26FfzPN9pEsKA
audrSxxdP1KjUtMpgI9xqAR3KKhyDOYLMinWjd2cegBQZpKTymcDQBj5WptJePoF
EnWP+v8dPmMxMIB+6KyptSDCjK8rruaez+DmVXN7QDS0s85L86cwPkrqIZbJ0uN6
j0HbmNjDv+LrlDQyi1vZTegos/E+yMa4tuJ37Tw8Q0ZMUHa0tcmd3WPf5+fwjtA/
umTrbO8ISYa+bprErgixjjgQMMp0tCtv37lYMK4+QUp6YljF9jhIIA44cRVaCmzA
fj8fi3SUfsFYrxZmXiz1YzGWGRwWJKOYptXdBjcuYiVeFPc+klA3Gr698iSFQOTb
2tpOj+a6Tf3CzPXNwISPVF2357ugKYf78nB/yt75F22AN7kVFXQLg2qb1ryMHP/P
kdiF62HJIk+A0igahx6BPiBPcJQZmsRJPQKpT2tr3Sr7mfBHQqY7tsNgPArqjcFT
niAYdCr8maz5lmjSc1Zk4S/JJhONk94AJD8k0Av7MOvPitEW3tEnfH5x7bDr3CbE
5ZfmhMs5XL8ahvcrH7qWmsql/nFYOVJffi74WYY3sJ7JRYu7eIczYRdTxqEfzL9V
V8fTA4tGoTTTwRsZ8U8/AqeqaVAFyvSK4Y9joeeFum4mFsXhcWE=
=fl0Q
-----END PGP SIGNATURE-----

--frwndulclmsff3ul--
