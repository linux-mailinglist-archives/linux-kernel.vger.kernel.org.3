Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25E9463E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245675AbhK3S7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:59:22 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:50298 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbhK3S7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:59:20 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 92F881C0BA8; Tue, 30 Nov 2021 19:55:59 +0100 (CET)
Date:   Tue, 30 Nov 2021 19:55:58 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] ARM: dts: mstar: unitv2: Wire up LEDs
Message-ID: <20211130185558.GD30113@duo.ucw.cz>
References: <20210923065500.2284347-1-daniel@0x0f.com>
 <20210923065500.2284347-8-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jCrbxBqMcLqd4mOl"
Content-Disposition: inline
In-Reply-To: <20210923065500.2284347-8-daniel@0x0f.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jCrbxBqMcLqd4mOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add the red and white leds present on the unitv2.

Thanks for cc-ing me.

> @@ -18,6 +20,18 @@ aliases {
>  	chosen {
>  		stdout-path =3D "serial0:115200n8";
>  	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +		led-white {
> +			gpios =3D <&gpio SSD20XD_GPIO_GPIO0 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger =3D "activity";
> +		};
> +		led-red {
> +			gpios =3D <&gpio SSD20XD_GPIO_GPIO1 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger =3D "heartbeat";
> +		};
> +	};

How do these look in userspace (ls /sys/class/leds)? See
Documentation/devicetree/bindings/leds/common.yaml . Should the first
one be disk-activity?

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--jCrbxBqMcLqd4mOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYaZzvgAKCRAw5/Bqldv6
8sZ8AJ998LOy4ySaPJQ+fkZxHdliuWUflwCgtsmz2w0+VZndz2PlVEy8Ie9cSrE=
=Y2nW
-----END PGP SIGNATURE-----

--jCrbxBqMcLqd4mOl--
