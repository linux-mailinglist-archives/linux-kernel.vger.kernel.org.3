Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1E4494C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiATK5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:57:06 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:13254 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229951AbiATK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:57:04 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K4mpaE024668;
        Thu, 20 Jan 2022 04:56:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=euN68nd5YAlW/BA+lmkUTwFBJNJ7HjWDXKMiti0Rxx8=;
 b=j2znbKDN76IjBz6yq+D/KpT5bFOxq8fL2wOR6BQlY0S+MHHB9Pd9+4b2W2x7ohYkKUzx
 FIPMv44D1CnX4JT3rsM696qJp9LXd17Vwz1Kn8gY+H/v8OveYm1rezpfQjKedgSBfL+x
 L5b7vs9MwLekBCplPONGeTs4T0vV0dndDorHLwEyUW4LGfy4zaJPXyb6rvb26BsVC8Qs
 Yp/SfV8RLvAEZH2JzXrG4kbSYqCLSHcqPoEhoOkv6/vVZKeDySN9vdAdmeyfTZ3vqVMB
 qOKfrV3WSQcjYofJwsvC3AS6Wx9/a4pbebmVT1DJ9FNlJzNQOX94ZWQ1feAiaRDYsG9L rA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dpk9mh39e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Jan 2022 04:56:21 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 10:56:19 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 20 Jan 2022 10:56:19 +0000
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.196])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D099546D;
        Thu, 20 Jan 2022 10:56:18 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA: hda/cs8409: Add new Warlock SKUs to patch_cs8409
Date:   Thu, 20 Jan 2022 10:56:18 +0000
Message-ID: <20220120105618.249144-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UnC3zu0dMcrNO6GV0JL1xls1YwvMcDeG
X-Proofpoint-GUID: UnC3zu0dMcrNO6GV0JL1xls1YwvMcDeG
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/patch_cs8409-tables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_cs8409-tables.c b/sound/pci/hda/patch_cs8409-tables.c
index df0b4522babf..2d1fa706327b 100644
--- a/sound/pci/hda/patch_cs8409-tables.c
+++ b/sound/pci/hda/patch_cs8409-tables.c
@@ -490,6 +490,8 @@ const struct snd_pci_quirk cs8409_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x0ADC, "Warlock", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0AF4, "Warlock", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0AF5, "Warlock", CS8409_WARLOCK),
+	SND_PCI_QUIRK(0x1028, 0x0BB5, "Warlock N3 15 TGL-U Nuvoton EC", CS8409_WARLOCK),
+	SND_PCI_QUIRK(0x1028, 0x0BB6, "Warlock V3 15 TGL-U Nuvoton EC", CS8409_WARLOCK),
 	SND_PCI_QUIRK(0x1028, 0x0A77, "Cyborg", CS8409_CYBORG),
 	SND_PCI_QUIRK(0x1028, 0x0A78, "Cyborg", CS8409_CYBORG),
 	SND_PCI_QUIRK(0x1028, 0x0A79, "Cyborg", CS8409_CYBORG),
-- 
2.25.1

