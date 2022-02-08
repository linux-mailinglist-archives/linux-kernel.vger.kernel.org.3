Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB984AD1E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 08:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347832AbiBHHDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 02:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiBHHDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:03:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B3EC0401EF;
        Mon,  7 Feb 2022 23:03:15 -0800 (PST)
Received: from kwepemi100019.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JtDT25kH9z9sWj;
        Tue,  8 Feb 2022 15:01:42 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (7.193.23.208) by
 kwepemi100019.china.huawei.com (7.221.188.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 15:03:13 +0800
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 15:03:12 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>
CC:     <kernel.yuz@gmail.com>, <wanghaibin.wang@huawei.com>,
        <wangjingyi11@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] dt-bindings: arm: Trivial typo fixes in cpu-capacity.txt
Date:   Tue, 8 Feb 2022 15:03:00 +0800
Message-ID: <20220208070300.1610-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the spelling of 'cluster1@max-freq' and fix the wrong
capacity-dmips-mhz value 576 (which should be 578 instead).

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 Documentation/devicetree/bindings/arm/cpu-capacity.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/cpu-capacity.txt b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
index 380e21c5fc7e..cc5e190390b7 100644
--- a/Documentation/devicetree/bindings/arm/cpu-capacity.txt
+++ b/Documentation/devicetree/bindings/arm/cpu-capacity.txt
@@ -62,8 +62,8 @@ Example 1 (ARM 64-bit, 6-cpu system, two clusters):
 The capacities-dmips-mhz or DMIPS/MHz values (scaled to 1024)
 are 1024 and 578 for cluster0 and cluster1. Further normalization
 is done by the operating system based on cluster0@max-freq=1100 and
-custer1@max-freq=850, final capacities are 1024 for cluster0 and
-446 for cluster1 (576*850/1100).
+cluster1@max-freq=850, final capacities are 1024 for cluster0 and
+446 for cluster1 (578*850/1100).
 
 cpus {
 	#address-cells = <2>;
-- 
2.19.1

