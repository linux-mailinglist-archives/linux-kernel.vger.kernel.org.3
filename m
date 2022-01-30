Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23584A3607
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354696AbiA3Lom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:44:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50528 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354689AbiA3Lol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:44:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 144C5B82904;
        Sun, 30 Jan 2022 11:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C35C340E4;
        Sun, 30 Jan 2022 11:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643543078;
        bh=bU+bE9g3RxDrvTkLSURPmNjGsKVoht5+G+tw3mHeICg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CqhdP3M0iSLXvD2CAyZVwibibEIE9lMP6ENk3lEOirjkWejXUqUUN1hyT3Vr9l8mv
         AEP+BkIBnLt9+9LekrKjs0/fIlLIdOKAv9wtdBTzgkcAh9x71n/xmedKbP7Wq8ftpg
         mQ2t2JGV6CTRUWY1pDUnvnQB1YnF4PkLkyYsd5Y8T8ASw/aTZeSqUrHxVz+Bp66Hm7
         DpCdUz7l1WIWiHsz7wEagaG6W8UzzTac9Zfu32hpBMcYFTyOHllzWWwemelUSnmfLh
         5akO18g6hjAAkdxP8vAa2VDH2Gh7bzNlPuEB/d6AlHmD9sEpWMC/lE1GocrPhCNMgA
         Dqh8gtFe4/wTA==
Date:   Sun, 30 Jan 2022 11:51:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH] iio: frequency: admv1013: remove the always true
 condition
Message-ID: <20220130115101.0dc314dc@jic23-huawei>
In-Reply-To: <b5b69eac10039de1b287df90279f464bd70e1de0.camel@collabora.com>
References: <YdS3gJYtECMaDDjA@debian-BULLSEYE-live-builder-AMD64>
        <20220115180941.709a667a@jic23-huawei>
        <b5b69eac10039de1b287df90279f464bd70e1de0.camel@collabora.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 13:34:28 +0500
Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:

> On Sat, 2022-01-15 at 18:09 +0000, Jonathan Cameron wrote:
> > On Wed, 5 Jan 2022 02:09:20 +0500
> > Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> >  =20
> > > unsigned int variable is always greater than or equal to zero. Make t=
he
> > > if condition simple.
> > >=20
> > > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com> =20
> > Hi,
> >=20
> > + CC Antoniu and this should have a Fixes tag.
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
>=20
> Please let me know if I should send a V2 with this tag included.

Great thanks an no need to resend.

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

>=20
> Thanks,
> Usama
> > > ---
> > > =C2=A0drivers/iio/frequency/admv1013.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency=
/admv1013.c
> > > index 6cdeb50143af..3f3c478e9baa 100644
> > > --- a/drivers/iio/frequency/admv1013.c
> > > +++ b/drivers/iio/frequency/admv1013.c
> > > @@ -348,7 +348,7 @@ static int admv1013_update_mixer_vgate(struct adm=
v1013_state *st)
> > > =C2=A0
> > >=20
> > >=20
> > >=20
> > > =C2=A0	vcm =3D regulator_get_voltage(st->reg);
> > > =C2=A0
> > >=20
> > >=20
> > >=20
> > > -	if (vcm >=3D 0 && vcm < 1800000)
> > > +	if (vcm < 1800000)
> > > =C2=A0		mixer_vgate =3D (2389 * vcm / 1000000 + 8100) / 100;
> > > =C2=A0	else if (vcm > 1800000 && vcm < 2600000)
> > > =C2=A0		mixer_vgate =3D (2375 * vcm / 1000000 + 125) / 100; =20
> >  =20
>=20
>=20

