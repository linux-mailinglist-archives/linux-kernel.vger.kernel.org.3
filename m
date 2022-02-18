Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856104BAE83
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiBRAam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiBRAa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746396007B;
        Thu, 17 Feb 2022 16:30:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d27so11766056wrb.5;
        Thu, 17 Feb 2022 16:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k4FaVMNNPhSDj7q5Q19N79VJNwXVDqFlr+yln1JNzbs=;
        b=qoOlphdcmrPVw5F3rV/pSRuH2p5GTg/MYKxsIYqmp3pYpNOv+JmPQj08X78ntmIlUt
         lknf0tahr1zMq5BZK+xYQF/KWqpKO4+n1vMHmMTryZH5XG4PctmUTYHMhtZUU90CvFit
         qmzvuZT1ODNmICEzyXaH7iKrPWu+KuvHykFwyurAxt801BDk9/zndd3knskGc+XjKpv4
         l9l5Eerpb2vJCY2vVz/3RqbXR3vxrtFY2LcocOQjvb0m5j9yeU2LU54AvEdiLqyHDQl+
         JtY49P4cWhvhkB0LUWY71EKJ8r0aAkklHW1Su7SQdLFPHG0cNFlIBajJFQwcJzysUDSa
         c8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k4FaVMNNPhSDj7q5Q19N79VJNwXVDqFlr+yln1JNzbs=;
        b=1Qhtj9al2lZmhOKOjKjxbMx0xWRS9DEVvtoGGiYa/7CnQRoUepZ4YvCwLXqTX8NxAP
         BAOnBORhH955NxwVVa7+rcVWfuRDpSdSVB87MSyyTSgMxPkPch2PPiw5DLgelM3bZVE5
         Dlofzw8cN/dNi7zFSCWhVG4qXiZUyWhfReQi7xUj8LIg27b5o786XaQpxHoWfBv2ya4A
         x5fpZGf3dpTGOZV7zW5AGp+KF136RdnjcZtvDuwGwYhbl6PaRcFtTExru+aPW6PFeBHf
         7bmOJ4shAdAE3U+WZuhU+bjE868y+Fs6nf/GtUcjsMx7F+TW08/j5IIIT/R1STzC1lq6
         c5fg==
X-Gm-Message-State: AOAM532U8RX1teDzK1Ga14KuNFr5sJ5r3iKE2//quNMgyzNaIwMSb+S2
        xEM1R/YnDni0nj1nKLaY++E=
X-Google-Smtp-Source: ABdhPJx5evv1wn3NZH12CNg1awbdtFHLK7CkWCyZ4JY4n2g9XdVtyhVoT18KCbfeNSzB2UTwHDSkiQ==
X-Received: by 2002:a5d:65c4:0:b0:1e3:ed0:a6df with SMTP id e4-20020a5d65c4000000b001e30ed0a6dfmr4041221wrw.3.1645144202439;
        Thu, 17 Feb 2022 16:30:02 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:02 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 07/18] ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
Date:   Fri, 18 Feb 2022 01:29:45 +0100
Message-Id: <20220218002956.6590-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
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

The current value for pci IO is problematic for ath10k wifi card
commonly connected to ipq8064 SoC.
The current value is probably a typo and is actually uncommon to find
1MB IO space even on a x86 arch. Also with recent changes to the pci
driver, pci1 and pci2 now fails to function as any connected device
fails any reg read/write. Reduce this to 64K as it should be more than
enough and 3 * 64K of total IO space doesn't exceed the IO_SPACE_LIMIT
hardcoded for the ARM arch.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index e247bf51df01..36bdfc8db3f0 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -918,7 +918,7 @@ pcie0: pci@1b500000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x0fe00000 0x0fe00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x08000000 0x08000000 0 0x07e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
@@ -969,7 +969,7 @@ pcie1: pci@1b700000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x31e00000 0x31e00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x2e000000 0x2e000000 0 0x03e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
@@ -1020,7 +1020,7 @@ pcie2: pci@1b900000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00100000   /* downstream I/O */
+			ranges = <0x81000000 0 0x35e00000 0x35e00000 0 0x00010000   /* downstream I/O */
 				  0x82000000 0 0x32000000 0x32000000 0 0x03e00000>; /* non-prefetchable memory */
 
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

