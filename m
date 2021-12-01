Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABA4464846
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347453AbhLAHbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:31:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59022 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhLAHbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:31:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DD8BB81DBF;
        Wed,  1 Dec 2021 07:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED5CC53FCE;
        Wed,  1 Dec 2021 07:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343694;
        bh=iG78YUkE9IoL0SXtf24gYqzCj5HG0i9+ICaEr61V23o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hgDxhFi9l7QE8HRnFCNINf5YHHptBm1k0dJv4wx6COexAfQbrVGguKkSMG4hgBwFv
         dDace2qRndLU/HRItran+fAGgiZqlY+Bz2mi4cGuWGiSN0aD+KvX9dxdzKtidaUo9d
         QK3Ff6Dgg0cwbVAcBtDiCku2ClXFkt8e++TVhwh4N0THqC5A6psq9h7ekjKoqzwVYW
         5VS/L6ZpeQz5vYC88bBVtaFlQJle5U/05DS729qV2TieBhv4XbXkyRC8pLtH3zmoph
         wQIDUh7GSwo01QbumS468pl92jFGFg3b+iqE1KX5Ei50ob7HwtdYhgRdzA094sfvIa
         kDdjXVLt4EnGQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dt-bindings: firmware: scm: Add SM8450 compatible
Date:   Wed,  1 Dec 2021 12:57:40 +0530
Message-Id: <20211201072745.3969077-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072745.3969077-1-vkoul@kernel.org>
References: <20211201072745.3969077-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for SM8450 SoCs.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index d7e3cda8924e..548733388497 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -29,6 +29,7 @@ Required properties:
  * "qcom,scm-sm8150"
  * "qcom,scm-sm8250"
  * "qcom,scm-sm8350"
+ * "qcom,scm-sm8450"
  and:
  * "qcom,scm"
 - clocks: Specifies clocks needed by the SCM interface, if any:
-- 
2.31.1

