Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68CE4DC506
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiCQLtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiCQLtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:49:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5671D2050;
        Thu, 17 Mar 2022 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647517664;
        bh=ScbeAyyxitZpz1A58nWOz/GETmODM7KSYw1wdmS7/qo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CDWHssWzK47sKOlzoUdIautvZtz6kufj13W9LUBpDDB4eqrI8L255Qp1Vh6iyvVEb
         5NwGoiq4kr0N8cd9InxsF6mX0iMAhH0rDqDt1fpcDWPPIqlQnDcsLxJM+PrJVtJsiq
         7UbSMz9XqNhVQAIdi3mvnIR6X9KOTED4A5HaXss0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv2xO-1oLojQ1lnk-00qzH1; Thu, 17
 Mar 2022 12:47:44 +0100
Date:   Thu, 17 Mar 2022 12:47:43 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: nuvoton: wpcm450: select GENERIC_PINCTRL_GROUPS
Message-ID: <YjMf3xraXv5In6vP@latitude>
References: <20220317114413.1418484-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Gy9dBRxGwPjNPkdU"
Content-Disposition: inline
In-Reply-To: <20220317114413.1418484-1-j.neuschaefer@gmx.net>
X-Provags-ID: V03:K1:yFRpWLHn6vGUewvUa9nCbY5STdTIWMyPIiKt0q/hjt4P5r7IrCd
 B69otjohkzayTidPIg4bXg17JelizEMhWJeodQn5srxhqKWkbhQLpxPKB44UC1lNmVFZFst
 z/7A2lK1qDHDx98LToBMiJZEq6lDlsZNLoHQL7Mo0Mwh7vBr9cJyyMcYQxrruWOf+SJlqWu
 44A7Mks5aFozbBYnipyLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jA4yzOIfJc4=:w4teZBIHhvU+cm/kz+TFBw
 Y1iM3ahLUBsOPbwuq+wJw2aS6pFKWM1Bz3M4xJPyz4Qwjed/4mcQGrCpysG7uSTqluiREWpbn
 pLfTpbXnOclHzoBpAIXAjvt1Yjh5wtBvAKKA7jRoJxlpBPYXFIh/OwQBe8UAw2yYUw3PZlhk0
 60A42+6xSU1MjMpiBStizHeHI7XfU+OnUvgAJ2gWh5AXLNlCDOy79GuC6lncuJ6vnTKTE5fl5
 p8wUDaGIRYkuDrHg++q/lA438duoscBrh2J3iB5LWjyUwvZe9FmLNp5bn1htlX/SJvSHcApUn
 Szqd5RYlWZX8/Qd+H21gTqmrCl8ifCarOWXgeZpTOasmZ3MxzsoPxPU6tedjmhX9Gs6yQ7ody
 V49Ygj7aCZiMWryMmirEgoBXTfmSeaCqYcjzqPvGdGP3tUVgD/0EvMYJROwkZa5Vha/dh5oGn
 qP59rnG/a36y96pD6a9pMgbQYDxUlYIjH1JMD8L4NC5Ge5gSxl2mpHb7Iu6EjWXRyoI7Wd5qA
 KAUNtOzZOzqoxYCKS7XlQJr1bihhwp2OexnbFA4cYRUbacF08WI+E6Tep6TPttLtK0VPF1EBe
 gTa8KXe6f5J5+A/5sOvCTX+qD1R6C1yhaBVTy5ZyWunVjRMoWsd/KTavWgXZ0pl7LbjcpompU
 TcYl97umDvBKmMP+tX/DKevS84hM9RCTPzvcDrlM8j6amGlIuNbxyRxMqhbX3CKvasWmqYpzG
 mwN0m/ATxuYI7Lt+8P1Je4Azcxftu2Y5llnWlSg7z9vHpBVuvUJZXgI4IRXZjVLH5IWVgW9gL
 L/cNQ1yTnfDI967qQi+PaS8/BdrIk6GaFczNlBCly+jJM1JFRcGz+/KPE+UFB2a+rnBjhlhdM
 5eEOIiSE7lEF00K5n6MI27t71besNAjW80Kt7SWidPOTEz2OdBkZDGy2gls9V8aOrdgFy1SpQ
 L3ZUcAhgdCEXzItmzyylQ9zha78dMRmtn8QfrnJCY7liZhAmeMmH+gVStJNKhUjgmZZjctHR/
 MGmBwmkkUPpz1rSJXhUbA6sM56fDilFsF9aSQQmfSAUS6Tt0aN93cmWYClFKR2l81GrHtmdOd
 FkrIrWzhxLQtNg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Gy9dBRxGwPjNPkdU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2022 at 12:44:12PM +0100, Jonathan Neusch=C3=A4fer wrote:
