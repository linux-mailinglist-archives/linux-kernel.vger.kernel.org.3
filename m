Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B58F4D70ED
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 21:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiCLUyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 15:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiCLUyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 15:54:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897CF3AA77;
        Sat, 12 Mar 2022 12:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647118368;
        bh=CbeS28zcgqCh0r0qS73ZLWP9QDI2MAXC8k7SOGUoBi0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=GuQkwF0CwcZfCvB7XON/RF/rjwwBKDJYGobZZO/i5ghsj71OVpzcMoUplyjxhfOW4
         WfED1UaaLw8TmJkDLNdgXxO3grrjU735kVq/m8TBh0jpGWxmJOTwxQbAdorTIlNGrO
         rloObkSfLTKAtjlnj1+QEquEV9r2FNh/7/8iTnxM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([85.197.41.77]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1nawlg11gy-00RcDT; Sat, 12
 Mar 2022 21:52:48 +0100
Date:   Sat, 12 Mar 2022 21:52:47 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-media@vger.kernel.org, linux-uvc-devel@lists.sourceforge.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: media: uvcvideo: Update mailing list address
Message-ID: <Yi0IH48oA8ztvX8K@latitude>
References: <20220312203323.626657-1-j.neuschaefer@gmx.net>
 <Yi0F6mUm7iCRGvCt@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gTbAhAjvoK6IqFCA"
Content-Disposition: inline
In-Reply-To: <Yi0F6mUm7iCRGvCt@pendragon.ideasonboard.com>
X-Provags-ID: V03:K1:yfDYTRJwX16KQlpgN/kXbx9T8OG84EKplTQBcoe1ZBhBFEp1lqp
 N8qGqvRhA/ScW8EUJGRyMysydOgGKcfAXIGWB9bS8yqFDw8Vh8+9y4ASI/CawZTFbu6sDUA
 8kQpgj4J7UqPnSObUnifxl0jLXE+qTGpQEMmH3GWCbLf6sukZzeAO/PmWprdtiFB0nXz4c9
 J2hgT/VaksGqf3diNYC6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Jz1JABYAhY0=:InjW6SBteQAE7b2rhalQba
 rPhLkMDXQLxCXNlx8JBLkJbAm/a/5bcMlAJ5bDx+KqWb0KXWMPx/pAWaL6BqgMu+PwLStuS6Z
 bMchhcy816kGnh0AQhR+oyrNBy4ne7sG3P2Fr8ryztG+2JC9rgURiL7yGgqrQRQTaThHlwGU2
 YwBHlk/65vPCWbV8SHFILqX0puKdlqgwK9Udzzjk4dC2MtSyRfHnD2mmpi4WGwtcRFQ4s69dV
 5r/RyJEHPuhRbTyrwTz1xLcEcMU2nwk9IqtdApbtuhcQ0JHvUWJaaJVLl97Eo67ZllshHfJo1
 yYDLZqQxraEcEFBrNXJPMQBhcxebpsspwsDCf7EHgaRDl2JPLNYaEWnD1ysGz1yiJfksW+gm/
 k/9kDMIqLatcyLgu6adWVHtPSQZVQPFyXJqSUdrOPQ2IW+AqjKoU6vndWdFQBexWwqlZ/0b5+
 Hvd1V/uizHJsC4PUM2RcPcTpdbhux1s0HpQpaJ2jQLwJeDk3eCZK6MrrkJTSgRkgtHaDMNA92
 2qM14yLjpGzSsK7WcR87hwYfydBvp17s01MbILDVll6PWEDuHHERwZm4d/QxqM+Mh3T7P/23z
 x8t0CbLDl7uyqKTO3B5JXvhYrMREBlNpYwlpQTjIjPa0OBjfLFRmy6CrlSe0four5bsEhkm9/
 PzRRYx6fT2VTVvMTCdfH6fUtD/DvJQYNSe6QzijRGEvtyICDNjKcgetQ8aXFeEjuGVHs/vp9f
 3yNYxUcWeF5hh9XIknnAP4dk/WIGWvxT00gM/ComGHfCw/0Dhjzxq25wQDPuoa3XGdDZBJ+Gy
 7AZbB8o1Zd3WG0djREU2HC59rPiHbgk/osyBNStx9t0i/n9liXGn5uzcC8V1fTHWZveASQJRe
 ScT/iYhudlbJDYRDfNrQbyxV0sGPzLLMnPLZuBU65DXnH+CQOj/CQodF13FmAl8/xvKiBOOU3
 w4IMmAmkZnTgcR/N50yY3s1Iip34yEPcKoB88sP2P8nP/UoO/D4XqhkFuy18TzTo90M2iNGeW
 HKPjexKCjahpZL/vyWiaa8TcuT+cA8kRnZ9Rq7bkf8BhLI4Sh0RXKr4AWVYFxi7GDgv01EKky
 9ly8OTv/dx4ub0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gTbAhAjvoK6IqFCA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 12, 2022 at 10:43:22PM +0200, Laurent Pinchart wrote:
> Hi Jonathan,
>=20
> Thank you for the patch.
>=20
> On Sat, Mar 12, 2022 at 09:33:22PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > The mailing list address for UVC development has changed a while ago,
> > but it was only updated in MAINTAINERS, not in the documentation.
> > Update it there, too.
>=20
> Thanks for bringing this to my attention, I didn't know we were still
> referencing that old list.
>=20
> How about moving to the linux-media@vger.kernel.org mailing list instead
> ? I don't see many reasons to treat this driver with a special mailing
> list anymore.

Fine by me, but I'll wait for the opinion of others who more regularly
contribute to the media subsystem.


Jonathan

--gTbAhAjvoK6IqFCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmItB+oACgkQCDBEmo7z
X9vbVg/+NwEo4slKPbq4FzfghAXoVyN5el01a5KHFwUhsSv5iWjDYL/BkhfRuKUI
7XPgkwHRJ4Db5btiFWOKKFCvaPPVPSrqIaLx9ygkzTBZlijUnmGk3ZVxgND8q8mu
vs3KF/KymWFAN6+cKzkGi+qEtuxBAp2LoIkQJrBA5DXHa2cwJfilJN0PMjTKSJ0g
2qMx6Og5wJOLUtYdbPo13/ScD9IbM+JCV/DR+FUKdBwV9Dr5jDOZ/EDYZjDvQKRQ
BWyXCyE95tbbM4ghh5th5gZXzwqFsAiWVlUfDMYFdhthV6tCDI3yXkuM5ZR5zaZd
Tw6cO6X4XcqzmxlqHsu8lySZjstfXkWBD8kcjhAui1waX94wHrixIhL7AMzU8V6l
kDj0SG5+ML47m+Yi5H0SS9x1zGxNF0Vg36NCmsmHQqfdRIArO9sJcffpMCflq59e
Iweo77N7bCLrEVWKOjNr+Ud8HRSOVqv+lj0QWGKY3VWNzxBj4NAVKLOEfF0r5Kxz
TFAfevTTBa13/XExR//qSysRQ7AxAFeS8e36iPOkmRzF1NRXY2doe9cA0R1MHgJa
P41oKHKMonTNAN470/PXCz++5emHvlfjDSsEiSoCjn+sFcZ4iA1v0E19Fy/mGC69
LPSytiHfTdlVGUX6HWhar2h6ACfXV55N6UCqQuUPEclt87B506I=
=9p7L
-----END PGP SIGNATURE-----

--gTbAhAjvoK6IqFCA--
