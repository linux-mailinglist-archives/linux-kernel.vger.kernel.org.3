Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF214E57FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbiCWSA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbiCWSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:00:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761B41F605;
        Wed, 23 Mar 2022 10:59:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kx5-20020a17090b228500b001c6ed9db871so7182116pjb.1;
        Wed, 23 Mar 2022 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TeKF1IrVTPwtitTV8dgbmN8AVqD0Mtciv+RTNtchAtM=;
        b=CvS8qLVfcrk3NGlCqS+dzql75jrHonuWq7qfMNBpfDuWkx+hMOOp9iOU9e0kom/Vzu
         PoEoodYURFWHBLM/vjzBIi1mkmM8fHUnSIZrKe7yhVUsBFioL4HmZDJQ89Mh8v+2al/l
         /9qJUdoMxL/wc5GDlc7snCBOhfpm+krsr4wX0aQrLjUa2cx5atgPYYeZ1Ogj5a1qfmOm
         i8r1AC/3qQiPyO/k+NEc//VJmgKq3WyYkzAogz3FE2klGCXhdxgnFNsrtmTPQRcbXZWj
         bC2exxhscNLB5MsO79gtUxB0jgrfhQKfy3nMB+SHVX7tUTFRrHzEQZysXgpD/wTcJjMf
         qK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TeKF1IrVTPwtitTV8dgbmN8AVqD0Mtciv+RTNtchAtM=;
        b=lEBqrZ/KWouxPw6rQxQyT4UfarzmmtVhtD2fcVm2rHQwxQZaZVh4Vw49/Y9eujfsjX
         kpY3yOLeJ/fJxJ87o33UM1WdV1ZdL3AUahlHxzry5AZA38fTxrHcwl/+uEk39xCMwSzw
         B1wIojbdVcABQUwuy7tDEoHetrg5bOl+eWLs/zSQE+f4Oaqiak4fsQP6Rp/vZWLwSLnR
         Gjyiv0X1iVWnYo7uPu+66iRK9x/qjG3WIDYk19RC9J6Q4gFgT2Y1RuZ74b3tNBbnkQVC
         VOaoM71tLC8kpnXJ9chlqqq5iIWr+gX9+1F1AeHjCOW0k6aY/bIO+9V2cHkbCA5p3Z4Q
         PVNA==
X-Gm-Message-State: AOAM533lxIOIplErCPHlPh95DZOJyCcRGxAtCXwOvEoaDE9s266/wln0
        hSz0R7FMdxkIMWeBXzdq/nk=
X-Google-Smtp-Source: ABdhPJwaHPOu98pWAjMGLcxyok9W+oPp/AYZC/v0jL+r/3wC+oBxGKiyJZhBZ8kX81WieVhTk9diBw==
X-Received: by 2002:a17:90a:cce:b0:1bf:6387:30d9 with SMTP id 14-20020a17090a0cce00b001bf638730d9mr13199933pjt.196.1648058366984;
        Wed, 23 Mar 2022 10:59:26 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00084200b004f761a7287dsm551622pfk.131.2022.03.23.10.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:59:26 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: spear13xx: Update SPI dma properties
Date:   Wed, 23 Mar 2022 23:29:20 +0530
Message-Id: <20220323175920.93155-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder dmas and dma-names property for spi controller node to make it
compliant with bindings.

Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v2:
- Add fixes tag
- Remove 1/2 patch from series as it's not required
- v1 discussion link:
  https://lore.kernel.org/linux-devicetree/20220312180615.68929-2-singh.kuldeep87k@gmail.com/

 arch/arm/boot/dts/spear13xx.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index c87b881b2c8b..45f0b2a33e02 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -284,9 +284,8 @@ spi0: spi@e0100000 {
 				#size-cells = <0>;
 				interrupts = <0 31 0x4>;
 				status = "disabled";
-				dmas = <&dwdma0 4 0 0>,
-					<&dwdma0 5 0 0>;
-				dma-names = "tx", "rx";
+				dmas = <&dwdma0 5 0 0>, <&dwdma0 4 0 0>;
+				dma-names = "rx", "tx";
 			};
 
 			rtc@e0580000 {
-- 
2.25.1