> CONFIG_GENERIC_PINCTRL_GROUPS must be selected in order for
> struct group_desc to be defined in pinctrl/core.h.
>=20
> Add the missing select line to CONFIG_PINCTRL_WPCM450.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Ah well, I forgot

	Fixes: a1d1e0e3d80a8 ("pinctrl: nuvoton: Add driver for WPCM450")

which would be appropriate here.


> ---
>  drivers/pinctrl/nuvoton/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pinctrl/nuvoton/Kconfig b/drivers/pinctrl/nuvoton/Kc=
onfig
> index 6a3c6f2a73f2d..b48d32912bef1 100644
> --- a/drivers/pinctrl/nuvoton/Kconfig
> +++ b/drivers/pinctrl/nuvoton/Kconfig
> @@ -6,6 +6,7 @@ config PINCTRL_WPCM450
>  	select PINMUX
>  	select PINCONF
>  	select GENERIC_PINCONF
> +	select GENERIC_PINCTRL_GROUPS
>  	select GPIOLIB
>  	select GPIO_GENERIC
>  	select GPIOLIB_IRQCHIP
> --
> 2.35.1
>=20

--Gy9dBRxGwPjNPkdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIzH74ACgkQCDBEmo7z
X9tQZQ/+NikVIHk3lzAqOLO6DkBqMLn0rKX1tw4bokOJ+5f/lCoBEBiGhIGddOgd
LpFDfvewGj65PkvdYkNN0WG93E1B2oc6uFZeKe8sQF4qGoXGEQHWHWSfDJWZjCp1
NEIIRDsdnHc1bc/OWkMjfWs9Fc5A66ATqMUaWWqFlp6BMXuuJvlqif4dU/NvUitL
5OhALWZeqMzqHdwmWdnZ5F0NhrSImjcApMfVdpS6UdT7ZVCqUBQvLUfq3wdxsuBa
22waseqVHx+d1PZ1g+WVck6++62/C+DNgoZ2BtT2eUTk/ltC8tI7A4Srt7CoQBPC
CXTFwFrQ9xw3yqBE+Go56vLzSh/NEVyDUIHkXAB0LhAYXbd3iB8cJmvQ8Tjs++Uz
LHLRLAwCnMc/H3uRegVsB+o4sQrWxjVWLagz8w6WkshJ/4MT6lay0SBHVWruv1jh
rx6wnjkHcIPSm+t13p+v8kMXYSLaNm/b2WCLtirn/cmOXCJMCDAGz1BwLeGcfM8z
v7GPTCEgSoZknZjf1d+dgZf/p5psrRURo7bJF2g07lpNi2GGzbCftzhhsY6s0SEU
26Zz893/mDriDFnEOZcRhz/VX7B2WY05aoc8og/Va407/eJLQNJmA/FPFyozfoV8
MQDwV2oyknxqcVnPGF58MLzbXQ9oscqQYsbIs1vyCICheEtXGhM=
=PTgZ
-----END PGP SIGNATURE-----

--Gy9dBRxGwPjNPkdU--
