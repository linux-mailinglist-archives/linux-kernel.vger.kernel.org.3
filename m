Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCF447691E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 05:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhLPEfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 23:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhLPEft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 23:35:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F25C061574;
        Wed, 15 Dec 2021 20:35:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EACDB82285;
        Thu, 16 Dec 2021 04:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE246C36AE0;
        Thu, 16 Dec 2021 04:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639629346;
        bh=y79COlb2nj+djtDCDbx7LTCD32j+1RJcU7XjiBJeA0s=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=N0i8uGCoqxbQoYosgINaC0cXUYrJB4Hokz2ejKlsTkT9xrHTqfilzGU1jLjXx1LZ/
         Lrv2XuseLAF3xKKkP8WTLLqXALV9TfdLrZxUPSNrZt65YzGhR+4R7119jv3PCbWk33
         KvHEKaTWhmNgjpLEuaIUmIjXhCQRVyZnw5N7U4Yj10oUwnUdPNzjLCOR0z0QxGCr0h
         KeQeVsYcQDYjuGKn5Esi9fgQo17fX7UMic9YunF+4URIt/1RU1W0de3Mnj/5dyU315
         txAhsglMusOrPK1BpD8MSCRDUCOod4/xYnP8dYBuOK/bGCRKopSO+sZZrTu3zNuESd
         SZKy3vM/RP7jA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211116150119.2171-6-kernel@esmil.dk>
References: <20211116150119.2171-1-kernel@esmil.dk> <20211116150119.2171-6-kernel@esmil.dk>
Subject: Re: [PATCH v4 05/16] dt-bindings: clock: starfive: Add JH7100 bindings
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
        Rob Herring <robh@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org
Date:   Wed, 15 Dec 2021 20:35:45 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216043546.BE246C36AE0@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2021-11-16 07:01:08)
> From: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
> Add bindings for the clock generator on the JH7100 RISC-V SoC by
> StarFive Ltd. This is a test chip for their upcoming JH7110 SoC.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
