Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A774C4D8038
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238699AbiCNKxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiCNKx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:53:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1235F30F49;
        Mon, 14 Mar 2022 03:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647255115;
        bh=oECk5B9577Bg6L/hYRaSYz3HYPl+YlalMHbwajDQoi0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bWxkOKvsETehgIZIwLFRUda3i7fFZyaOLWSKKMC4P4vjRS06SWRpIenV0P8Duwq0U
         C99P8KbX00jbjTYyPIjT6cqb7uPjiYry0WTDhqErnO1HSohuB+qCFyv5TXJp9s6JPb
         t/UxBCck5Vuln9VIm8g2PZGLrLDiE8ng8z7hNVlM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1o47SJ1XTQ-00h4H2; Mon, 14
 Mar 2022 11:51:55 +0100
Date:   Mon, 14 Mar 2022 11:51:51 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-media@vger.kernel.org, linux-uvc-devel@lists.sourceforge.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: media: uvcvideo: Update mailing list address
Message-ID: <Yi8eR1nQIk4t7o+a@latitude>
References: <20220312203323.626657-1-j.neuschaefer@gmx.net>
 <Yi0F6mUm7iCRGvCt@pendragon.ideasonboard.com>
 <Yi0IH48oA8ztvX8K@latitude>
 <164716363247.3407360.2736836911812651199@Monstersaurus>
 <Yi3+33EysD/JqCdr@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IeSFFX1yzYsaLYJn"
Content-Disposition: inline
In-Reply-To: <Yi3+33EysD/JqCdr@pendragon.ideasonboard.com>
X-Provags-ID: V03:K1:hYMmSQrL3bPc8+CIx3DPBxfUGaRa7/tA9JtWlJuKVAHEsf1qsB9
 Qjm/TzfGdK7copyw+FG6lu/uVyvzO2D/X1zwM3kwUSm2y08Rbesqi+YAEDgR4D2icheDra+
 pIXJ8a0gzTfEFAWNaN/waTyRBScAqS1p3UOn/atXtIvNQm0CnzrV7A7WqQoDAiYcMknGOJV
 pVGJu1swqsQ5p0hS4Mgrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pFWspQwbjXM=:0oJ/owvNo83AAqoqdW4Tjy
 KWY9wkAcy2CMTrSdrPsilOnq+48+AazeceEkb5dVQ8Lz5of7gqIZ1bE20VAjlG/AHEkIrL3kx
 nrn7OniSnQpD2uD1cPig15/vt5K9iV2bmiF1LGVzdYs9kpbB/vyc50Cg41e+8Fq5vlJFjHMhk
 49WnjYw85PS35BPscPTCoRdzMNpppFc2YBjTcu0nh+Zwsu6CYnQB2bOuF3+qc3esQ2bn4rCZ4
 oGisd0ETdS93uQPtv2Xksafu3AU1v0tJLbPnSxl7TUh5wceBUGHHUYT2c3qStKw9kE5KqGXBo
 L6rgNVbwqW/RYTVcb/EiOQ3gaQxQ9vZN9dOREY1NrDQxVSC3tPH3D5H/NLDdDK0bJXRZvxDo9
 sAZb0XxjYPqk7QCIm5xF/y7PI/y0StYL9baOT5vjZwjWRftIWN4LfOFv4k0H7XOeTf8to5cIE
 JyK9NdaxYt1eipiF5GOHtP74CyjVT3S+L/gBvvgeToRxhI7VUTvdmpw5mynvvgg7NozytwyhM
 j7o/ZZ5hkTsUIDn4OnRsjjoFzdwHr5vYT3RMNR27qj44fskTXsm1nRx7JgtS5ieob1BxQWf+I
 CM0HacG1Gi+3NUwAWAoFk32TSiPPp5x42DIK4L87YH6CMDu59BpyfOnN0zB33jtc/XrtDgdB/
 knJ42BI+OSzkIzmM8IO11e+dpqhBPSL1BVP+uFOuy6NBbMMPPzD54JmJb21Moj0PibGNoc6L8
 Jo7a9SQlWoaXbaJuX2Hr5w6PaEKr15AiqY7C3Rwg1zCBs9JYqaqXxHMqvcAGyzI6PVCw7Lc4L
 xgNU6jaYIBzwPQymcJ5KiRYp9VKeuvoKv4YHc0MNAtx7VTeqKODzDHSYelSREuIcVmPxWX+KT
 XeQL0fCvJkGuvkNze28CW4XPVbhABGqfJInYJ1mqlS8Bt5KoSx42mnSEPIPfO7FH4S3Non/Z2
 zgRO96KcjIVbak1Lkj7r85lWCxJzom8FeE4twO4iq3s9RUlLPArG5E0kS4m2bWD7A66bLjlvq
 9TleqSSeXRx1vTTkGHNeEIYsfWAHFho2DodWSDABP2scbonJbUfZlmgmI3piW1/rR3F4639om
 zZQiebmB1Tjkb4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IeSFFX1yzYsaLYJn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 13, 2022 at 04:25:35PM +0200, Laurent Pinchart wrote:
