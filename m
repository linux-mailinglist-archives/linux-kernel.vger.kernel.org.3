Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBA2569772
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiGGBay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbiGGBav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:30:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CDB2E9C5;
        Wed,  6 Jul 2022 18:30:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y8so15573066eda.3;
        Wed, 06 Jul 2022 18:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKi4RXaC4DagIFoOVZIbvN2+wPxyAJ0ILA+POA4IWXU=;
        b=gpl6tmcSXHa0s+CoR5QxMt1giHv0yqfvRDXnSzW04dfEuN+lcpdDVR9udfeSfASPqw
         Y4c5ZlNfo2pXxqTi9ajr0XOhSHMstqJ6XG+2SYeutjUY1TYAz7znVFPB7+VcCT9ykbs/
         kjJhj5WEW8+xpIGwTnHf0w4nVkYVX1jBBE+UktIaQMjKxVUvbTSOeOqtkbCsgeEmMqHB
         YazzHgalIB0pvsa/+h+I9YYGZUQO7KW6WtiafuJPgXQriG6PugEPWB55j7U0ydOurGbq
         ys+ftsT+K324F4jrd1ko0LQigwoHxXZ3tk/566qCu/3925va8+inJxv0DIdtMRHzuQRH
         YJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKi4RXaC4DagIFoOVZIbvN2+wPxyAJ0ILA+POA4IWXU=;
        b=ji8VxhYxwkpCGw+onNv1XpsCPGdoLs1RtR85qd1bLy6nwmxFGMXmDXjvJjhlz5BT/S
         Mio4DSbc6O+G/GKDhMspuvSZJv8UC/c7Yaln3R9zwqnqUeW2rI5BKNJkTFIsMiqF6UIA
         NPaN3hv+xUTSrEeFzbkBJm0VQp3gMHYgD2+OmHC3zO1j9+8C8bg0ya1EAnxDGdpN6RmO
         73IheXIhTcafR5oiW9fsxPnha4L4YFCzE1kxr5II1BuNpDTVjZjfSYkeQt5bdtKcqwlK
         9cSDp78EHB/Rg5qeIkCYubtL3KhYHPo4PLm4+6W6e/X8Wk8jZmpZyrJdKtaLgp/kPvGf
         u1gA==
X-Gm-Message-State: AJIora/dYDmRtlMEpqXzg9j/QmvbOTvOOBot5inIs+P0aZS9PSlzdc6p
        4d2wzlAmRt6mzo5nPrkugWs=
X-Google-Smtp-Source: AGRyM1tvRW8jOn395Cf1nAQOc2eTCCBlruL1sZKOeKP90O5nIUvJLopWQUsOFY5hKyj6KpwmTlCXQA==
X-Received: by 2002:a05:6402:18:b0:435:9a79:9a40 with SMTP id d24-20020a056402001800b004359a799a40mr56959292edu.328.1657157448818;
        Wed, 06 Jul 2022 18:30:48 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id t27-20020a17090616db00b0071cbc7487e1sm18025172ejd.69.2022.07.06.18.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:30:48 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/3] ARM: dts: qcom: add missing hwlock for ipq8064 dtsi
Date:   Thu,  7 Jul 2022 03:30:15 +0200
Message-Id: <20220707013017.26654-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707013017.26654-1-ansuelsmth@gmail.com>
References: <20220707013017.26654-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing hwlock for ipq8064 dtsi provided by qcom,sfpb-mutex.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 4b475d98343c..cd1b43e2cab4 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1224,4 +1224,11 @@ sdcc3: mmc@12180000 {
 			};
 		};
 	};
+
+	sfpb_mutex: hwlock@1200600 {
+		compatible = "qcom,sfpb-mutex";
+		reg = <0x01200600 0x100>;
+
+		#hwlock-cells = <1>;
+	};
 };
-- 
2.36.1

