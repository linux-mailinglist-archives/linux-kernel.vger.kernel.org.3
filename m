Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413E54E7902
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376720AbiCYQhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356637AbiCYQha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:37:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49A360A9D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:35:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gb19so7999655pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04bZ9l2OKVtfN4Urve70oIr9AZ8XOtSj5lg9hqy/gnE=;
        b=iFDs5Id5VD5k6hsPSJH29huaEDAR8cn8C3MwuTRBTIR0IpLn/rWnNtU4f2b3E7G4OC
         InZOXxCieQdNzNhNTz4wg0bZ/pEKb5VMsxZbr7Xvelbs1t6m/fSrsEvXSZEGXmy+pPTm
         K7DCl8ZDxDcTLDWrSfS45Ne7XRq/xY33KaMi0jJS/70m+kMWLt7FN8fAe/hawW+Z53mO
         ALdMKn53561aYVc7DowPmx7eu7QhQ++MMq2n07gRaeZ6xs3fUZ/u2POmqlr35h4FQALt
         +8JiVMFmXgnG+kaOqKGt6miiDAYaVr91eB2lUUtj1rJT8doCNRoJCFm4+N6kKsCmyniE
         vnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04bZ9l2OKVtfN4Urve70oIr9AZ8XOtSj5lg9hqy/gnE=;
        b=V1YkPpyRiN0X5LlHzFsvOLTAkFb5oUYq/l8zq5r/MBu76w7I1AX7zdXU0tpzdMwzLy
         6JVq5fQKhl92HZi2QiM/5Kc4uMr0xkiPKxioLfRzS59c9BN1f3a6sLPR963wtLhZnjYp
         K4gKeiU1D3IBjrFyXT8a0/7VnaJPh5/ZHe/+j8qYFlJolgXB0Jbn6P+q1H6Z09TG2PHC
         usV2gh9UOE9kLKcvtHzj/2FH2VnDH0WfPsNe6HoO1p6vre4/qI/wPAUDBiVnbJmCxnSQ
         36eeVxOdjPP9yD88xF+97TF14CvDtXvS9tKkFtccEC0Sk7GgY7RaRf16UYSfGiEfciAZ
         3BxQ==
X-Gm-Message-State: AOAM530puw6lemGshzoCUk5DPNvWuXn839N9DReN/4mdxw0u9t+0wmcB
        pXmUVXy3Z4zQBZR849ndnzMG7Q==
X-Google-Smtp-Source: ABdhPJxO/yWk7yYNVZDfTf1TBINSbNDhDNnV/sXkdPgDHGtU4vUS5etlY89aEMtu1PjfCzfH5Zt1Pg==
X-Received: by 2002:a17:902:f243:b0:154:57eb:c748 with SMTP id j3-20020a170902f24300b0015457ebc748mr12434732plc.164.1648226155153;
        Fri, 25 Mar 2022 09:35:55 -0700 (PDT)
Received: from localhost.localdomain ([223.233.78.42])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a588600b001c699d77503sm6264948pji.2.2022.03.25.09.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 09:35:54 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 1/2] arm64: dts: qcom: sm8150: add ethernet node
Date:   Fri, 25 Mar 2022 22:05:36 +0530
Message-Id: <20220325163537.1579969-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325163537.1579969-1-bhupesh.sharma@linaro.org>
References: <20220325163537.1579969-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

SM8150 SoC supports ethqos ethernet controller so add the node for it

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[bhsharma: Correct ethernet interrupt numbers and add power-domain]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 15f3bf2e7ea0..915c8353feb4 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -915,6 +915,33 @@ gpi_dma0: dma-controller@800000 {
 			status = "disabled";
 		};
 
+		ethernet: ethernet@20000 {
+			compatible = "qcom,sm8150-ethqos";
+			reg = <0x0 0x00020000 0x0 0x10000>,
+			      <0x0 0x00036000 0x0 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+			clock-names = "stmmaceth", "pclk", "ptp_ref", "rgmii";
+			clocks = <&gcc GCC_EMAC_AXI_CLK>,
+				<&gcc GCC_EMAC_SLV_AHB_CLK>,
+				<&gcc GCC_EMAC_PTP_CLK>,
+				<&gcc GCC_EMAC_RGMII_CLK>;
+			interrupts = <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 699 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_lpi";
+
+			power-domains = <&gcc EMAC_GDSC>;
+			resets = <&gcc GCC_EMAC_BCR>;
+
+			iommus = <&apps_smmu 0x3C0 0x0>;
+
+			snps,tso;
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <4096>;
+
+			status = "disabled";
+		};
+
+
 		qupv3_id_0: geniqup@8c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x008c0000 0x0 0x6000>;
-- 
2.35.1

