Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317BC4956E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239239AbiATXVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378198AbiATXUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:46 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1845C06173F;
        Thu, 20 Jan 2022 15:20:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso17640900wms.4;
        Thu, 20 Jan 2022 15:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CXVZRlEKPP4hcCweUpH3JuNpFEE+gl2M3UXNpQ3IHj0=;
        b=Ya5ahECiik+EI90hXBMoD7x/gKR47I4qsNXYBdexkEEz4ccDAaQeJWJ5I3atnWdfpR
         VTzk8YGre+HvRsg4wgryGuk1SIHPiOKTbbO4HXlj6wRPJ6vsb1v9NB7GALotfKraRY0G
         1c4xNy4cXe2VR3q9T/QWT1kcUNsAc7hOCyEijIGsQYBybiObrq9Gru9nP446tbE3J5dQ
         Vl4AFrwdTNckMLtSEGxaNn5NB62YQsqT2k94h2VdPjius178XKnD/rz6iw2tNk0l5eym
         AbvJ328+voz1OW2XPk5zLPbtXza8nLMJgu/eSD/kYTcVa0JktL9qzQlgyJCDwoQBL7JF
         S28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXVZRlEKPP4hcCweUpH3JuNpFEE+gl2M3UXNpQ3IHj0=;
        b=W+PzKCiWI6mYcnOzvXkjcVYVJMbLTavtlrsN1j7Y9HxTfgwUkUis66XUMikwD8Vi6R
         vjKCFz0gVNVeKG1zBxybBWxLzfb1vEPBG2zkpK3GcCu0OcflAtgQ9/98HiR/IqY7HBGl
         Dl09DuLvoEPcJTGp7GOm0UYUMdHsjqdiZNoH0HvB1NwwT7piZOrrZIMShXskviu+C4++
         A9Ny/K5tlz/sIsc+uWiXBizwKjhnDtAbgwokXCq9D5zfW/ThMcRtEQbHHhVAWv7cIgXb
         Vyq6csPdZV6cB1vJXSDh8UOhQKBWmT+hPIPqRBaFWH/u+EldcgD3cCd166XTujzD2Fux
         xydQ==
X-Gm-Message-State: AOAM533YMekalI2USYaBhDhPVFS3R2n0/sbCCQ8pDpnN+QHcUfsiViB4
        HLI28xGt82Ot/lDazGP+KX0=
X-Google-Smtp-Source: ABdhPJzBimoN+aIvqoMDnCkV82jqCOR++0dBAy2a4x+wuwmUQhWXGr6NdM3kyrdR4e4DaSour1+W4A==
X-Received: by 2002:a5d:6042:: with SMTP id j2mr1275472wrt.105.1642720844158;
        Thu, 20 Jan 2022 15:20:44 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:43 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/15] dt-bindings: clock: add ipq8064 ce5 clk define
Date:   Fri, 21 Jan 2022 00:20:24 +0100
Message-Id: <20220120232028.6738-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ipq8064 ce5 clk define needed for CryptoEngine in gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 include/dt-bindings/clock/qcom,gcc-ipq806x.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq806x.h b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
index 7deec14a6dee..02262d2ac899 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq806x.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq806x.h
@@ -240,7 +240,7 @@
 #define PLL14					232
 #define PLL14_VOTE				233
 #define PLL18					234
-#define CE5_SRC					235
+#define CE5_A_CLK				235
 #define CE5_H_CLK				236
 #define CE5_CORE_CLK				237
 #define CE3_SLEEP_CLK				238
@@ -283,5 +283,8 @@
 #define EBI2_AON_CLK				281
 #define NSSTCM_CLK_SRC				282
 #define NSSTCM_CLK				283
+#define CE5_A_CLK_SRC				285
+#define CE5_H_CLK_SRC				286
+#define CE5_CORE_CLK_SRC			287
 
 #endif
-- 
2.33.1

