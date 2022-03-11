Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8794D5E97
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347633AbiCKJjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347602AbiCKJjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:39:19 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A6BE0A25;
        Fri, 11 Mar 2022 01:38:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gj15-20020a17090b108f00b001bef86c67c1so7685441pjb.3;
        Fri, 11 Mar 2022 01:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iXKoOhJsegCgBWbpQZaKhqPFw+9/pc6YzaaD+yCqeLI=;
        b=NsC6TSNJe603PGQnszA9PJacCMKoaSa4T+QzSVMgCch1XLq/wM0zgoP5qL9XSpBxi4
         AQQV+E8zoKJfPg9NTqIAV/TCByvxBF69OxWRZx4U03ja2g14truZBU26BxBemicDq9hb
         8h8iLE6rXHd4UHx24a4c3q7QzfT+6wuX1eW7Jbh0ljsVBK0MRwuEEWwC1awFCJKMAfmQ
         nDbSx4ni2i7Xij5u5crvpcjpFUkg1QQJW4ceV6WuGs5xbsuqP6dJPnfAinU4VrjzbP+9
         yivy2AzAliFv3qvnUdv01GAn4yIFek8TW3jyIJ6aTou9YlsguJy8hR3aeabSYOolieoY
         BNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iXKoOhJsegCgBWbpQZaKhqPFw+9/pc6YzaaD+yCqeLI=;
        b=fsImKXXZF2lGkovoDOMvgUE2cuCSvbcClhPtHmYCNVg5QOTO1WbAW0wnV6GMTuWzeM
         EV+ywvMwmtvxelCdB962rBv55UZXQfrOXfHZOHigl70kiJtaqjP3Shvlus+MWPjTOvCa
         eyf1xT3pPriGjrrEyzOx0OTwkU65ZkgkZqN+itu+EJoW3HjKYqkMC9TBgz092B3sTxAp
         /q3vhNS8WMcU7FPmxzWhfRSV4jnlNesvzg8F0DApvM/ZfRGHlheU5O51bSED0k8xittN
         oOxf7arXUtv43KMkRJKRMKCNSR9VSTqkce0gd6qWo2x+H2NfpiEl7L15IrzfyIEzH4O9
         MlRw==
X-Gm-Message-State: AOAM533r3OxfAixXWJMtafN+EvUna5cchnL74ISPbsEtEEzgiQGb8vBv
        sxqNqaGdG+kc9IdrxFic0eqrys3dNiMsgw==
X-Google-Smtp-Source: ABdhPJxOwlYZb3pZsNu37/YVDoq39syQkU+41qFjqS4cko1TODNhT00GBLVx5sFkgiyJynay7J/jBg==
X-Received: by 2002:a17:90a:d3d3:b0:1bf:2e8d:3175 with SMTP id d19-20020a17090ad3d300b001bf2e8d3175mr10011200pjw.2.1646991493353;
        Fri, 11 Mar 2022 01:38:13 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f75d5f9b5csm9011011pfk.26.2022.03.11.01.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 01:38:13 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Chanho Min <chanho.min@lge.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] arm64: dts: lg131x: Update spi clock properties
Date:   Fri, 11 Mar 2022 15:07:59 +0530
Message-Id: <20220311093800.18778-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
References: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
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

PL022 binding require two clocks to be defined but LG1312 and LG1313
platforms don't comply with bindings and define only one clock.

Update spi clocks and clocks-names property by adding appropriate clock
reference to make it compliant with bindings.

CC: Chanho Min <chanho.min@lge.com>
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
- Resend to soc ML
- Add Rob's acked-by tag

 arch/arm64/boot/dts/lg/lg1312.dtsi | 8 ++++----
 arch/arm64/boot/dts/lg/lg1313.dtsi | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index bec97480a960..e4de0f98c685 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -172,15 +172,15 @@ spi0: spi@fe800000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe800000 0x1000>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		spi1: spi@fe900000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe900000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		dmac0: dma-controller@c1128000 {
 			compatible = "arm,pl330", "arm,primecell";
diff --git a/arch/arm64/boot/dts/lg/lg1313.dtsi b/arch/arm64/boot/dts/lg/lg1313.dtsi
index ada3d4dc6305..873baae75035 100644
--- a/arch/arm64/boot/dts/lg/lg1313.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1313.dtsi
@@ -172,15 +172,15 @@ spi0: spi@fe800000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe800000 0x1000>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		spi1: spi@fe900000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x0 0xfe900000 0x1000>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&clk_bus>;
-			clock-names = "apb_pclk";
+			clocks = <&clk_bus>, <&clk_bus>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 		dmac0: dma-controller@c1128000 {
 			compatible = "arm,pl330", "arm,primecell";
-- 
2.25.1

