Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8345859F511
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiHXIWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiHXIVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:21:40 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226AF8F95D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=ZA6NZznO17pPAf
        YQn+ZaPqoOw1BDdgUMYqc4V7ZjXXg=; b=LkNpW3WqCHqPoO8EInfjd3/x72/QnH
        4Zj6qMFpQjV9YIR/mgRhoWukUl98f8JiXBunAC1mj7eyTbbRBFeNxB3zPgopeunJ
        JRakwpUwx9Qm3iZW0mKMkGGWOZuc0vGaNgld9Q7Aij4yNZLqPLhxxTVuRj2B600+
        qXWfeSHwgXXbs=
Received: (qmail 2131806 invoked from network); 24 Aug 2022 10:21:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Aug 2022 10:21:32 +0200
X-UD-Smtp-Session: l3s3148p1@SHFQXvjm5OcgAwDPXxw3AFlguiwjsjwa
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-spi@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: stm32: argon: remove spidev node
Date:   Wed, 24 Aug 2022 10:21:28 +0200
Message-Id: <20220824082130.21934-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824082130.21934-1-wsa+renesas@sang-engineering.com>
References: <20220824082130.21934-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 956b200a846e ("spi: spidev: Warn loudly if instantiated from DT
as "spidev"") states that there should not be spidev nodes in DTs.
Remove this non-HW description. There won't be a regression because it
won't bind since 2015 anyhow.

Fixes: 16e3e44c5b87 ("ARM: dts: stm32: Add support for the emtrion emSBC-Argon")
Cc: Reinhold Mueller <reinhold.mueller@emtrion.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Please take it via your platform tree.

 arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
index ac53ee3c496b..30156b7546ed 100644
--- a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
@@ -435,12 +435,6 @@ &spi1 {
 	pinctrl-0 = <&spi1_pins_a>;
 	cs-gpios = <&gpioz 3 0>;
 	status = "disabled";
-
-	spidev@0  {
-		compatible = "spidev";
-		reg = <0>;
-		spi-max-frequency = <100000>;
-	};
 };
 
 &timers1 {
-- 
2.35.1

