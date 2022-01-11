Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046E648B0B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244017AbiAKPWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 10:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiAKPW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 10:22:28 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF8C06173F;
        Tue, 11 Jan 2022 07:22:27 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g11so57587010lfu.2;
        Tue, 11 Jan 2022 07:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cncrSO47/dxTzJw3Hb5sh69Ee7OGFih0UXbfWgWwSJM=;
        b=INzUaxbs+mQkRHXZ3Rm8t5IcTWwb7Ttgsd2lsFxj+3puCEgShGJ0o5N8h+LeD5oqs6
         BXj7XrJsHA7hYzT7uvnh/FUw8AMAeR0ojO21krTbQBXET4hJW6vN8NEgB4jA6LxpgrDp
         T+68zNf/+79dLsXrgzXERjegzbxSyOfhrgt6am4M1Ch0AR6r1pMeGopdqiUiTh2z2mP1
         NZ7tg485kbdCj0u47JspHihG6tsi51a/xU1hlomF4Ye97TFDRGFa2MtP2Gab5YMC/rOc
         V4ikzOuYRM7AHIxYfrLRKkqCaaKtM+1Cm1Wl/K/ougAKzo56p80a1iyLRoWhoIRd8f0y
         39og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cncrSO47/dxTzJw3Hb5sh69Ee7OGFih0UXbfWgWwSJM=;
        b=Q4sydZaE8iojAQvSVHYF/4vUiuPPa1iNzw5ThSiZeg/MKYbGlpwuJU9bhdCEG9GH4V
         ZlL/44D9iS5r3KvFwVUFolACR/2EbF384bzdWX7kelTkPiyFEwlNkvyNrbqyYhIBmAUZ
         fJ0qKNkX9NJk3RNkW9iGoy5AUY1oixAf61aeirH2V2G48U3msfUQoFqokejkQG80QRm6
         c7/jORh9aer8d2cGfB9BCKb2tasPC/k126dYuzoDhXQtA0NjeDbwzd0OpD9v/YddiWXc
         xlaNI7iQg1R3QylSgrSo6tHwAiOfd5kSrfXsQGPEMwvawVpBlpuH6kfMMjJtm+ONoZ8C
         y2Pw==
X-Gm-Message-State: AOAM532522NvbSKoQO86/DWbChBn6+mG0FFaNfu6liXe2hvf6ae74hiA
        76HtlrCEvm4xqbnTCQjAfhCOokHoXJoj/A==
X-Google-Smtp-Source: ABdhPJxX/U3rRogB45yH/QpmqrxN1k+9JvMQn9qTByOMINqb/Vp4CeaQ2UCpubIXd5aMyGDnZ207KA==
X-Received: by 2002:a2e:a16f:: with SMTP id u15mr3225184ljl.510.1641914546089;
        Tue, 11 Jan 2022 07:22:26 -0800 (PST)
Received: from localhost.localdomain ([185.6.236.169])
        by smtp.googlemail.com with ESMTPSA id bi16sm1363069lfb.81.2022.01.11.07.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 07:22:25 -0800 (PST)
From:   Maxim Kiselev <bigunclemax@gmail.com>
To:     vladimir.oltean@nxp.com
Cc:     andrew@lunn.ch, benh@kernel.crashing.org, bigunclemax@gmail.com,
        davem@davemloft.net, devicetree@vger.kernel.org, fido_max@inbox.ru,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, paulus@samba.org, robh+dt@kernel.org
Subject: [PATCH] powerpc: dts: add device tree for T1040RDB-REV-A
Date:   Tue, 11 Jan 2022 18:22:04 +0300
Message-Id: <20220111152204.3524442-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111131355.djuyn6bbirqtsama@skbuf>
References: <20220111131355.djuyn6bbirqtsama@skbuf>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On board rev A, the network interface labels for the switch ports
written on the front panel are different than on rev B and later.

