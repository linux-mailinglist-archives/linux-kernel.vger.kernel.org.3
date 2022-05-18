Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3905252C6A7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiERWxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiERWxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:53:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C6A14C76D
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:52:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id bh5so3151546plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89xJl/5AucW2svLYY82lzLas3d/413S0Fsu8gNXuG9M=;
        b=BrtidlQe1FgptHjDWtJaGPrkEPtqkg0V2+26eRRvqBzgrLI/Xk3q2SRVlhKFUw3czv
         ripjKhwfJzjJIGYlDMW15Yy+CMkyvuB13oJ8RDgbHk04q67vPa4HW0QR7ZUbiWU8NFGe
         XNS0fCL9ZiPZayBM5GdFmA67fj4XhRGF4E/ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89xJl/5AucW2svLYY82lzLas3d/413S0Fsu8gNXuG9M=;
        b=DtlpNt0CfvlfFdI0ox/d/vYhAVFJPgRckDFJ2cEqmZfQTzlJk6OYNigyU+bEf0C+1k
         mSjRGxydMh4ZFSSncZ76aI/Tjc8nqw+JnXz+EMUWflrE7pgUSoqVLh3WjGRWsHcCaS+M
         po3N3ipz3rgxv1vaX2oKPcSdxvZlRhinwnvOESJvVIk9gb2+fPH2V6O78Ekrc7XoeJ0b
         RUHBXw80ezioUQqV9nPcPNyXRD5bUmB5WEYMaRDu3CJGkPHjimUfE3aUhd9nDDTxVSj6
         nbz4ji1kCfb2J6hUSwnrq7IwrRlnAiMxSEVEnsnK50DJUrzw6rhXZU2B4f/5mP9/Vd+q
         QOyA==
X-Gm-Message-State: AOAM5334a7JxLAmckrUL3OK4eQrPftgV/RV8ILtTBMtMj0ee3qD/kLGF
        PZ+SWM8JdMmhszZnHiZINSFRYg==
X-Google-Smtp-Source: ABdhPJxGXJRcQd8UATDMy3zIg1etHJVVL5FlHgTkB/BAVp75YVd/+bX2Pn+xzQclDoPUJolDy6VxMQ==
X-Received: by 2002:a17:903:1c6:b0:161:9fbc:5a6 with SMTP id e6-20020a17090301c600b001619fbc05a6mr1787688plh.65.1652914378674;
        Wed, 18 May 2022 15:52:58 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e229:79ea:227e:d9dd])
        by smtp.gmail.com with UTF8SMTPSA id w26-20020a62c71a000000b0050dc7628167sm2490226pfg.65.2022.05.18.15.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 15:52:58 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, Kevin Lund <kglund@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7280: Enable wifi for Chrome OS boards
Date:   Wed, 18 May 2022 15:52:55 -0700
Message-Id: <20220518155252.1.I176d4254c79cfaafa38cbe36f066f02f819df9b6@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 'wifi' and 'remoteproc_wpss' nodes for all sc7280
based Chrome OS boards. Delete the corresponding entries from
sc7280-idp.dtsi since this file includes sc7280-chrome-common.dtsi.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 11 -----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index 9f4a9c263c35..0002e389bbe2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -91,7 +91,20 @@ &remoteproc_mpss {
 	memory-region = <&mba_mem>, <&mpss_mem>;
 };
 
+&remoteproc_wpss {
+	status = "okay";
+	firmware-name = "ath11k/WCN6750/hw1.0/wpss.mdt";
+};
+
 /* Increase the size from 2.5MB to 8MB */
 &rmtfs_mem {
 	reg = <0x0 0x9c900000 0x0 0x800000>;
 };
+
+&wifi {
+	status = "okay";
+
+	wifi-firmware {
+		iommus = <&apps_smmu 0x1c02 0x1>;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 5eb668991e24..9cea8fc7ff8b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -560,14 +560,3 @@ sw_ctrl: sw-ctrl {
 		bias-pull-down;
 	};
 };
-
-&remoteproc_wpss {
-	status = "okay";
-};
-
-&wifi {
-	status = "okay";
-	wifi-firmware {
-		iommus = <&apps_smmu 0x1c02 0x1>;
-	};
-};
-- 
2.36.1.124.g0e6072fb45-goog

