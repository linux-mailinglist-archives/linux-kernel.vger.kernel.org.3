Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BB74BAE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiBRAbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:31:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiBRAbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:31:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA40975C19;
        Thu, 17 Feb 2022 16:30:45 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i14so11727896wrc.10;
        Thu, 17 Feb 2022 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4j5HXvTwEBrqBc+6y0WS7fJHWujyLf/r9OKfZSJite0=;
        b=SYqw17nILxqurV7i2g//aeC/EYFOYGCQwLdqUnJWssBH03Trve1e4D0ahsKEeFmBeu
         ocQ4N/XCsfGM+mDQ1M62NRB1JiEBqhTEIqeCBWnDl2pjuzq7InC86zL5NVf6ftPqvfbI
         j97FS5nwGCwq1dpIavhQqmyn6GldiTNHEHuDA7LrhdV/aHpJ3mTflyD2cz/X+8qi6lt5
         tuRlvNiQEp1ZbuGpo2FWZykeaMA3jOqgkBeFfkURKwxwD17iTWUaO+KeKegmS4hCiISK
         J9K8hz11EbuOSZZpF4hE6Mmep1QyTKq6YU6d8eIF06kq51Aor3gln3zJid3h9qX9Bu9y
         vwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4j5HXvTwEBrqBc+6y0WS7fJHWujyLf/r9OKfZSJite0=;
        b=4NsIQJc6oG4+SYJoQ05yiGBFYrfKdHMHO5pPMI61EAQzu+d7p+pBGnhl+Pe9SxDC3O
         bDdKEpTh/Y03qkqUDNGpqSi5ROHdq3xaTIgNsCd3xfXiEOpvcex1Y8PzoLKMXjkus29A
         3+PzPwUkU/cxGhRnMKpMg0WxzYIvZ/apQhv0Stxy44ZqTveAdCU7ysVYack07chJ85FK
         UXKyyLzhbCkdCOhYxZziKx++4TAbYuQH4OsJ2j56NSty+4m775TWf2r00Wr558aAnvfW
         lO4lgp3L958ZGJbZJ162+HLT26QKQyUiStaTTMZNDtCSAS69DvS6vCgDZTzN0dnz8l1E
         QBZg==
X-Gm-Message-State: AOAM531Xf6QSZPXVwb8YAzhJBSxwdO+tVt3OdA71wJz2kLqQlnZuHw/Y
        PwK5+9UcTxAkKDe1qJcxSXg=
X-Google-Smtp-Source: ABdhPJz7XV2WjbHfF5lLSWG7Igys7ojnDTcTkhxZYfqBqpROz+2ka8wIMq/VLPDuNf3PEDSredES+Q==
X-Received: by 2002:a5d:5885:0:b0:1e8:edbf:2d07 with SMTP id n5-20020a5d5885000000b001e8edbf2d07mr3293277wrf.85.1645144210750;
        Thu, 17 Feb 2022 16:30:10 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:10 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 16/18] ARM: dts: qcom: remove redundant binding from ipq8064 rb3011 dts
Date:   Fri, 18 Feb 2022 01:29:54 +0100
Message-Id: <20220218002956.6590-17-ansuelsmth@gmail.com>
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

Mdio0_pins are now declared in ipq8064 dtsi. Usb phy are enabled by
default.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index 0982b6214fb7..ddc9cc49ab60 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -259,10 +259,6 @@ &gsbi7_serial {
 	status = "okay";
 };
 
-&hs_phy_1 {
-	status = "okay";
-};
-
 &nand {
 	status = "okay";
 
@@ -309,15 +305,6 @@ mux {
 		};
 	};
 
-	mdio0_pins: mdio0_pins {
-		mux {
-			pins = "gpio0", "gpio1";
-			function = "gpio";
-			drive-strength = <8>;
-			bias-disable;
-		};
-	};
-
 	mdio1_pins: mdio1_pins {
 		mux {
 			pins = "gpio10", "gpio11";
@@ -358,10 +345,6 @@ mux {
 	};
 };
 
-&ss_phy_1 {
-	status = "okay";
-};
-
 &usb3_1 {
 	pinctrl-0 = <&usb1_pwr_en_pins>;
 	pinctrl-names = "default";
-- 
2.34.1

