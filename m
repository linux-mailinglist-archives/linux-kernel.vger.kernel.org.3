Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049A151DCC7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443345AbiEFQG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443330AbiEFQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:06:51 -0400
X-Greylist: delayed 1950 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 09:03:05 PDT
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D025369CCB;
        Fri,  6 May 2022 09:03:05 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1nmzuZ-0005Zh-4F; Fri, 06 May 2022 17:30:31 +0200
Date:   Fri, 6 May 2022 17:29:56 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ssb: remove unreachable code
Message-ID: <20220506172956.25004612@barney>
In-Reply-To: <20220506075814.115059-1-jiapeng.chong@linux.alibaba.com>
References: <20220506075814.115059-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X0fbrmtqHTaRTxhiMw+aYS4";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X0fbrmtqHTaRTxhiMw+aYS4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri,  6 May 2022 15:58:14 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Clean up the following smatch warning:
>=20
> drivers/ssb/pci.c:917 ssb_pci_sprom_get() warn: ignoring unreachable
> code.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/ssb/pci.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/ssb/pci.c b/drivers/ssb/pci.c
> index 148bcb99c212..493bebbba521 100644
> --- a/drivers/ssb/pci.c
> +++ b/drivers/ssb/pci.c
> @@ -914,7 +914,6 @@ static int ssb_pci_sprom_get(struct ssb_bus *bus,
>  				err =3D 0;
>  				goto out_free;
>  			}
> -			pr_warn("WARNING: Invalid SPROM CRC (corrupt
> SPROM)\n"); }
>  	}
>  	err =3D sprom_extract(bus, sprom, buf, bus->sprom_size);



Acked-by: Michael B=C3=BCsch <m@bues.ch>

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/X0fbrmtqHTaRTxhiMw+aYS4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmJ1PvQACgkQ9TK+HZCN
iw6NthAAyKfzsQpLYd9idoiE9ulR6GvTJkpq+syShMJB6lWxn4gK/pFXaHrz18Ko
zM+cdWQnId/P1zlNH5UDw8wBL6CjCDdSAl0FfJX9Fsdiz9Mp0bM+cjPprI4Fn+Qx
NO3pWKEIwy2C2DV4iK2QpgLUPgu7kIOfpCTevDmwXxMT9PIjl/DFGrqmZFo7X326
MKVisT7nmoKQpCdeso7MkaXPFVRklE35KcHkQFlwtroo50IHn3Dt+Q+rrqqDN0nd
D/aOh0rHgFDRlPn5CGj9oz+5/Mxy4soV7d+/VIIEdi4fhuywBw34stn4No+X/1v4
JgrCU/tl2HSQemrhH+P8zkDaIziVLCYdDMZIj01WVnLEEAuaWezKladxqJkIHPKW
Bm9qJ/e3t1ZekZ/SRPHXi+HTA+aetxjOWGgWgy1t0+ZOdT16Ail2ERxPvD5yGAo1
EoFlHMzPuh3XYLWbwHajMj4U1uVNbwQfQCPE2xLbs1Vvl98x6vDoNPWMBvL8Uxzv
l8MM9XtkPARm7fxsQPRwGWW3s++1IQot5U1CIWvpNlnHcscIJXdAEOmijb+lqLy/
qinal+mbJ+9VQOvMRQ60yD27YcIHLTgFBqNEpXLBpq01kNtX6A3zEvAcmDnl/buZ
kSQzM8TC02drF+Mmtr7bTcSd2FxD5tHZmgWww+pA3v6r9Q3Lrv0=
=flqY
-----END PGP SIGNATURE-----

--Sig_/X0fbrmtqHTaRTxhiMw+aYS4--
