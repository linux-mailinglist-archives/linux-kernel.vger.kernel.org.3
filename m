Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09E472D00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbhLMNPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237283AbhLMNPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:15:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C918C061574;
        Mon, 13 Dec 2021 05:15:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C9792CE1021;
        Mon, 13 Dec 2021 13:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36D1C34609;
        Mon, 13 Dec 2021 13:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639401306;
        bh=ZSkrJr5jeIX9QM42d2p88YBZcxwTdx2H/m0sT26M48g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QAJ+o+Oq+h3S+HVI6cs3fMIs3R8JPPbhNzXgdn3uBaUZwjWg6of4ZmBR5zdyVPpyp
         K62C43kK7aQq+K3FkWzsEY5sNB2zvPAK0WucA+VjYapqk57gwXbYCr0JCcDZ1nRC0W
         3FUALxGhZnmnqGGbiGEzP4Lblpm06raxb0FjDdQYax0sfUkyOKclZ45NuW+gSYGBuc
         cYjHYtNIUW8VMKsqShTxH3STSNB7WningNJmuNSre67+fEAowNwoVKbYWAMoj9RDgT
         xWL5jnZ1ZQe1zW42EovzBLKNMXXRQ+NnZtt+98NooFFYfd0UYerY5YjhKW2QmKpBre
         AulJEVNqI+Jew==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: phy: qcom,qmp: Add SM8450 USB3 PHY
Date:   Mon, 13 Dec 2021 18:44:49 +0530
Message-Id: <20211213131450.535775-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211213131450.535775-1-vkoul@kernel.org>
References: <20211213131450.535775-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for USB QMP phy in Qualcomm SM8450 SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index c59bbca9a900..d625a6fe0205 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -51,6 +51,7 @@ properties:
       - qcom,sm8350-qmp-usb3-phy
       - qcom,sm8350-qmp-usb3-uni-phy
       - qcom,sm8450-qmp-ufs-phy
+      - qcom,sm8450-qmp-usb3-phy
       - qcom,sdx55-qmp-pcie-phy
       - qcom,sdx55-qmp-usb3-uni-phy
 
-- 
2.31.1

