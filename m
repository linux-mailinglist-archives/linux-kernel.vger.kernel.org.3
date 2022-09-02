Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737785AAA65
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiIBIn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiIBInS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:43:18 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35F0AFAC2;
        Fri,  2 Sep 2022 01:43:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 0F406DFECD;
        Fri,  2 Sep 2022 01:42:46 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id obPoZtoo9hhS; Fri,  2 Sep 2022 01:42:45 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1662108165; bh=dLxGZ2rBkhtKIFimeky7PZ5dqQic1x5ZAGAEZHNaB4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KMrKLYnae4TV1G8nsJKolHN1cTyAeDBWI1JtzSrjglkZfB/BkS8RJ6Y40Ng6/ojdO
         kttmwFDfFUJ1MBe3I50HWENlKVlyYB3NY4l7vnuoVpV8qYNH8elYfl/R+FWQq2N70Q
         HwR9ReiAN/feAbHP2TmZ2DGDRipg+uN4+7mnHjsEHSTmLgmxxqsC3ZEkqMky0cbewF
         5FSkXA8xGhF7E3bhLLjHuqEVhiYu/KSnm4oqjsliIfGciT/6LWR9KWoQ1i1JGX0heg
         le+2ausqTbyoHhMAwiCoyHMJ/VeX5HRfyjltSmmmI/BsHOvVSOXUkz1qtjL3OPkveK
         SdXoyDpV9ewAg==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v2 6/6] arm64: dts: imx8mq-librem5: fix mipi_csi description
Date:   Fri,  2 Sep 2022 10:42:16 +0200
Message-Id: <20220902084216.1259202-7-martin.kepplinger@puri.sm>
In-Reply-To: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
References: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properties are not documented so lead to the following error:
'#address-cells', '#size-cells', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'

Fix this by removing unneeded properties.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 058d6ecf109b2..ae08556b2ef2f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1143,8 +1143,6 @@ &lcdif {
 };
 
 &mipi_csi1 {
-	#address-cells = <1>;
-	#size-cells = <0>;
 	status = "okay";
 
 	ports {
-- 
2.30.2

