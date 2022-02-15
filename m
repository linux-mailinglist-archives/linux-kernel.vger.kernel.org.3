Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECF94B5ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiBOAIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:08:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiBOAIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:08:37 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC34698592;
        Mon, 14 Feb 2022 16:08:27 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21E8pDbi031979;
        Mon, 14 Feb 2022 18:08:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=yvLDbSoOiHYVUaGAf88ObqoKHl+AJqhcwIW4kLXp17U=;
 b=mdCCzRUuL39FHQqgeZsUoemwtPJcqFQGRJ+yhAOz67NN+CYzWx+GaqFevOFyx2xscTnO
 n55VWPvTOnPX9l+FOOjrVFi1YYPjlQrKuAzOALKCCj//OZ2wCsUGcVLeZ2dML+U6ixCN
 uUXKWYUUAeIvO5zd02wZdAy9Z/189y1Q+JlRquMujryJSLp88ZuQDFIGJo/ohk5cWrco
 +qRKlDxuOWTk/7r9PbhySK+psA7V68WPDIl2jrXPnaftWugpiLQXjoZhJRbtMLbedqoz
 lPzzHHElmVglXPHKeBErOwAm1WVKRA12OVfAgSZI5/WBHHg68VLIIu02O6BZBrUBv1Uh /Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3e7kx7rukx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Feb 2022 18:08:19 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 00:08:18 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 15 Feb 2022 00:08:18 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.19])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 41C49B16;
        Tue, 15 Feb 2022 00:08:17 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [PATCH v3 3/3] ABI: testing: sysfs-class-power: Adds "Long Life" entry
Date:   Mon, 14 Feb 2022 18:07:58 -0600
Message-ID: <20220215000758.803501-4-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215000758.803501-1-rriveram@opensource.cirrus.com>
References: <20220215000758.803501-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ADNtf2A49AXMgoohqGVqySN2s59j31vV
X-Proofpoint-GUID: ADNtf2A49AXMgoohqGVqySN2s59j31vV
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a brief desciption of the "Long Life" charge type and adds "Long Life"
to the list of valid values.

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
---
 Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 8e3bf1aa6268..b304fa9c1482 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -380,16 +380,17 @@ Description:
 		algorithm to adjust the charge rate dynamically, without
 		any user configuration required. "Custom" means that the charger
 		uses the charge_control_* properties as configuration for some
-		different algorithm. "Bypass" means the charger bypasses the
-		charging path around the integrated converter allowing for a
-		"smart" wall adaptor to perform the power conversion
-		externally.
+		different algorithm. "Long Life" means the charger reduces its
+		charging rate in order to prolong the battery health. "Bypass"
+		means the charger bypasses the charging path around the
+		integrated converter allowing for a "smart" wall adaptor to
+		perform the power conversion externally.
 
 		Access: Read, Write
 
 		Valid values:
 			      "Unknown", "N/A", "Trickle", "Fast", "Standard",
-			      "Adaptive", "Custom", "Bypass"
+			      "Adaptive", "Custom", "Long Life", "Bypass"
 
 What:		/sys/class/power_supply/<supply_name>/charge_term_current
 Date:		July 2014
-- 
2.25.1

