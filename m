Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5351C4E643E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350525AbiCXNnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbiCXNnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:43:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571CEA8883;
        Thu, 24 Mar 2022 06:41:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E760F61418;
        Thu, 24 Mar 2022 13:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE256C340EC;
        Thu, 24 Mar 2022 13:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648129307;
        bh=HQ2E2Y+yu+DG6fiF3uPWqaUBh1Sx2Ds3jVT251EbPVo=;
        h=From:To:Subject:Date:From;
        b=e1+pr3oGkh9ngnV1WNqeIJpRqJqru8Xi0oE3SuRin9TfZf4frk5duWI7Cw609Y7nG
         CAHkZ4NTQQ8mhZ4ExeMpjzaRJv9dvdF+p5p0whgZFLojNFbpnnKuJKGMoCWGue8wuB
         ralzG884qKQb7ekY8F1qKfX7VRLeXPlnWd8pnmfcWzLy41sfWM3FGLpsTm3tDnhJtw
         7Kknn7CJ04hHU38K3XaqTD1ACAgk3BYx7BsmLoGYYcPQbseAB8BwqE/pCjoJnvcnj2
         mA03Ldm9TTn8Oh7jZIGA4muOS0CUyY7Ai2CJ0wXVTBAet3iHtdhdIUzy7DiphQ03TH
         aYL3h3nyuO/Zg==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: samsung: usi: refer to dtschema for SPI
Date:   Thu, 24 Mar 2022 14:41:06 +0100
Message-Id: <20220324134106.103588-1-krzk@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding DT schema for Samsung SPI controller, the Samsung USI
bindings can reference it directly for proper schema validation.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
index ea9c233052f3..58fd858530cc 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
@@ -73,7 +73,7 @@ patternProperties:
     description: Child node describing underlying UART/serial
 
   "^spi@[0-9a-f]+$":
-    type: object
+    $ref: /schemas/spi/samsung,spi.yaml
     description: Child node describing underlying SPI
 
 required:
-- 
2.32.0

