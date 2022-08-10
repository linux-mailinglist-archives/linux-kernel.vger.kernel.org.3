Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC09C58E473
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiHJBVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiHJBU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:20:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E7E1147C;
        Tue,  9 Aug 2022 18:20:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q19so12343559pfg.8;
        Tue, 09 Aug 2022 18:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=K8PB1ciS662o1jhXEW/30/xnIB1fBOdqWTq+opSx6m8=;
        b=K5ZL9QYOWSZsR/ShTSrILo4k4ZAWTcKhdo8r/L9sgegOaH4Kagm2nvicjb/KBScaoa
         OxQHtMrxRnj1OPOH0sxeqCkQG5k6Lt0Gy+zXx55QneuNCTN+caP02M/Pme2oHr9f+UjF
         vJtcfBZLC5PMA5ENvK9lrwI8cDkPMlK7GWCOFX+Ovjoys0DY9S3E0aaQ3wlunzRE0l59
         0xlK5p0mzbkuPId9nt9BEkPgDCQTJbIGQ+ttogMkxVGmjWGNcJZuo6XOxwZlh/PxrcHl
         d/l1FPhk0mgA2mH/EZIPA4LL3B2P40QcoO+bURitbAtJ3FiIThP06msuHcUSi66iecbx
         LHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=K8PB1ciS662o1jhXEW/30/xnIB1fBOdqWTq+opSx6m8=;
        b=hkAOIzh7hqYCYmcMQBxAOHjMHKPyUdV6GVC0YdE5I9Q51Rv00tYUsW++XDdwdpbk/n
         LLI41G6L5j5NTPscVbxGxw2ed4WqOrKLZyhogI1dvIUDSE16AsBrAKEf0QHzHovOrNoI
         Nvx1iPpSo9y0vY2K9bnt8jEBk62oT1yoGtMK26QKCjzPofe9+2Et1L/I0RIMS7FPXwlf
         k3HF2ol4YbcTRDz40E14JKdwDCaf95G/+R7me4EoMWzB5PnT5GX/61BjY8owBNOvVAUp
         UMSyXmIuqBh8MutXBTUR+LLXoU/0xd9GP7N5m00GBvKeRWce6hhPA8oYtyEO4oXNWh+5
         BycA==
X-Gm-Message-State: ACgBeo3Axj4l8zRc8dymz/N7Mj3MDBZFAgwRsyEhYYLAfxWXzKBIoeAN
        0QvBF1AXpZqWK6+BbarxbHffCW5cVSLAwg==
X-Google-Smtp-Source: AA6agR4GqR70FuMvJ7suELLr5AKo8xKVh84iqXtuNR07KxSiTtk66QetWIgLvl0R1XQOM1kT482y0g==
X-Received: by 2002:a05:6a00:1948:b0:525:45e3:2eb7 with SMTP id s8-20020a056a00194800b0052545e32eb7mr25750251pfk.77.1660094455911;
        Tue, 09 Aug 2022 18:20:55 -0700 (PDT)
Received: from localhost.localdomain (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b0016c3affe60esm11356754ple.46.2022.08.09.18.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 18:20:55 -0700 (PDT)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 2/2] ARM: dts: aspeed: bletchley: remove hdc1080 node
Date:   Wed, 10 Aug 2022 00:43:38 +0000
Message-Id: <20220810004338.329832-3-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220810004338.329832-1-potin.lai.pt@gmail.com>
References: <20220810004338.329832-1-potin.lai.pt@gmail.com>
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

Because of incompatible 2nd source si7021, removing hdc1080 node from
devicetree, and move node probe to user-space layer.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 54c9f182f6a5c..1f72017c1e2d9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -882,11 +882,6 @@ tmp421@4f {
 		reg = <0x4f>;
 	};
 
-	hdc1080@40 {
-		compatible = "ti,hdc1080";
-		reg = <0x40>;
-	};
-
 	front_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
-- 
2.31.1

