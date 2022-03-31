Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770514ED1B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiCaC0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCaC0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:26:31 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112396BDD7;
        Wed, 30 Mar 2022 19:24:44 -0700 (PDT)
Received: from hatter.bewilderbeest.net (174-21-187-98.tukw.qwest.net [174.21.187.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5A6AF497;
        Wed, 30 Mar 2022 19:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1648693484;
        bh=5tqPMlfgjBS/krqHw0aXsQR0VZ6bcG/ODgpNFGKyDDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buwota9WVu/vdy8W/fApI7wu1pQpnKu5DyFBY+KAwlGhj43ZxoxVo4NwIgf79hp40
         y3cyKdFzaAT51+XsRQUKvCqqdeHRrBIc7bCUHFTxP82oqVYtIWYuOVs7aqwlXJy5dF
         SLMFOmMHxr3rFh7MUTkBO1KC7MILfZItH1KBv/Kc=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: aspeed: romed8hm3: Fix GPIOB0 name
Date:   Wed, 30 Mar 2022 19:24:25 -0700
Message-Id: <20220331022425.28606-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331022425.28606-1-zev@bewilderbeest.net>
References: <20220331022425.28606-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This GPIO was mislabeled as DDR_MEM_TEMP in the schematic; after a
correction from ASRock Rack its name now reflects its actual
functionality (POST_COMPLETE_N).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
index 572a43e57cac..ff4c07c69af1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
@@ -198,7 +198,7 @@ &gpio {
 	gpio-line-names =
 		/*  A */ "LOCATORLED_STATUS_N", "BMC_MAC2_INTB", "NMI_BTN_N", "BMC_NMI",
 			"", "", "", "",
-		/*  B */ "DDR_MEM_TEMP", "", "", "", "", "", "", "",
+		/*  B */ "POST_COMPLETE_N", "", "", "", "", "", "", "",
 		/*  C */ "", "", "", "", "PCIE_HP_SEL_N", "PCIE_SATA_SEL_N", "LOCATORBTN", "",
 		/*  D */ "BMC_PSIN", "BMC_PSOUT", "BMC_RESETCON", "RESETCON",
 			"", "", "", "PSU_FAN_FAIL_N",
-- 
2.35.1

