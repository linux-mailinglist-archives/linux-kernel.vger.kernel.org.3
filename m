Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6F45AAC0F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbiIBKIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiIBKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:08:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2C899265;
        Fri,  2 Sep 2022 03:08:15 -0700 (PDT)
Received: from localhost (unknown [188.27.54.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 93F9D6601F05;
        Fri,  2 Sep 2022 11:08:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662113293;
        bh=2QEA+I9MjqrPeHXxdVp3wmfcnrjvvqck3Dd+MJY4pRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EoOmLc9nAMqaoRjp7aesPqRK6lj10ieWf9ObItk1rgnNVqDJAICSPIF7xcj/bVtAI
         HMJ5A88h0J0hc/cPhMi4m1cy6cvoiFAxhKa1LnhFGhC5f5D3fXI0yL4EXY62G90qDz
         nPiRqoKg+y61CIVj7SH1Pa3FLGg17jHHQxOCBJAhGA3fh8JJYGn15N52KoGil/u4bp
         9jyVh6uhq8kBE/wyv/wUkZmOZWiXt0sYvnkh7xJCt91Yt/XOTEW4mOEXyU2wzv9y/5
         vkNxAhvVkFoi8bySNedegH+pNFewvayjLbFk1aAcozQIweQRsZLXeH+sLIlvy1y3qb
         DQ1uSpNqVVXNg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2 1/3] dt-bindings: riscv: starfive: Add StarFive VisionFive V1 board
Date:   Fri,  2 Sep 2022 13:08:04 +0300
Message-Id: <20220902100806.2378543-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902100806.2378543-1-cristian.ciocaltea@collabora.com>
References: <20220902100806.2378543-1-cristian.ciocaltea@collabora.com>
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

Document the compatibles for StarFive VisionFive V1 SBC [1].
The board is based on the StarFive JH7100 SoC.

[1] https://github.com/starfive-tech/VisionFive

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 5b36243fd674..5d3fcee52d59 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -19,7 +19,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: beagle,beaglev-starlight-jh7100-r0
+          - enum:
+              - beagle,beaglev-starlight-jh7100-r0
+              - starfive,visionfive-v1
           - const: starfive,jh7100
 
 additionalProperties: true
-- 
2.37.2

