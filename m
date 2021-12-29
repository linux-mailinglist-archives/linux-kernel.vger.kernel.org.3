Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48648159D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbhL2REo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241032AbhL2REe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:04:34 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E06C061748
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:04:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w16so88570049edc.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 09:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tRa41Q7YmcA2jiHokzQD85AZtD/jes1qyk4BowEUlZs=;
        b=4Kb5/y5pLN+ryu5bSVC8Ndy3/d2PIad+2guuviQIYuJUuvp+znx9xO1R1OZaoIKVWi
         ZFWRd+/lfmDC9lERmavU3s5XkILb+b/XK67O8VQwn1AwKc3w05VVpsHJuOWUg6mKkrrD
         /JD0Wap1jUlZy87MWPjv7/bpVJ/v+V4c5dpluhLXM7nfTAP17g/l3+eNH38sH+FtaB9s
         zoNi+x4AWVsJZ8QvaoAD9FF0chiRXERBCh/Jp+S23wIeaMRH62oPFnLFYQ3U4wKJetsm
         XRfEDYdWr67UJx3YMmjToZzqMkFV+0B0u1Iclc9uoO08+Js0+NffwGj8B0EP71zzZat1
         /PNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tRa41Q7YmcA2jiHokzQD85AZtD/jes1qyk4BowEUlZs=;
        b=aEg+DMaGgIdhiKVV96AGCQytWA6mtChnGBIW+lY3Z6UM4YiIuSIhhETaAJYSfSFkDG
         wbUlbmbzVZ6O4UuSAPa0U4LUsBcCWR7rPzvtqnLi2vrNg26Wb/NRvbpvxA6UWYVrX9ig
         syAk71XC3zVwddpieKTB+/R6jNKIMKgqgBHLHZXNOxMJjKt6U/kVnGXQG5L33x52cxQn
         Fgg5CES0qZEKaK7tsXQwJGEkkolpQOSNec3dHfLz8Uov6HZhoWFFbzfNE5pwKTYqWTgI
         BIV4E3KRMDL7kAH7iuF8vkzGMrwOyiYxrnnH4MjTt49yoUIYbJRq7dSTH4DcGub2a3/V
         E0Fg==
X-Gm-Message-State: AOAM530/Wb8eaXMOe/WE8hIg65AMvxNJLbCJSK3faQB7J/BWnTA7ASoV
        V6BV+gXphuoHfUBG8uUBSzdWiQ==
X-Google-Smtp-Source: ABdhPJx2nYgUSU+x3h23MRcMcRC1dXlEaTzi9l4EqBY+DCAX7wN++gN2yZhEl6nn2gce9PmI5GFSyQ==
X-Received: by 2002:a05:6402:35c2:: with SMTP id z2mr27185785edc.43.1640797472546;
        Wed, 29 Dec 2021 09:04:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id w11sm8546153edv.65.2021.12.29.09.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 09:04:32 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: qcom: pm6150l: Add wled node
Date:   Wed, 29 Dec 2021 18:03:57 +0100
Message-Id: <20211229170358.2457006-4-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229170358.2457006-1-luca.weiss@fairphone.com>
References: <20211229170358.2457006-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLED is used for controlling the backlight on some boards, add the node
for it.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm6150l.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index 3ca2860bb0cf..7aa2ef90cb6a 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -52,5 +52,15 @@ pm6150l_lsid5: pmic@5 {
 		reg = <0x5 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pm6150l_wled: leds@d800 {
+			compatible = "qcom,pm6150l-wled";
+			reg = <0xd800>, <0xd900>;
+			interrupts = <0x5 0xd8 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp";
+			label = "backlight";
+
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1

