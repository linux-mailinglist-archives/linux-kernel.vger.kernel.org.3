Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410685AC5B9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiIDRWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiIDRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:22:36 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B220356EE;
        Sun,  4 Sep 2022 10:22:33 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oUtKB-0000tW-61; Sun, 04 Sep 2022 19:22:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andy Yan <andyshrk@163.com>, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 0/3] Add support for rk3399 based eaidk-610
Date:   Sun,  4 Sep 2022 19:22:16 +0200
Message-Id: <166231195329.2423948.3022216609132415714.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709102902.2753851-1-andyshrk@163.com>
References: <20220709102902.2753851-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jul 2022 18:29:02 +0800, Andy Yan wrote:
> EAIDK-610 is from OPEN AI LAB and popularly used by university
> students.
> 
> Specification:
> - Rockchip RK3399
> - LPDDR3 4GB
> - TF sd scard slot
> - eMMC
> - AP6255 for WiFi + BT
> - Gigabit ethernet
> - HDMI out
> - 40 pin header
> - USB 2.0 x 2
> - USB 3.0 x 1
> - USB 3.0 Type-C x 1
> - 12V DC Power supply
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: vendor-prefixes: Add OPEN AI LAB
      commit: 467dcf345613a779efc3af1dce88a576079666e6
[2/3] dt-bindings: arm: rockchip: Add EAIDK-610
      commit: a15ca48b6451b7af27323749f35d0f9929f83f73
[3/3] arm64: dts: rockchip: Add dts for a rk3399 based board EAIDK-610
      commit: 904f983256fdd24bde974bf2f38fbacd3edbcd80

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
