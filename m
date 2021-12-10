Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC9246F856
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhLJBU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:20:56 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48896 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhLJBUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:20:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 98669CE25DC;
        Fri, 10 Dec 2021 01:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E13C004DD;
        Fri, 10 Dec 2021 01:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639099037;
        bh=P8EOenvo2nuHAw+DOVUAUoRUdPP2urCA48hW4wDJXMU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ai8m6YPTKgbiMPzkMK6O/mM4hR2fny15R2zbsDzGDtPCHmVMm9lUJ0lkD5sF75MQh
         dgTinYPydcUw8NpVO7UrmZ09XgfaFt6B1O947i5kYzDuFHunM/aTxl7X/91mHyTS+w
         PvZOzDC6G3LucexgzKcYNxqrJ3uSntgOCWNto0da0ZZavQuT9JUMfcfW8OYX+RPUPj
         5nR3bq/Shf/OV9Mg4aZDW8YIW8DtqHFnvVKhW27AiCc/G8WkxqMUF7a0zStDddjlck
         Y9m3M78L9aNerEiIhIfeTzbeGwUBvuyk/x7bLqI5ew2h6rtfPUaZM5NQr39f7o72Po
         fDNhPch8AK/nw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211013172042.10884-1-semen.protsenko@linaro.org>
References: <20211013172042.10884-1-semen.protsenko@linaro.org>
Subject: Re: [PATCH v6] clk: Add write operation for clk_parent debugfs node
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mike Tipton <mdtipton@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 09 Dec 2021 17:17:16 -0800
User-Agent: alot/0.9.1
Message-Id: <20211210011717.B3E13C004DD@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sam Protsenko (2021-10-13 10:20:42)
> Useful for testing mux clocks. One can write the index of the parent to
> be set into clk_parent node, starting from 0. Example
>=20
>     # cd /sys/kernel/debug/clk/mout_peri_bus
>     # cat clk_possible_parents
>       dout_shared0_div4 dout_shared1_div4
>     # cat clk_parent
>       dout_shared0_div4
>     # echo 1 > clk_parent
>     # cat clk_parent
>       dout_shared1_div4
>=20
> CLOCK_ALLOW_WRITE_DEBUGFS has to be defined in drivers/clk/clk.c in
> order to use this feature.
>=20
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied to clk-next
