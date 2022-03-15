Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D574DA4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344031AbiCOVqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiCOVqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C7013D42;
        Tue, 15 Mar 2022 14:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9F1611F2;
        Tue, 15 Mar 2022 21:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C80C340EE;
        Tue, 15 Mar 2022 21:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647380709;
        bh=Qon2iIt5uBJXkNbHfxyap6NYpZHZHZbIpQcJu0mhpCE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MYD9w83F8k4iVmgJwQSZJIYQwUR9mrYF+65pKeIA9oYdzjYeCFBRFxwr+JGVjo9Dq
         jrfSgYQ6yBcdSlvNXVucMSyPKX2dnQHf1KzEd8Ar/B9HVoYrswTbFFbO8s6P+dzX/r
         GkUu6HJaZacakfwjpezxCdLyumebSjDq33JnVSo0gdMHxvLeUlnUWY3dgB7X33ajuP
         x9jsL+HMjrm/1nquBbKsmo2CzmJZ/nRywG4m/U8Ef5r1KbwVAe731RcjT/HZXKJ0Hd
         5Q/QjHSKf4Q+P05MEZZmXGgfaVaeQm5OcpJSwg6HTOtk2BrDIM0uNpseV1XHw2JRQv
         9FA0+GFqT2yIA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220315082446.3120850-1-abel.vesa@nxp.com>
References: <20220315082446.3120850-1-abel.vesa@nxp.com>
Subject: Re: [PATCH] clk: imx: Select MXC_CLK for i.MX93 clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>
Date:   Tue, 15 Mar 2022 14:45:07 -0700
User-Agent: alot/0.10
Message-Id: <20220315214509.51C80C340EE@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2022-03-15 01:24:46)
> Most of the i.MX clock generic API is built by selecting MXC_CLK.
> Without it, the i.MX93 clock driver will fail to build:
>=20
> aarch64-linux-gnu-ld: drivers/clk/imx/clk-imx93.o:
> in function `imx93_clocks_probe': clk-imx93.c:(.text+0xa8):
> undefined reference to `imx_obtain_fixed_clk_hw'
>=20
> So fix this by selecting MXC_CLK for the CLK_IMX93.
>=20
> Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---

Applied to clk-next
