Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6098F4DC4CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiCQL0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiCQL0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:26:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F0C1E3E08;
        Thu, 17 Mar 2022 04:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647516277;
        bh=rz/kIL0ebTYiAvUOeOo0SqZ21Y/rMB/+G/lC/CVXaQo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Q6sIsGfiyqni72VWRmGARY9030nqerCMxTyZYypf7zOCJ2aoqz9MUCWmcZLLFClnp
         qWfwv1tuBNtmlrHUNubSsGLrUZMy8U2fhAfev797vI6yRwPfxyJ+Jesig/CBWOMCfS
         ksTFPWu8IIXBGgX2AUC/3qJ7M3gp9CBIzYDGXG/k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0JM-1nxZTp1uqu-00kNsD; Thu, 17
 Mar 2022 12:24:37 +0100
Date:   Thu, 17 Mar 2022 12:24:35 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jialin Zhang <zhangjialin11@huawei.com>
Cc:     j.neuschaefer@gmx.net, linus.walleij@linaro.org,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pinctrl: nuvoton: Fix return value check in
 wpcm450_gpio_register()
Message-ID: <YjMac/pwFH5Z+Lxs@latitude>
References: <20220317065851.495394-1-zhangjialin11@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gVWGy808rXGFxfpb"
Content-Disposition: inline
In-Reply-To: <20220317065851.495394-1-zhangjialin11@huawei.com>
X-Provags-ID: V03:K1:3F1BaI76xUMu3QZtwU5ZFOFb2sBVwOzw0CAV5Hyo2V7xYEktmBw
 gZR2rtZY1OnA73RRDWfv6qQI2A0SZj0aJ2Q251Ogm04ZWRWjzd+XgLm9YwuyROraf7JeKbN
 fiSrUi4XYYc20D3HzXJtlubZ6RgxhjcDyqt1bTDggseLs7dhW+soMvdffLXmqpDLEdxiJ9p
 kxHyBXB7Yy0z1l5ZBWksg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NsN/WGv/mSs=:Cnc2bfkzOWHRjCU6R40qYH
 G2zybI/25E0oeQdE+CKGHePm8GLjf6KLzuIo0hEAaN0to2A/OgqpTx3qlpgz3I9BHYfKC/loh
 1cNr86pyKNRTlDIkrLew5rIvK8NNZrj/LhHpMDyIwUfZd/8KhB7puCDozAwRze9dQr7QaRM50
 5q9gwdQl/REjRTzc14FrHuCz4co/n1SfW5w0NHCER/ANOkc0SD954x+8zeuC3RtDMdM2FmmR0
 bj0uPG4OPD0mBICAsZ9ufaFpnUkZa3+MQR9wCXQuPsETzxH9Qlcy9jaUR2L7mSm6o3NL6YHqZ
 IKTA9qvZSptBKyZX6K1P7aNV1+VI/kRVj72Lg0U0+GPmbpyredNhqctdCX7IdIBTB97eXOkXB
 kx2QSynGjIP4+lyWYlh+lklHWzhpJ2a85k1knEh58gJemZfgxc6HVQuAPzlNmwTXoC2OG5OoO
 G+B3waaapTwRQWjl4aRrJoNaz/gLVaXfR1jcdqbTIBpB9/nQUv5B9T1lV7y/qmL4U5tkiBQxT
 CgxTtivrwchEl4WmBrsYWvhWrHz5cwpqLpB6+IQb5L2vh6F/xaPZx6cEzuFVW969xiyq19B2H
 Ash+q63zfWAjHJxFJKyjXv4ijFNYHRG0g3Eo4g+cYTCbfd4LJprQ6P9/kv0+LOc9CF3Fzix5R
 iM64LcsXdiMI/wAmgmhKVkamTpv1YhDtH2bXp5LGt2qHbgsEKJenWnyaUdbfgT+Eay13b37Fg
 JLpRarf84ML/S6DzwOe8r11LAMDGeSKeNg3FKDPZwAK9gla+WMhf9gWMYEqbmJRsXnmGKAONO
 fbXE3lvm0WGFhByZP4G30oefC+QRcDy6iyhUohGYT7XKafZlfctH6Ngp1Q6vlpMDSbJrAcSpq
 caeeiranVbCn6BMAeEfiljKB9NZBtQFagdylmWU5AAg9NfqpW7Z8LuAvvwi9lWPNVYmMC7cfF
 saoyMkVzsea1X/y4BGiDAz6aKLq9foVhslSCk9tA9VNQ8e8usEZBzQqm+LL8L3wdbmVTYYQiM
 4lj7uuKZB1+klbGZ5hotUFyR0P5UdHEL7/dn90po5MbUuKPXm5eekkNwgV0jzcOWYdmIsDOWO
 Ux23WNuiEzRcig=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gVWGy808rXGFxfpb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2022 at 02:58:51PM +0800, Jialin Zhang wrote:
