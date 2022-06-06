Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF053E679
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbiFFP0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbiFFPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D684F1CD343;
        Mon,  6 Jun 2022 08:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42B7A61522;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F90C341CB;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=mkHtdDuPA882sz437T9Aas24sScBzzwqd23tLOmUZUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iD0RdBcPQOmeIKn8T1RxIq3nexv2+8rPfXggaB/DzObHMdtqVQwB14KGbS8Bgjwym
         LI4FIOOcuyOqQHhMYT2RHsi3Yx2/tgnDORn+Rw5hdy+Lx8R1rOJAXCbsZcGKCjBNGE
         KP+b5g9dYCEF3wR9GQbm3kbSLNqiuxyVD0vIdL1Q3y+f9sLP4zu2KHVBRXaM4FEiE7
         MgoorE998lOfjV2hvHJcRvdgyJRqIubcnSHQep416fm0sd00MZnJceWEkr4CcMiuDk
         cg/wbyZygNSpwA2XoixSz8yOYVsEWwoZpuqb7JgwKGxw+1xG+KLO0s+iNMwCIY5kpz
         3Cxvwh0f6JIGQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012P5-4x;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 06/23] dt-bindings: mmc: exynos-dw-mshc: update samsung,pinctrl.yaml reference
Date:   Mon,  6 Jun 2022 16:25:28 +0100
Message-Id: <5c937793dd7aec30da4964b39561072ae184f89b.1654529011.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
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

Changeset af030d83da1d ("dt-bindings: pinctrl: samsung: convert to dtschema")
renamed: bindings/pinctrl/samsung-pinctrl.txt
to: bindings/pinctrl/samsung-pinctrl.yaml, splitting it into multiple
files.

Update exynos-dw-mshc.txt accordingly.

Fixes: af030d83da1d ("dt-bindings: pinctrl: samsung: convert to dtschema")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index 753e9d7d8956..985b781f0a48 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -64,7 +64,7 @@ Required properties for a slot (Deprecated - Recommend to use one slot per host)
   rest of the gpios (depending on the bus-width property) are the data lines in
   no particular order. The format of the gpio specifier depends on the gpio
   controller.
-(Deprecated - Refer to Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt)
+(Deprecated - Refer to Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml)
 
 Example:
 
-- 
2.36.1

