Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A71464842
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbhLAHbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:31:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58966 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhLAHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:31:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83DE7B81DBD;
        Wed,  1 Dec 2021 07:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3636EC53FAD;
        Wed,  1 Dec 2021 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343691;
        bh=3PVz2V9iNQllJFoHEamrh6hw7ZtHslowFrxYxgzf2/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2V+mtxIyeGE6hG2VyLU9BiKTzAjjXvRju4rNVj8A2LG5KrUtUwfJGVs6SLD4tYr+
         W+58G4qaDbeyxf5YIHq9HYuQcGoWY447RnT0JTr63BalSNBleh1J6yOJY1lpq/3s7D
         ys8HW+uJrOBH5WW5jGKECTfODDt4gq2cFrKi+sz7VgX/j62UQtjnf2coJbTPMAu/Di
         8DFU2wTDBJuP9JrT/lOjBMXtoneC025c1xEgEPFsxfo6JDDF+Ntk5ZBCvUsdhqKXzG
         LXwV3+kgMA2vVkrTJC/ec2FdGztpZajEogETffp1sB6lGXW7m1piBI/TrEErVmH1ev
         OfDVcHSz5Ntyg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: arm: cpus: Add kryo780 compatible
Date:   Wed,  1 Dec 2021 12:57:39 +0530
Message-Id: <20211201072745.3969077-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072745.3969077-1-vkoul@kernel.org>
References: <20211201072745.3969077-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kryo780 is found in SM8450, so add it to the list of cpu compatibles

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index f2ab6423b4af..dfa28e3525cb 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -174,6 +174,7 @@ properties:
       - qcom,kryo560
       - qcom,kryo570
       - qcom,kryo685
+      - qcom,kryo780
       - qcom,scorpion
 
   enable-method:
-- 
2.31.1

