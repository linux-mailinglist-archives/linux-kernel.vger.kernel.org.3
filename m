Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D57C478264
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhLQBrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:47:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59800 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhLQBri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:47:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0457D61FEA;
        Fri, 17 Dec 2021 01:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA49C36AE0;
        Fri, 17 Dec 2021 01:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639705657;
        bh=3J8k33CQTphuVW6PtLpiYVzbqWIK8XVYiqNdZ/Wqjbk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qZiUtiqag4yxjqQ/EgPVH+LZ6O77oY9pmdkO6acsaIJ4FSxmUcAS7Bo/uVZK5lF2V
         JZomFcK99OQlod2gI3WVuS27ac+DJ7Gq7aLC3k/YPFQ+IEyCvY7jUrbVwOWzs2v5J4
         7hNbDlcBagh4pw6jY1DhNM4oJ1b2QRRw/plMuGMMh15PVqV0rZGJz3zxhBJHCyOPud
         Y4hpnR3inlfFsJzwVEBt0pjR32jeA9JdwfbGnhXDKNpC9cgCRJM/E9ntt9bQ6iqjPD
         g4VshzeAhDMVt3j8DhRr7aGPwgtbKZLGUEHkvaXaNcz6MJlxCaoPnXmnoIVQCFWBen
         9AaQAuOnshJ/g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Qk2RUY9T8QCX1un25vsEYOAnlYlkMQpywbz05_FpVSYq8Lek4EStNPkA_vt_BBH1HKuwsbNw_F8Ec73fM2Kk9Zdl1wvjLtwaHE5QKSvV6Hs=@wujek.eu>
References: <20211203141515.2448129-1-dev_public@wujek.eu> <20211206225354.BF0AFC341C6@smtp.kernel.org> <jgJW1u3RfTQcv5ZBcVQt4fz8_sA4gvyXsN5x18zzLo_nTR5nfLpZtdAjy-WlEaCMnmnPGZjeFGV5OoiWNtA4Tn5wLhqNJdQEvPw5Cqs1z3I=@wujek.eu> <20211208043054.CEFD6C00446@smtp.kernel.org> <XedF_WXH1abo9n2bzY4gaRIjq-R1O6ha5QedK8e1W9-R_1p_zo90aAgaKSSfDYMW3WUaMdY0pjONnKWj4zNMh5TbHlbZbAVAe4KG_Zq8Vvk=@wujek.eu> <20211216063245.603F1C36AE4@smtp.kernel.org> <Qk2RUY9T8QCX1un25vsEYOAnlYlkMQpywbz05_FpVSYq8Lek4EStNPkA_vt_BBH1HKuwsbNw_F8Ec73fM2Kk9Zdl1wvjLtwaHE5QKSvV6Hs=@wujek.eu>
Subject: Re: [PATCH] clk: si5341: Add sysfs property to check selected input
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     wujek dev <dev_public@wujek.eu>
Date:   Thu, 16 Dec 2021 17:47:36 -0800
User-Agent: alot/0.9.1
Message-Id: <20211217014737.4BA49C36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting wujek dev (2021-12-16 06:25:58)
>=20
>=20
> =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original =
Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
>=20
> On Thursday, December 16th, 2021 at 07:32, Stephen Boyd <sboyd@kernel.org=
> wrote:
>=20
> > Quoting wujek dev (2021-12-09 04:04:48)
> >
> > > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origi=
nal Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
> > >
> > > On Wednesday, December 8th, 2021 at 05:30, Stephen Boyd sboyd@kernel.=
org wrote:
> > >
> > > > Quoting wujek dev (2021-12-06 15:08:03)
> > > >
> > > > > Other sysfs properties used by this driver are not documented so =
I didn't add for this one. Even more not a single property from clk subsyst=
em is described. Shall I the add description of this single property?
> > > >
> > > > Please don't top post. sysfs properties are supposed to be single v=
alue
> > > >
> > > > and for machine consumption. Is this a debugfs property?
> > > >
> > > > No, I think this is rather sysfs than debugfs. The type of informat=
ion is similar to other reported by this driver. The values in the added pr=
operty are the same, this is just a different representation (input selecte=
d as an int, as string based on manual and as string as described in the DT=
B).
> >
> > Ok what program is going to check the selected input?
> So far, only the project specific program. I'm not aware about a standard=
 tool that check other (already available) properties from this driver.

Why doesn't clk debugfs that indicates the parents of a clk work here?
