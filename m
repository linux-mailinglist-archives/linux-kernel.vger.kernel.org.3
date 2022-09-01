Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2345AA344
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiIAWnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiIAWng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:43:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923E467CBE;
        Thu,  1 Sep 2022 15:43:35 -0700 (PDT)
Received: from localhost (unknown [188.27.54.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D9CD86601EBA;
        Thu,  1 Sep 2022 23:43:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662072214;
        bh=KzKhwls9rXQht8qlDBSXnDEtPH0QZN4XnleCNhtFc2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kpfF10M5FSXdKo0xIxEt1vC/iH6NSySzU3FZjcVe/7rN8d5OR5up1eZhQu5YiZ/fu
         ObJrfeJaVpEmyXLSvgR0QnPqX10nAeQavXd0fxostkX9WOE2AjGkty5OBVWlVJZ5aU
         jMIRPVv8OlE1Fgt4YSpIPJrZu1/TYFll/AxcVQDsFJciGJRMc+qcLcN+bEkeX8IoWW
         G46sX0BWmBIkaQjsbGfTQ4XxNe2NEPSSZtbKQHgd9b4QuBM7ZKdcxIPOjBcDdRG/gu
         M5NUuZq0JhlA5+KN/ccJew0mpr8AymDHv/mVpvbWplBb3qWGKlJcYBFOTZ5ZSFCZc6
         sRwNh6vOZT+qA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH 1/3] dt-bindings: riscv: starfive: Add StarFive VisionFive V1 board
Date:   Fri,  2 Sep 2022 01:42:51 +0300
Message-Id: <20220901224253.2353071-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901224253.2353071-1-cristian.ciocaltea@collabora.com>
References: <20220901224253.2353071-1-cristian.ciocaltea@collabora.com>
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
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 5b36243fd674..9c948b379c8f 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -21,6 +21,9 @@ properties:
       - items:
           - const: beagle,beaglev-starlight-jh7100-r0
           - const: starfive,jh7100
+      - items:
+          - const: starfive,visionfive-v1
+          - const: starfive,jh7100
 
 additionalProperties: true
 
-- 
2.37.2

