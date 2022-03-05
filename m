Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527764CE60D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiCEQxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiCEQxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:53:08 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6553B3C6;
        Sat,  5 Mar 2022 08:52:12 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id g39so19282629lfv.10;
        Sat, 05 Mar 2022 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FiJx5gescDdcx8BtGU1joboCGEN0cEdbkRq7CYc/eY=;
        b=QKmOJiFS0IDe8rEPUOqkru1cfY4m+xgqI+irzaGieOQfR6UmP68fvH4Qf7CQ1s+fb+
         Ce3PoCvXC8J0eifrh6m+eWrCyRak1FAQ5Uw2BJnUFBCK/fIRs5Epjf5rHMZxFhX0rzsU
         EdwPH2YHuvJ+uLpusm5O1rbpSeKMcanSlDKaOdspjIr0Ylsveav2swLu8ugMbKSUp9Nk
         2DaxcM+1PW3Ie3uWb3XH0Xx2V+NeKj7NI8OpbUOjTBX3txd41Ir3HYNHGYO0AJQdjzCB
         rDHsXw8XrQ/VhtWp3jkSUnDUJU+kqATFTCjkBYGRZ8BOklVfkWc+U6O5SlgD3uCkBq/F
         H2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FiJx5gescDdcx8BtGU1joboCGEN0cEdbkRq7CYc/eY=;
        b=aZgO4tDns+G0SBirXGL7ZCnc0ch5q6460fhefvPMq4CnixmCbufe2GAMYyqgPLuzk4
         cXMRdGVagAshWSkU2I1Y9PxE/2W8GARB2a9a04Vjs32HNLxvdPmsrhURR7rr7IrMTXko
         hbTGRreztk6RP2AKlZBDrHOUH7+SF+kWE08fUQWTLg50NcQqruHJErWbu+0r33mMApZU
         JJfen9tcqbAYGeb9+GtfEqIVo1+Ho86GDaQT0obarElriXW2GgkK4imtDVO8+w+6p6k+
         x+Zj75y3MUyVCmjiZGLO75u4NrMD6mImDSH8mcgea6UaMM8lHZncytLHWlGxVrBKfWxN
         jJBQ==
X-Gm-Message-State: AOAM532zkG88Nqzrh63EroB2ELovKrkefo9JMZYc0BefXAikuJsvwuCb
        l8ckpz/0Cc5WLYrQo3y+avLb0AV5Hi8DG+/+
X-Google-Smtp-Source: ABdhPJxS4S1Eu0lLkLMS6BwKj1YmzwHh6c1eDAYgZZFeQSYc/PT8LV0OxS5cKMstyhm8b+DshxllpA==
X-Received: by 2002:a05:6512:ad3:b0:430:5c07:467 with SMTP id n19-20020a0565120ad300b004305c070467mr2631270lfu.632.1646499127985;
        Sat, 05 Mar 2022 08:52:07 -0800 (PST)
Received: from localhost.localdomain (adsa4.neoplus.adsl.tpnet.pl. [79.185.186.4])
        by smtp.gmail.com with ESMTPSA id n16-20020a0565120ad000b00443c3f383c5sm1751287lfu.231.2022.03.05.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:52:07 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: firmware: qcom-scm: Document msm8976 bindings
Date:   Sat,  5 Mar 2022 17:49:04 +0100
Message-Id: <20220305164906.16853-4-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305164906.16853-1-a39.skl@gmail.com>
References: <20220305164906.16853-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

SCM driver on MSM8976 requires 3 clocks.
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index b1cd4ad1889ae..0f4e5ab264779 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -19,6 +19,7 @@ Required properties:
  * "qcom,scm-msm8953"
  * "qcom,scm-msm8960"
  * "qcom,scm-msm8974"
+ * "qcom,scm-msm8976"
  * "qcom,scm-msm8994"
  * "qcom,scm-msm8996"
  * "qcom,scm-msm8998"
@@ -37,7 +38,7 @@ Required properties:
  * core clock required for "qcom,scm-apq8064", "qcom,scm-msm8660" and
    "qcom,scm-msm8960"
  * core, iface and bus clocks required for "qcom,scm-apq8084",
-   "qcom,scm-msm8916", "qcom,scm-msm8953" and "qcom,scm-msm8974"
+   "qcom,scm-msm8916", "qcom,scm-msm8953", "qcom,scm-msm8974" and "qcom,scm-msm8976"
 - clock-names: Must contain "core" for the core clock, "iface" for the interface
   clock and "bus" for the bus clock per the requirements of the compatible.
 - qcom,dload-mode: phandle to the TCSR hardware block and offset of the
-- 
2.25.1

