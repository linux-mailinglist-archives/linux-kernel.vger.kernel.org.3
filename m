Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0F487FD7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 01:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiAHAIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 19:08:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57562 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiAHAIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 19:08:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 126CEB827B9;
        Sat,  8 Jan 2022 00:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8373C36AE5;
        Sat,  8 Jan 2022 00:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641600491;
        bh=eRTFqRjFRgCxvmbchANikxM/bE3d5Z9QWcoIjpeA9No=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=q7NbhrGKV6ToLJTDT/XYgUGwPUbhiN8AEtI6Wg693M0CZuPXWEVz+MgWoYAq2hIkt
         ogidsf6NW0emarxkW/WFsbpWzrFGw/Yaf3ATe9pbnv8xa5RB2j/BgGZypx3IwkPJx4
         Aae+3HWZ1Qo08Gp5Nz1RJClmeqAT29g4jYvtnVqQTa3pr6Yc+6ALJL6/3DxbVj8JBq
         RX0O+cFzp5j0UbKezAbDODbsuh1S7E0/Loumw/xUsELKpifGrCQLIX+LB67RZoLbdR
         I/uMVLX4zaG6CJ3ECT7lMhwvFVyIWY/NoHU94bmqAD+HCHwR2GN57RQzizf1Lqw1HT
         f3xD1828e65xw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220107183303.2337676-1-nathan@kernel.org>
References: <20220107183303.2337676-1-nathan@kernel.org>
Subject: Re: [PATCH] clk: visconti: Remove pointless NULL check in visconti_pll_add_lookup()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Date:   Fri, 07 Jan 2022 16:08:10 -0800
User-Agent: alot/0.9.1
Message-Id: <20220108000811.B8373C36AE5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2022-01-07 10:33:03)
> Clang warns:
>=20
> drivers/clk/visconti/pll.c:292:20: warning: address of array 'ctx->clk_da=
ta.hws' will always evaluate to 'true' [-Wpointer-bool-conversion]
>         if (ctx->clk_data.hws && id)
>             ~~~~~~~~~~~~~~^~~ ~~
> 1 warning generated.
>=20
> This array cannot be NULL if ctx is not NULL, which is allocated in
> visconti_init_pll(), so just remove the check, which matches other clk
> drivers.
>=20
> Fixes: b4cbe606dc36 ("clk: visconti: Add support common clock driver and =
reset driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1564
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Applied to clk-next
