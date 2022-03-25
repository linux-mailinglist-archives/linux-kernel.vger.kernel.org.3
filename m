Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911E14E7D32
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiCYUJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiCYUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:09:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A36543AFA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:07:48 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u22so7316221pfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3knZRWWujkRahNIIybfg/CGJU8bv3OrwffFxGrAdCik=;
        b=bVBePrcqsOxc0Xyz3wyYaw4zq1odh0jKeWdTDhjAX6DDqqtVCeNuAdyE+JjSwIigmV
         AFj4zT4SGtUfotWWWAtvib+UJSd9Eh5XA6yZwfYGZ7QxWCM0iZe6T+IYoAYevoK4NswG
         0l/s2odil/62sBOTDEhEzLP9xp9Qes9SV9vztRduyWOqH9xtGFL1wz9au9qyCHiNNJBM
         AiT5A9XofI8tnjOLuUOnljMbZ1Qoj/YCGuU3djfH++p95F0t9X0MvekDpdygb/97nqS4
         RGARwAp6QM/Ijh8Rxbnsbeiz6S+eMYQRFgtfQvjJomOwFDFosfnVAbLXMm/s2p5HciKU
         7nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3knZRWWujkRahNIIybfg/CGJU8bv3OrwffFxGrAdCik=;
        b=azqIhh57l+eFU5bQamACA4S4296MmtAcb/xt3JVT4fkgLu38sEOs/81zrT64Jz5u32
         2OU3IrKF2OjQVrFhYJkd2MpNl3zBa/stNOfeF8P1q5xU6Etp5J/jLn1FvCpdd+5AgdgQ
         rbamPhWBbPT9hgFBdbGdsMG30hLpOsMByjQ3B1VqpGeTr3kd7AFLque4zX7qx4UfrSDQ
         MymZW3Qb09/pCBOXyZ9HOX25Wl86y2Dn/JhWFsyO7auxAE86oWmQ7r1QSpg2RqX5jqdz
         iLNRJkdsmhCIE/sD5T4uprWbnPJztcAsD16+XwSZeNbjlb9VYjCzF45guI+e2y2REfCF
         Yysg==
X-Gm-Message-State: AOAM531rJJHslTcepzD/UeScArB7hhxsSyGa1jGJ0NTAEinyIr19uRAn
        AbEPeOrJ7uGMU0HrQ1Ri+075Nw==
X-Google-Smtp-Source: ABdhPJyzAPS3+sLo/07obtP9q9XmA2zPmwQJeLOzFav+trIQjghYy+nwnz3fXxpmsS0XPCok58gCVA==
X-Received: by 2002:a63:5020:0:b0:382:4781:7f4c with SMTP id e32-20020a635020000000b0038247817f4cmr968505pgb.230.1648238864561;
        Fri, 25 Mar 2022 13:07:44 -0700 (PDT)
Received: from localhost.localdomain ([223.233.78.42])
        by smtp.gmail.com with ESMTPSA id j23-20020a17090ae61700b001c6bb352763sm6643590pjy.52.2022.03.25.13.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 13:07:43 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     netdev@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        vkoul@kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 net-next 1/1] dt-bindings: net: qcom,ethqos: Document SM8150 SoC compatible
Date:   Sat, 26 Mar 2022 01:37:31 +0530
Message-Id: <20220325200731.1585554-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
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

SM8150 has an ethernet controller and it needs a different
configuration, so add a new compatible for this.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[bhsharma: Massage the commit log]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---

Changes since v3:
-----------------
- v3 can be seen here: https://lore.kernel.org/lkml/20220303084824.284946-4-bhupesh.sharma@linaro.org/T/
- Bjorn requested that this patch be sent to networking list separately,
  so that patch can be easily reviewed and merged.

 Documentation/devicetree/bindings/net/qcom,ethqos.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.txt b/Documentation/devicetree/bindings/net/qcom,ethqos.txt
index fcf5035810b5..1f5746849a71 100644
--- a/Documentation/devicetree/bindings/net/qcom,ethqos.txt
+++ b/Documentation/devicetree/bindings/net/qcom,ethqos.txt
@@ -7,7 +7,9 @@ This device has following properties:
 
 Required properties:
 
-- compatible: Should be qcom,qcs404-ethqos"
+- compatible: Should be one of:
+		"qcom,qcs404-ethqos"
+		"qcom,sm8150-ethqos"
 
 - reg: Address and length of the register set for the device
 
-- 
2.35.1

