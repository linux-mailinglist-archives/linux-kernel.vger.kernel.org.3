Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA31759CC67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbiHVXpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiHVXpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:45:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048D641D1E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:45:11 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s206so10801163pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=d0Csk6K/KRDvQOW2pJh/wb18v7EwQgVkPuj58liA9sk=;
        b=d0OjFOtnA74HEPODGOej0roBiHJdXfjGLLMCSA7Dja6dRiZnZ+AIa+/Zq6lX5Ml6bR
         UhWPfGcABUeKPxY8LkSuTJTdmMgY16YD6uRueoeouqYr0jwXhuQd/vC3haQPN33MOxo8
         p3cbT1GhwmDy66zEiQ8KCJgxILUB/5DBIK8oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=d0Csk6K/KRDvQOW2pJh/wb18v7EwQgVkPuj58liA9sk=;
        b=eD6pFRSOeOH4IDxofVjZenE0QE0pJ9oOXaFXl/ock4dyqyvC3ouHdmA/kdFPqH96tx
         rcGlhENevou5DUwQK8x5kWQ+mgFKzIt3jZw3GFptLtAg+142Xg93XbVpR/4eQKaCnBlM
         DuUNecNX/IeEHMm+7v7IcJ0i4o6wdeszUMMEawO9GYE6hEDbW4mm7ab5dK9bWX8aVMK2
         wmFxFF8HC5ymvZ1n1kinGTt5Zl1qs2w4J3lw8Tu0ThibwV4z4soW9ak0hcyJIs4kN6u2
         VXVaWUtKiQdozg0JsipsFQpRsmPp4Js1Pc9RoRnfpeHUqS99bbAEsCEJzgZmE0L7sotR
         VR1A==
X-Gm-Message-State: ACgBeo3N8RBMgpKqy2fku61ZOQ+n74lN9aLDHC8wUD1227ruU3Jj/evK
        uFUNkNSDCKwixTGyz3OM48E+TvtYb5xsWQ==
X-Google-Smtp-Source: AA6agR4N9JHSXn0/iMlmacfOfIr0W8bQdy9dMMxR+LBeppeS0cmq9y8V81RI4gycpJsfnvP43c5qaA==
X-Received: by 2002:a63:8749:0:b0:41d:89d4:ce3d with SMTP id i70-20020a638749000000b0041d89d4ce3dmr17913148pge.344.1661211910403;
        Mon, 22 Aug 2022 16:45:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:34e2:c40e:42d3:27e0])
        by smtp.gmail.com with UTF8SMTPSA id h196-20020a6283cd000000b005367043e163sm4063261pfe.28.2022.08.22.16.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 16:45:09 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Brian Norris <briannorris@chromium.org>
Subject: [PATCH] arm64: dts: rockchip: Pull up wlan wake# on Gru-Bob
Date:   Mon, 22 Aug 2022 16:45:04 -0700
Message-Id: <20220822164453.1.I75c57b48b0873766ec993bdfb7bc1e63da5a1637@changeid>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gru-Bob board does not have a pull-up resistor on its
WLAN_HOST_WAKE# pin, but Kevin does. The production/vendor kernel
specified the pin configuration correctly as a pull-up, but this didn't
get ported correctly to upstream.

This means Bob's WLAN_HOST_WAKE# pin is floating, causing inconsistent
wakeup behavior.

Note that bt_host_wake_l has a similar dynamic, but apparently the
upstream choice was to redundantly configure both internal and external
pull-up on Kevin (see the "Kevin has an external pull up" comment in
rk3399-gru.dtsi). This doesn't cause any functional problem, although
it's perhaps wasteful.

Fixes: 8559bbeeb849 ("arm64: dts: rockchip: add Google Bob")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts         | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
index 31ebb4e5fd33..0f9cc042d9bf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
@@ -88,3 +88,8 @@ h1_int_od_l: h1-int-od-l {
 		};
 	};
 };
+
+&wlan_host_wake_l {
+	/* Kevin has an external pull up, but Bob does not. */
+	rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_up>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index cd074641884b..45796b9fd94f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -578,6 +578,7 @@ wifi_perst_l: wifi-perst-l {
 	};
 
 	wlan_host_wake_l: wlan-host-wake-l {
+		/* Kevin has an external pull up, but Bob does not */
 		rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 	};
 };
-- 
2.37.2.609.g9ff673ca1a-goog

