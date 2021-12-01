Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABFD464849
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347456AbhLAHbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:31:47 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54666 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347447AbhLAHbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:31:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6AD82CE1D73;
        Wed,  1 Dec 2021 07:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9342AC53FD5;
        Wed,  1 Dec 2021 07:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343696;
        bh=IZVU6V9VZSLbDruSD3CwXHfsbc+1ZYVrEFg6wsYL8KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+zTStgHDOV2X7qhFkEXjcBoJtKfD/nVCegiz7pKmz1qtXTpE6G3nU+mCUrI4arjf
         lUpHNYpJ+KA+5Vg1EuedIhJeytUBCoHVOVXbpZhMybkKlRsR2frObuFrCluxIXRQER
         TAHkO3fOap5Hp6W41VGtk2hKWQGqzmZY0ka/P+/wGxdfm9SvPj0ia9ZgwrckFSRKEq
         6Bh0gevDeC7v1EUP523oGGM/Fbp2pGfcozlyivO6lWDOpAwX+AXqZz8ZMVPhWeRuQT
         17E58SoR5y4Z9Rav2es2LaiLb/w0yTbVmCBoijr0ffKRsVIhcdi3nIkQ/pvO9waT5N
         wqmQ9RKv4cD5g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] dt-bindings: arm: qcom: Document SM8450 SoC and boards
Date:   Wed,  1 Dec 2021 12:57:41 +0530
Message-Id: <20211201072745.3969077-4-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072745.3969077-1-vkoul@kernel.org>
References: <20211201072745.3969077-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8450 SoC binding and also the boards using it.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index c8808e0f9e64..29a0bd3adac2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -50,6 +50,7 @@ description: |
         sm8150
         sm8250
         sm8350
+        sm8450
 
   The 'board' element must be one of the following strings:
 
@@ -257,6 +258,11 @@ properties:
               - qcom,sm8350-mtp
           - const: qcom,sm8350
 
+      - items:
+          - enum:
+              - qcom,sm8450-qrd
+          - const: qcom,sm8450
+
 additionalProperties: true
 
 ...
-- 
2.31.1

