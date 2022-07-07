Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A256977A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiGGBa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbiGGBaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:30:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC942E6B3;
        Wed,  6 Jul 2022 18:30:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v12so8699397edc.10;
        Wed, 06 Jul 2022 18:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IrfFhBH+L4zbS3ugX8pRey925Xtf+IgisH4J8PjPwAs=;
        b=bJ4yKoNJmHYErL1xYrVwTGGvdvKJv9diit70u6+8+wJIIxB2PW70eO91iUQ9gucdw8
         AXYUD6kVU+XW7+t6XkKHYQhRbie+lpwaiJJX/1yiLTaKICHgt7tGWdB4+eB3LeoxIOry
         4WyZkSio4IzUi715vktG+Bn5KY0aKucSYw9Plt6TbLv8vx9+BZL1prS8fpBnley7+P7U
         adGES/k6peItUdaelK8/OOoS6elpatbcJS5Ixgj8zigGikFpuqDkfXQl7NIGQt6Nd9VV
         m7aS8EMkYxgnycpvy2mJQ8xUjJv0+ajKG7zZdse81BqhqPNFON+szJjpKXr2GMv5EfeD
         85tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrfFhBH+L4zbS3ugX8pRey925Xtf+IgisH4J8PjPwAs=;
        b=hEczf9bwGEvgWnR6+n71VwXKGY1IwKPf1Y1XAiP3nVKDcyioR0PpQu05LRPMaLNbk4
         JEkTNk09uSFu8Iw2xn5WsFp5ijC9fx519bcFYNRlpuc5bH0Twfl5wkevQoNKBdBbOWql
         uc66fPRT9G8aW7gVf3E9gBrEBrYOrF7WmZzeLlxcafab3xLC9QYECYAmEM1kIv578RjR
         FMvVZxX1qBCfVE/U932+/eBgTajSEQfdGmDye18c45qkBOl3iaAGor63oRKUW/xJs8Lf
         +WPwZU5WAfjsvN8diAWeOKgtgAjmZ5ocd7hbpfoiSDkKE5SdLqprG2n6HrY/podynAbk
         zKkA==
X-Gm-Message-State: AJIora/BDoF5DwPJsY2EGX6rgwgppGPods4qRS7w34Enj1oOtT+OuZ+x
        mie93K9gO2+E9Eo8Ss63Wuc=
X-Google-Smtp-Source: AGRyM1u1Ai6fzTs6ITeLopa0sNMdG+vE1mWq6grvdYItgPG2wOAVRDxA0vDr9kCp+7TTfjrkWBbl1Q==
X-Received: by 2002:a05:6402:2710:b0:435:bf54:8569 with SMTP id y16-20020a056402271000b00435bf548569mr58057919edd.165.1657157449957;
        Wed, 06 Jul 2022 18:30:49 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id t27-20020a17090616db00b0071cbc7487e1sm18025172ejd.69.2022.07.06.18.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:30:49 -0700 (PDT)
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
Subject: [PATCH 3/3] ARM: dts: qcom: add missing smem compatible for ipq8064 dtsi
Date:   Thu,  7 Jul 2022 03:30:16 +0200
Message-Id: <20220707013017.26654-3-ansuelsmth@gmail.com>
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

Add missing smem compatible and hwlocks binding for ipq8064 dtsi
smem node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cd1b43e2cab4..ff1a2acb1d83 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -292,8 +292,11 @@ nss@40000000 {
 		};
 
 		smem: smem@41000000 {
+			compatible = "qcom,smem";
 			reg = <0x41000000 0x200000>;
 			no-map;
+
+			hwlocks = <&sfpb_mutex 3>;
 		};
 	};
 
-- 
2.36.1

