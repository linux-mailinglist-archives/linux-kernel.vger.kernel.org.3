Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E132B4FDE22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiDLLlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354697AbiDLLi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:38:58 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFDB37BE3;
        Tue, 12 Apr 2022 03:19:51 -0700 (PDT)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8B7E283DA6;
        Tue, 12 Apr 2022 12:19:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1649758789;
        bh=3yz4s9o1nz4BvPmYZJ3QuhCwoJciRv228WlmR/aEPOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScT8GtsTqsNDdMHsXSJl9Xe194rsBs9Uw9T92Emr0AWZHP+4QqdecgjGABYwgWudY
         fyrnV59eX6EPHv5MjFRNV5LVg/Btp1pQqpfDYPQP+MvFw1I3Cbv6/jSC5YXrqe4COs
         PkbFX+rvDO7YD2Zu8mON2kms1YhdB4uP3EtrPbNFaWDRjLUsce5C5OOeVGqatl/cvp
         xLqPfFZWaeos/ZlTLLcvX7DfUBGki7vHf5q3ar+0uXnnzkts0sMt9WYPSK96KIoGm4
         cWEl4sqOuDz3dH2qUcZ53jf5k+++Z8njFVN5VeGNLKovxbfjXtsdsq0cVF0GqnbjB4
         LPHUPPkRU2cGg==
Received: by janitor.denx.de (Postfix, from userid 108)
        id 334A2A02B9; Tue, 12 Apr 2022 12:19:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from xpert.denx.de (xpert.denx.de [192.168.0.4])
        by janitor.denx.de (Postfix) with ESMTPS id F03CCA005F;
        Tue, 12 Apr 2022 12:19:38 +0200 (CEST)
Received: by xpert.denx.de (Postfix, from userid 535)
        id E21983E0786; Tue, 12 Apr 2022 12:19:38 +0200 (CEST)
From:   Philip Oberfichtner <pro@denx.de>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Winker Matthias <Matthias.Winker@de.bosch.com>,
        Philip Oberfichtner <pro@denx.de>
Subject: [PATCH 1/2] dt-bindings: arm: Add bosch acc board
Date:   Tue, 12 Apr 2022 12:19:04 +0200
Message-Id: <20220412101905.514310-2-pro@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220412101905.514310-1-pro@denx.de>
References: <20220412101905.514310-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding for the Bosch ACC board, based on i.MX6 Dual.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
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

