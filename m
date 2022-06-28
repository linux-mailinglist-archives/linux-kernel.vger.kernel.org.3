Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC21955E3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345866AbiF1Mpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345290AbiF1MpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153DB193ED;
        Tue, 28 Jun 2022 05:45:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h23so25450013ejj.12;
        Tue, 28 Jun 2022 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKQyH9C8gO8jBo4jczcS1bhOdjsHy0Bi1N6w+JS8218=;
        b=LjmaQv+UaMIjunLurOL+z37Ha+0Ha5xCcz8TSNyiWiX4mT4KHEwjXmxN+fag+bM0Am
         yDXP1r7Xc6Zz5IsXYiUJh6k9bSR4DbvAQr6mvKlUF1GPcxRFliO3pFHhUdQEFvePNov0
         +UIkfd/sF5nx41cPYL1xor8DJo3YHYiF/Im0ty1E8n7A12RL/Zo7VOtUYSr4JgaddVhr
         z/ErA31vpWhM9EtFwZomRV3mkYkLBlX1ziGbMxFswIl2irSQ/jybJ9VUylYimIv8ArsP
         Cdo7e59GNGqfPv89fyweeII2sry/rHE+H5XvLiw7049ZtQJl/rkSJiEKUNwVsOTBCfSr
         dryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKQyH9C8gO8jBo4jczcS1bhOdjsHy0Bi1N6w+JS8218=;
        b=FnduCv2gR+mc6t+K9JQaabi/FvXaRGMNA/Dfbe5MhmD+jVI4KccutYp053DVAMqhgt
         ALBbDlagVf5jLMwwNF11Vypvwn4aUuh4XLVyOi9UCYLgv6uvEPA7RtdH9IeW41K0LnIv
         zZ25xJqO/9GuBbzG8EeF2/IW8jpMVwR+Cmv2IaayowUi+MW/EHWxzRcst2kYArK5aHwp
         Zhnqxjw7fTIiNwH8gkgtvMvlHPhZ2DvdHZn3vbrZe5+gOiAtaX/YfPrDhpr5VY9belIV
         MktscxYnyM1BREJeC86rtJ7M4LgpJgtmhFW7qxzsCGQhP3ryGicOiSCn7TSa6JHjJAFn
         VASg==
X-Gm-Message-State: AJIora/3uCq+swb0NAutNCoSmW4Dm1PQZpt51cbG9GV251CUks1Ich13
        HPCriuuKZyQQfPDnPRcw4Qs=
X-Google-Smtp-Source: AGRyM1uy7MEZIEthYVomXDaHu9jetS7Xdb/FUEi0ipDJra34TCTFPRGKmuJ7DXtAsyRDRkeBXtJgBQ==
X-Received: by 2002:a17:906:e256:b0:726:abd9:1063 with SMTP id gq22-20020a170906e25600b00726abd91063mr8552132ejb.741.1656420320598;
        Tue, 28 Jun 2022 05:45:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm622871ejx.173.2022.06.28.05.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:45:20 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, rtanwar@maxlinear.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 4/9] dt-bindings: mips: lantiq: rcu: Remove binding documentation
Date:   Tue, 28 Jun 2022 14:44:36 +0200
Message-Id: <20220628124441.2385023-5-martin.blumenstingl@googlemail.com>
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

This is now part of:
Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml

The PHYs are still using sub-nodes while the reset-controller is moved
to the main RCU node. Also the system reboot is now described directly
in intel,rcu-gw.yaml which makes the syscon-reboot node obsolete.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/mips/lantiq/rcu.txt   | 69 -------------------
 1 file changed, 69 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt

diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
deleted file mode 100644
index 58d51f480c9e..000000000000
--- a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
+++ /dev/null
@@ -1,69 +0,0 @@
-Lantiq XWAY SoC RCU binding
-===========================
-
-This binding describes the RCU (reset controller unit) multifunction device,
-where each sub-device has it's own set of registers.
-
-The RCU register range is used for multiple purposes. Mostly one device
-uses one or multiple register exclusively, but for some registers some
-bits are for one driver and some other bits are for a different driver.
-With this patch all accesses to the RCU registers will go through
-syscon.
-
-
--------------------------------------------------------------------------------
-Required properties:
-- compatible	: The first and second values must be:
-		  "lantiq,xrx200-rcu", "simple-mfd", "syscon"
-- reg		: The address and length of the system control registers
-
-
--------------------------------------------------------------------------------
-Example of the RCU bindings on a xRX200 SoC:
-	rcu0: rcu@203000 {
-		compatible = "lantiq,xrx200-rcu", "simple-mfd", "syscon";
-		reg = <0x203000 0x100>;
-		ranges = <0x0 0x203000 0x100>;
-		big-endian;
-
-		reset0: reset-controller@10 {
-			compatible = "lantiq,xrx200-reset";
-			reg = <0x10 4>, <0x14 4>;
-
-			#reset-cells = <2>;
-		};
-
-		reset1: reset-controller@48 {
-			compatible = "lantiq,xrx200-reset";
-			reg = <0x48 4>, <0x24 4>;
-
-			#reset-cells = <2>;
-		};
-
-		usb_phy0: usb2-phy@18 {
-			compatible = "lantiq,xrx200-usb2-phy";
-			reg = <0x18 4>, <0x38 4>;
-
-			resets = <&reset1 4 4>, <&reset0 4 4>;
-			reset-names = "phy", "ctrl";
-			#phy-cells = <0>;
-		};
-
-		usb_phy1: usb2-phy@34 {
-			compatible = "lantiq,xrx200-usb2-phy";
-			reg = <0x34 4>, <0x3C 4>;
-
-			resets = <&reset1 5 4>, <&reset0 4 4>;
-			reset-names = "phy", "ctrl";
-			#phy-cells = <0>;
-		};
-
-		reboot@10 {
-			compatible = "syscon-reboot";
-			reg = <0x10 4>;
-
-			regmap = <&rcu0>;
-			offset = <0x10>;
-			mask = <0x40000000>;
-		};
-	};
-- 
2.36.1

