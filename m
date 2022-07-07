Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E6056A9C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiGGRhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbiGGRhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:37:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE8433A3E;
        Thu,  7 Jul 2022 10:37:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id l23so1873743ejr.5;
        Thu, 07 Jul 2022 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lnir6LgkpdRMbpwiFT3OtePuYtNQt7Z4A5ni5uK8NYM=;
        b=kblcKqBZdr4sSFcKa1z5P7DrASwYaA8KSy70SbMzV3uOqN6yGWc1nE/REZsP7dbRUp
         fGHwyAlLxjlsSe1H9QT4SmHVjJvpfDVqAHP6FW6IvkTG4YKirje4EyDB+bjt1VqcViOV
         FQEDZwkYwj9JeOriw4viuGpD/ExZyT1zl96KfEqJKHr14maPac0+YAbl0od+uVnpmP7Y
         PxAPpn42rMxMTwb+DdB3a03xSKB9bc5LBGUZWcXYZ8GZi87Sf3h+TScGuec+nEp8kZPe
         owtsipMfPThPm8v+OBFJhXG2chUhA4nN60/2SqEV0S7bSLQQvWqFdqTEU72xdoUxo9FL
         kUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lnir6LgkpdRMbpwiFT3OtePuYtNQt7Z4A5ni5uK8NYM=;
        b=VaExffct+ML6/9Mez9WxNi83tbMbQ1MTjdU4I53BaYwSgjLFS2rUnbJmNJB1/HGOgl
         5ImsaVEb9d9GtlpVA+x5UmdhgDaCUHCMXBh1zNrV4iHzmWQY5E/KOAIE7z9RpR6Dcw4p
         JM8zinVWXbrOMZtD/Xsd+Yd5/Gk6nMaxHwYEWZssepPhWICI3+yZm8bgFZsfL1annn++
         QtXtzJl8unXEhOtCE2IWtp/xJYJx+A2Z0zpfzbG6rpUPGsIKFijb2Y1vxjfQ75G095jx
         6pg1hUoH8C4LSd49uy4zza7KxhsJFS30WVYy/oaq+onq4h1kw+NwdmUsHY9jsy8mLS+L
         fpTA==
X-Gm-Message-State: AJIora/q9hc6xeb42QqIZepxPmo59a/N4muQGxvQU/y3ZtENK/Hz5lWI
        G1plJukkrwPN29uY5U5tZ/sCW9wQ8fXGJg==
X-Google-Smtp-Source: AGRyM1tNkqn649mBRfSwZAp/UrqG/OSWPDgkHtChgS5HKqpGsnFpdJtjeRcMkmc6Cx3Cduh86KOAlA==
X-Received: by 2002:a17:907:2894:b0:72b:145b:af83 with SMTP id em20-20020a170907289400b0072b145baf83mr2853406ejc.234.1657215460099;
        Thu, 07 Jul 2022 10:37:40 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id l10-20020a1709060cca00b0072b16ea4795sm674715ejh.48.2022.07.07.10.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:37:39 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 4/4] arm64: dts: ipq8074: add APCS node
Date:   Thu,  7 Jul 2022 19:37:33 +0200
Message-Id: <20220707173733.404947-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707173733.404947-1-robimarko@gmail.com>
References: <20220707173733.404947-1-robimarko@gmail.com>
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

