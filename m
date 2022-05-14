Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D791B5270C4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 12:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiENKyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 06:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiENKyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 06:54:45 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B331FA;
        Sat, 14 May 2022 03:54:41 -0700 (PDT)
Received: from p508fd4ce.dip0.t-ipconnect.de ([80.143.212.206] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nppPz-0006h4-Kl; Sat, 14 May 2022 12:54:39 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] Cleanups and enablement for Quartz64-A
Date:   Sat, 14 May 2022 12:54:37 +0200
Message-Id: <165252567323.2504740.10027372252751805398.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511150117.113070-1-pgwipeout@gmail.com>
References: <20220511150117.113070-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 11:01:11 -0400, Peter Geis wrote:
> Good Morning,
> 
> The following patches clean up some dtbs_check warnings, fixup the
> Quartz64-A dts, and enable some additional functionality on the
> Quartz64-A.
> 
> With this series the only remaining dtbs_check warnings are due to
> unconverted bindings.
> 
> [...]

Applied, thanks!

[1/6] dt-binding: clock: Add missing rk3568 cru bindings
      commit: b21445db9818ccb9fa1c0ba81fd3705eb8d347e3
[2/6] arm64: dts: rockchip: add clocks to rk356x cru
      commit: 70f679ad25d5f8d0076e283bd6c61e047c7af226
[3/6] arm64: dts: rockchip: rename Quartz64-A bluetooth gpios
      commit: 650a1523756bb1e697f8927d2915cbbb92e83f8c
[4/6] arm64: dts: rockchip: add Quartz64-A fan pinctrl
      commit: 82f4f0183e5d3b2d0a2af6c70ba16f86b5897ef9
[5/6] arm64: dts: rockchip: enable sdr-104 on sdmmc
      commit: 6adce30701c810e11685911ca2114fbc0107120d
[6/6] arm64: dts: rockchip: enable sfc controller on Quartz64 Model A
      commit: e5008be69a1947d4236ab3f73c939f9c2a9a6f80

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
