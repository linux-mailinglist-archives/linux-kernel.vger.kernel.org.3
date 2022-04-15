Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E52B502D04
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355508AbiDOPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356330AbiDOPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:39:35 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60AE3DA46
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:37:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so7951318wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k5Hrv/6P14wuxEAoJwZ4UjPTdo8Z9vjBoCCIqwWWzR0=;
        b=KcwavP/bNwYUDWjOLWTRjKSPXsBlI7T5EpiuJmJHyK758VWcq/UQxaolWi2DTzsz9t
         kJuNEMoCZHya0SOybBjkjd6emwgywcjD49HjNWfdyZPD7Bd81Y+hnXD04fVhoPUBrk8Y
         fgT9MkofQkarujUGccZVT1ZoMCQdjGBvWUpmpZ6uDiFtXJQwNHdkpyzkLT1xIPpI/4yP
         SuZI10jpSceLhZ3RJXMHKZ6QYkcI/3Ta8+0hbgXXjc9+rqa5EVtgBDGn/iMYqpqLBQAv
         F8yHel57Vmpjzl7LYT368XTN3hQhvJTTXXKPyscFT7yD73vOZP+1J6QAOlVIaLx5LGAe
         p9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k5Hrv/6P14wuxEAoJwZ4UjPTdo8Z9vjBoCCIqwWWzR0=;
        b=rVxZSs/fJscV/eOScPqqNFG5FntClhx6m4wZnYD9oLIny60vI/uvWwo2k0jbz9FITJ
         qGampWHESnr0u/yyMs9omf/D7A2JwuqxGN7RBSlTUWkPLqR168XoWq4JJQ9hqf1nja9m
         xk5ERruWfbcwZvYQCOo9OS60x7XLkPS5cO7xU/0ykaeanm7VixA/+m+CDMRIWGHAfWDt
         z4/dfzpM1pvJkGMYWC91nvtaKUwAOrNpVtQVquhCdgzVzzSaMPmJn5NoiPxt15riZNiK
         D9djPibIXk22r+JRV1xf9PS05yAhBCDVE/tengZtLpK5D6v2cP4R6fELZgutOpmt3gpT
         REBw==
X-Gm-Message-State: AOAM531I7dIJfUGcjPV/xKWoww/uYfIP7pzjcQnhsZCOYfgId0ypuigS
        vvChqg39Py/MeF4RCh8kFL5rZw==
X-Google-Smtp-Source: ABdhPJxP2hHLChu7w5jeTrumBfb7Vqd/IYiSc2LBN1TOeIrWhbLE73c5LQrfRoy450OfnBz2o7LoOg==
X-Received: by 2002:a1c:4c05:0:b0:38e:b736:350 with SMTP id z5-20020a1c4c05000000b0038eb7360350mr3878657wmf.65.1650037025270;
        Fri, 15 Apr 2022 08:37:05 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc018000000b0038a18068cf5sm8459292wmb.15.2022.04.15.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:37:04 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] arm64: dts: mediatek: mt6359: add node for PMIC keys support
Date:   Fri, 15 Apr 2022 17:36:29 +0200
Message-Id: <20220415153629.1817202-8-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415153629.1817202-1-fparent@baylibre.com>
References: <20220415153629.1817202-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the MT6359 PMIC keyboard in mt6359.dtsi.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
Dependency on: 
https://patchwork.kernel.org/project/linux-mediatek/patch/1622011927-359-9-git-send-email-hsin-hsiung.wang@mediatek.com/

 arch/arm64/boot/dts/mediatek/mt6359.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
index 18c0d5325c22..dcafe1ff23ae 100644
--- a/arch/arm64/boot/dts/mediatek/mt6359.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
@@ -3,6 +3,8 @@
  * Copyright (c) 2021 MediaTek Inc.
  */
 
+#include <dt-bindings/input/input.h>
+
 &pwrap {
 	pmic: pmic {
 		compatible = "mediatek,mt6359";
@@ -294,5 +296,18 @@ mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshub {
 		mt6359rtc: mt6359rtc {
 			compatible = "mediatek,mt6358-rtc";
 		};
+
+		mt6359keys: keyboard {
+			compatible = "mediatek,mt6359-keys";
+
+			key-0 {
+				linux,keycodes = <KEY_POWER>;
+				wakeup-source;
+			};
+
+			key-1 {
+				linux,keycodes = <KEY_HOME>;
+			};
+		};
 	};
 };
-- 
2.35.2

