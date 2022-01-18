Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6C491334
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244186AbiARBCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244086AbiARBCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:02:06 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9981C061401;
        Mon, 17 Jan 2022 17:02:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 30so72680525edv.3;
        Mon, 17 Jan 2022 17:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AjXtNoxCWeIUyUrNbQiYIAA3OZQBx2qW4EKDiOvy2ws=;
        b=MgbRNVbxVKt0Tynj99e5EQobcmx24aj6DDWSgj1WKBlZ85mbOVOsWShaOkGs80al3l
         zEKkHGCTi8uu+8g6VtBwV2uOz5pZ5xrN/0hEakfiT8DA8mSABuGzkAYqoDnVPQj3mtja
         cYy8MsQKLVsf7Fr7+MJNckoCvtLJ7Nk991BSf1UP5OJGSp2yVdfoyIfpC+7+jLwquVdk
         gaJHpzgmAAF6zLu1OfqA+KS7a88DWo4TT3NndGtxsmOh3oJnP4iYI9A1tiKc7hhhT27N
         r0kbPB9LBe23y5LDTcQw4+7afYUmGAGzL47t3xJwuW3bs4iiNQdB6un3jSf9qiyqg9YF
         TE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjXtNoxCWeIUyUrNbQiYIAA3OZQBx2qW4EKDiOvy2ws=;
        b=BoGVbZHjy1xqXGH1DVF5bk+EMGFx8LNhxkLlbcnJj2EkPF8qjCCkD+jSPebT00aMkg
         HIJ+qjapgBtbc795Kc6f8IrQLBVuqUjXqZHKyrAfGLD5FzIMB5xuHzAOrBQmYVGoaCiM
         VS2stHAl1ap6M+ikdeerY3Q0bM/Io2YVOW746QWjNw0mmUuGSl3gDPOeukosqwGhrQP0
         PMIS3osjs0T4RDbJnc/HN1UXou4/5kuv2+pdd2gIlYH3hhrey0ox/dkAMoAC+HfBKQrB
         7a2itIV/eJ93fRiFmjr0cJwLYnmBNvNYuPDODWSuI8ZIoj+AISQLTra4kVg1w5lIqGL7
         AuHA==
X-Gm-Message-State: AOAM5333jNkgo4ZAZncwX9LV53SohQbN7BpiyOk74Yj7IvRJWvwYvHxd
        avVU6xptW6S6N65lw/hJbtI=
X-Google-Smtp-Source: ABdhPJxWD9GjZWXF9KNdx1yNOfWyPalEc6TUFl0+3gRRecCqdAfXBze690PbS157ty6hU2ua8soB4w==
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr9612759edd.407.1642467724265;
        Mon, 17 Jan 2022 17:02:04 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:02:03 -0800 (PST)
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
Subject: [PATCH 12/14] dt-bindings: reset: add ipq8064 ce5 resets
Date:   Tue, 18 Jan 2022 01:44:32 +0100
Message-Id: <20220118004434.17095-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
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

