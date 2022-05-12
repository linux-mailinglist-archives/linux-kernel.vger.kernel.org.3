Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A31524D80
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354027AbiELMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353998AbiELMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:49:32 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F724EA3A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so10025499ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtfJqDS+4XXgrs5gmHjTVbohIpUyumGa7vczR+1IPgQ=;
        b=okxummRYoYmm3mndr4IQ4mgnv150u1olNX74O7biUh+HrNqMKUVuUqAIzcm/QxtJTg
         q/Wppj3fEdtm4aHOGPk4dQedpaKJzGP/07VYffXkh6ial1HBi6dxX/tSmMC3X98lNr/E
         6fo4ablNWe2hi3uLO6m1lNGDioa303lXvjye1sjYFXCltiBp9kk/QjxtYSBTAp+1LAvX
         B5z2eHs6kwZ0vXEUsFybyBhskYWK65mVnxJE0a8brcOCFwMFI8Zq28j3jNcdYj1DG7zO
         /0hn8dRwmcTPOnzs65HkH2IzTWoz9FkvBaGkZWjc7FUuteGlXfMYG8b4BOFVokQY4XRK
         Nftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtfJqDS+4XXgrs5gmHjTVbohIpUyumGa7vczR+1IPgQ=;
        b=v2/dVq5L/D+cMJZ8U+YSUhTFOoWGQ9Zcgk3RMmKLDTPBUEhOR3UDAXJSve8OJPqame
         EwnRcosSm2kiqgJt/tM5Ew8d+p8HpR3Gnx0CINdBiBm5tYpBJZIGjAflk1iEi51WDrwc
         7E6VBVwqZrlpZdNT6GPxhggnI4AVZuXRIXJaeFFRbKvybaE8StS5kT1NvCRtPX7lzQ5U
         RFsIpfpyqGxWSYMl27i0y3u7KOGncpAAbdm+aIdwdyioAp0rZE8x3wce6U1wK30eOZOx
         IO+Hbw+uG5DKsBkZE08XCtjxQXeSAFp43AtoaZCCE4TIQ6e1TJjz+IDST2yjskX4ZiFk
         nZNQ==
X-Gm-Message-State: AOAM530prfKLBlPRiwvxUK2Tvr0yox+C2FFBrL/duil9ZEEXqikcO9XF
        BneJiv6KmVxl+492KS/GV8Tfkw==
X-Google-Smtp-Source: ABdhPJx6hUgrDA/sPEgXzBnUZI+wl8Y+4ZV8GUq0JQoFPJlaV4kfSgX/xPyQM3zp8YMWYBx0k8cbVQ==
X-Received: by 2002:a17:906:6a28:b0:6f4:d368:ccf1 with SMTP id qw40-20020a1709066a2800b006f4d368ccf1mr29868611ejc.35.1652359767733;
        Thu, 12 May 2022 05:49:27 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-58.xnet.hr. [88.207.98.58])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170906828300b006f3ef214dc2sm2109475ejx.40.2022.05.12.05.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:49:27 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 11/11] arm64: dts: marvell: add support for Methode eDPU
Date:   Thu, 12 May 2022 14:49:05 +0200
Message-Id: <20220512124905.49979-11-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512124905.49979-1-robert.marko@sartura.hr>
References: <20220512124905.49979-1-robert.marko@sartura.hr>
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

Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.

They feature the same CPU, RAM, and storage as well as the form factor.

However, eDPU only has one SFP slot plus a copper G.hn port.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Changes in v2:
* Make the DTS split a separate commit
---
 arch/arm64/boot/dts/marvell/Makefile             |  1 +
 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 1c794cdcb8e6..104d7d7e8215 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
new file mode 100644
index 000000000000..57fc698e55d0
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "armada-3720-uDPU.dtsi"
+
+/ {
+	model = "Methode eDPU Board";
+	compatible = "methode,edpu", "marvell,armada3720", "marvell,armada3710";
+};
+
+&eth0 {
+	phy-mode = "2500base-x";
+};
-- 
2.36.1

