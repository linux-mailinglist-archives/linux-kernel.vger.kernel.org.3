Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE294CDEF4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiCDU7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCDU7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:59:05 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587A131359;
        Fri,  4 Mar 2022 12:58:16 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D285C1F469EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646427494;
        bh=E+isCBS7igZjLV9k9qxgLmflOtCVpTfkme3Tz3afPbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izkdobviYBLD9mV9nqyDx3cuor8wfdJ/albVKhClXH9uiJitfYhvNfmZhCRmB1EXm
         337Im+R+BSMcqQkiv8zJEMCSHO1awiElM3SASmki+Rc81ok1rJ9z3vDNNntj4CVQ+3
         zjt+KKbzUwjPQM/MDOZZeP/VeEwB9WgZ6HRVFlcAh1JkeNm1ZG8XPfh8XXK+sXHqzv
         d44mYefhNyp6X0hrv08P7If2gwzbbkNliJpVG87uYgIGlXa+dcGV+XnLsNwSk0OiFY
         zfBDfNakofPYESGrNrBfUhBwk/FMAHBxxs6iuUaTpLjqn1LXQJPVgblEgGZdN2tt1s
         mNM6w+G+mE23g==
Received: by mercury (Postfix, from userid 1000)
        id 51FDF1060602; Fri,  4 Mar 2022 21:58:12 +0100 (CET)
Date:   Fri, 4 Mar 2022 21:58:12 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        patches@opensource.cirrus.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: Add missing free in free_charger_irq
Message-ID: <20220304205812.atinhbkeywj3zhtt@mercury.elektranox.org>
References: <20220303094322.342569-1-jiasheng@iscas.ac.cn>
 <20220303132617.GN38351@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="55dzw32ddp2elyus"
Content-Disposition: inline
In-Reply-To: <20220303132617.GN38351@ediswmail.ad.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--55dzw32ddp2elyus
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 03, 2022 at 01:26:17PM +0000, Charles Keepax wrote:
> On Thu, Mar 03, 2022 at 05:43:22PM +0800, Jiasheng Jiang wrote:
> > In free_charger_irq(), there is no free for 'WM8350_IRQ_CHG_FAST_RDY'.
> > Therefore, it should be better to add it in order to avoid the memory l=
eak.
> >=20
> > Fixes: 14431aa0c5a4 ("power_supply: Add support for WM8350 PMU")
> > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > ---
>=20
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks, queued.

-- Sebastian

--55dzw32ddp2elyus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIifV8ACgkQ2O7X88g7
+pqqqw/+MfkKbH7Dd2UHEDVHSO/2g74cVinru/D/AGcpJ7GjVAqZEUpqxMno0wtM
JPiHG3CpExpCjwPaBozCIp0HVHEwDiHkPTSuGeuCRClNKHPnaTHCgssW6lYfjwP2
OiJnqE2+CEdUcLBCncChyuaO+AObGStDeJAFgBUCKvqYBV7vdL0lOtFkygyfBiSq
+CkWVkEgSiZk3Ot9qkltVZANSFSLeb2mmIWDbSRs60fsFZnmSsZyne2aKfAVWL9p
kJxXkBZOVnyrM6z3lbQc023HqufHIozK2u1TWzwDztGLmyCZYdYwYCH14pMBuxz2
ghDCuwFlrp95z5GSD8HAZ7feOfBV9/w8T0vI1QAZYNYWL7VWcAmMtNh39SCMoReo
8z/7M0oSBSP36Eixxin/BYlnQ9OMTQGG9HaLuJWjyMTMFeWSDFmk0slumWHmE+vQ
bO1Dq/OYRw6KxIfKnjgx4nhaAjqoOKvXQpPJupnUE/VrPAA9WDsWzaiuBdoOYq7t
NSIK6OLs3Jg07R9zG5710rkW/0bvmKzXlOdS/5oqCzIvJHOYy4DTynB5U3WckPYi
b6sn8ycWiI8UcR542k1SHNMdC1z0FZoSktGRpHBx4mIAOohgY0ZPxi8HSgBN9n6C
f379tbtD1Fi0wqf07SI1hlm2LUOugdBrOAIJNRoPpqet6D5blfg=
=4Jzv
-----END PGP SIGNATURE-----

--55dzw32ddp2elyus--