This patch introduces a separate device tree for rev A.
The main device tree is supposed to cover rev B and later.

Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
---
 arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts | 185 +++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts

diff --git a/arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts b/arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts
new file mode 100644
index 0000000000000..f74486ba1d45f
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/t1040rdb-rev-a.dts
@@ -0,0 +1,185 @@
+/*
+ * T1040RDB Device Tree Source
+ *
+ * Copyright 2014 - 2015 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *	 names of its contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/include/ "t104xsi-pre.dtsi"
+/include/ "t104xrdb.dtsi"
+
+/ {
+	model = "fsl,T1040RDB-REV-A";
+	compatible = "fsl,T1040RDB-REV-A";
+
+	aliases {
+		phy_sgmii_2 = &phy_sgmii_2;
+	};
+
+	soc@ffe000000 {
+		fman@400000 {
+			ethernet@e0000 {
+				fixed-link = <0 1 1000 0 0>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e2000 {
+				fixed-link = <1 1 1000 0 0>;
+				phy-connection-type = "sgmii";
+			};
+
+			ethernet@e4000 {
+				phy-handle = <&phy_sgmii_2>;
+				phy-connection-type = "sgmii";
+			};
+
+			mdio@fc000 {
+				phy_sgmii_2: ethernet-phy@3 {
+					reg = <0x03>;
+				};
+
+				/* VSC8514 QSGMII PHY */
+				phy_qsgmii_0: ethernet-phy@4 {
+					reg = <0x4>;
+				};
+
+				phy_qsgmii_1: ethernet-phy@5 {
+					reg = <0x5>;
+				};
+
+				phy_qsgmii_2: ethernet-phy@6 {
+					reg = <0x6>;
+				};
+
+				phy_qsgmii_3: ethernet-phy@7 {
+					reg = <0x7>;
+				};
+
+				/* VSC8514 QSGMII PHY */
+				phy_qsgmii_4: ethernet-phy@8 {
+					reg = <0x8>;
+				};
+
+				phy_qsgmii_5: ethernet-phy@9 {
+					reg = <0x9>;
+				};
+
+				phy_qsgmii_6: ethernet-phy@a {
+					reg = <0xa>;
+				};
+
+				phy_qsgmii_7: ethernet-phy@b {
+					reg = <0xb>;
+				};
+			};
+		};
+	};
+
+	ifc: localbus@ffe124000 {
+		cpld@3,0 {
+			compatible = "fsl,t1040rdb-cpld";
+		};
+	};
+};
+
+#include "t1040si-post.dtsi"
+
+&seville_switch {
+	status = "okay";
+};
+
+&seville_port0 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_0>;
+	phy-mode = "qsgmii";
+	label = "ETH5";
+	status = "okay";
+};
+
+&seville_port1 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_1>;
+	phy-mode = "qsgmii";
+	label = "ETH4";
+	status = "okay";
+};
+
+&seville_port2 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_2>;
+	phy-mode = "qsgmii";
+	label = "ETH7";
+	status = "okay";
+};
+
+&seville_port3 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_3>;
+	phy-mode = "qsgmii";
+	label = "ETH6";
+	status = "okay";
+};
+
+&seville_port4 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_4>;
+	phy-mode = "qsgmii";
+	label = "ETH9";
+	status = "okay";
+};
+
+&seville_port5 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_5>;
+	phy-mode = "qsgmii";
+	label = "ETH8";
+	status = "okay";
+};
+
+&seville_port6 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_6>;
+	phy-mode = "qsgmii";
+	label = "ETH11";
+	status = "okay";
+};
+
+&seville_port7 {
+	managed = "in-band-status";
+	phy-handle = <&phy_qsgmii_7>;
+	phy-mode = "qsgmii";
+	label = "ETH10";
+	status = "okay";
+};
+
+&seville_port8 {
+	ethernet = <&enet0>;
+	status = "okay";
+};
-- 
2.32.0

