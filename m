Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8EF349138B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244267AbiARBiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244044AbiARBiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:14 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1776C061574;
        Mon, 17 Jan 2022 17:38:13 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 15so39678348edx.9;
        Mon, 17 Jan 2022 17:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7OEXPaorzPX6/OWjLiW6YLyF6RH1B/DBM1qZbPBHMk=;
        b=iu2Dtg4dAWHSWaV+x+m/sadGp9n2nQxiGg+O2XcThlH0M7fga8J7D1D6ouBKoyjhBR
         FQkRwhm3eeXuEipO6DsIvWjCWJdHTIOWr9SksgybFAKPDWbSQ2QHYXtEEXEGp4KwSPTM
         +szpLqsZOdWqKlRe43/stKpxsaGUwHU5cVv9MBV3TfXrRK/pdXihcxAp/7Ti7WIBr+t6
         CYTG7s5Ku00Q3t7HbJ3hTzVMk3KAeaTVaPbvYYzL3knrHMnaHZr9i4NplshQT7fIzclO
         7C/akzNwiCA0ZxBFBQ9b221rfhXUNU2MOp5HBBXaX+NwzgYT1EjN4VwpZPOS4vuVloZx
         6VNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7OEXPaorzPX6/OWjLiW6YLyF6RH1B/DBM1qZbPBHMk=;
        b=S9gmfzR0NfxIi5n/drzJ+/O3DKTxmriSYZZXoGi0yfm2sdX+pJUVd7VNXc05trHOTC
         mwXzi4Bmol/Lv4Fwl/gu499DoDzKpGkyZeWAMF4gpjyCoCEXanPB2/cytGZQSDFSnSBJ
         CRkwsAWfJxvwB2DmD15cI5EZBhGTp+CDDIy+TS6vWNTAk3uphRdzTOqLsdmyIuzJUc8l
         XN5NXFLiEUWF8LESPYt5DKQuOTuPAlx00wyXDC+vhd8xr/zseaLZrE04p2LmcN90XNp9
         Yed1UeUSuAFXQyJDmX+t25e80yoZMWP/DQDYpsA7QmDzZfpZg7vjfIweIMuUTpjQXD2q
         d8sg==
X-Gm-Message-State: AOAM5312w6jmMsSfykrXtCw5mCCBu7XzmaZTLpYlEed595FVJNqrK5wg
        fZcVbuNZitKBy34bVl7sJA4=
X-Google-Smtp-Source: ABdhPJxpDCUkKC3vu8StLJLAYvV1xJth/QJFdT1nv6qJ9mPpSnnfUYgfNHJj/uIz/FAzlQKZ/5zzEg==
X-Received: by 2002:a17:907:1dca:: with SMTP id og10mr100729ejc.597.1642469892403;
        Mon, 17 Jan 2022 17:38:12 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:12 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 03/17] ARM: dts: qcom: add missing rpm regulators and cells for ipq8064
Date:   Tue, 18 Jan 2022 02:20:33 +0100
Message-Id: <20220118012051.21691-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cells definition for rpm node and add missing regulators for the 4
regulator present on ipq8064. There regulators are controlled by rpm and
to correctly works gsbi4_i2c require to be NEVER disabled or rpm will
reject any regulator change request.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 35 +++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 094125605bea..824cf13dd037 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -829,10 +829,45 @@ rpm: rpm@108000 {
 			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
 			clock-names = "ram";
 
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			rpmcc: clock-controller {
 				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
 				#clock-cells = <1>;
 			};
+
+			regulators {
+				compatible = "qcom,rpm-smb208-regulators";
+
+				smb208_s1a: s1a {
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1150000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s1b: s1b {
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1150000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s2a: s2a {
+					regulator-min-microvolt = < 800000>;
+					regulator-max-microvolt = <1250000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+
+				smb208_s2b: s2b {
+					regulator-min-microvolt = < 800000>;
+					regulator-max-microvolt = <1250000>;
+
+					qcom,switch-mode-frequency = <1200000>;
+				};
+			};
 		};
 
 		tcsr: syscon@1a400000 {
-- 
2.33.1

