Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E6753D759
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbiFDO6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiFDO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:58:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BE82D1C4;
        Sat,  4 Jun 2022 07:58:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y19so21036868ejq.6;
        Sat, 04 Jun 2022 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdxomBwRPh0XCfD0FFgCu7OEZQemPZyMFK2HqSAOxOw=;
        b=AEbMv4lwZG1ecKb1QG237h98ziiE7ElGabFZquXuXEKq1e79B8VsL+W0WnzWmpkMTY
         SkYA1bSLQ9KHquN94DEaKjd/5K6TW0iLvkgni1r77T2q0771Iq4rFUemzvwkERWCB2NA
         kebT8itTyno4mzZSU9pLr14C2Xx89fA0yRw/Z068TqHkV7RoaFrI++zQt9a+3OOmJvSx
         jMB+EbgVdUB0QUqiFvVtTvJSHi9WgxEIduoHQyvk3heTJqgYAxhilGW+iuAap6g4MvlB
         wCp724a8TUTpRKdkJ/f1jEQlNoIDgvyyHLwES0CO5r1kuB8cN7JcqwwUzkq8j1Hp0ZDr
         5mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gdxomBwRPh0XCfD0FFgCu7OEZQemPZyMFK2HqSAOxOw=;
        b=xXYfgSSS2m6SwXIlHqAY+KBYXWC+JXjbfYJ20C7z+Qt8tAsKIfHkozw1GnN6kE+tbI
         v/4f+jWp5ps5HRvjV8rpT34uhWLYEBU9nQlQQ4k/mt5oaBLqkSmV1Ixyd/zJ5tOV5vKe
         Tc/92FQD7MI0LyANqNA/Lu64Q38XmXGjubWyPGiw56ROqoBvK+wpKK3G+H/HL9EkRZUo
         cIIouE+K63r78mCoScjCePc/LC+fcQFr8+HLnwieENhfJSjyyhPzYUbg1WhSiZ61A1pV
         x8STRmj5B7wgibtviv2PrEVCrUTIQ66tL8Zgh2bhr0+PIynFvex/nPYwdvgeqerr46uA
         9/HA==
X-Gm-Message-State: AOAM532nmziNrk8PPwJUdhr/ql0gq5u4oPcHUa41ev/GuzmIkfs6VquC
        MFiGgG2hjHm+F4IaJWna5gX9WGs7mug=
X-Google-Smtp-Source: ABdhPJy/hAqxDgi+GMA9QA7AClDGu6PlQjx2HLSREJ45JSh60HBsV0UJb6S1pZY/S/BjcXygpr8xlA==
X-Received: by 2002:a17:906:9b8d:b0:6ff:16a1:19c0 with SMTP id dd13-20020a1709069b8d00b006ff16a119c0mr13221236ejc.122.1654354698611;
        Sat, 04 Jun 2022 07:58:18 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-43.zg.cable.xnet.hr. [94.253.165.43])
        by smtp.googlemail.com with ESMTPSA id lk24-20020a170906cb1800b006fa84a0af2asm4139322ejb.16.2022.06.04.07.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 07:58:18 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 1/4] regulator: dt-bindings: mps,mp5416: add MP5496 compatible
Date:   Sat,  4 Jun 2022 16:58:13 +0200
Message-Id: <20220604145816.47576-1-robimarko@gmail.com>
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

MP5496 is the updated version of MP5416 with the only difference being
that now all Buck regulators have the same 0.6-2.1875V range with a 12.5mV
step.

Since there is no way to differentiate them other than using compatibles,
add compatible for the MP5496.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Send DT bindings as well

 Documentation/devicetree/bindings/regulator/mps,mp5416.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
index 90727fdc1283..7023c597c3ed 100644
--- a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
+++ b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
@@ -15,6 +15,7 @@ properties:
   compatible:
     enum:
       - mps,mp5416
+      - mps,mp5496
 
   reg:
     maxItems: 1
-- 
2.36.1

