Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1661C511D41
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbiD0PLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbiD0PK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:10:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EFF33E07
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:07:47 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RBg6q9022428;
        Wed, 27 Apr 2022 10:07:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=XVCfOf6hJlgIzYiqsHcHFyp8cFTHvQ62xx1M2B+16kQ=;
 b=qTUG25Yl1P6vcGET5FF6wSUEoZw+vfUQYV5bmMKw7t/s6O3FNVUnJcbAJyowBW5q3nA1
 zOipFdJWFNlTjNCwCpU4egQHaPGYiRQClqvIU5G2nlDeDXIdxIIsVpiowZ1i1pH38FNp
 HRqenkYwgJ2fH9MJQFLjOZreS5VPl/o+M9SzVQomFGSHSemRsMWI9w4hiOq7LiZUZArW
 VsSo0ryTx01gjdWiLAIR1RhV99mq2zSy13rGlOwJfsQ+oKT3WJ+CFEhITW/Al+JaDiI2
 gRNgH9kdQxzZ1PNUj3a/3a+N3uUSFz+yd5l+QzbLOsaMDyYPa7U4TxkBe78ed2X5FEDl Sg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fprt60xte-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 27 Apr 2022 10:07:30 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 16:07:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 27 Apr 2022 16:07:21 +0100
Received: from vitaly-Legion-7-16ACHg6.ad.cirrus.com (unknown [198.90.238.170])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 53816B1A;
        Wed, 27 Apr 2022 15:07:21 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH 01/26] ALSA: hda: cs35l41: Fix error in spi cs35l41 hda driver name
Date:   Wed, 27 Apr 2022 16:06:55 +0100
Message-ID: <20220427150720.9194-2-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TKhh9rl7Yh5JO5S6LpvYbM0Zjy1bKnIE
X-Proofpoint-ORIG-GUID: TKhh9rl7Yh5JO5S6LpvYbM0Zjy1bKnIE
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Binding <sbinding@opensource.cirrus.com>

For consistency, rename spi cs35l41 hda driver name so that
it matches i2c.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index 50eb6c0e6658..22e088f28438 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -48,7 +48,7 @@ MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_hda_match);
 
 static struct spi_driver cs35l41_spi_driver = {
 	.driver = {
-		.name		= "cs35l41_hda",
+		.name		= "cs35l41-hda",
 		.acpi_match_table = ACPI_PTR(cs35l41_acpi_hda_match),
 	},
 	.id_table	= cs35l41_hda_spi_id,
-- 
2.32.0

