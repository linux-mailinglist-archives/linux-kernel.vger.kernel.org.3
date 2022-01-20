Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955C14956E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348048AbiATXVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378227AbiATXUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:20:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB57C06173F;
        Thu, 20 Jan 2022 15:20:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n8so14867947wmk.3;
        Thu, 20 Jan 2022 15:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AjXtNoxCWeIUyUrNbQiYIAA3OZQBx2qW4EKDiOvy2ws=;
        b=Ucrroh9WAXok2oxE4m6dWt5I70dfUTErwT44FSCodido01s/fRuEL26NzgA36BOGxC
         kDY5mfs7F/iRFUfP16kuAGas9KO/JpFgp4KTlU1comHaKlBUZdxNli11pJq+wU9/OXg4
         msoqgfxvbcBeZe6lXruVgEYJ4tbJMsSh09wGwBcPcBeMbYFmV8spzy/L6u+PYIyc7oYy
         Izgfdg1pcTEP0TuEId1f4oc89sTMFj0EizjfefqtJyyWDW8KdkGuFRH6xVEWVZwK62GE
         LpKg4i+87Hbex5wjogKCdtjp08Zyc8GdkccFeu9cxQy1MuezDu80sxbLyDtBPb0YYIdf
         zTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjXtNoxCWeIUyUrNbQiYIAA3OZQBx2qW4EKDiOvy2ws=;
        b=6EUKtli7jWUq1Y+j6oGXFplsWuWPfpYIKkFKaumdo1C94sRg3bGYdRp9HnoVKPcE5L
         PLCyPaec+A22ct9rpS8FRgbbks4GTeeq+6Xpq+j2Iy8bZik12C9GtWUNTM/t2f2WYv1s
         qTNikMECko0r8bse0cZPt3WTgLvkQn/yl1rf4cXAJFMsA7gGUWx4G0DipfGKk2GnejDf
         nYiWmI71cJYNqhbKxvdcoImhBn21U4s6+cwuKVjhZ4gwBSkeU04PlGJU7od5wdtvsMec
         18i9Nc56ZeloK5XJ0Jv6usOrm+44zt+ev0slhErujKHlQGSVFDlTPopwMeXXv4X4P/B8
         fHXg==
X-Gm-Message-State: AOAM533+shuNbrk1vXtYqZkndWNJw1LSeT/w24SFLnpXDB30W7j/LunZ
        dvteVIy6NWfWnoETDw2qN5M=
X-Google-Smtp-Source: ABdhPJzWFkhW5CTNJ3HxDt6zA8/cOwyIlG03P6YXMef5kNyNyAn/0m9cOVMnLPOGT7Kz9Yw+GlZMAA==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr1116001wmc.70.1642720846328;
        Thu, 20 Jan 2022 15:20:46 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id a9sm3939283wmm.32.2022.01.20.15.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:20:45 -0800 (PST)
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
Subject: [PATCH v2 13/15] dt-bindings: reset: add ipq8064 ce5 resets
Date:   Fri, 21 Jan 2022 00:20:26 +0100
Message-Id: <20220120232028.6738-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120232028.6738-1-ansuelsmth@gmail.com>
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ipq8064 ce5 resets needed for CryptoEngine gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 include/dt-bindings/reset/qcom,gcc-ipq806x.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/reset/qcom,gcc-ipq806x.h b/include/dt-bindings/reset/qcom,gcc-ipq806x.h
index 26b6f9200620..020c9cf18751 100644
--- a/include/dt-bindings/reset/qcom,gcc-ipq806x.h
+++ b/include/dt-bindings/reset/qcom,gcc-ipq806x.h
@@ -163,5 +163,10 @@
 #define NSS_CAL_PRBS_RST_N_RESET			154
 #define NSS_LCKDT_RST_N_RESET				155
 #define NSS_SRDS_N_RESET				156
+#define CRYPTO_ENG1_RESET				157
+#define CRYPTO_ENG2_RESET				158
+#define CRYPTO_ENG3_RESET				159
+#define CRYPTO_ENG4_RESET				160
+#define CRYPTO_AHB_RESET				161
 
 #endif
-- 
2.33.1

