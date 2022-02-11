Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF34B2E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347108AbiBKUJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:09:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBKUJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:09:04 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FECC55;
        Fri, 11 Feb 2022 12:09:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8D63E1F47303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644610141;
        bh=eAvRqHo0RU9Lgp188B/WFV9rRy04nr9pCE2iLNixyFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Im9yRkqXOA2OltaBx2puFM96HCyvq9T2KyD858+EML2gDrBCDmk6PQcKyiPy5LDMu
         hpntVIUgMDB1NrN1z3rm7XT+iZF0+K/CBCeXLTZzsLQx36pFGtvJYoqn+l9LRKZUh1
         e/IimYk9TT0zOjfuhGobPJLsO1u2bfKhfLLq8co+qjAACX1FVsEHMTujJHlTtSPs0R
         ovgqGg5iK8Y/SSLH3Dx67CTEiAX0jQrfv4s4LGppmlBMoVRsydoRLpJhBxcHd1pKnr
         sN1/XRW/zJuqMKskHRr982tnobVrKqPjXm06Ie0hGHCFozEA1OBXXWw94okKVM3vam
         /ibnrEdAmyTrw==
Received: by mercury (Postfix, from userid 1000)
        id 6233E1060908; Fri, 11 Feb 2022 21:08:59 +0100 (CET)
Date:   Fri, 11 Feb 2022 21:08:59 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     elicec@foxmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] power: supply: ab8500_charger: fix spelling typo
Message-ID: <20220211200859.zyzthhhitjmmhih7@mercury.elektranox.org>
References: <tencent_5DA124DA30164B8C65F2406B34E193F70A09@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7trnl2prv7cntliw"
Content-Disposition: inline
In-Reply-To: <tencent_5DA124DA30164B8C65F2406B34E193F70A09@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7trnl2prv7cntliw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 19, 2022 at 11:53:01AM +0800, elicec@foxmail.com wrote:
> From: Hong Peng <elicec@foxmail.com>
>=20
> fix the comment typo: "interrupts", "structcure"
>=20
> Signed-off-by: Hong Peng <elicec@foxmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index ce074c018dcb..fcf4ed4e35aa 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -171,7 +171,7 @@ enum ab8500_usb_state {
>  	struct ab8500_charger, ac_chg)
> =20
>  /**
> - * struct ab8500_charger_interrupts - ab8500 interupts
> + * struct ab8500_charger_interrupts - ab8500 interrupts
>   * @name:	name of the interrupt
>   * @isr		function pointer to the isr
>   */
> @@ -1083,7 +1083,7 @@ static int ab8500_vbus_in_curr_to_regval(struct ab8=
500_charger *di, int curr_ua)
> =20
>  /**
>   * ab8500_charger_get_usb_cur() - get usb current
> - * @di:		pointer to the ab8500_charger structre
> + * @di:		pointer to the ab8500_charger structure
>   *
>   * The usb stack provides the maximum current that can be drawn from
>   * the standard usb host. This will be in uA.
> --=20
> 2.17.1
>=20

--7trnl2prv7cntliw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGwlsACgkQ2O7X88g7
+pr0Cg/+ICRenfUZuyz4BY0vq0kP+dLddVrxlhkPLNbvJWFpihi6aYRwQpjilCOP
0IT2k6u5BW9PGOJURtr1LtXNWc8yNA2k/905JHxapj+z6792zWYpj/ctYKcusTrb
bjDPzEr+IIySxNxThaJ5RtyO2znMIPzmGzpkM1yAJZKGg9ribb9AUesFhrC8vatq
2Xil6k6RScOfbRxHFtMVwjgY9ooC2SYLFUT9uxTWXFE5D19dTKRZdQOT+Lg4SzQW
vncz+7zwsIKYhJxwZKwP7snx7SCS+bY465XuQSL+OiJLZQLkicxeX5MUYW9BMa6E
f3CRTpu7vscB4XmK08Wq+CB75cU0VI43Ts5QABnaNshYh/btAdQiSksZmCnQugt+
j4GSB80aVuxT/5CDIeNHVNbbOjXPfHHNwmXM2m5Qpn2DLyZPuRq2PZaZ01MDamjW
Q2laR5IubOKiMhatz+N7BWKyRAhgD7LjpcxqwlB0oJYWca0m0UY7MEhbQkdtWqwU
5xvJZZ0vfvcCcyVQPQ/dn6NW/9iqaY4dHa6XFiJTozp+PlKdwnE2NxJK1l2fZalA
+byoG6iVy9SfSIl4JM8yUBR9MxPdk+qju2PTkq7mJhQA/MFQUXDeSJZsYaj9JYxB
CGA2EXtSUbISp/f3xXBshtm0hq7QJ44mvasMP9cR7y7KUy2Ernk=
=lZWd
-----END PGP SIGNATURE-----

--7trnl2prv7cntliw--