> On Sun, Mar 13, 2022 at 09:27:12AM +0000, Kieran Bingham wrote:
> > Quoting Jonathan Neusch=C3=A4fer (2022-03-12 20:52:47)
> > > On Sat, Mar 12, 2022 at 10:43:22PM +0200, Laurent Pinchart wrote:
> > > > Hi Jonathan,
> > > >=20
> > > > Thank you for the patch.
> > > >=20
> > > > On Sat, Mar 12, 2022 at 09:33:22PM +0100, Jonathan Neusch=C3=A4fer =
wrote:
> > > > > The mailing list address for UVC development has changed a while =
ago,
> > > > > but it was only updated in MAINTAINERS, not in the documentation.
> > > > > Update it there, too.
> > > >=20
> > > > Thanks for bringing this to my attention, I didn't know we were sti=
ll
> > > > referencing that old list.
> > > >=20
> > > > How about moving to the linux-media@vger.kernel.org mailing list in=
stead
> > > > ? I don't see many reasons to treat this driver with a special mail=
ing
> > > > list anymore.
> > >=20
> > > Fine by me, but I'll wait for the opinion of others who more regularly
> > > contribute to the media subsystem.
> >=20
> > Being subscribed to the linux-uvc-devel list, and seeing that it's a
> > black hole where people post, and unfortunately get very little to no
> > response I certainly concur that it needs to be changed.
> >=20
> > I don't think we can guarantee a better response with linux-media, but
> > at least it's the right place, where the driver is actually maintained.
> >=20
> > So I also believe it should be moved to linux-media.
>=20
> Jonathan, would you send a v2 that references the
> linux-media@vger.kernel.org list ?

Will do.


Thanks,
Jonathan

--IeSFFX1yzYsaLYJn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmIvHiQACgkQCDBEmo7z
X9s4fg/+JAxbTqjTZe2yn4H2xautGMoBbW/SonKS5JC3b1crlfFR9eoiHbnX3tzg
nXaD4iiANSee+IM0f0z1AXo2SPiY8v/Xng94KsOUN5x7tZVBDICXNGgiW4d0wI4i
Vdm7G9nmrrjF8Laf6LNShSqcYbA3tdyMxnGLUcLohwUQ1HZxzGQGoFwXkFlQ+llf
t0sbXULhZ2eyQutCVCLXaVyunzkih8SGim+F16ocOeaO+rxDKHEadbKbjXvGG0ae
z09kUsp9xmyxHmMiUDAinNnHlvK/GYsOBKMzPebuAYEFXf5OvXB5ORV8LLtC+f/m
4tAx1IchRK5gIeRe2/O6HHuXzLc4W1ylXhxZLegccwqld9BLDJaO+xjterBCHBEb
XazfGveB6YUisaa8T8vfPj7t1jBX966mFFDXwpoZLak73rwLDihFR59Zbt7bVWsv
SLw2ceQhw4Lm1i0hSf+/KfjmUszJ5368EqvpgXWXDQYf2k6NVmYJylbSF59bYoDV
MmMKqSogNbMqbPSPmmqZPxFmeOoa+jO0qtZtixKh/MgNSG0aZ/0+BabL37VLucbQ
fd7oFtA2dlQdovvA6aVs/LdjjJMspRzlJRBmx3+cI39b7Nf7DlgVM+7B6ODNPmWR
lIAAzhA8RKxMzukTLDK6c8EQOVcc/WAwcby6MZvQicdF4QDMhzE=
=NEWr
-----END PGP SIGNATURE-----

--IeSFFX1yzYsaLYJn--
