Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2C8476919
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 05:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhLPEfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 23:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbhLPEfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 23:35:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A813C061574;
        Wed, 15 Dec 2021 20:35:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 525F661B97;
        Thu, 16 Dec 2021 04:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ABAC36AE3;
        Thu, 16 Dec 2021 04:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639629336;
        bh=y9QOFaHTSntjEd1BcEK7/c1Zltf72qo8zEU0NPs5vVg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gfyhz1hDgi7s41XdwKJJvPdJiT3I/+kzGCkoFWphA+s/PSWz1E/1L5kwF0rb9XBvp
         24Q3+h3bU1o3lTWb6Y8K4N9RCsOGS4RIV+PX/yVfbxaUeMC5n5Yei/1oAVg6CIL2qO
         rCmObBbNzrzH4ZzfzVxldVZzI6LAj3IvjnTLJ3d+H7ySqQEr2SrA2HTk/MCpnXGmXD
         Dxc2VT/Ni12LHvBY4vS5vpNAcpozAUMj2zk1F6/tMlu+8IDmdQXxbJN0ZTFPSjtQq4
         T3NLD3RAPiEKpanDRkp8fBOkcdX8OSFhbJ9ddUjaxSxKn5ynQVrkGE6GFXAcVV37W0
         Z680YFEL7o2ig==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211116150119.2171-5-kernel@esmil.dk>
References: <20211116150119.2171-1-kernel@esmil.dk> <20211116150119.2171-5-kernel@esmil.dk>
Subject: Re: [PATCH v4 04/16] dt-bindings: clock: starfive: Add JH7100 clock definitions
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
Date:   Wed, 15 Dec 2021 20:35:35 -0800
User-Agent: alot/0.9.1
Message-Id: <20211216043536.A5ABAC36AE3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2021-11-16 07:01:07)
> From: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
> Add all clock outputs for the StarFive JH7100 clock generator.
>=20
> Based on work by Ahmad Fatoum for Barebox, with "JH7100_" prefixes added
> to all definitions.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
