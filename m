Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B433658BC7B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbiHGSg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiHGSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:36:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D1C5F9B;
        Sun,  7 Aug 2022 11:36:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f30so6009989pfq.4;
        Sun, 07 Aug 2022 11:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=byyZWet2uDAgpm9su06EHwBJ5r0AF/TLaVTFyMqG220=;
        b=gHNMX3AW4gx9Q5o9memn1/6nOXP8sNuy4W5CoybCw9zddo45lJ2aMPtq+PhyKT/KuO
         LkaC5EX1y5UrDIqUn43ZmjT23GB1MZ37GPiE2JzjFQvh/gDzzAsigBsj1SI29ZI697AD
         3hhXx2NWBS9B6JBLG0OP82844LTlkF+ZoEGLcJpxtlTiOXl56fEL9kbY2fpMhv1l/Lno
         8DeS1NjJjbCDu4zYxOazhvpqF1+HP/4NYoL2iXPeHHLRH5aRMdnT6DKF5UQSsen+hbg2
         eS7Z8Z/QUI9j4mwoDwAR62j7lTv4VeqQQT2/RCTKhjJyKCRCYlUcwGdrvFpfYteFZ1wT
         W6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=byyZWet2uDAgpm9su06EHwBJ5r0AF/TLaVTFyMqG220=;
        b=w3KjFHXNOx1cYVBGm9tU9bioHOH4fYWDqbIH+yNoFaWl9IPguRi/i30EfInbu98hoF
         P1txQly5UrSDWXyYoFxhic0Lhlh9VMbdZ1cQCHpGANEPaXOMmXPzqH9BhBmRk16nHmkY
         ynSFsqYmAqF1oiT9rTHvp5Zmi5R1cEXbVX1gaCbsinAMeY33rnYPYh4FqObzLxCVgIOo
         SGzOBkW/mxedhfzlnTBePL9nknse3n1pL84qlsGd/TGJSMWomJ3sBB37NuD+MZPjfoA1
         8RRkYyCTyhpJwGFGtpUl7s26xGaE5XzlRDQxI3lpZtODpXGzGcH22hlQBew9cYy3Np6M
         dVcA==
X-Gm-Message-State: ACgBeo2qhxldYEhYIdgnytOsDLt/hGKmzoRU82jFtWmTx7eloezx+pKx
        fyxMlRMJz4v8AyYnOVWfJ/M=
X-Google-Smtp-Source: AA6agR5lVztS2dNmZQsbKu/VztBJ5mARir9FsqTaNwsZ1MatyOuKuV1pW8IylNiwPWAQ0puMtVpwdw==
X-Received: by 2002:a05:6a00:b41:b0:52f:59dc:75 with SMTP id p1-20020a056a000b4100b0052f59dc0075mr1356394pfo.33.1659897415891;
        Sun, 07 Aug 2022 11:36:55 -0700 (PDT)
Received: from localhost.localdomain ([122.161.52.254])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090341c600b0016be596c8afsm6908361ple.282.2022.08.07.11.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:36:55 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: ls1021a: Use generic node name for DMA
Date:   Mon,  8 Aug 2022 00:06:45 +0530
Message-Id: <20220807183646.5641-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT spec expects generic DMA controller node name as "dma-controller" to
enable validations.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index fa761620f073..7c5510e34494 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -647,7 +647,7 @@ sai2: sai@2b60000 {
 			status = "disabled";
 		};
 
-		edma0: edma@2c00000 {
+		edma0: dma-controller@2c00000 {
 			#dma-cells = <2>;
 			compatible = "fsl,vf610-edma";
 			reg = <0x0 0x2c00000 0x0 0x10000>,
-- 
2.25.1

