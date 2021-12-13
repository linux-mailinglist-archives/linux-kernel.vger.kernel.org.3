Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED96A47367D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 22:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbhLMVTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 16:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbhLMVTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 16:19:10 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9CEC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:19:09 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m6so21506677lfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 13:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zUxwvp9vYwyJcQZmzhjmfM3rufvm3bxRQemKOq+WF8Q=;
        b=BepgohHib2ilglMUKoAF4i0Q9de8231SPgv/vmLejAwIRYhRCHc1MRBhI2mBOVtely
         xhZYEjEsNhFtz5WxStJrHyCJZPjIQO8FVHAp9m3vBtIDwMWLzETMOm8Q9ShsC5LktX/0
         x4p5xyOkT2KlvcQHrwN9a9KE0KO0tsPKk9RvAKT4pt/F5o1elW9AxFMN9MdJgKVthKTl
         F2TR09q0pXdsRtjJR+P9CgXFg5U9/MNmw67+mpcxuDLECZm/Wep4X6MbesxC9SEPs6IU
         lJIgOzLBnvLtMOzhIsu+RwKOxLp364zpJ7bxGLp6AERqzdBXAasg6gF/kRUvRyuVlLZD
         wT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zUxwvp9vYwyJcQZmzhjmfM3rufvm3bxRQemKOq+WF8Q=;
        b=BiOW37Z1ncKBDnLKgxBFUSCGuQJT5UHGiSeJQX/FUgGZCebW/t6Ov9d6d94fP7UNCa
         47CqMIShJ0B6oDaDdKPui8q+eDWRsJ0ouHoZrUG4Q7awLh8aOo/XOt0mKbYPvPCWOQdR
         h29NlfEZ6WMLzsetxC+UxgTpJzvtnpa0mtm4BLgPLyZSZJcaZWtD2J6Ce74im8vDuz/I
         ltif9L8gDJy8aUdaiExIKlwwoxQxik4OtV5TfR+O6+kP+y7HRzN0KMUN74KFGE1hwFek
         s3OfRh57FW5H68R9x6cH82hPtrq7/A/I3h0pO2yTiJDq1DeM7s2ls4XSAFcZdb325lAu
         oW3Q==
X-Gm-Message-State: AOAM5322QCyQ5AODgWzAr/LbD2ZhCme7sVEzswvSBee6yDpAbT9bdO1F
        y2Iy+eDfJ0JatNrsjOAyv2LCDA==
X-Google-Smtp-Source: ABdhPJw1q7FMK03KgySTCBv1JP8ARKdSQFa+PNCLG7CJSlWWm8Rm4MGVvbfvJnDdFOOgJ5lhfPLffg==
X-Received: by 2002:a05:6512:12c8:: with SMTP id p8mr790416lfg.69.1639430347911;
        Mon, 13 Dec 2021 13:19:07 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id f35sm1567100lfv.98.2021.12.13.13.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 13:19:07 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] arm64: dts: renesas: r8a77961: Add lvsd0 device node
Date:   Tue, 14 Dec 2021 00:18:55 +0300
Message-Id: <20211213211855.1052211-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing lvds0 node for the R-Car M3-W+ SoC.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm64/boot/dts/renesas/r8a77961.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
index 86d59e7e1a87..d324dfd0d1f7 100644
--- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
@@ -2718,6 +2718,33 @@ du_out_hdmi0: endpoint {
 				port@2 {
 					reg = <2>;
 					du_out_lvds0: endpoint {
+						remote-endpoint = <&lvds0_in>;
+					};
+				};
+			};
+		};
+
+		lvds0: lvds@feb90000 {
+			compatible = "renesas,r8a7796-lvds";
+			reg = <0 0xfeb90000 0 0x14>;
+			clocks = <&cpg CPG_MOD 727>;
+			power-domains = <&sysc R8A77961_PD_ALWAYS_ON>;
+			resets = <&cpg 727>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					lvds0_in: endpoint {
+						remote-endpoint = <&du_out_lvds0>;
+					};
+				};
+				port@1 {
+					reg = <1>;
+					lvds0_out: endpoint {
 					};
 				};
 			};
-- 
2.30.2

