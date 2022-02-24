Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127304C2ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiBXLWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiBXLWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:22:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F5E59A7D;
        Thu, 24 Feb 2022 03:21:50 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C99451F42062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645701708;
        bh=YBLvfr3OobSAV/rNNzdpOTHNgJpHKsaNfSljGVW3xNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lvUTuTfupIEMLS2D7sVgrU3AzNiTKEx59CsDtF2KkMSfFDFts4QUDfZaLiuiIFsNI
         tkqgWySO0Z0TtD1y5saPM0UR4m3BX+DIMv8N3eLGjRQfN32GZfZnnnIajPVvezQlnM
         KRPoIj4laLzVsBIxu9khBXGqEA0Xqsue05u1BMJwSTjD+8GEzErj9LlPVCVL3G6MrP
         2zsFwf3iqvBMX885kCgArCCtcZbRHSWL1uPcsWU/CbwnMpRHt+ewOiJeThfl3xtlYL
         dqwESKlMXAUo84XxttXnoQOiP/YR9LDPYMXRzWQ8YRR5f3byaOzX6Qym0GJXZ4vqFh
         b589cqNtd5oYA==
Received: by mercury (Postfix, from userid 1000)
        id CA609106049B; Thu, 24 Feb 2022 12:21:46 +0100 (CET)
Date:   Thu, 24 Feb 2022 12:21:46 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] power: supply: da9150-fg: Use
 devm_delayed_work_autocancel()
Message-ID: <20220224112146.ytrcop3lcjfd6f6n@mercury.elektranox.org>
References: <c4cf74b56258c679f69bbc6350179b8b500f5800.1644774892.git.christophe.jaillet@wanadoo.fr>
 <DB9PR10MB465210AEF84FD0F390B1616480379@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qbwhz74rtboa72lk"
Content-Disposition: inline
In-Reply-To: <DB9PR10MB465210AEF84FD0F390B1616480379@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qbwhz74rtboa72lk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 18, 2022 at 01:13:10PM +0000, Adam Thomson wrote:
> On 13 February 2022 17:55, Christophe JAILLET wrote:
>=20
> > This driver only uses managed resources, except for the delayed work, if
> > it is used.
> >=20
> > Use devm_delayed_work_autocancel() to also manage the delayed work.
> > The error handling path of the probe and the remove function can both be
> > removed.
> >=20
> > This saves a few lines of code.
> >=20
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>=20
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Thanks, queued.

-- Sebastian

--qbwhz74rtboa72lk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIXakoACgkQ2O7X88g7
+pobYA/+LlE8lFoeRCKrCzws94CDRC8eF3Rogl4SuwGgSpRBMbjrIiW5rSF6RwtX
E1qmWrpCPyksk2i9QsIOiSY8WCWmoo7LnUqVwEfZNtftpXJrwZyo1lKVTepShSvl
ti4oJYhdTjIKxyfJfpKzd3D8icLkdoPG3Wv46DosxtcXFJIRrXGYR3RaMQLQyu09
x6chf/sSQDgrsZUtuKdtCTJeBpwoSXIjur2UV4i4wMxw6q0HqPeGJcPpBmnYPsHL
7KeJPNA0sTcnjXgherqm5l5KVxNDEoXajKKga9XykvO8BQZvxkI5V72AtAxJxT0v
Ya5DgwtTW0vkSEMQwHARbUrz091BIZSBJkBtkjz8oNLhxi4q9fB99qO+DxrtoZm3
3EcbxqkmJpjSrm7pslOjc9awj83TxpNBsbxrDEDTxPsf8gGx/ucTUuz0H97Gmf0V
rXsgYCVBkQu9MFS7kjdLLoF30CH0R2oJTQoD1YSk+WXN+E5t3inufJVMQMillt4Y
JJeS1ZW/RTK2VD7yXzz/XDOYE2KPajgRwhZLXzRy2s1vYnjU14z91fklS4Yt3zft
R4eHxSfe4khDViUiDMcm4ssQxxUM4O2tejCy3FdghPaKp/n25Nbnu5OQ0bEkVZy4
UFAWrPkv32SzNmW5DjrgJ6JUwVVsqAtLZsl34f+MCZb6+Q+8PiQ=
=LDsa
-----END PGP SIGNATURE-----

--qbwhz74rtboa72lk--
