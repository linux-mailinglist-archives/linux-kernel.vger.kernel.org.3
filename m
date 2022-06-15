Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB4854CFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbiFOR2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349653AbiFOR2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:28:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931C3959D;
        Wed, 15 Jun 2022 10:28:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a15so16313082wrh.2;
        Wed, 15 Jun 2022 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPJh0+5QxVl9IcfIvjsxlZmZC8UvoEwLLOJqypTZHXc=;
        b=Qbx/WYWJfRWvXbO5/QYUstaVAaNakVAkD1orizUvn5sG9T4r/X03Reo8/rpPxcrAyx
         HAE0zYdcvw/0AliGuzyAUDHkr+MscMeJ0x7oLhQ/IKgbpQbhUDdFeIOSg2BDi8ipMk4k
         Nxk2lWYs5MkzL8wOKY9tQsCaAz+KvM4sFXXgCkSBo+m/UJWJUZ0DZD9n40tuNB8mbL06
         DzNwVGfk0CAytBpJCbf75vndA+8RFz76ekoKAE3r9jBN31I/M04u+ZTdzTHu6Kgpdv0x
         7MhmgUdAJcIXDK2/MKjHAEeIKk/to+UZNRZa/Mrcwq+0rkNzhh+xJAL6ns+UWn+HVmHg
         ZlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPJh0+5QxVl9IcfIvjsxlZmZC8UvoEwLLOJqypTZHXc=;
        b=1IlB8UJFpyf7eRGoyGUucW8LClCh2hCkgiSNGE4rFX1aI/3YqhhiIZvdo0llo/x/td
         B7LLLfS8SFIBRxaLOqd+9WxIwj5N8QKA+A/2JiLyjie1BJ/nhc5YsAR65IwBHqJ18EKW
         kbG6qha1ihdGWVvAHFd0Fdow2nh+04KiLR8aygMvhShgubnp/XTt+lu1NNB9sVHPiRXZ
         RawFG7Ghrz/mcyHc/DY6LauTSuUnIs5S1/du+FdvUtATOGhufsPqviFHSCp/TwfIF4pG
         mAv8+IdkBkcvmN/QdJLHFDDvqin+8zCu/9Ajbbtiz5/5AJKyvvjkjUqrV22c2qi/WE0h
         NGSg==
X-Gm-Message-State: AJIora9jxQLZxTYQYvlGbImodMCYtbAvAMgB+6sWdqpuzIZ/zuHtahKV
        2ocyT/xECj1WjkCmhJ87vbg=
X-Google-Smtp-Source: AGRyM1uiE7j+UMgU29QN0t5gfsp+6EyQLQ4EmGOgoJfFhX57n4p9IxIHkwjyLW2f9A2DvLre7XJmqg==
X-Received: by 2002:a05:6000:1c02:b0:218:42ab:281f with SMTP id ba2-20020a0560001c0200b0021842ab281fmr810768wrb.607.1655314091949;
        Wed, 15 Jun 2022 10:28:11 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id w3-20020a7bc103000000b003976fbfbf00sm3023792wmi.30.2022.06.15.10.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:28:11 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 1/3] dt-bindings: clock: add pcm reset for ipq806x lcc
Date:   Wed, 15 Jun 2022 18:34:06 +0200
Message-Id: <20220615163408.30154-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Add pcm reset define for ipq806x lcc.

Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 include/dt-bindings/clock/qcom,lcc-ipq806x.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,lcc-ipq806x.h b/include/dt-bindings/clock/qcom,lcc-ipq806x.h
index 25b92bbf0ab4..e0fb4acf4ba8 100644
--- a/include/dt-bindings/clock/qcom,lcc-ipq806x.h
+++ b/include/dt-bindings/clock/qcom,lcc-ipq806x.h
@@ -19,4 +19,6 @@
 #define SPDIF_CLK			10
 #define AHBIX_CLK			11
 
+#define LCC_PCM_RESET			0
+
 #endif
-- 
2.36.1

