Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6624491326
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244084AbiARBCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243993AbiARBCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:02:04 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BE0C061574;
        Mon, 17 Jan 2022 17:02:03 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 30so72680267edv.3;
        Mon, 17 Jan 2022 17:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CXVZRlEKPP4hcCweUpH3JuNpFEE+gl2M3UXNpQ3IHj0=;
        b=ZKRD2QhSN8Ds7tSnS8enr3uAt/NjQva6NIkkOknlj5OszLfPQsZR/ijsyWJ9fc2WLk
         uplnrJY3ZAREamzZ4Dcwfkp7nNxQdNm6CKdDi7mZjTLcqkFQm3QiCmm1KhrMQpA7nRiU
         OOtbFGIMy0+EWerZrExY3I7HcDhaUx7WDkN26yqNipdBfkNFCGYOfNe5ZbGKa/W/ay8J
         rlICGXR0po/frBL7YyPIipvshTTZoULIqLgS+Yy5wCfWDywC4+Cvht4aXZIWTPcTI9Mq
         QR3TpOIQQue0Q3i0vlt7aYIne1HcDDFEtVoEabqfioezw65Zb2yWMOPJiePQB/S/uL1V
         s4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXVZRlEKPP4hcCweUpH3JuNpFEE+gl2M3UXNpQ3IHj0=;
        b=A8V+3+XrX5rz8FVhzQVGw59aVK+ifYeNz4T9RN/V0yJnY3/pXmp32OdTFrcwukZcJ7
         seFMgFQ3uAn5kGFNpD6oBv/zvzKBqStEdTlgNcNmsMwAKVsem4ohR11dHutcbeksdxTm
         dHN9vhYrHsFz1dunSrIo0/4L6FfaK5dh8W6/lkCTpFEYBzKjWiFFTXqMtm7fQDapSLUf
         ALgYBixGDKlAg2k3RVjACq7Eufm4NAUrP3UHhr3ugDLx29EI6vjyuCBH6x8qUaWgjW8U
         ObhIxEu0aBiSKWhpRCxBB2MGYJdFgXjMDWDhMKDxDE71xxb+zeZdIaJ9Eaz8ouQsgH6j
         sKuQ==
X-Gm-Message-State: AOAM530JgfwsiYSFZyob/t6GHJ5Sc0pZGo3pADVmDmJDSOHIY8weTRYX
        URZU8qNO5R5I0NRcwcbHW0Y=
X-Google-Smtp-Source: ABdhPJzmraW03nyXQa7eHj0BHSKZoBUEYfqBf7IaDSvinDs2ioZsDB8+ygHWlvmLbW3+6GhNAq4TQA==
X-Received: by 2002:a05:6402:c12:: with SMTP id co18mr14364166edb.246.1642467722156;
        Mon, 17 Jan 2022 17:02:02 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:02:01 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] dt-bindings: clock: add ipq8064 ce5 clk define
Date:   Tue, 18 Jan 2022 01:44:30 +0100
Message-Id: <20220118004434.17095-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
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

