Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7BC5803CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiGYSJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiGYSJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:09:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D82F1EECD
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:09:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p6-20020a17090a680600b001f2267a1c84so13405504pjj.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXHUeursV/DnjA3vkdaJ9YQ6tDdJ4lD2AcKBqo+/DmM=;
        b=pU+PspT7bMrdPFrmwH5v7iD+m9BosZvMDVMaMlBSdp2Yh8KrPvuVldL1USRhBCv8Pk
         KpnX5yU3diW7ZhoNYURhrbXdGGR9Z3yYQ9vdsGklAn8txZyAgWOWyxNtAWG6y9iwBnTw
         yRUUT0PJrxHczV/PWHAEnb1PVQbzOtYOWKtgYShEzF8kCBPuPcCCOWyW+mw8Bx5gQ8F+
         hN/uqE01TP2o6xChI3TUQZb3U0Adl1iwExG5Ycti+ayXcMEaepTJ2Oz56TqKuc51FUP4
         +suUot1DegNzhmDIJuXLuViLToZzEKtZ4ZjL4RHwdcNG6UCHqnQ+mMWF92/9LHhaXook
         vK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXHUeursV/DnjA3vkdaJ9YQ6tDdJ4lD2AcKBqo+/DmM=;
        b=QwOsYikuztJD/eaDhtdeRzLiaBWsQ9pyx/tqyAC03H0fIX6FDkC9tr+wE9dtXj/HA2
         MhzyLan2dGMK9zATDL1X01qJWm5nYkCiBukwiX71i/vLWz2emW77M8L9fKz2sVNhZ6fy
         siNM09/Jx2YSCTN8QwgB+i5dxwOTfvYDmzgbljH5Ia7mm3spMaZM6YF115aOFvdUT+R7
         H5Pxm89IMkMx/C5lwgOMd+DxwC95/6IB4eebXmyk+T6Pz628s8j+vYE3cgNosMABjAyr
         7Ihw2es4Ync0cxpVGrlcB1Wpn/kk1/f5kCcHcWff1zlxjPNk4CdcP9cHZa8d2MABVyNh
         8J0g==
X-Gm-Message-State: AJIora+OJ8MtLxNMrfAguEsac5V6Mv6jLPgXMCAyy6fR3WPBblRkqIQQ
        zfqmwU8LziONPQFi+ie0XSlcdw==
X-Google-Smtp-Source: AGRyM1sJFjjTAQKKaSs8M50XszsAs8p2m3lvgVY9YJiOr1lX5bLoCrA+vhgLYYf4q/AvaxN8bKPlqw==
X-Received: by 2002:a17:90b:38c3:b0:1f2:e229:41fd with SMTP id nn3-20020a17090b38c300b001f2e22941fdmr1481399pjb.201.1658772572680;
        Mon, 25 Jul 2022 11:09:32 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a64c800b001ec92575e83sm9219735pjm.4.2022.07.25.11.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 11:09:32 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org
Subject: [PATCH] dt-bindings: mmc: Set maximum documented operating frequency as 384MHz
Date:   Mon, 25 Jul 2022 23:39:16 +0530
Message-Id: <20220725180916.2850228-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Ulf noted in [1], the maximum operating frequency
documented in the mmc-controller device-tree bindings
should be updated to the maximum frequency supported
by the mmc controller(s).

Without this fix in place, the 'make dtbs_check' reports
issues with 'max-frequency' value for ipq8074 sdhci node:

  arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb: mmc@7824900:
   max-frequency:0:0: 384000000 is greater than the maximum of 200000000

[1]. https://www.spinics.net/lists/kernel/msg4442049.html

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
- Rebased on linux-next/master

 .../devicetree/bindings/mmc/mmc-controller.yaml          | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index ff5ce89e5111..c49f3060c24a 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -87,12 +87,19 @@ properties:
     enum: [1, 4, 8]
     default: 1
 
+  # Maximum operating frequency:
+  # - for eMMC, the maximum supported frequency is 200MHz,
+  # - for SD/SDIO cards the SDR104 mode has a max supported
+  #   frequency of 208MHz,
+  # - some mmc host controllers do support a max frequency
+  #   upto 384MHz,
+  # so lets keep the maximum supported value here.
   max-frequency:
     description:
       Maximum operating frequency of the bus.
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 400000
-    maximum: 200000000
+    maximum: 384000000
 
   disable-wp:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.35.3

