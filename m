Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704BA46E800
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhLIMI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:08:27 -0500
Received: from mail-4317.proton.ch ([185.70.43.17]:12941 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhLIMI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:08:26 -0500
Date:   Thu, 09 Dec 2021 12:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail; t=1639051491;
        bh=bPgLA86kFfRnF++La1cDuPaCDGUpBHhrcy/56L8/uog=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=qsZ/ZfyRlSo4EAmQZxBhwgHX/Ptj+QZqYR619FQbmhrnyRDu/CwdYYKlTvcZ3RH2e
         XZawUnCD71IvV4RRFlvEqoUw8WfMRCsnARehnxoq9w+lf/LHRG0iJelHt24K/IbgD9
         mSR3rjgDnTDQ+NoTEtInd3a1Kj/RKeJSLE7xMb+Mk+3VnCQ41W1IkOyy4VvvMT0RFb
         OxrXvFLiH38NUMJDAoVIIvhHTUz+w9mNHo4/3pKb9NtJjuOrEALPaVhWr19AzYYq/Q
         PaX95ozrlk4ai+Y0Fq/Pkt7JImUyaMQFpAjN2Wwbf5nkOGSue07/h01mWviSZmBRWC
         qhAJKFAkcRbpA==
To:     Stephen Boyd <sboyd@kernel.org>
From:   wujek dev <dev_public@wujek.eu>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: wujek dev <dev_public@wujek.eu>
Subject: Re: [PATCH] clk: si5341: Add sysfs property to check selected input
Message-ID: <XedF_WXH1abo9n2bzY4gaRIjq-R1O6ha5QedK8e1W9-R_1p_zo90aAgaKSSfDYMW3WUaMdY0pjONnKWj4zNMh5TbHlbZbAVAe4KG_Zq8Vvk=@wujek.eu>
In-Reply-To: <20211208043054.CEFD6C00446@smtp.kernel.org>
References: <20211203141515.2448129-1-dev_public@wujek.eu> <20211206225354.BF0AFC341C6@smtp.kernel.org> <jgJW1u3RfTQcv5ZBcVQt4fz8_sA4gvyXsN5x18zzLo_nTR5nfLpZtdAjy-WlEaCMnmnPGZjeFGV5OoiWNtA4Tn5wLhqNJdQEvPw5Cqs1z3I=@wujek.eu> <20211208043054.CEFD6C00446@smtp.kernel.org>
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

On Wednesday, December 8th, 2021 at 05:30, Stephen Boyd <sboyd@kernel.org> =
wrote:

> Quoting wujek dev (2021-12-06 15:08:03)
>
> > Other sysfs properties used by this driver are not documented so I didn=
't add for this one. Even more not a single property from clk subsystem is =
described. Shall I the add description of this single property?
>
> Please don't top post. sysfs properties are supposed to be single value
>
> and for machine consumption. Is this a debugfs property?
No, I think this is rather sysfs than debugfs. The type of information is s=
imilar to other reported by this driver. The values in the added property a=
re the same, this is just a different representation (input selected as an =
int, as string based on manual and as string as described in the DTB).
