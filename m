Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261AE492DFE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 19:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348546AbiARS6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 13:58:17 -0500
Received: from h01mx20.reliablemail.org ([173.236.5.222]:34801 "EHLO
        h01mx20.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348510AbiARS6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 13:58:11 -0500
X-Halon-Out: 937473e3-7890-11ec-90dc-00163c81f1a9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=1FcLjva00SLkPxQdscGEux0R9htdpzwYk7cdxDo4J5g=; b=ElZvChBSckCfwQSjyL/3ab4ghH
        DwS8+DX0sjJd4XKxRUiNiwFBNctozWvNT0AL9Jp7FlVK0bNRFZCz8xwyBOZotE1sTTMDCAlSaAoj2
        o+6F9TSmUlmnCAo/tR9BSwSd244UFh9qZWrLNxubJLsZT1SwXPdkqEv91asb6V4N6FdUgXGjP6LLf
        K6CY0gr3za4ksAeReTFtoURWFdcjzRLySTr7yaH8gEJ9vnrovBPl5O7CqS+V7tnyr2ORBWZHrts8D
        7a3vz3YX0j/z5mF1QQPCsbXEJ072cWMh0HtBogNgJc+DntuINDoVaZlLibI4yf9MUErteZJcyseDu
        ygoaHy6A==;
From:   Henrik Grimler <henrik@grimler.se>
To:     semen.protsenko@linaro.org, virag.david003@gmail.com,
        martin.juecker@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, alim.akhtar@samsung.com,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH v4 1/3] dt-bindings: arm: samsung: document Chagall WiFi board binding
Date:   Tue, 18 Jan 2022 19:57:44 +0100
Message-Id: <20220118185746.299832-2-henrik@grimler.se>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220118185746.299832-1-henrik@grimler.se>
References: <20220118185746.299832-1-henrik@grimler.se>
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
codename chagall-wifi. It was released in 2014 and has several siblings
with similar hardware.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index 052cd94113d4..a2a8bf44fe9b 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -140,6 +140,7 @@ properties:
         items:
           - enum:
               - insignal,arndale-octa           # Insignal Arndale Octa
+              - samsung,chagall-wifi            # Samsung SM-T800
               - samsung,smdk5420                # Samsung SMDK5420 eval
           - const: samsung,exynos5420
           - const: samsung,exynos5
-- 
2.34.1

