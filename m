Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E909049F18C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbiA1CzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345689AbiA1CzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:55:00 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5188DC061755
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:55:00 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id e81so9808850oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZFOGW+nVn/EM1Z2BztmM+/jCRAogoevTBkpE6moeqjw=;
        b=HdaemvutluNp99sWBlcuaC1SxIFeOm3iywNN8TxBxGmC62cU911Ph2uHk4jsJU7vqY
         S6Lqs1ibqhqQ0VOetBb7NOuUAkTRN6ewV2zYblA6uxhpSr4ZNiZzsvJShmsf8PQGwXRJ
         B8SvZAD5yKdQ7G1QwWL8v/kCPmuWxLNHmBM3/tu0MkC2ZES2V7u6e1b5g9NI/Pz4fkNw
         iuMzWiq8diKFZtwomPbEWZvTz5e17SMdd9JmmCYTyMdnqrMxXUUMH690uJs/DyFcVhe3
         opbiv2mJVOxuBH5ORq9/uj3wEJmsIaZleoW5sQeVkjV2SsMUtkZO7fNVcR0wgKKSJcTF
         syUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZFOGW+nVn/EM1Z2BztmM+/jCRAogoevTBkpE6moeqjw=;
        b=cP980oh36qbJGyIjRUMKV8ZWgBwUeF8vkug98SNeVPRPF3QPgG6avx1dgPHzzuLzxe
         F5C+39YqJ1g8OndwZ/6Z3riY4mooXnqIur2+ipK8l1tmF9a67zdX18IMetMyGJacneFZ
         bVFU1MWvkxC8/epEG3b5ooz1NZKSx0OQqdPWO0xdLikRMitGwTMx69P+nmu1wpCp48dB
         Qr9YLpIUZnzlzknSXgku46W4bwnNZJnCu8M+FZmLt7uHGoOdg+xoNf1DuBe2nmNHJRmn
         H815UNfSGDJ7fH1wR16q0r/B6UA+An/bZLW7nfDfyBQu/+Sq/Ee6UR9mBDvD21avHAx/
         9HpA==
X-Gm-Message-State: AOAM530e+B8n1/7ig9LGbdD7KIGPn/sFEIuqxFN17PkD3gDBd9WbzHbq
        5aEl848IoQTk2Ow6g5l6AL5cMw==
X-Google-Smtp-Source: ABdhPJzK2qMTXj7NERh/AtWEIFGTW3DUbZtlsOUyoBZqt+PngY65GEw549w2aJ2kvxJIo8FmPw5UqA==
X-Received: by 2002:aca:ad0c:: with SMTP id w12mr4128987oie.287.1643338499659;
        Thu, 27 Jan 2022 18:54:59 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k6sm5677352oop.28.2022.01.27.18.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 18:54:59 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] arm64: dts: qcom: sm8450-qrd: Enable remoteproc instances
Date:   Thu, 27 Jan 2022 18:55:13 -0800
Message-Id: <20220128025513.97188-14-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128025513.97188-1-bjorn.andersson@linaro.org>
References: <20220128025513.97188-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the audio, compute, sensor and modem remoteproc and specify
firmware path for these on the Qualcomm SM8450 QRD.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index b68ab247e6ae..9526632d4029 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -346,6 +346,26 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	status = "okay";
+	firmware-name = "qcom/sm8450/adsp.mbn";
+};
+
+&remoteproc_cdsp {
+	status = "okay";
+	firmware-name = "qcom/sm8450/cdsp.mbn";
+};
+
+&remoteproc_mpss {
+	status = "okay";
+	firmware-name = "qcom/sm8450/modem.mbn";
+};
+
+&remoteproc_slpi {
+	status = "okay";
+	firmware-name = "qcom/sm8450/slpi.mbn";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <28 4>, <36 4>;
 };
-- 
2.33.1

