Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5AE847746F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbhLPO0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:26:03 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:42349 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbhLPO0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:26:02 -0500
Date:   Thu, 16 Dec 2021 14:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail; t=1639664759;
        bh=g/fz5cZVneyfqlIcRWWPmLRxRAIAuLd0ulxsixOUGj4=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=YoJNwKlAe5BvMbnoeluITxJQx6W3VkVfWkXF9sNG9TZlBeE2fbyH2kimJ4VNQlicg
         YMEXgfUEIM0cm8ineFW0/1vhQ2IRNIEjPbIOf/zBVNJasIqwoh+6GSgA/Wf2ECHWB7
         uw3JbZxsLVjjMHPzP/54xJYIJ82jc79E5mhdY8kxzgGsu/dXLdEvMe7T2bWawkVm4t
         2UBWpGhj86eb1y0Nm8C4wAcSOZGv6MMf7hX8XwYJDxgEoNHPzK3hBWW5Wql4VPRUp9
         ODBmMEAucI1VVqpnu4WngO78ZaUHC24UDN2Z2fxdUbeK09BG2x2MYLr6uedBpmPUfw
         XsY8+M7wMcA4w==
To:     Stephen Boyd <sboyd@kernel.org>
From:   wujek dev <dev_public@wujek.eu>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: wujek dev <dev_public@wujek.eu>
Subject: Re: [PATCH] clk: si5341: Add sysfs property to check selected input
Message-ID: <Qk2RUY9T8QCX1un25vsEYOAnlYlkMQpywbz05_FpVSYq8Lek4EStNPkA_vt_BBH1HKuwsbNw_F8Ec73fM2Kk9Zdl1wvjLtwaHE5QKSvV6Hs=@wujek.eu>
In-Reply-To: <20211216063245.603F1C36AE4@smtp.kernel.org>
References: <20211203141515.2448129-1-dev_public@wujek.eu> <20211206225354.BF0AFC341C6@smtp.kernel.org> <jgJW1u3RfTQcv5ZBcVQt4fz8_sA4gvyXsN5x18zzLo_nTR5nfLpZtdAjy-WlEaCMnmnPGZjeFGV5OoiWNtA4Tn5wLhqNJdQEvPw5Cqs1z3I=@wujek.eu> <20211208043054.CEFD6C00446@smtp.kernel.org> <XedF_WXH1abo9n2bzY4gaRIjq-R1O6ha5QedK8e1W9-R_1p_zo90aAgaKSSfDYMW3WUaMdY0pjONnKWj4zNMh5TbHlbZbAVAe4KG_Zq8Vvk=@wujek.eu> <20211216063245.603F1C36AE4@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Thursday, December 16th, 2021 at 07:32, Stephen Boyd <sboyd@kernel.org> =
wrote:

> Quoting wujek dev (2021-12-09 04:04:48)
>
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
> >
> > On Wednesday, December 8th, 2021 at 05:30, Stephen Boyd sboyd@kernel.or=
g wrote:
> >
> > > Quoting wujek dev (2021-12-06 15:08:03)
> > >
> > > > Other sysfs properties used by this driver are not documented so I =
didn't add for this one. Even more not a single property from clk subsystem=
 is described. Shall I the add description of this single property?
> > >
> > > Please don't top post. sysfs properties are supposed to be single val=
ue
> > >
> > > and for machine consumption. Is this a debugfs property?
> > >
> > > No, I think this is rather sysfs than debugfs. The type of informatio=
n is similar to other reported by this driver. The values in the added prop=
erty are the same, this is just a different representation (input selected =
as an int, as string based on manual and as string as described in the DTB)=
.
>
> Ok what program is going to check the selected input?
So far, only the project specific program. I'm not aware about a standard t=
ool that check other (already available) properties from this driver.
