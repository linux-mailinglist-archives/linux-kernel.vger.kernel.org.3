Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B1B48E23A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 02:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiANBnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 20:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiANBnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 20:43:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCBEC061574;
        Thu, 13 Jan 2022 17:43:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE3BEB823E5;
        Fri, 14 Jan 2022 01:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947F3C36AE3;
        Fri, 14 Jan 2022 01:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642124626;
        bh=VbYaOOUNdvRi/6OFam1hc6qimqnMsLtwWXOXwTZSL3U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sWKaXi7qF4iopRYzdN15QLGrGhGF/kwtPEENjGcbdL0NsMafA0r6NVXr60gPv2W/t
         doSkyoIzcbtQIvNVFlzaJ9B9aIIE8hO0L8l28e1X3GEbnaGkvOiBeD7jxiFjBxvrNt
         ffDIn/LpEYu4viI0oyq1QVRd6Gk9ZREMYbjOooc/bbgFYiYGaZwm+mAm3tmTMIluX/
         DjRIXksfktFdhintICbLKz1ausK9jcPk6G2H8uRCenhKBQp4nLW4vklA5Es9YXY7S3
         tvugfZ84NX6RrWUnWXq5dPy+wJRK7yRAbfkpbAtfZ2eFUpMqqGn4TWJHnf2NMWvRpt
         TAwRC7Ulxb/IQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0f3836a37d36dece52213d4b33e2b666cb187fc2.camel@mediatek.com>
References: <CAKXUXMy8ywQXqqmOvvm9wKL_ikixRJOFgCcgu4OdPUPhjq6MhA@mail.gmail.com> <0f3836a37d36dece52213d4b33e2b666cb187fc2.camel@mediatek.com>
Subject: Re: GPL-1.0-licensed code for files drivers/clk/mediatek/clk-mt7986* included with commit ec97d23c8e22 ("clk: mediatek: add mt7986 clock support")
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ryder Lee <ryder.lee@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>
Date:   Thu, 13 Jan 2022 17:43:45 -0800
User-Agent: alot/0.9.1
Message-Id: <20220114014346.947F3C36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Shih (2022-01-10 04:12:57)
> Hi Luka/Stephen,
>=20
> This is my mistake, I seem to use an old license header on it.
> Just like "clk-mt7986-eth.c" in the same patch series,
>=20
>=20
> https://lore.kernel.org/all/20211217121148.6753-4-sam.shih@mediatek.com/
>=20
> I intend to license "clk-mt7986-apmixed.c", "clk-mt7986-infracfg.c",
> and "clk-mt7986-topckgen" under the kernel's standard GPL-2.0.
>=20
> Should I need to resend this patch?
> Or I can just send a follow-up patch to fix it?
>=20

Please send a followup to fix it.
