Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD548F7DA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiAOQdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:33:36 -0500
Received: from h02mx15.reliablemail.org ([185.76.66.168]:61212 "EHLO
        h02mx15.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiAOQdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:33:35 -0500
X-Halon-Out: 091f04e8-7620-11ec-930f-f5be715b97e5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U6p2/hhR+trjs5sFnpqmdNqE9AKwpYpz7RTLmmUkLI0=; b=jXLzM+itShn61QuYA3FXuFrfoq
        RrSV4tHDvTz9t2/S1TiyPEJkWDLXRzi5+MAV/fA6oPXmxuNd767X9MEDW+DQQANO5wvyGib46vGEV
        sGmgaySUX/63CpageNjlZErMd7DgGYMQiXnvFnNC1YQ5TjR6cMgkiosYHAyg4xmA3OIAxyM+S46xz
        xzeamdH+SYqaAcKQeyTMDr6mPnSUYfocGa1reMop9Vp+CxZwKpIowMdcPKC8WY7JgLwEylJd8KVih
        aoxcWeKeSEVUB6E9Lz27Od1albWTbjDSkDP5C4XtEYSPDcEIjFqQahtvZGBehMV+X73EwT/QRK75g
        s2fbC/JQ==;
From:   Henrik Grimler <henrik@grimler.se>
To:     semen.protsenko@linaro.org, virag.david003@gmail.com,
        martin.juecker@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, alim.akhtar@samsung.com,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH v2 1/3] dt-bindings: arm: samsung: document chagallwifi board binding
Date:   Sat, 15 Jan 2022 17:27:01 +0100
Message-Id: <20220115162703.699347-2-henrik@grimler.se>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220115162703.699347-1-henrik@grimler.se>
References: <20220115162703.699347-1-henrik@grimler.se>
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

