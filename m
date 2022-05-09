Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067D85200DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiEIPSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbiEIPSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:18:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDAC27CE6;
        Mon,  9 May 2022 08:14:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n8so14153068plh.1;
        Mon, 09 May 2022 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l2qY2cWlLlfG1RUgISmGZpjql0HcXWQoFGn6X90qPgw=;
        b=HfpJU62BWT0EujKLbfSRY6wrZRaE5cObcOb+ZI6QW3t0fNHohXRezm2t+V8qmyyZ9p
         IrsG6hw0nFIUodpqCg/hV3cHh+J48WkjRwoRPxbjWisvDKptfa/OM+8aRj3kttpPriGL
         26lj75O5GGl7QPIucUmRgCkmBayFT3et0YyYPFEfv8byvgBIZn8jeeped/yo3GC6jwtO
         hJMEdTl4FzAmBgnEqebb9N5oqRwl39/tvhTal9UfnZ4n9m2mUrHd4nd9wkeUc8MgnK4d
         zQ47MMIZkXNdYj2/a71XRRKOvB2o2ySi780ldxqejtfDPG6RxHcDRW0ni0zpHjqT5OOk
         66RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l2qY2cWlLlfG1RUgISmGZpjql0HcXWQoFGn6X90qPgw=;
        b=eTPeVbwDahiqJCYt8OcCG2fx40A+kg/fEmyCO1Sd22trQmCuDZAF7qzO/y4sgsZviB
         FaunnrNyFnkWZGdP4jclA/lH2fBqzW1CGaEJi1r2hkZ+EStoTfR6gx0xqfSqdi1Nu7Fl
         edOeg5Jzv87mVa8v6VuoQALlyJdqMa+Yrcr0YGOiT+4HKf07GsXJv0vUhEoCsRuj1AyZ
         EE4yW/6CUG/u2TwALh0nAnZEP2IFgFxTkwpPP2wuT06wFxZ6ewVM4i0IBm8jpPFMvV2U
         F8yZMHgYHTEMaRl8n1bVcmSpVn0dZwMz7Q08LzRS4jqf5vHUVclsMOM1ulzLB3eusPyO
         t/Bg==
X-Gm-Message-State: AOAM530dKiAWe9muDBnKlwY1MtHVtIW3NgIApM/GcZqKWiSoAQwV33hm
        0w0qDrxpIfmsBwVXPWQLo30=
X-Google-Smtp-Source: ABdhPJzMRdVCHBfbZqKWcPvtFFQon5E4cmHhyCetrXKiUDqjC2LJYav7DQoCH6sy7+Up3FJ24crgCA==
X-Received: by 2002:a17:902:e884:b0:15e:bfbc:1a35 with SMTP id w4-20020a170902e88400b0015ebfbc1a35mr16553144plg.51.1652109268422;
        Mon, 09 May 2022 08:14:28 -0700 (PDT)
Received: from potin-quanta.dhcpserver.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id k7-20020a056a00134700b0050dc76281b6sm9221596pfu.144.2022.05.09.08.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 08:14:28 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 6/6] ARM: dts: aspeed: bletchley: add eeprom node on each sled
Date:   Mon,  9 May 2022 23:11:18 +0800
Message-Id: <20220509151118.4899-7-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220509151118.4899-1-potin.lai.pt@gmail.com>
References: <20220509151118.4899-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add eeprom (24c26) on each sled for storing sled fru information.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed-bmc-facebook-bletchley.dts     | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index b30986e7cb41..41d2b1535d9a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -314,6 +314,11 @@
 			op-sink-microwatt = <10000000>;
 		};
 	};
+
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
 };
 
 &i2c1 {
@@ -395,6 +400,11 @@
 			op-sink-microwatt = <10000000>;
 		};
 	};
+
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
 };
 
 &i2c2 {
@@ -476,6 +486,11 @@
 			op-sink-microwatt = <10000000>;
 		};
 	};
+
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
 };
 
 &i2c3 {
@@ -557,6 +572,11 @@
 			op-sink-microwatt = <10000000>;
 		};
 	};
+
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
 };
 
 &i2c4 {
@@ -638,6 +658,11 @@
 			op-sink-microwatt = <10000000>;
 		};
 	};
+
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
 };
 
 &i2c5 {
@@ -719,6 +744,11 @@
 			op-sink-microwatt = <10000000>;
 		};
 	};
+
+	eeprom@54 {
+		compatible = "atmel,24c64";
+		reg = <0x54>;
+	};
 };
 
 &i2c6 {
-- 
2.17.1

