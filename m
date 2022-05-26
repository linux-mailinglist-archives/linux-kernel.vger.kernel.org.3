Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A38535079
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiEZOSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347621AbiEZOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:18:02 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE474C5DA7;
        Thu, 26 May 2022 07:18:01 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r71so1501025pgr.0;
        Thu, 26 May 2022 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evzXCRElQX1dPpYOohRZm82+/mRQCembTUZz/W7nKE4=;
        b=iW5Zb9cUbecEDmbuXsk3dtQB4EwsTes5v02W2nQGnMRr6eyZwUsyk6tPL+59fwNi1Z
         yTFsJZ5L1yq7t/f/T5HHmKGTJB+ASW2IbG84b7uk82IwKe9QLXJHolSk3n68Zz4kBZts
         Zx11dZzs2NYHPpgKkli++EMqYuf28rgCVUEHQWHJL5NJFKxA7+Hlmn9vweWHxevlhiCp
         m0Mr8V73QKw95n030TB9qKsz3/3bQ2aG0IHidaxCyXg/gXOIKla0IzvumCXAJnsh9/EM
         4tQLuN1XywXWMJaaL+rwiV4RggkqON4hn8bnfBZfO7RqAdkv+05WPl8RjhbVqlE3FNbO
         EpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evzXCRElQX1dPpYOohRZm82+/mRQCembTUZz/W7nKE4=;
        b=dnVByYczqT0LxJu1XeAc3WY9THYg57VhzBVaJf6p7K8fXYjt1ql0ycnenQ47C0xGvk
         WPuA5naxSTeqUAQw2biRJJiTLjIemsQ+gyEpZsScMwSqOsMZ6HhyqKemmKikOwf+Pi7Q
         k4LeG7XK7WupLujJ3bRPrs/bfF/fS0sDK4OnfZ7N4/0zxPM5ZeyEbOTP5UHKm1JhlWuq
         wI2BsoB+e0Fl/hLcdNYkjc6XYriFuqBwbcxDkY6NE8eQelQsuWbysRkxKEQN4ZucmB4Q
         Z27CblmZD/Z0DlhZ4dyigSxU4lT03csgxcHNw3zWql2XvEwp1n+TH1WMYP5FeZDzcV//
         pS3Q==
X-Gm-Message-State: AOAM530m2Bpuhuv2/wUqiGF5/gNzpfnbZptOweTi0jU4FbZkQQFaoa+I
        jBSZgQ//rkbo3fpSMSpAb7+cmY3/aUOig7g4
X-Google-Smtp-Source: ABdhPJxBiMhXstsS758IEH4GIK/QjbIPtooIepKzJSkYZqM53K/60JCKuzPaeeMM5odpjZqoqT6L1w==
X-Received: by 2002:a63:d849:0:b0:3f5:eb01:ae2 with SMTP id k9-20020a63d849000000b003f5eb010ae2mr32608216pgj.230.1653574680711;
        Thu, 26 May 2022 07:18:00 -0700 (PDT)
Received: from skynet-linux.local ([122.173.191.164])
        by smtp.googlemail.com with ESMTPSA id ei3-20020a17090ae54300b001dedb8bbe66sm1546622pjb.33.2022.05.26.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:18:00 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc:     bjorn.andersson@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/2] arm64: dts: qcom: msm8916: Fix typo in pronto remoteproc node
Date:   Thu, 26 May 2022 19:47:40 +0530
Message-Id: <20220526141740.15834-3-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220526141740.15834-1-sireeshkodali1@gmail.com>
References: <20220526141740.15834-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smem-state properties for the pronto node were incorrectly labelled,
reading `qcom,state*` rather than `qcom,smem-state*`. Fix that, allowing
the stop state to be used.

Fixes: 88106096cbf8 ("ARM: dts: msm8916: Add and enable wcnss node")
Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e34963505e07..7ecd747dc624 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1758,8 +1758,8 @@ pronto: remoteproc@a21b000 {
 					<&rpmpd MSM8916_VDDMX>;
 			power-domain-names = "cx", "mx";
 
-			qcom,state = <&wcnss_smp2p_out 0>;
-			qcom,state-names = "stop";
+			qcom,smem-states = <&wcnss_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&wcnss_pin_a>;
-- 
2.36.1

