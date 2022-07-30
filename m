Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBD7585AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 16:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiG3OXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 10:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiG3OXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 10:23:43 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1A013FA3;
        Sat, 30 Jul 2022 07:23:42 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y13so3619290ilv.5;
        Sat, 30 Jul 2022 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Voqu6aJRMeEVOlwvE2Se+YOjP0roD05uM97alfr1h0Q=;
        b=MX7F5L/LWJMPs2QHSwZwzmP4Y6xVwFQp8GJCkHXhb7CGqUJa7+vf8kRe4DXN0f62qU
         a+g7LFZfWpWd7Xyq/BV2lvmBrpq6aoaE7hj+etBbwBk4WyceBQcdNtH301NfavcfY1c7
         jFO8+eVuVeb0+snB8izWnwQpKIlBYF1GtKRXyQX6wl5WqBtgBzrVFHsoIwRtLTzpyc9l
         ZkULh3EpTqRi+wmJUrvSeNgPuYboJy1p+X/xr3NrFEtWJ68y5F8SK6k1iAt7q6BEVH4i
         azqGvDkB9fHhjPWC82oEQ5O97iM+SEwL0qGfqGC3k/nyJ8PYviGWUTVxUoYOEXdTvlvT
         eG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Voqu6aJRMeEVOlwvE2Se+YOjP0roD05uM97alfr1h0Q=;
        b=uopa3dGFBt/AGvpki49oXINF6ihVRi98dYNJgxLA4ix/LpY+xEa0WCD56LQWwPb75w
         9VanUjq1+pcipJ2YerPSwU/H2QQY5ecUhwxP03k6TB7Dq9XTFIGuNnpDKYYagH7jJ5ZV
         YbWClFQXzutOcJM2K2oD84JL8DR657BZNJ/qlspRE8SQ1nxEbYyaEEssJjd2pOcGb594
         kqtIrbZVHbm2Kxy7ClTe6xQt89v8Me9leWhjmLIQQ0tSFThxSL6je1iejQfuopCcd5Oh
         vcm5id/QheWZlkKSFJTNCvSXzKJSIztSkM2vbuNkQPOmtGWvH3Ydox//yn2Miv1BDEMc
         H7jg==
X-Gm-Message-State: AJIora/h2mRfFurB3sLwJ1MnBMlDRi3lNWgXbWxUFOSMJnpX/T3qWC5H
        gjAtPtpp6ElLD5LtjmnD2fyAJezyq0A=
X-Google-Smtp-Source: AGRyM1sHoqCRGd+RA6qoOLRK20en+E/bcTFuyjB7xzm3eFF9tkeNeqofLeVur/DL9Sp8bhxqzCZYeg==
X-Received: by 2002:a05:6e02:1ca5:b0:2dd:77a2:7d71 with SMTP id x5-20020a056e021ca500b002dd77a27d71mr3164913ill.256.1659191021792;
        Sat, 30 Jul 2022 07:23:41 -0700 (PDT)
Received: from localhost.localdomain (wnpgmb0311w-ds01-45-179-115.dynamic.bellmts.net. [206.45.179.115])
        by smtp.gmail.com with ESMTPSA id q25-20020a05663810d900b00339c33df66bsm2991083jad.118.2022.07.30.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 07:23:40 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sudeep.holla@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH] arm64: dts: juno: Add missing MHU secure-irq
Date:   Sat, 30 Jul 2022 09:23:36 -0500
Message-Id: <20220730142336.484564-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

The MHU secure interrupt exists physically but is missing in the DT node.

Specify the interrupt in DT node to fix a warning on Arm Juno board:
   mhu@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4]] is too short

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index f6c55877fbd94..3220a00e9500d 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -26,9 +26,11 @@ mailbox: mhu@2b1f0000 {
 		compatible = "arm,mhu", "arm,primecell";
 		reg = <0x0 0x2b1f0000 0x0 0x1000>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "mhu_lpri_rx",
-				  "mhu_hpri_rx";
+				  "mhu_hpri_rx",
+				  "mhu_secure_rx";
 		#mbox-cells = <1>;
 		clocks = <&soc_refclk100mhz>;
 		clock-names = "apb_pclk";
-- 
2.25.1

