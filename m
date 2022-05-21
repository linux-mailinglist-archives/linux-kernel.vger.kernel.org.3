Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D6052F849
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354139AbiEUEPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347930AbiEUEO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:14:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA77195925;
        Fri, 20 May 2022 21:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A5F608D6;
        Sat, 21 May 2022 04:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4AFC34116;
        Sat, 21 May 2022 04:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653106496;
        bh=Yr+zPfiQun8GK92zEq4Xft6+56O3vdTOZLYaH1m3eBw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=cy1KYMbG8YZnNyDMAlyK8rhpk0SJKGq7dxAx2EnCT/3hEe/NZbWxnDGcmC6nu+WY7
         cTinbzdHKNdQIwWuvOeFsgOeE3a1tNQNSwxd+iWND39V+CCAN00VQ2LYAkKpwoBbrP
         prpirbHhUHCbApfX30LhyuSy05ZOd2qthPFzV+sFTcrOM9ccMhC6+ttdAWPFKwGmbY
         b/WDp6HJwn/WhDolkDRlxfDb9NcoUMApktvlDp15uYdCoaAvYgahkkHvkaWgGJJKSD
         HSb++VLDQXeb5BExKLdq0wLqld6vPZTdiIah4CrHlY+vctS1di2W1Xmdaee8Su569D
         rHozoi7reKg7g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220516070600.7692-3-gabriel.fernandez@foss.st.com>
References: <20220516070600.7692-1-gabriel.fernandez@foss.st.com> <20220516070600.7692-3-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v4 02/14] clk: stm32: Introduce STM32MP13 RCC drivers (Reset Clock Controller)
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 May 2022 21:14:54 -0700
User-Agent: alot/0.10
Message-Id: <20220521041456.7A4AFC34116@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting gabriel.fernandez@foss.st.com (2022-05-16 00:05:48)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> This driver manages Reset and Clock of STM32MP13 soc.
> It uses a clk-stm32-core module to manage stm32 gate, mux and divider
> for STM32MP13 and for new future soc.
>=20
> All gates, muxes, dividers are identify by an index and information
> are stored in array (register address, shift, with, flags...)
> This is useful when we have two clocks with the same gate or
> when one mux manages two output clocks.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next
