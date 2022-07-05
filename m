Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5209356778D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiGETNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiGETNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:13:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6A21C92A;
        Tue,  5 Jul 2022 12:13:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fi2so23276469ejb.9;
        Tue, 05 Jul 2022 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URUNgyykm+FYXGtKi3BEFInGhuSrvdoaZojpppShAEI=;
        b=DvZiUoAZIXVYK1lYDINksnqMthpHlDZ+s60K8rIA8ci9iwtTGTxeIsmM3FzHjxnOqR
         brp9yjgM8GVwIeVdY5zr30DWgJFLWONC7qKEUYbotb6e3N7fRcDcWHM73KgTxoqJRr9y
         k8byO9pGpV8XQPr+lkFvS9L6wayjc1+cPk5WALNnAUFINmNNkE89fjwLwDqoJgICkXye
         NlwYbpsaEafKWHmakdF85bNNQiNgIFV1DVovSrea9PDTjCeRnDGhTe9UegS6nemGsgmr
         U9cgXYPSgnWtnU3DY+4xqs/L9kOtSfmQLTMjXeZba+hvF4ge1Hez/dVRcV3qr9IosTNL
         oRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URUNgyykm+FYXGtKi3BEFInGhuSrvdoaZojpppShAEI=;
        b=PIKk44YSvvANTqlRuPmPDDR9iXGWk0oWnbc6S6UJpvXCmgrWUZJKIWSEOtq0obT20h
         aAS1A3UpEuCaMAC19Wx1UaEnkVGSfwx2xAsI3VlLYS2dVpYJf/dmvgcJQ5WvstVBDUq4
         TdRjIwbqUk+i1B1WugJDT7VhWMqGFoPkayzG/bJop2OosuHBSCLMKs4jUxOox2UQKAHG
         rObbbRl/jTgrF367aEroBhYmwkixWtDDzI24rnWeFV3wm4w9M4qDrubPXrNz8eeCm/sr
         UID/nbhUktEVaYESnKLEehw8AHjcK4ZonbN95AhomtSJZtsgCCJHEMDGmx8g9/9pyonX
         mPMQ==
X-Gm-Message-State: AJIora8oyI4ttDyvWfKoey07z3JuvPfEPdHL1BN+PXpMhMs0UE5aLQZA
        fU2iIRSxOYYPpCkRJss+9to=
X-Google-Smtp-Source: AGRyM1tG8ZQMhZx97EC3KCT0ulWN8e1JUVGlJemzWyxj27J1Via61Dmgli9PwCCxVxmb8EDBZRtwhg==
X-Received: by 2002:a17:907:217b:b0:722:fc5e:326e with SMTP id rl27-20020a170907217b00b00722fc5e326emr36697662ejb.478.1657048412027;
        Tue, 05 Jul 2022 12:13:32 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-13.xnet.hr. [88.207.99.13])
        by smtp.googlemail.com with ESMTPSA id o19-20020aa7c7d3000000b0043a75f62155sm2480365eds.86.2022.07.05.12.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:13:31 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 3/3] arm64: dts: ipq8074: add APCS node
Date:   Tue,  5 Jul 2022 21:13:27 +0200
Message-Id: <20220705191327.1684277-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705191327.1684277-1-robimarko@gmail.com>
References: <20220705191327.1684277-1-robimarko@gmail.com>
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

APCS now has support for providing the APSS clocks as the child device
for IPQ8074.

So, add the required DT node for it as it will later be used as the CPU
clocksource.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v3:
* Node does not currently exist in the upstream kernel, so add it instead
of modifying.
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index b4ae13f16398..76707b9f9845 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -886,5 +886,13 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 				      "axi_m_sticky";
 			status = "disabled";
 		};
+
+		apcs_glb: mailbox@b111000 {
+			compatible = "qcom,ipq8074-apcs-apps-global";
+			reg = <0x0b111000 0x6000>;
+
+			#clock-cells = <1>;
+			#mbox-cells = <1>;
+		};
 	};
 };
-- 
2.36.1

