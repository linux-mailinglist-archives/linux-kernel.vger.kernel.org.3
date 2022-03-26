Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD34E8465
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 22:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiCZVXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 17:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiCZVXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 17:23:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3AD9BADE;
        Sat, 26 Mar 2022 14:21:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so6410227pjb.3;
        Sat, 26 Mar 2022 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TyBK01jrf008SVfLFXsPXvWmiecmsTzyMmbOyqtInlc=;
        b=B+Rs+UWSLybpeZxAWtBcyyOMx+iqm7JPyXuSA6lt+6RQT7a8CHeOWPxYl1myiqbrVi
         OgBRl04RQZrCkJ2I9UB8/T9oyew6SOxURlztEhUtW9t4K9BOrO62JLVsU4k5ZLTLH3qo
         b1TJj/v/RODWbP8A5lk+gQU513XV+lRGNTDS5+9jeMJC3PJ7niyh0ccAkYctI9S38UtA
         WVXBujilYAy0ivwZLTbxuQoGxn8UqHd3ldHx2AP9JifyXE+1lQFWDqA8HaaZuXCzBwiX
         4tVAxPVZ2qsYwt4rd6IjiLYiJPF7vrwrySuARZqwnNAb0c/1yCWM/OLsptR2AjWcyeHI
         jYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TyBK01jrf008SVfLFXsPXvWmiecmsTzyMmbOyqtInlc=;
        b=mQEgydLWre/SAM9Q1mPgiAiDwecCYYKBMDc4tMZWCNxkButu3oReNdDHqCIgoWst/Z
         dzm2ffI2Cp54ecOYVTWFGA9LKpVPfnbveq/Be1Qg6NZBs/jiWtyYhZEHKpyd5Q0k7M8j
         fSbI9sCsIMb8rHpOkh2XzvHLdQkZ0xmcm4T91RPRaZzxmXRm7rboNRMzTKGsUMr77f4N
         7ddjYteqROZK3Z1eFpeltB13RJUknybViq8e54oa8BNrcpeXs/C4tZ/tEg0nsAXUqD/s
         cytZUnt1e68Eu6yVqTYz9FeGIHg5Ihy8T6iNZ7wJpOvF4sYZZhNYL/HffDUKXzwM5kui
         E2IA==
X-Gm-Message-State: AOAM533QDZ9uLTi6+6Yi5ZaJT9khxXIdTXtHOuHEsvg4c6weGTt3ukiF
        MR58fNrmY524mYqGwCpUAE3TD4CbtI0ueQ==
X-Google-Smtp-Source: ABdhPJxASVZuRWBucF6JwS8GEH1In6Rw/XlhRogRmB8w2a5HB4Y+oEEdOfDA3E7L8hV16/fuivgCoQ==
X-Received: by 2002:a17:90b:4c49:b0:1c7:d6c1:bb0f with SMTP id np9-20020a17090b4c4900b001c7d6c1bb0fmr14322401pjb.230.1648329700957;
        Sat, 26 Mar 2022 14:21:40 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0024c500b004fae56b2921sm10669697pfv.167.2022.03.26.14.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 14:21:40 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: spi: qcom-qspi: Add minItems to interconnect-names
Date:   Sun, 27 Mar 2022 02:51:34 +0530
Message-Id: <20220326212134.45759-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Qualcomm QSPI DT spec says interconnects has minimum length 1 and
maximum length 2. Same configuration will be applicable for
interconnect-names. Schema currently depicts interconnects length
correctly but not interconnect-names. It can have a single entry, which
is a valid case yet to be incorporated in the current configuration. The
schema tries to look for 2 names and fail for DTs with a single entry.
Thus, add minItems property to interconnect-names to fix it.

With the change applied, below interconnect-names values are possible:
['qspi-config'], ['qspi-config', 'qspi-memory']

Fixes: 8f9c291558ea ("dt-bindings: spi: Add interconnect binding for QSPI")
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
index 055524fe8327..116f3746c1e6 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
@@ -49,6 +49,7 @@ properties:
     maxItems: 2
 
   interconnect-names:
+    minItems: 1
     items:
       - const: qspi-config
       - const: qspi-memory
-- 
2.25.1

