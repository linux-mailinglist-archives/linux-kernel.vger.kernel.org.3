Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD747706A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhLPLjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:39:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45704 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhLPLjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:39:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B952A61D72;
        Thu, 16 Dec 2021 11:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE70C36AE3;
        Thu, 16 Dec 2021 11:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639654744;
        bh=NYXGt9xJEHEdbKYv4dV1TCwIBY8p5SDp5rSejnUXkd4=;
        h=From:To:Cc:Subject:Date:From;
        b=IC+XmPjro0Zn2GMW6dnkDQBLXHOVWtYXiqm0rHtfpzpu9icvHr5LAuo8Ea7vvQuEC
         TccGpo7sxBp0gKtrl7TNrqgHJQ/KH1/c46mu3TDLnNb/k+nk7SMPXXU77lclX3E8hk
         ya71IEfjdRiqGhoysjjJvhGM51mf4uAgPnBD3Fo9FY/NggYPQqoYKRQ1ytIvzLIr/9
         qvC7k1tmWr9Kh8IXcX3cmU9NJX+6Gl6ZfySXpZ8UnEogcVZM1uhz5EgEGYJyyBxwym
         wvmXK8OHXMN3fqYoqp6YPITm5pQEeSKeI2DK58BX4KHNAqFq+ndkyobrpl4Dpi2rvE
         qxpGv47KGz/Fw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: qcom,dwc3: add binding for SM8450
Date:   Thu, 16 Dec 2021 17:08:49 +0530
Message-Id: <20211216113849.659856-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for USB controller for Qualcomm SM8450 SoC.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 2bdaba023c01..4b0d209dde78 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,sm8150-dwc3
           - qcom,sm8250-dwc3
           - qcom,sm8350-dwc3
+          - qcom,sm8450-dwc3
       - const: qcom,dwc3
 
   reg:
-- 
2.31.1

