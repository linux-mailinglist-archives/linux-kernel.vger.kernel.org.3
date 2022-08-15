Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055245931C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiHOP3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 11:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHOP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 11:29:38 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50ED1658C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 08:29:37 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FBN0T3023234;
        Mon, 15 Aug 2022 10:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=PFUH9P7TYQY6V5hI/Q7v0wHt4DryK2p1UkfQTaLLTa0=;
 b=Z935sQFymRb6MU2n+6Wp0RgjqZNbmmEW+PoQbNYHPicFpGgYrEnmG1EOLlI01HGCl8/I
 mbPQIvbB6neI+WZhxDObkZ3sUHYdyWA98ZiEu3oF2mD+TDxCFmVdhUQw/9D1mgc1TGRt
 ZF+zN7hZw1VXFlyxEw0dkhm2NmnOsFbU8aJo6DYsWeN7LaPAUEi/avTGJa/yDa7q4aCh
 N0i9ijXHAarm9/zQ3LJ1AfTBgLdaBhmes/tU5i2g84DONHK5ImbIV5RPxedI7dDsU5GD
 +qzioml3pY9NgFmH3ZbbZ5/oRYRhaHwndVGdNZXfQu748FUAcpJnVOQiqCmaTdYhKkFl 0w== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hx9c1tcm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 10:28:53 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Mon, 15 Aug
 2022 10:28:51 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Mon, 15 Aug 2022 10:28:51 -0500
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2E567B06;
        Mon, 15 Aug 2022 15:28:51 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1] ALSA: hda: cs35l41: Clarify support for CSC3551 without _DSD Properties
Date:   Mon, 15 Aug 2022 16:28:44 +0100
Message-ID: <20220815152844.462229-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tJG7ppFwiCmZOZ_8CJJrMW_PTNs0s499
X-Proofpoint-GUID: tJG7ppFwiCmZOZ_8CJJrMW_PTNs0s499
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices which use HID CSC3551, correct ACPI _DSD properties are
required to be able support those systems.
Add error message to clarify this.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 129bffb431c2..b9d94f3a5b99 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1163,6 +1163,11 @@ static int cs35l41_no_acpi_dsd(struct cs35l41_hda *cs35l41, struct device *physd
 		hw_cfg->gpio1.func = CS35l41_VSPK_SWITCH;
 		hw_cfg->gpio1.valid = true;
 	} else {
+		/*
+		 * Note: CLSA010(0/1) are special cases which use a slightly different design.
+		 * All other HIDs e.g. CSC3551 require valid ACPI _DSD properties to be supported.
+		 */
+		dev_err(cs35l41->dev, "Error: ACPI _DSD Properties are missing for HID %s.", hid);
 		hw_cfg->valid = false;
 		hw_cfg->gpio1.valid = false;
 		hw_cfg->gpio2.valid = false;
-- 
2.34.1

