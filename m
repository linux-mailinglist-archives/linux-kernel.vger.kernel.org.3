Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CE74D39E0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbiCITRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbiCITQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:31 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A271107E2;
        Wed,  9 Mar 2022 11:15:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i66so1939505wma.5;
        Wed, 09 Mar 2022 11:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hldPsR9u6qgwtLMZcTNitQaUGyr4m6295BrOOfQZurE=;
        b=fz41RZyU+tFO6Amyy88pjHELi3GGmsiEe3L9ZnC1HRHHQggBcogVlCxfP6z+TJkrO5
         6G+mzbrFvQL8Huf7tmWxvm8Fy1O3Gl5tEs0M1VTa3xhOm9Pjzs5PMOjTAmiTlIbJTYga
         OU3CQpyEhwlpSTmgrmRnL2iphCPrBH6sPhsPkiFi2dzyjbs6cQqBE3SVDSuolEPmtZae
         1NuyEd5vlwYNuIXM2HEIqgbgoC17q0NKyeTOaS6jymCHVcXp0Gubi93iGSP3la1x/xzo
         qqpsQNHbxbZdjdTVBXjREbqYIaKMOneu4bK0jKgR45j7oYHHp+pIvniLPjyH0QC1sYkW
         0+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hldPsR9u6qgwtLMZcTNitQaUGyr4m6295BrOOfQZurE=;
        b=ghK5Up3hlZXowy7f2Ah4HYljZR/Jlo9ttpTZYnysX4hHuKjcFI1jc9CqSbqtU2i+tT
         nvYqIT8SeNXxMtkjmrWnOBXJBrGSiq/kvMOHCcU/NaFOLJQK1sN/ATzMsyTh2ANkeeMn
         mHKE0Z8zdgD/Q/Eetppqv02rtjyrVAC6LLuMd7aSRu0rnrLCbkETsvzry2uWZhPruJfQ
         Umb6O+n+DN562Rl5a+yaU07422YgDPZZWXYslL5pAZ/4qYBLAN9LG9tejzU54LV9FvQh
         Ofebnyf8yGson+PfkzS5bEA4tSq/H/MAH6jqVYpDc1aN/hPX273fKElAEcqZQE7sT3zv
         pZLg==
X-Gm-Message-State: AOAM530m4lwhXJUPdrrpJ89YSBuGpjyqPpUKxyzeTtb9XKJOCEQJFJhk
        FtyaVo0QvApHBX2USqx79qRrBvLygu8=
X-Google-Smtp-Source: ABdhPJzA3jmM4mchAGe0tHfk7/7el4ZBHGpYEM0ttQVivdDl/LWIaYk8vD2V4o5ICOfIy/8HP6WbBw==
X-Received: by 2002:a7b:c114:0:b0:381:f7ee:e263 with SMTP id w20-20020a7bc114000000b00381f7eee263mr8852329wmi.30.1646853327670;
        Wed, 09 Mar 2022 11:15:27 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:27 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 09/18] ARM: dts: qcom: add smem node for ipq8064
Date:   Wed,  9 Mar 2022 20:01:43 +0100
Message-Id: <20220309190152.7998-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
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

Add missing smem node for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 6768f7ba0d04..c579fb09e768 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -906,6 +906,11 @@ lcc: clock-controller@28000000 {
 			#reset-cells = <1>;
 		};
 
+		sfpb_mutex_block: syscon@1200600 {
+			compatible = "syscon";
+			reg = <0x01200600 0x100>;
+		};
+
 		pcie0: pci@1b500000 {
 			compatible = "qcom,pcie-ipq8064";
 			reg = <0x1b500000 0x1000
@@ -1330,4 +1335,17 @@ sdcc3: mmc@12180000 {
 			};
 		};
 	};
+
+	sfpb_mutex: sfpb-mutex {
+		compatible = "qcom,sfpb-mutex";
+		syscon = <&sfpb_mutex_block 4 4>;
+
+		#hwlock-cells = <1>;
+	};
+
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem>;
+		hwlocks = <&sfpb_mutex 3>;
+	};
 };
-- 
2.34.1

