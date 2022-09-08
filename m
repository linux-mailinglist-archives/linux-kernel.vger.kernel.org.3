Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302E85B2095
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiIHO3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 10:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiIHO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 10:29:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0A5DEF;
        Thu,  8 Sep 2022 07:29:24 -0700 (PDT)
Received: from localhost (unknown [188.27.54.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD4FA6601F97;
        Thu,  8 Sep 2022 15:29:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662647363;
        bh=ACPX1O/55jmYl4XQH9KqX/fcKaXpHRpw86mnaJXhFSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NP12pTaOh/knK67jBR9i0s0Xdp9Zkjan2OZ6mS6UngUmk+pzewDfy9+UIyC6BNUXD
         vx/WuEUFkgfbL4+hKCRHYdHntAmuaDomenFTuPmMKv1EjA2Cr30Xl/S1gBPC1h6pw5
         GbipM+7Y/b0VOUq5mxpTS7C+C6GyoTOp8Jrt3/3r8dkByRZruQNdY0iovNOCfR08HH
         TTEC3WJbEvjFBGeskTkLZREf079UwrqkIzkyKw66gdLhYoGChEZEvzPdlFaCgfxxJw
         DgVcHImk12/LeX6ETVIizFJyJ43D0K00Qh2dEpUW3xNq+pLpsP13cw/QKLzXnlKgZF
         W1HEWaGa01wag==
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
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/3] dt-bindings: riscv: starfive: Add StarFive VisionFive V1 board
Date:   Thu,  8 Sep 2022 17:29:12 +0300
Message-Id: <20220908142914.359777-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908142914.359777-1-cristian.ciocaltea@collabora.com>
References: <20220908142914.359777-1-cristian.ciocaltea@collabora.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.37.3

