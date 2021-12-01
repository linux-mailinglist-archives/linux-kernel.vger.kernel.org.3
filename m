Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A834647F0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347287AbhLAH1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347264AbhLAH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:26:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C818C061746;
        Tue, 30 Nov 2021 23:23:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6F53B81DE2;
        Wed,  1 Dec 2021 07:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13698C53FD4;
        Wed,  1 Dec 2021 07:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343411;
        bh=matYzBlnUO2Ojp60sr8aE8r2R8xw8ndin9xmddUfo2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B3pAzZswlz62s5j2Yd3SdutZjMR6JclSxouUctCb9cn4k8rfz/wo7Xu4Tchv4OBcg
         V1sD3bFI7T3xNaa/g9PyfWeRyNMabrdfUENSgzc8C3GqLiQYg+pb61sQ3c/17VK4k3
         g12ogho/edhXC9tztbgbPaUzFH7Uth7ClueAS5St4SW3LppV6+Egu1y7lzFEDzgR2Y
         B0X7GZT0wvE4dpkwLCuh7nZ/zgf7VUpVtFaBCvMHvB8yXye7/yqjtGJf0D45tR8nSz
         GWPasq3gIEEVc7cyyXTvL0LnpYDpwY+ink3tQzAL9tUyaR/5+/14+vEcnk1E9wvYLQ
         qXpE1c5TZEmVQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: clock: Add RPMHCC bindings for SM8450
Date:   Wed,  1 Dec 2021 12:53:08 +0530
Message-Id: <20211201072310.3968679-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072310.3968679-1-vkoul@kernel.org>
References: <20211201072310.3968679-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings and update documentation for clock rpmh driver on SM8450.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
index 72212970e6f5..162701e55953 100644
--- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
@@ -26,6 +26,7 @@ properties:
       - qcom,sm8150-rpmh-clk
       - qcom,sm8250-rpmh-clk
       - qcom,sm8350-rpmh-clk
+      - qcom,sm8450-rpmh-clk
 
   clocks:
     maxItems: 1
-- 
2.31.1

