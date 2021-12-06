Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABD946AE43
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377301AbhLFXLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:11:37 -0500
Received: from mail-4317.proton.ch ([185.70.43.17]:60745 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357400AbhLFXLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:11:35 -0500
Date:   Mon, 06 Dec 2021 23:08:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wujek.eu;
        s=protonmail; t=1638832084;
        bh=1G0+W2sk8G+/1XYnDYRKW6feBTO2wLN4gaf00kYugRo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=XCKNnPlRqyUZYoZs47ZYutR/DaaJeLpUIgz5JPz2JNS08KaHjS+rmx1jdag8v7NhL
         s56kqFsWs/ieXSEDJD4Zcart88L+rb4hS0U95sC1enc59AjpnjfsHR8bxXOKNIUGLI
         seVb4LiKO+5jf5TLBbPFqsGmqzahQe0oDh0RyPG8/OrXmwXtpZUQHTpb8wKreW8NSe
         fThcXl1r2x3YsMOvpSl4lg8WVlM/zmNDffw7MCn2q7vXPv99H6tayMkL/cP74s4j0l
         YwGzuxH806TQjqOsHRPvZRMuikhucRaUCIoYD5vv4biJJMZ3AXsfSLr7sj+F7p7T1+
         ucbCrjh42U8Ig==
To:     Stephen Boyd <sboyd@kernel.org>
From:   wujek dev <dev_public@wujek.eu>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: wujek dev <dev_public@wujek.eu>
Subject: Re: [PATCH] clk: si5341: Add sysfs property to check selected input
Message-ID: <jgJW1u3RfTQcv5ZBcVQt4fz8_sA4gvyXsN5x18zzLo_nTR5nfLpZtdAjy-WlEaCMnmnPGZjeFGV5OoiWNtA4Tn5wLhqNJdQEvPw5Cqs1z3I=@wujek.eu>
In-Reply-To: <20211206225354.BF0AFC341C6@smtp.kernel.org>
References: <20211203141515.2448129-1-dev_public@wujek.eu> <20211206225354.BF0AFC341C6@smtp.kernel.org>
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

Other sysfs properties used by this driver are not documented so I didn't a=
dd for this one. Even more not a single property from clk subsystem is desc=
ribed. Shall I the add description of this single property?

BR,
Adam

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Monday, December 6th, 2021 at 23:53, Stephen Boyd <sboyd@kernel.org> wro=
te:

> Quoting Adam Wujek (2021-12-03 06:15:31)
>
> > Add a sysfs property to check the selected input.
> >
> > <input_num> <input_name> <input_name_from_DTB>
> >
> > E.g.:
> >
> > cat input_selected
> >
> > 0 in0 WR25M
> >
> > Signed-off-by: Adam Wujek dev_public@wujek.eu
> > ---------------------------------------------
> >
> > drivers/clk/clk-si5341.c | 19 +++++++++++++++++++
> >
> > 1 file changed, 19 insertions(+)
>
> sysfs properties need documentation in Documentation/ABI/
