Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD374D38FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiCISkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiCISkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:40:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365841704D7;
        Wed,  9 Mar 2022 10:39:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D974CB8232E;
        Wed,  9 Mar 2022 18:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992C8C340E8;
        Wed,  9 Mar 2022 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646851170;
        bh=A1WR8Wa0q1Tb60p8NvM8B+XJXSA09o36ZvVXUiktXhQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Prw/oGXFFzVWobc/hScuBsVUV9ti3ml5QS3Aj/hbhdQKs1BGgm8t9+zTq7BQvhrfY
         a+wdQJPv6b6f3Es1uCUhT7W6E3JsYKkgRhQQcTlpDQsW0RcqcsUssVKo+8DQ0QASDD
         YVL3wxDR06QnurH4hHv5EBNFzI19cgWzZGailF7NuSwZT8j4rYNuwdfv9qZnwsBEbF
         g7g2SrZ3ar0DFFln4fJ3JG7GuFQkDE1U26bdHMR6pyFmiZBjgrsy8nB+csq48RxCfK
         8WfzSvR4r7q5kn7285DmpTt41xukXc1SUIWcym2x8lKsv+q4Rk20XOTwjAWsQiSe+J
         BugY1LPjdap/Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220303090508.1125175-1-colin.i.king@gmail.com>
References: <20220303090508.1125175-1-colin.i.king@gmail.com>
Subject: Re: [PATCH] clk: imx: remove redundant re-assignment of pll->base
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Abel Vesa <abel.vesa@nxp.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Date:   Wed, 09 Mar 2022 10:39:28 -0800
User-Agent: alot/0.10
Message-Id: <20220309183930.992C8C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin Ian King (2022-03-03 01:05:08)
> There are two identical assignments of pll->base to the same value,
> the second assignment is redundant and can be removed.
>=20
> Cleans up cppcheck warning:
> drivers/clk/imx/clk-sscg-pll.c:528:12: style: Variable 'pll->base' is
> reassigned a value before the old one has been used. [redundantAssignment]
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Applied to clk-next