> In case of error, the function devm_platform_ioremap_resource()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().

Right.

>=20
> Fixes: a1d1e0e3d80a ("pinctrl: nuvoton: Add driver for WPCM450")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>
> ---
>  drivers/pinctrl/nuvoton/pinctrl-wpcm450.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c b/drivers/pinctrl/=
nuvoton/pinctrl-wpcm450.c
> index 661aa963e3fc..a71b684b9b44 100644
> --- a/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
> +++ b/drivers/pinctrl/nuvoton/pinctrl-wpcm450.c
> @@ -1019,8 +1019,9 @@ static int wpcm450_gpio_register(struct platform_de=
vice *pdev,
>  	int ret;
> =20
>  	pctrl->gpio_base =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (!pctrl->gpio_base)
> -		return dev_err_probe(dev, -ENOMEM, "Resource fail for GPIO controller\=
n");
> +	if (IS_ERR(pctrl->gpio_base))
> +		return dev_err_probe(dev, PTR_ERR(pctrl->gpio_base),
> +				     "Resource fail for GPIO controller\n");
> =20

Reviewed-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


Thanks!
Jonathan

--gVWGy808rXGFxfpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIzGjkACgkQCDBEmo7z
X9uHzg/8CgMmkm5zckLAtMOv/xJMr+xEhsotnEUf87aBvGKvjZhDzhYXXu3hlAIM
LLwNRfVpKdqupE3Hh3asBW113EiNH/cymS9jbTyxS02b9wn3G0a2svAGdFgYKsmC
MT/5RWgUpj5eJo2q5PfJMRSQqQW4LP4ZPQyNvBPCqS93IFAJpuBAe4uQKcp589Kk
0ZrPrOaodBKPv3V0Bdrole4gCuq67mV/erYRWx3/9nl9326jPDr9pzPtO9E63QQP
uXaX5yyNw8EqVcJXyi4AFKF7C8iELvRwRrZ+xR2oW9mb/LEUohjFx13OPiX9rtaU
px/EkKMCVvfyVOhSULlsGxGTZE7f2qHFPJkkHNAg59FC8dWP0MxZkVoz7q1UCaOd
zRXd51IwY3yH2fmdAjDT6/p3xjcPumYtzgy4LikxvSG3kbcbqLDB+5R2p/kXmHMj
HVNTkyDEYExRUByqIgDX5A6zWy4nZU8OgmGCZuzveRnZP+QSDnft6vRchLhwRE1P
JF7Gm/Lwzb6kWOus1bYlAv7HvUAjPLdd8KKAtt6Fm9dR6cwyh1HfNDr7tuhuSDLu
irk7KhP99uYuK0as5kOGy4yQjZ503uoEYgtaGNzMlCilAjHpe8rR5+cf+v5S8EG1
wgPjX8O+lwINQxwyNrUB2cJ/IdLiZrWCvrLwGuwweiews3uD7jI=
=2Ou/
-----END PGP SIGNATURE-----

--gVWGy808rXGFxfpb--
