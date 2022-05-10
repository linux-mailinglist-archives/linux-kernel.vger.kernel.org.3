Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1049522121
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347318AbiEJQ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237625AbiEJQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:27:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2C2A0BFC;
        Tue, 10 May 2022 09:23:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j4so30243869lfh.8;
        Tue, 10 May 2022 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lE9M1LT3yKC1XMSzyFOtlSmz+JiIYT6pQw3EYMoZJec=;
        b=UHgfWbsTrNXXX6mF1ThS2P4I3clamg5/10H18jPoQOT8ICcwCcR2ohxK4nQBIv1lmN
         PX2uPGYkEabwoJ4clEomc62ZzxHhv+n7Q1sB/pl1yJqzpgQoNbAGwxfsB+G1aGLtsHHC
         hi3MNnhRMcIHD7h0eRxAWUbwd1VH91Nfq2zf86XZ8IHKAjc/YPsiL/yPV+im9nYg9wQ7
         U4FuD5PnDqnnNTtWWm5XPGM9bpndelYfMlcOqXHaLC4vjTHbwLhRT6b6Pb8vjQ7Y90o+
         nAMP5zRsVS0zsAVI9uKgzQEpuZegbm3RT2qIg9SkHWUlFX9tM+ZD6XjXH+ZB9a72V7Fh
         /kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lE9M1LT3yKC1XMSzyFOtlSmz+JiIYT6pQw3EYMoZJec=;
        b=IrtudqCezAcRTDC9NeeXXP5Z0KCupJuKm0Z+woKS8+6Hr7bh+ZsV6LVB+Ab/zy2U2J
         JC6beqc1tVf8mlbxQRjPFkshk4bdEaXE8spDwH6H/DFM2P9FwvWEwtOrgezLpEHyIQ0h
         nAzKTAOMixqBvm6aPdcFc5pfvImjVSWFCusYz49bwUFlRI+omx+kf20uc9UO0QRDYqeP
         D6vRq3+ohfgM1imgrN8ROOmR91SVsMlC8Aw88PdJoZAp1giSmq/5ox0cB5Dxb5maAfWg
         wPeOSlfFlXOFA5WyF8g5UyFEc6Oed3DH7/9YMbt0Z4Ot8sKByoi2j4KDMLQCWYLvM0af
         ELgg==
X-Gm-Message-State: AOAM530F8noeFhryBAL2bgSKWOcE2tQRtVJ4uyEe6JchM3LCwONh4bh7
        A8e+LGl3bbynr8aOEy7DcPc=
X-Google-Smtp-Source: ABdhPJwfQ0dQeA8YbZQyqC6JBjPo56fJ0/mD8aAtBAuEVrVNRrN152j/YvTuQrWeK3ZE6QkDtxHmmw==
X-Received: by 2002:a19:f706:0:b0:473:9e36:79de with SMTP id z6-20020a19f706000000b004739e3679demr17272138lfe.35.1652199801284;
        Tue, 10 May 2022 09:23:21 -0700 (PDT)
Received: from vmu1804.lan ([2a06:a003:501a:a7ce::887])
        by smtp.googlemail.com with ESMTPSA id k19-20020a2eb753000000b0024f501aa770sm2217089ljo.134.2022.05.10.09.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:23:20 -0700 (PDT)
From:   Mikhail Zhilkin <csharper2005@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>,
        Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v4 1/3] dt-bindings: Add Sercomm (Suzhou) Corporation vendor prefix
Date:   Tue, 10 May 2022 16:23:14 +0000
Message-Id: <20220510162314.20810-1-csharper2005@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510161641.20655-1-csharper2005@gmail.com>
References: <20220510161641.20655-1-csharper2005@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "sercomm" vendor prefix for "Sercomm (Suzhou) Corporation".

Company website:
Link: https://www.sercomm.com/

Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..65ff22364fb3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1082,6 +1082,8 @@ patternProperties:
     description: Sensirion AG
   "^sensortek,.*":
     description: Sensortek Technology Corporation
+  "^sercomm,.*":
+    description: Sercomm (Suzhou) Corporation
   "^sff,.*":
     description: Small Form Factor Committee
   "^sgd,.*":
-- 
2.25.1

