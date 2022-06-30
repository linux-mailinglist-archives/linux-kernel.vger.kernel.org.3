Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EDF562234
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbiF3SkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbiF3SkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:40:04 -0400
X-Greylist: delayed 620 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 11:40:03 PDT
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5513121E3F;
        Thu, 30 Jun 2022 11:40:03 -0700 (PDT)
Received: from 1o6yv7-0006sc-Vr by out3c.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1o6yv9-0006u1-TV; Thu, 30 Jun 2022 11:29:43 -0700
Received: by emcmailer; Thu, 30 Jun 2022 11:29:43 -0700
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3c.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1o6yv7-0006sc-Vr; Thu, 30 Jun 2022 11:29:41 -0700
Received: from tsdebian.Massive (97-120-89-198.ptld.qwest.net [97.120.89.198])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 252701AD06;
        Thu, 30 Jun 2022 11:29:41 -0700 (MST)
From:   Kris Bahnsen <kris@embeddedTS.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Featherston <mark@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Subject: [PATCH] ARM: dts: imx6qdl-ts7970: Fix ngpio typo and count
Date:   Thu, 30 Jun 2022 11:27:46 -0700
Message-Id: <20220630182746.3813-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.11.0
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Message-Id:Date:To:From; bh=HjwjPVTAYTLdyByvG9Mm1PRdcfdz+vFJodfS0eS9vzs=;b=Y6XXGMXVwIlYIaqIUxao0mvrJODOFKWRG2wPI6fYqjmymko9Fa/wCS5mVowGplHk6SBY92CrMrxT7bonPgz9UdUsSNSy7DOLFxw9OiS7v7dQ74kPwQnfSHhlEZvjcaZya5wDf+DdKGRgR4FHpeUPMa+ml2sxL35Qv9Sw76SOW6l8A1fKZJTIayEhurRD/JmYQQzn6pnb/Fm8/MgF8JNrmXTeMtbKX+tyUIFZrqzPmOspyKkmmdd0UeIJ+Kzfs6spgajGVrddQQR43xJ9KuV4FAu131C6BJVt2FCOoQwVnnU+1eZgBQzJlIiOpZRIoGbj2OI0hb+uGi4DJpXqVbatHg==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device-tree incorrectly used "ngpio" which caused the driver to
fallback to 32 ngpios.

This platform has 62 GPIO registers.

Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---
 arch/arm/boot/dts/imx6qdl-ts7970.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-ts7970.dtsi b/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
index fded07f370b3..d6ba4b2a60f6 100644
--- a/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
@@ -226,7 +226,7 @@
 		reg = <0x28>;
 		#gpio-cells = <2>;
 		gpio-controller;
-		ngpio = <32>;
+		ngpios = <62>;
 	};
 
 	sgtl5000: codec@a {

base-commit: 03c765b0e3b4cb5063276b086c76f7a612856a9a
-- 
2.11.0

