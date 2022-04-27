Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3E511A29
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiD0N7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbiD0N6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:58:48 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB17AE44;
        Wed, 27 Apr 2022 06:55:33 -0700 (PDT)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7995E83E9E;
        Wed, 27 Apr 2022 15:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1651067732;
        bh=8eYvVBd/3DpcmHQqYetFdTfTTiOdFCR9Rown27tb0EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7L4iTXLuiajqZfBlTEBSf1IBTUllPmmHPSBnSFELKZXC9zroOQ2U8prp9nBPUmjh
         s4oLl/5pBVQM4Db837ilGmUG055VTjc2qYta09NAhEQCVjABXU2q59DlEI27a86bYf
         IflFC2lllOoOxdEe8+TEBCDfqU3gxqp95RsTpeo56X8rVt/wV+9UVRP1dM8eRJDXZ7
         mjTRRdVHjvxgM/aO1+6j6SZcvRIACcnmwBMhh4ckPwDLFpZRkDLsLXqXilM7+Jf3V0
         TDn3RfCnKhC2JeKPxOfKU+530ozWzup0q5HbBe1UZB/rCBa9GtE6sleMEOXdTs6acp
         CFrPSU9WldxJQ==
Received: by janitor.denx.de (Postfix, from userid 108)
        id 33130A030E; Wed, 27 Apr 2022 15:55:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from xpert.denx.de (xpert.denx.de [192.168.0.4])
        by janitor.denx.de (Postfix) with ESMTPS id BE178A00A4;
        Wed, 27 Apr 2022 15:55:17 +0200 (CEST)
Received: by xpert.denx.de (Postfix, from userid 535)
        id AF0EA3E0540; Wed, 27 Apr 2022 15:55:17 +0200 (CEST)
From:   Philip Oberfichtner <pro@denx.de>
Cc:     Philip Oberfichtner <pro@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.winker@de.bosch.com
Subject: [PATCH v3 3/4] dt-bindings: arm: Add bosch acc board
Date:   Wed, 27 Apr 2022 15:52:31 +0200
Message-Id: <20220427135229.2339865-3-pro@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220427135229.2339865-1-pro@denx.de>
References: <20220427135229.2339865-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding for the Bosch ACC board, based on i.MX6 Dual.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: matthias.winker@de.bosch.com

---

Changes in v3: none
Changes in v2: Acked-by Krzysztof
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..9deb568761c1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -192,6 +192,7 @@ properties:
         items:
           - enum:
               - auvidea,h100              # Auvidea H100
+              - bosch,imx6q-acc           # Bosch ACC i.MX6 Dual
               - boundary,imx6q-nitrogen6_max
               - boundary,imx6q-nitrogen6_som2
               - boundary,imx6q-nitrogen6x
-- 
2.34.1

