Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA52472CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhLMNPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbhLMNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:15:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10A5C061574;
        Mon, 13 Dec 2021 05:15:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1A8CFCE1021;
        Mon, 13 Dec 2021 13:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A24DC34601;
        Mon, 13 Dec 2021 13:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639401302;
        bh=tvvUBMXu9bigl3+FP0wtOQ9eIr333s7ge1/gtweziiY=;
        h=From:To:Cc:Subject:Date:From;
        b=Pndtj6+6bOSTA1bnMqAXFzymoqN2zLhQTG3KzBtpDt+42ORyZhX3qlNaleIZe4jNZ
         qDd2pVyv9gaA6D6568KhMQDU2v6FCENCFB0exIUaiYJ/ZGq45eK5u4834nTCgmyU4d
         YVgzb/cXtVV91pRsXG3EtVMwFsHLKbRb2/rNTUm/gpXH3z87hTsfcRXkjxXgciAUkg
         aV8YrQATqhCwe8w6WdoFYlTqLGR3xIjCZCuc/jG9F/OHGKslPSP8xbetU3MOGYJkUR
         zyz6hom03MjOn66tI55VnAJuMaZlDmE5VcJC2+onf9YveQnysgx84oyXXzC0xCNW8F
         NS4ZsXUDVh6FQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for SM8450
Date:   Mon, 13 Dec 2021 18:44:48 +0530
Message-Id: <20211213131450.535775-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible string for USB phy found in Qualcomm SM8450 SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 20203a8a9e41..0dfe6914ec87 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -20,6 +20,7 @@ properties:
       - qcom,sm8150-usb-hs-phy
       - qcom,sm8250-usb-hs-phy
       - qcom,sm8350-usb-hs-phy
+      - qcom,sm8450-usb-hs-phy
       - qcom,usb-snps-femto-v2-phy
 
   reg:
-- 
2.31.1

