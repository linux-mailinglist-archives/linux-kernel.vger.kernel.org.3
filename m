Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81C74B32E4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 04:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiBLDoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 22:44:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiBLDoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 22:44:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F402CCAA;
        Fri, 11 Feb 2022 19:44:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E2EF21F46C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644637443;
        bh=eUnTyKCYsmt34avibvcGGRdqVod07WVee9Noc3HCMeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMr4+2xCTSEwVQERus0GAVXyjsiRtBSZCLFbBEfj1N9nCIjczJZ8QtBp44GE8G5g5
         lmZ4E/wTPCtfvOKIAXyu3G+CAMdiXb3nm6uGmZpgvAHYBTK9k5OIdEf+wEwX90/rlW
         yFKnUt1WVnWejvNQrLiJKRB3QCtHEztuPjlw/dD83D7C0eLDpkgYVhy1ikSdbBOXxB
         qJXufqljmA7uL4GhjFPTnwueWoM7U5ogdtdMmEpXdEzj07VtDEmw5G2ndTRxkmLktU
         zO0ztzvBEuFPUhwLHVI9klraptdWJ3gNrY5FKu297QUEGqo9XPJrXzlcsKtcIOTwS7
         /dUbWouCgIwjQ==
Received: by mercury (Postfix, from userid 1000)
        id C3D821060908; Sat, 12 Feb 2022 04:44:00 +0100 (CET)
Date:   Sat, 12 Feb 2022 04:44:00 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     "Rivera-Matos, Ricardo" <rriveram@opensource.cirrus.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [RESEND v2 1/2] power: supply: Introduces bypass charging
 property
Message-ID: <20220212034400.kg4cy2t6g7espy6n@mercury.elektranox.org>
References: <20220210154108.641369-1-rriveram@opensource.cirrus.com>
 <20220210154108.641369-2-rriveram@opensource.cirrus.com>
 <20220211204309.apzep7w233vh7iin@mercury.elektranox.org>
 <7DD3FE07-445C-47BC-92AB-B281ABF67068@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k24gd5mxe7y6lu5c"
Content-Disposition: inline
In-Reply-To: <7DD3FE07-445C-47BC-92AB-B281ABF67068@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k24gd5mxe7y6lu5c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 11, 2022 at 03:46:52PM -0600, Rivera-Matos, Ricardo wrote:
> > I think your patch description is a good explanation for that file.
> > Also I obviously missed to point this out for the "Long Life" charge
> > type, so please also add a sentence for that so that the property
> > is properly documented.
>=20
> As I understand it =E2=80=9CLong Life=E2=80=9D means the charger reduces =
its
> charging rate in order to prolong the battery health.
>=20
> Is this a fit explanation?

Yes, thanks for taking care of it.

-- Sebastian

--k24gd5mxe7y6lu5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIHLP0ACgkQ2O7X88g7
+ppXlxAAoobFCBKmGdJBV8MBwzqD7Qt2+dGk85abpvzDXVTTwHOB24jJSZeo/uxs
SDxE1as5at3zSAxmDjcS2U/xmQUPGOOZeQbycJPDj+rKzfj+lP92fzGfikVpTKof
cch8PJzWFoXOcjDvPz73QjI/R3ole9MV5SWl/oa4Hj/78rw3rjcsFYvUx4ISWbFy
h88ETM3dUgqG18xpxRy69zlCAjOnwssPRT5QEQzAigEgS/cJ8lR2bET/WlrRP1bh
RhEvpo5hNT1lQuAzafzV6Ht4wiAXnx02JG2WuEDgypf4vrIEc3Zjx3lOYvr/a2GC
C5wh3RjtdtKGVMMzVdU0T0G5bLiILThtX16Sa5hPP4Dl7TSkfUjjPSApF5Gyxjh2
zfFAnrXNgQDyDpy/xZgMfsQCgLbnncYTgQr3AeFKe3fqfEErmIpdt5qEsH3NyIjZ
fGpbir5hSmDbl5WQxfAA9hZfkA/qhNHyROFahO4yiqujIzucNsQTNBs61ED0nUvB
d0gphzEsbozfz92FQ/ffAwdovexRqWErpIpFx+3pK9GiY+8OJcqgr8+27YJcd7O9
/6hxuRLbtgdfzzMC/BitY4FaSWiZq10ZyBaV9otAkQITj14qGb5fZIKdOpuTiLBD
vonhcOlgnuLO5WGCfIALSp8YIuDMg44Qi09Ng3xxsEmYUUnFAHA=
=oivJ
-----END PGP SIGNATURE-----

--k24gd5mxe7y6lu5c--
