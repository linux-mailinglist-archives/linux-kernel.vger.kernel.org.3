Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF234966ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiAUVEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiAUVEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:04:05 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8102DC061755;
        Fri, 21 Jan 2022 13:04:04 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id n10so29198049edv.2;
        Fri, 21 Jan 2022 13:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CXVZRlEKPP4hcCweUpH3JuNpFEE+gl2M3UXNpQ3IHj0=;
        b=mcQt3QQuz8soITCTpwVuo8Dx4/K7umNypJgMjwKSj55Z1PfHWVAfu4UWskKCcT3EWd
         rldbdvu16iGSPYv96Xy0/Xx274rd/Z0uNl4KjDZMowC+eXo35KmnfutLZ/mgSH+VYJAw
         aZ/eB6uNiS7qKBnbLAmm1z4AAg6J7buGFhuyEnvsUMmvtlMSC/lug248DXrLHR5Bt4r4
         4/R+8/ESqqZQchJNnKMHAOAjn8EMH95abNyboWko2rzIzRFuiAzmhakjD5RzYo3hxXAK
         WfTQwW113L4JoVO1bt49gBPnXLVZGzt0Cp1Y+oJL4UNyz+pMRZFECUi5od47qp4mGee6
         q67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXVZRlEKPP4hcCweUpH3JuNpFEE+gl2M3UXNpQ3IHj0=;
        b=hGlhUWPC4OW0wzTkZPXmBqrvDOdyks0aFnK3IEUeq7qaIJfePW29Tv45WGveTei1Qg
         5pPHvhqUOIj7HjamHO2qTbcW9FABRWqro/5YkuX53x9uHRJjMzqRPHzbC62P+P6O3ekg
         3fcQOrNnt3x/fiV2q4u/eh4bFK4OFYcxYorKTvDdTDCefoAIB9EudP7kEcpmOo4EWndX
         DSy4GcMaLyyFrgF2kUeEvVzjYZU1Yw0oAO3zRuBPU2xf1N63VoNncKQAAdyt8lM8E4pl
         d3EsOiJQKTEdvjTkOd0q09xP448dpnOb4RhcJg6EBwGrTHglysohn8sh2c5uCT4aeyXd
         C2YQ==
X-Gm-Message-State: AOAM530r5uNvbdWL4c766dqp968JZDhXYUHHD/WDH/PtOTapfDZloyhz
        fMXti8rIcbTpFCSTbttQI4c=
X-Google-Smtp-Source: ABdhPJxFu9Aw6F9p69w0CcpdMnivsQPmOxAwDuYEJ9Yv+/EwnUbTiGFkSEfMT7UpCgHA+MdsIcbSvA==
X-Received: by 2002:a05:6402:5107:: with SMTP id m7mr5715878edd.292.1642799042879;
        Fri, 21 Jan 2022 13:04:02 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:04:02 -0800 (PST)
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
Subject: [PATCH v3 11/15] dt-bindings: clock: add ipq8064 ce5 clk define
Date:   Fri, 21 Jan 2022 22:03:36 +0100
Message-Id: <20220121210340.32362-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
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

