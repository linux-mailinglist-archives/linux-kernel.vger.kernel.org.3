Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFF946481C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347386AbhLAH3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347373AbhLAH2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:28:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFEBC061757;
        Tue, 30 Nov 2021 23:25:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 589E8CE1D67;
        Wed,  1 Dec 2021 07:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB26C53FD3;
        Wed,  1 Dec 2021 07:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343528;
        bh=RPCOcElDh6GCMU7cQoyYSvQ2DST2lJDoZJ49UXUoXM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GUBx4b9kxGrx2hliHuHMx/QfT0QkKikoyUoapBP3drbW3jaqL3vk4XEd0QKS2qun9
         +JTv+wB3v/pOhOP/6V8mtqKDUV6BwawazX3sbefcR6a4l/z0UMnbyf++07ur+YxDGc
         27is6KKQD6LlcEhCc9oKf7OC8RpP5rAi6epA1UMXCjjW31acvtMYrIF+S8D3DXPoSm
         Z3d+rVsKcm/AyLxlK+uWleKj8ArtefEku6z2lgJeqES6WoGbO4iZBRZ/Ef0kFdA/DA
         pfJUBYot3CN2akZZnSnk4ts3EX0IEGZBE50c2VSaJuLLKunPWVngTXI1RPPhUbr0UX
         FkAqFO9CznC1Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] regulator: qcom,rpmh: Add compatible for PM8450
Date:   Wed,  1 Dec 2021 12:55:14 +0530
Message-Id: <20211201072515.3968843-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072515.3968843-1-vkoul@kernel.org>
References: <20211201072515.3968843-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for PM8450 used in SM8450 boards.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index b959504e0ea4..6c04f256d497 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -43,6 +43,7 @@ description: |
       For PM8150L, smps1 - smps8, ldo1 - ldo11, bob, flash, rgb
       For PM8350, smps1 - smps12, ldo1 - ldo10
       For PM8350C, smps1 - smps10, ldo1 - ldo13, bob
+      For PM8450, smps1 - smps6, ldo1 - ldo4
       For PM8998, smps1 - smps13, ldo1 - ldo28, lvs1 - lvs2
       For PMI8998, bob
       For PMR735A, smps1 - smps3, ldo1 - ldo7
@@ -62,6 +63,7 @@ properties:
       - qcom,pm8150l-rpmh-regulators
       - qcom,pm8350-rpmh-regulators
       - qcom,pm8350c-rpmh-regulators
+      - qcom,pm8450-rpmh-regulators
       - qcom,pm8998-rpmh-regulators
       - qcom,pmi8998-rpmh-regulators
       - qcom,pmm8155au-rpmh-regulators
-- 
2.31.1

