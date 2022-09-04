Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298C65AC5B2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiIDRWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbiIDRW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 13:22:28 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DC032070;
        Sun,  4 Sep 2022 10:22:25 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oUtKB-0000tW-HW; Sun, 04 Sep 2022 19:22:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zain wang <wzz@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: Set RK3399-Gru PCLK_EDP to 24 MHz
Date:   Sun,  4 Sep 2022 19:22:17 +0200
Message-Id: <166231195330.2423948.14822467158233209548.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830131212.v2.1.I98d30623f13b785ca77094d0c0fd4339550553b6@changeid>
References: <20220830131212.v2.1.I98d30623f13b785ca77094d0c0fd4339550553b6@changeid>
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

On Tue, 30 Aug 2022 13:16:17 -0700, Brian Norris wrote:
> We've found the AUX channel to be less reliable with PCLK_EDP at a
> higher rate (typically 25 MHz). This is especially important on systems
> with PSR-enabled panels (like Gru-Kevin), since we make heavy, constant
> use of AUX.
> 
> According to Rockchip, using any rate other than 24 MHz can cause
> "problems between syncing the PHY an PCLK", which leads to all sorts of
> unreliabilities around register operations.

Applied, thanks!

[1/1] arm64: dts: rockchip: Set RK3399-Gru PCLK_EDP to 24 MHz
      commit: 8123437cf46ea5a0f6ca5cb3c528d8b6db97b9c2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
