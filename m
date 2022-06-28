Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2694C55E3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbiF1Mpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345532AbiF1Mp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:28 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C6522B0E;
        Tue, 28 Jun 2022 05:45:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fi2so25489528ejb.9;
        Tue, 28 Jun 2022 05:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4lchPYP/IyiWYBGbhJ8z0BxhrlEHqQ8KwuAEVEe5qTk=;
        b=FI9azK4scCMVGjJ5RzqsXlmja0FGvySyeKsvw6EkplLZ0r1jZjFRNKW6WMPun+RQvw
         MWelRC3NRNy9F1p2TrlGm+65fFTZLKHnY7DGNYgRnfYF8Z3btEnCj8dMFfEmDq3wEMwO
         25xzTGyUpwSfo5j/Fe3YUUaLJXsJGjILD+/PGtleqYbE0EFthANq8x8azTeOb6YYUtRg
         pMh9029N5PxDBc/PT/CKRoi6sWRiXw+6GLfuZxMqAR56gTGBCMTdTQrWj6lr62ad2djU
         nip7s+OjWo/NIGcU9obly5d0L/RyXsZLZ8dIU4NFBqYWjnrmdPqc0Km3M+r+2HxKHphj
         qtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4lchPYP/IyiWYBGbhJ8z0BxhrlEHqQ8KwuAEVEe5qTk=;
        b=RGWl1ABuaXpFdkiRGsbqKRpAHl5c4uEG5N35dVqA3VIeAcwEIE3xXqpWrmXlGw2iax
         Ye6K3gDnZLfrjbfjuSPJF2NFA9tp/peVVA7VHfgDehKSaexVSld6Wi+rHh04R9H3eHoN
         sOO92pm9Ymh6Q4JQsRxH5+uI1ZeatIhEBc22Gqb8jE03mRnPFVJXBaUCjRQLxJjzPjXh
         2nLvIhWRO+Y+ba0YUXtarieUG3ni+mg5PCy2tUNZMOzY2fOp6YivnJZt0EazuZKZrLQe
         WHT8wtfbP38L4SUOQUH+ZPJVsEBOAkGhs5rkmp65QM1Cvz3tjw9TurS6G0eHsbbnzE3p
         D8mA==
X-Gm-Message-State: AJIora8Heseg6v90NVWzFyDpHL114FSbaDPQn5dILcVU1S3XjuuJFinC
        l3m14WtPOtL8QxrNI4gl5d09wHOWC2c=
X-Google-Smtp-Source: AGRyM1tUbRD9qAr2Ml1BZh/r3lbTY8/lgIU0dZECXsAOpJChKuAGiAEdUiE1r2GCtLi2Zp6IbygNNQ==
X-Received: by 2002:a17:906:7482:b0:722:ea8f:3a12 with SMTP id e2-20020a170906748200b00722ea8f3a12mr18125775ejl.220.1656420325113;
        Tue, 28 Jun 2022 05:45:25 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm622871ejx.173.2022.06.28.05.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:45:24 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, rtanwar@maxlinear.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 9/9] mips: dts: lantiq: Update the RCU node to match the intel,rcu-gw binding
Date:   Tue, 28 Jun 2022 14:44:41 +0200
Message-Id: <20220628124441.2385023-10-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
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

Use the updated compatible string and also add the USB2 PHY child node.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/mips/boot/dts/lantiq/danube.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
index 510be63c8bdf..8ac806662083 100644
--- a/arch/mips/boot/dts/lantiq/danube.dtsi
+++ b/arch/mips/boot/dts/lantiq/danube.dtsi
@@ -57,8 +57,26 @@ cgu0: cgu@103000 {
 		};
 
 		rcu0: rcu@203000 {
-			compatible = "lantiq,rcu-xway";
+			compatible = "lantiq,danube-rcu", "simple-mfd", "syscon";
 			reg = <0x203000 0x1000>;
+			ranges = <0x0 0x203000 0x100>;
+			big-endian;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			#reset-cells = <3>;
+			intel,global-reset = <0x10 30 29>;
+
+			usb_phy: usb2-phy@18 {
+				compatible = "lantiq,danube-usb2-phy";
+				reg = <0x18 4>;
+				status = "disabled";
+
+				resets = <&rcu0 0x10 4 4>;
+				reset-names = "ctrl";
+				#phy-cells = <0>;
+			};
 		};
 	};
 
-- 
2.36.1

