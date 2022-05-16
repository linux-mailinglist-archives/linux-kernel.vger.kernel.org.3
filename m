Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CBC52847E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241644AbiEPMtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbiEPMsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:48:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C626F38BE3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gh6so28549751ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWmbjpF50fRkAy7B2nsI8Zqd1HdhGpan8qf1bwnnudo=;
        b=jojLnmTeHwgPjo42nAF6jtXJY2kHpUWP8XMiUyo52Nvg2bYujjl12HsQw+sDCD5OB3
         WJE6wnOJ7v6OEkilPD2aH2yr4TqI2DV76EwhRvp5H6ZDVcxKEYsagdiSitwR0T/0Wx3G
         MZQpmlCPdxHclIL4HgmG5muKvZgWQUSysZdfFq5I3abov7xrqQmiiBX49pFWOgI63JIr
         L6NiUNRJ5eFUwLZNlJfOzeMr3xRdFwj2G3yF42/GBMVP2RxCXQx3pSbk74ehKsDzbBR6
         cH0Fvx/96WzZ5yKxE3uwdHpEeMIE5IYbx2oInk4bMpg+G5yIrLuJ0rggvkHGOAAf9oi7
         C/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWmbjpF50fRkAy7B2nsI8Zqd1HdhGpan8qf1bwnnudo=;
        b=fukvSu82Y/JJwskHKnLq4dLTFkvqTa0138qQDu3mtpBrkVKqHwaEbMkt/ZRlyDp2ew
         D/bTeHI6MW7gmEKwj3o4jNTqGGOGJHKVIC+gZKsHQCX6jpVit29IsuEf91SVJW7mM97H
         gO+isIaOhOAHeFFHIKwmkAtF1fz34nQlbixo8jjAywccO3TWerQNvSS/04R/KZxOLLHO
         uDE3D1j4bbMf1uKCY2mBvSx1IHJO/U9aVdi+f2VSoX3pa3ba888iMyFCDDmvS8A2VW9o
         ESbzZftlGEr9cGG1aEJ2V7FhEHNNwZLVLonEJR30SNTQLrnIwwyxfM/2kWqILMVGTA1L
         Wkwg==
X-Gm-Message-State: AOAM533HA8F9RWiP+q5ALD6vmEoGn+cc+i8ROlq3PeQrGcnYd2bHklkO
        ZILq+tOdyDuDe7PDmdx/slSndA==
X-Google-Smtp-Source: ABdhPJxy3qhYiFQf2sBQmCvFgN1Z6gLC6YwyvK4kACy8ZMrCLR/hu79twnkPAfPzOoCeQF6AkU2+7Q==
X-Received: by 2002:a17:907:3f02:b0:6f3:5c42:321a with SMTP id hq2-20020a1709073f0200b006f35c42321amr15337949ejc.521.1652705324400;
        Mon, 16 May 2022 05:48:44 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id e10-20020a056402330a00b0042617ba6386sm5093331eda.16.2022.05.16.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:48:44 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 04/10] arm64: dts: marvell: uDPU: add missing SoC compatible
Date:   Mon, 16 May 2022 14:48:22 +0200
Message-Id: <20220516124828.45144-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516124828.45144-1-robert.marko@sartura.hr>
References: <20220516124828.45144-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the bindings, all boards using Armada 37xx SoC-s must have
"marvell,armada3710" compatible while 3720 based ones should also have
"marvell,armada3720" before it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index a35317d24d6c..4ae1688e6627 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -16,7 +16,7 @@
 
 / {
 	model = "Methode uDPU Board";
-	compatible = "methode,udpu", "marvell,armada3720";
+	compatible = "methode,udpu", "marvell,armada3720", "marvell,armada3710";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
-- 
2.36.1

