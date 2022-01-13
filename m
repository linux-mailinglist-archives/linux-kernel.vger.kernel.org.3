Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F39A48DAF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbiAMPqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:46:46 -0500
Received: from h04mx16.reliablemail.org ([185.76.67.209]:51400 "EHLO
        h04mx16.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiAMPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:46:44 -0500
X-Halon-Out: 28bef255-7487-11ec-a232-556aad082471
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U6p2/hhR+trjs5sFnpqmdNqE9AKwpYpz7RTLmmUkLI0=; b=MNiRHcuLP5f0A0P2rFi2KsJ2SU
        ZkE3EN9pPswt86n4QVw15bS3GhiDkUJsChbfl+XIti5QajMlQW9xHkyySYBGYuw4QUwpLMNoOaLtb
        wHmwl/NLAs9LvFF5TtIjJ6egGVl3+EPbhJGBcAMObocVJ7uWC0CLe5+612xgw3z8V43hu767y2Udp
        joC9YNl7Nm3Iy8Y2bV03dX95D2MhKLnZkU2mt3Fvv7POU8yWUwk2H32uDHuu13mXE2e87yRNCqaQ1
        xG6h18pHSeXpvgpeSPQ2qML+flUuiRuBWPt0wXECu0SLwVk8K4s49/C+0IOx3YUg7w1F+w///TpSm
        8l8a34tw==;
From:   Henrik Grimler <henrik@grimler.se>
To:     semen.protsenko@linaro.org, virag.david003@gmail.com,
        martin.juecker@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, alim.akhtar@samsung.com,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 1/3] dt-bindings: arm: samsung: document chagallwifi board binding
Date:   Thu, 13 Jan 2022 16:40:17 +0100
Message-Id: <20220113154019.74434-2-henrik@grimler.se>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113154019.74434-1-henrik@grimler.se>
References: <20220113154019.74434-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for Samsung Galaxy Tab S 10.5", based on Exynos 5420 with
codename chagallwifi. It was released in 2014 and has several siblings
with similar hardware.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index 052cd94113d4..3f2ffb0d7b46 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -140,6 +140,7 @@ properties:
         items:
           - enum:
               - insignal,arndale-octa           # Insignal Arndale Octa
+              - samsung,chagallwifi             # Samsung SM-T800
               - samsung,smdk5420                # Samsung SMDK5420 eval
           - const: samsung,exynos5420
           - const: samsung,exynos5
-- 
2.34.1

