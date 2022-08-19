Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15DA599CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349188AbiHSNVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348748AbiHSNVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:21:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA1EEE686;
        Fri, 19 Aug 2022 06:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AD64B825BF;
        Fri, 19 Aug 2022 13:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7DCC433D6;
        Fri, 19 Aug 2022 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660915304;
        bh=mYD368IWeJoxT8nG1mYtmFWpeb/lHHm5JRI5bGDo3Os=;
        h=From:To:Cc:Subject:Date:From;
        b=Pe/L85jcxhl5BdWRZsaZYxpoZkz+2DdQn71SwfFd+7gqrg37mXPd0Y/28V+nkY/7d
         t3VuHkndXMxvHWPFHo4JmHk6N42RdY9KXEeH3Lo1FMl+A6ywviZ1yyKi6+EUPncsfw
         aWrfdFJZY4l6aF3+KdDdMShfpHy6GOeJYSaUAEO3TE6L4egCnLltJuhKg2Mv/8E2gM
         fz1/+3leHQXA3sFP2dSlcGZltAnOxaYUxBqHdkL4SYUlELCZqgOxCxvTJH1Tusupg8
         0U48UbGc2mbiWU+P/xETv6r6TOMvsGFNYLjOpzK8eynMUH5j08AtQR5nwas6le0vQ3
         R489G97CR5ONg==
Received: by pali.im (Postfix)
        id 4F192761; Fri, 19 Aug 2022 15:21:41 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Behun <marek.behun@nic.cz>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: turris-omnia: Add mcu node
Date:   Fri, 19 Aug 2022 15:11:52 +0200
Message-Id: <20220819131152.6513-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At i2c address 0x2a is MCU command interface which provides access to GPIOs
connected to Turris Omnia MCU. So define mcu node in Turris Omnia DTS file.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Same change was already sent to U-Boot project together with driver. As
Turris Omnia DTS file is shared between Linux kernel U-Boot, I'm sending
this change also in Linux. There is a plan to write also Linux driver for
Turris Omnia MCU, like there is already in U-Boot.

https://source.denx.de/u-boot/u-boot/-/commit/832738974806e6264a3d0ac2aaa92d0f662fd128
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/gpio/turris_omnia_mcu.c
---
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index f4878df39753..f655e9229d68 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -184,7 +184,13 @@
 			#size-cells = <0>;
 			reg = <0>;
 
-			/* STM32F0 command interface at address 0x2a */
+			/* MCU command i2c API */
+			mcu: mcu@2a {
+				compatible = "cznic,turris-omnia-mcu";
+				reg = <0x2a>;
+				gpio-controller;
+				#gpio-cells = <3>;
+			};
 
 			led-controller@2b {
 				compatible = "cznic,turris-omnia-leds";
-- 
2.20.1

