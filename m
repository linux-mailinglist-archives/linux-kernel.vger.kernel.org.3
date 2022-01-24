Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92F04980B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbiAXNOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:14:19 -0500
Received: from h03mx16.reliablemail.org ([173.236.90.20]:16942 "EHLO
        h03mx16.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiAXNOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:14:16 -0500
X-Halon-Out: 8725e4ee-7d17-11ec-a67c-00163c72d6d3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=f55NchOZwSBusfmJsrIVv7pqGW5tH7bswQNbon6anEU=; b=qoHBZJK1wPOWRe96Jqj25TDwKc
        BJyPmEq8mh3VrLXCxmDfOa9byiW/TelVqQkh7u/+2jL/FG3LP5/slU5Dp0j5fg1jXZ7kPwPgeNcKH
        JXQ1on88oUsaLMqwqjInAXV6leYPapXcPMz4eY4ffeOrMlXl2p/lqNJQRc+5gOBVIxC22RN6XU2O2
        KpjsMihOA/4SCsw+z3PqpSmzI1AI1iaTN0ffA0fc0rVn9eMc8Gw3NBCe+/2obF/GgLpod6fbYWjPg
        NflNFyoXBiIZZYNXsD2WwTK0TWuftu/yKHB8wXlFqSBXNiiTcNTmZd+MpjfJ2HPyp9joyvR5kmhtj
        Q5QwpEGg==;
From:   Henrik Grimler <henrik@grimler.se>
To:     krzysztof.kozlowski@canonical.com, semen.protsenko@linaro.org,
        virag.david003@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, alim.akhtar@samsung.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 1/2] dt-bindings: arm: samsung: document Klimt WiFi board binding
Date:   Mon, 24 Jan 2022 14:12:40 +0100
Message-Id: <20220124131241.29946-2-henrik@grimler.se>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124131241.29946-1-henrik@grimler.se>
References: <20220124131241.29946-1-henrik@grimler.se>
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

Add binding for Galaxy Tab S 8.4", based on Exynos 5420 with codename
klimt-wifi.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index a2a8bf44fe9b..faea33e4f731 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -141,6 +141,7 @@ properties:
           - enum:
               - insignal,arndale-octa           # Insignal Arndale Octa
               - samsung,chagall-wifi            # Samsung SM-T800
+              - samsung,klimt-wifi              # Samsung SM-T700
               - samsung,smdk5420                # Samsung SMDK5420 eval
           - const: samsung,exynos5420
           - const: samsung,exynos5
-- 
2.34.1

