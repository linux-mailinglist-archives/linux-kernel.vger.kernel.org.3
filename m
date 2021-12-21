Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E8347C693
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbhLUS2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbhLUS2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:28:36 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F6C061574;
        Tue, 21 Dec 2021 10:28:36 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c2so70111pfc.1;
        Tue, 21 Dec 2021 10:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQC5STMzw4TlY0FvT781KJXZa9jGBgzdgcysSv7pHIg=;
        b=PHNILbg5zu9B+nrTaUJ4u8DISDwxjdcnL7Ck1t1Gv7LEy7+aljPgbA9IiwzLXd1DGD
         jIQQzMI7jAv+/onFxB8Zn9d55AlkXp08hOX5cFHGf/o8GI3LDsuA8QRQK7ggBg3ttqzk
         w1h5JuRNDMRboIqkH77cfA9lrZHUMmWJm++uA6jAOqOLQowp9z2jbSj0Cb6kgEMoLPpN
         NZ3wev5sT5MI1FT5nAXBvOxcct0ewGZ7GoLjP7koDUH3CgE1rsGGtKC3/dP/2cAxbPK9
         VRuEe3TaDupTN52IPCw5W8FCRz78Ma6clGUWnKXBWPPk+y23DeSfkPxYEmygWL4pe7Lf
         56lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQC5STMzw4TlY0FvT781KJXZa9jGBgzdgcysSv7pHIg=;
        b=5SE7eAOMMdZMfq+tkBhFGfwMpf06P4KKzI6LWxtLFbJtAe8n7gFiDfRDGz3kobVcup
         D5eYwSRQ+AwC9zqmjtzEyZxVqH4JPclxckcek8W4gZxi15VxBf51YzsDpxQM9lSu3fKG
         jlqSlGNAy/P+0eDbGGjq5W9A3S8blpJtLihkt9DfoKfnwgmbIhScGusqU7qRVF7w6bO/
         ywEPOlxTbYW4evW637LaKeLJhPhBlbMNd/edYbrejynoYMSL/P4K9yk7rk28RPTtPJJR
         PYG38srxDbRPJfRcv1nLHaXZD+Kt83HWtYY4A0xWsbG5Lgw0yaKj6JOqccc4dPMb70H4
         rjIA==
X-Gm-Message-State: AOAM530o7J3ic4ZXJ0HOSIfmtufNGrC8TrdkkdoxxWqKqTxHfDLfUGqu
        Gx8eyMkm+q3Q5pmAgh0qLQ8=
X-Google-Smtp-Source: ABdhPJy/vd0oGUe2uvFOW0EEA5ajTWnrgWWATbExu3LpqAzlhmtUTukt2LyeGVnz9Nv4ogEtyv+fxg==
X-Received: by 2002:a63:e50:: with SMTP id 16mr4030925pgo.619.1640111315659;
        Tue, 21 Dec 2021 10:28:35 -0800 (PST)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:36:b871:81c1:f2ef:8174])
        by smtp.gmail.com with ESMTPSA id s19sm23436133pfu.137.2021.12.21.10.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:28:35 -0800 (PST)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        bjorn.andersson@linaro.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH RESEND v4 3/4] arm64: dts: qcom: sm8150: Add imem section
Date:   Tue, 21 Dec 2021 10:28:25 -0800
Message-Id: <20211221182826.2141789-4-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221182826.2141789-1-jaschultzMS@gmail.com>
References: <20211221182826.2141789-1-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarrett Schultz <jaschultz@microsoft.com>

Introduce the imem section in preparation for the surface xbl driver.

Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

---

Changes in v4:
 - N/A

---

Changes in v3:
 - N/A

---

Changes in v2:
 - Created to properly reference the xbl section inside of imem
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 81b4ff2cc4cd..bcfcb7306cdc 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1175,6 +1175,14 @@ gpi_dma1: dma-controller@a00000 {
 			status = "disabled";
 		};
 
+		imem: imem@146bf000 {
+			compatible = "simple-mfd";
+			reg = <0x0 0x146bf000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x146bf000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		qupv3_id_1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x00ac0000 0x0 0x6000>;
-- 
2.25.1

