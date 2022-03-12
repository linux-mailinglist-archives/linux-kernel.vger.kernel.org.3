Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4774D6BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 03:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiCLCSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 21:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiCLCSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:18:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316B2A8258;
        Fri, 11 Mar 2022 18:16:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02F9AB80EF1;
        Sat, 12 Mar 2022 02:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E415C340F4;
        Sat, 12 Mar 2022 02:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647051416;
        bh=gGsoo2cqex0QIAWH4Pz6Wmuc0cataTXL1Xe3abv7TUo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mIKdbY67d6fk7xxdNZYfdBkpvjIGZH0AWuGY8CDdn0lvpOuRT292KRbyUmMZHFE7d
         w7+gyIswux0Wg3nW6VpPMKwDHdV3BIJti8AEaqZQSvbzMOdxJ7GYz5uyI6BXI/mQcY
         UaRlTXQqrvigXWt9sfEzRRGTNp8nQZEO8CxXEbRJ1uj5/qPJwOaEqM5iEy3w/KImw6
         C+A/AiJCZDkYpACD7u7xNWY+Jyxzb9NQbQ2P/X52nRqJ/jJVCxesl7gtBhM6M489rC
         Mr8R7Tl5DEMVhCXqPOxSM/Xzndgjh1rmvNjB23zapUxuimhtTjoOiCzI6lBvNAMGYy
         bwrId5ShKD3Xw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220218000922.134857-5-j.neuschaefer@gmx.net>
References: <20220218000922.134857-1-j.neuschaefer@gmx.net> <20220218000922.134857-5-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v4 4/5] clk: clps711x: Terminate clk_div_table with sentinel element
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Mike Turquette <mturquette@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 11 Mar 2022 18:16:54 -0800
User-Agent: alot/0.10
Message-Id: <20220312021656.8E415C340F4@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-17 16:09:20)
> In order that the end of a clk_div_table can be detected, it must be
> terminated with a sentinel element (.div =3D 0).
>=20
> Fixes: 631c53478973d ("clk: Add CLPS711X clk driver")
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
