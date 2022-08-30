Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9D85A6E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiH3USZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiH3USE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:18:04 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89597FFB6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:17:56 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f24so9437695plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=8Amg5b56oQl+ZjuCqznlrXnzwH450EVUCei1qHh8YaA=;
        b=cLHGfYpFjKg4LfQbdwq1ncMirzhvpWWcCdSP0WPnrYpwI08hPAR57Vp2rkQqSa9qF3
         hbHyzoQCOctpv6ij5bBZOau+F77S2b1Nkp4Chiv+Y7dCdL+SG+iogvYy+JZfeDxyjxHp
         tn60S3B9Ag2xe1RJovoMsTfrD1cotR/e7tnkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=8Amg5b56oQl+ZjuCqznlrXnzwH450EVUCei1qHh8YaA=;
        b=1qexQRTdi4/Y6+H6CGHz2SkzpMHOtTXr69NZ1Gh0y41wFFgpEXvg11reI1IQZIwGnJ
         IQlv0+dIvwEJHCxZ14youefJe38TI1vGHVNHUwCOZVEnUXl8i2Jc3sOnCUoqbStcLzA6
         Jiv3k7ZkpQwqbPafGWtROeWZQUJSBHd8tfxPkZ7NI+4RXeZuCTf9/ZuN8faQaR2Vrg2a
         qPRvCPZLEq0wYgRJkLg1pzIKCHyaelLthpOGdqhiSNdEPBR2nJH6r7rMmFOPnBYUpqzV
         oLa4zpq1Nc1N0SpeuTXonMg1TSc2PSDeDz/AF8t1jjUgO83QzET9lUnE86P5ajtrrdMM
         HiPQ==
X-Gm-Message-State: ACgBeo3s+EU22jTCcCX1VWmzc2FEkN8satAOkWCjDgshe/hGNqxcbivY
        omrDx3F4Luukd7bSgCIGpg+VjQ==
X-Google-Smtp-Source: AA6agR71P/HmC5vMFbdfvfVHoIYJy/fkqJ/ObJltZwgbWIk8mUDynhEUCoJF82BTs1NDNqkjbf5weQ==
X-Received: by 2002:a17:90b:1e4a:b0:1f5:4f69:d6b4 with SMTP id pi10-20020a17090b1e4a00b001f54f69d6b4mr25598894pjb.164.1661890675446;
        Tue, 30 Aug 2022 13:17:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d14a:ebf8:88f1:35e])
        by smtp.gmail.com with UTF8SMTPSA id x196-20020a6286cd000000b00536816c0d4asm10036104pfd.147.2022.08.30.13.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 13:17:55 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        zain wang <wzz@rock-chips.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] arm64: dts: rockchip: Set RK3399-Gru PCLK_EDP to 24 MHz
Date:   Tue, 30 Aug 2022 13:16:17 -0700
Message-Id: <20220830131212.v2.1.I98d30623f13b785ca77094d0c0fd4339550553b6@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

We've found the AUX channel to be less reliable with PCLK_EDP at a
higher rate (typically 25 MHz). This is especially important on systems
with PSR-enabled panels (like Gru-Kevin), since we make heavy, constant
use of AUX.

According to Rockchip, using any rate other than 24 MHz can cause
"problems between syncing the PHY an PCLK", which leads to all sorts of
unreliabilities around register operations.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Add Doug's reviewed-by
 * Set authorship correctly

 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 45796b9fd94f..ee6095baba4d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -244,6 +244,14 @@ &dmc {
 &edp {
 	status = "okay";
 
+	/*
+	 * eDP PHY/clk don't sync reliably at anything other than 24 MHz. Only
+	 * set this here, because rk3399-gru.dtsi ensures we can generate this
+	 * off GPLL=600MHz, whereas some other RK3399 boards may not.
+	 */
+	assigned-clocks = <&cru PCLK_EDP>;
+	assigned-clock-rates = <24000000>;
+
 	ports {
 		edp_out: port@1 {
 			reg = <1>;
-- 
2.37.2.672.g94769d06f0-goog

