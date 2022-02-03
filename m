Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB04E4A80D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349669AbiBCJAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:00:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48816 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiBCJAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:00:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1DFD60B3F;
        Thu,  3 Feb 2022 09:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C852CC340E4;
        Thu,  3 Feb 2022 09:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643878839;
        bh=mskTuDaWMO9hrgsJLybQZ9MJwOoTKtGni6kAJ9qDs1g=;
        h=From:To:Cc:Subject:Date:From;
        b=D3tBOKZI+4sIQq+Mt7QRCfh3GmwW2RAzwc3DCAV/pNlj8YBK+W5SACx2+1DYtL4xo
         lR/2rtXbk/xF+iAoYAvB5JlDqduqfII0QNCUf6O8gkERSvZtAX7RZ52xefaGWDdABY
         qFt064VII6PYzij6QKeuXFHEMPhkM30pCi1xXuCfXxgOC17x2/sqDBlF2fOuKhPIUV
         AIROIdD9fvt8qT2bHRq6tcwX0pFqkDzr9UtAQnncGUQV3GnEiaYqjRg6NnknsPNn4y
         Nu7FHTxclKsMQZceKh8oETlyXRjL5xKlG8xtYvoH1xxwSSYE2y3/0H98o6UtfwFvlT
         QH4xMlTjaM+sA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Document SM8450 HDK boards
Date:   Thu,  3 Feb 2022 14:30:30 +0530
Message-Id: <20220203090031.3128702-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8450 HDK board

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 370aab274cd1..9a75274f9ae4 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -268,6 +268,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,sm8450-hdk
               - qcom,sm8450-qrd
           - const: qcom,sm8450
 
-- 
2.31.1

