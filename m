Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D70A478BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbhLQM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:58:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49794 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbhLQM6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:58:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E504262166;
        Fri, 17 Dec 2021 12:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CC9C36AEA;
        Fri, 17 Dec 2021 12:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639745884;
        bh=pHMtGWbLEqRF6ha7t9sW06OfJiHkfnSAuviVUpxCnQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ndn/LzTipdID0YRiTnukiAQqIdGwTsx3GZszJBE+OfTCuuLEPL0/iSG7bK/Vpw/e8
         Zugl7kH5Uf+NYVwQp/HxleW3Dj+krJBSmMQwGY8cgHt3s9HbFgFq1q31EDbXPazFvA
         tZ/biGHE8eptN+cDjL6/jAt8lR3Lq0rLmb/u/5PjYGIwL8oFn5SYQgN2RPZboteu8t
         sJ9f6jpoyHb4AuiTOcR2WpVBXx0d4WtjdRIGkX2kp7EZFMACpdMxURorFlwa93myZS
         cX4BCTKxQlsSaqiZ+ZzZdpbjuyDgAuGPr2e9Ir9tNAQ6/zj0y0C3rF3kCF9jSOwSXw
         JwY+c6A/n1s8A==
From:   Felipe Balbi <balbi@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@microsoft.com>
Subject: [RFC/patch 1/2] arm64: boot: dts: qcom: sm8150: add a label for reserved-memory
Date:   Fri, 17 Dec 2021 14:57:56 +0200
Message-Id: <20211217125757.1193256-2-balbi@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217125757.1193256-1-balbi@kernel.org>
References: <20211217125757.1193256-1-balbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <felipe.balbi@microsoft.com>

With this label, we can let boards append board-specific memory
regions which should not be mapped.

Signed-off-by: Felipe Balbi <felipe.balbi@microsoft.com>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 15348512cf9e..26f9eb8e9b42 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -660,7 +660,7 @@ CLUSTER_PD: cpu-cluster0 {
 		};
 	};
 
-	reserved-memory {
+	reserved_memory: reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-- 
2.34.1

