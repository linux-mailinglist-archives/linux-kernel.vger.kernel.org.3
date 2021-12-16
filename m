Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9885A476923
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 05:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhLPEgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 23:36:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34428 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhLPEgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 23:36:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA8E761B97;
        Thu, 16 Dec 2021 04:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494C6C36AE0;
        Thu, 16 Dec 2021 04:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639629366;
        bh=iTPhelKYVuiYtgSv4risiaN2muO295q58+hWF8wJec8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Wg/wA9qF99lzo1Tr7OEsbGggT0XjMUaFnxz/w6bl+1AB6BGCc0ovCtfoHYPNql2eW
         3RgaiIOSekITC2GNEJ3POBFSwO95d4EcLFgPJ0TxFnyCxA7CG3F6y5NLWewmn3l7jk
         +1E8iPiWotmfM3Q/3MnZ2QqiVlpzSriOTcm18JER9TZphqtjAK96qW7yQLVKXcwGiA
         14gKUWHA6QUleNQxD0vGcjYfZlMLRlvf4hZWWDGP9kwnAAFmDB/EP3X7+mb1/rLL63
         rtBR9kKbJWCtytTkySBLkcrXbXmncxwfkxEEp0q29Yz3De0rMTk0fZw3YLWxQC8zFi
         sxInC2R82o5UA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211116150119.2171-7-kernel@esmil.dk>
References: <20211116150119.2171-1-kernel@esmil.dk> <20211116150119.2171-7-kernel@esmil.dk>
Subject: Re: [PATCH v4 06/16] clk: starfive: Add JH7100 clock generator driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Drew Fustini <drew@beagleboard.org>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Date:   Wed, 15 Dec 2021 20:36:05 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216043606.494C6C36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2021-11-16 07:01:09)
> From: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
> Add a driver for the StarFive JH7100 clock generator.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
