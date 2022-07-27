Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4D5823A7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiG0KAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiG0KAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:00:25 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916FA2BF8;
        Wed, 27 Jul 2022 03:00:24 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R4SNEe032560;
        Wed, 27 Jul 2022 04:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=T6+2mzXRPTLTtBq7x98yRAkPxVcb5dHCe1xJUV91oCI=;
 b=TNYSGwwh76BBHIpY0CGeSe+1YzJO9YFfbaisikwUU0yT4Gs10ICv3Pu9nAxmuUHshM43
 9X9DDDTUdbLsTI9hxdNgKJng86o6D4V5amkqeLMwSaJEc9lAIaDdYRzBXmXzc0Ym+Pd/
 NWbzdtjG8fX6hgZfKwNTBcrHcOUy6ayhxsqmP+AUiA4Qh/5x/AVSuUxtsuhS0PnIPqep
 rYuci/HcCGKHQPXn6JlzB4gdrsDID49bFQ9zcni9ZgIdSDc3dFFpX9S/aORkaj9w5fA6
 rKGZxgbSXvFCK6tCOD8aixzcnwExc2Cg8aY0ky9sOMIDJvH1yHDxpoWuZLHtkWYfN1Yd ig== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hged1vtk5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:59:31 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 27 Jul
 2022 04:59:29 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Wed, 27 Jul 2022 04:59:29 -0500
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.94])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4FDF02D4;
        Wed, 27 Jul 2022 09:59:29 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Cameron Berkenpas <cam@neo-zeon.de>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 4/4] platform/x86: serial-multi-instantiate: Add CLSA0101 Laptop
Date:   Wed, 27 Jul 2022 10:59:24 +0100
Message-ID: <20220727095924.80884-5-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
References: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KwUWKi34NrhthI5lpKwmDqaU7d1As0EB
X-Proofpoint-ORIG-GUID: KwUWKi34NrhthI5lpKwmDqaU7d1As0EB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device CLSA0101 has two instances of CS35L41
connected by I2C.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 drivers/platform/x86/serial-multi-instantiate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 67feed25c9db..5362f1a7b77c 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -328,6 +328,7 @@ static const struct acpi_device_id smi_acpi_ids[] = {
 	{ "INT3515", (unsigned long)&int3515_data },
 	/* Non-conforming _HID for Cirrus Logic already released */
 	{ "CLSA0100", (unsigned long)&cs35l41_hda },
+	{ "CLSA0101", (unsigned long)&cs35l41_hda },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, smi_acpi_ids);
-- 
2.37.1

