Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0805823A4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiG0KA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiG0KAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:00:25 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C5D10DC;
        Wed, 27 Jul 2022 03:00:24 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26R4SNEd032560;
        Wed, 27 Jul 2022 04:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4GMh/xGa5TNYNqY554M0oZkoPr+GvTe1jc7k9ZTapsY=;
 b=XUp2LLOqcknXoF0P0iMQBihxtbaw61wYS4emhJx9mhaWQGYQW8n7hQ3h3HAxWIo2xeFP
 PrDZal03qNwFNgKE48Wer4kiaxMNrTfaF70k0yft5w0IH7tpmdCkRAE4LkKOmmvaQiq5
 NAN6yUxiXbM1pp7rfbL7YByKExBYCAonwgUyYn044bs1WI1LNZpB4PW1dgLfvPH2ujIS
 Z9EnWM/15AspyGRvbhX0SJrDBQU/9ElqCE7Om+LCwFVCzimUHWcXBvpIQC2N4GKzXS27
 z8ygA+nFZ/2nIgDaSTPMbWp7WZJoez7ddtezIHySwfeTizUwd/PWW5tQ5oKHVHP12Uav ig== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hged1vtk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 04:59:30 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 27 Jul
 2022 04:59:28 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Wed, 27 Jul 2022 04:59:28 -0500
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.94])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 25CCB477;
        Wed, 27 Jul 2022 09:59:28 +0000 (UTC)
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
Subject: [PATCH v2 1/4] ALSA: hda: cs35l41: Use the CS35L41 HDA internal define
Date:   Wed, 27 Jul 2022 10:59:21 +0100
Message-ID: <20220727095924.80884-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
References: <20220727095924.80884-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4fn0EyL3NZu1_JRPPHSh5zWMTgrohK_a
X-Proofpoint-ORIG-GUID: 4fn0EyL3NZu1_JRPPHSh5zWMTgrohK_a
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow GPIO1 pattern, use cs35l41 HDA internal define for
IRQ and then translate to ASoC cs35l41 define.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 28798d5c1cf1..48d94c683b75 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1014,6 +1014,7 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 			break;
 		case CS35L41_INTERRUPT:
 			using_irq = true;
+			hw_cfg->gpio2.func = CS35L41_GPIO2_INT_OPEN_DRAIN;
 			break;
 		default:
 			dev_err(cs35l41->dev, "Invalid GPIO2 function %d\n", hw_cfg->gpio2.func);
@@ -1273,7 +1274,7 @@ static int cs35l41_hda_read_acpi(struct cs35l41_hda *cs35l41, const char *hid, i
 	cs35l41->reset_gpio = gpiod_get_index(physdev, NULL, 0, GPIOD_OUT_HIGH);
 	cs35l41->hw_cfg.bst_type = CS35L41_EXT_BOOST_NO_VSPK_SWITCH;
 	cs35l41->speaker_id = cs35l41_get_speaker_id(physdev, 0, 0, 2);
-	hw_cfg->gpio2.func = CS35L41_GPIO2_INT_OPEN_DRAIN;
+	hw_cfg->gpio2.func = CS35L41_INTERRUPT;
 	hw_cfg->gpio2.valid = true;
 	cs35l41->hw_cfg.valid = true;
 	put_device(physdev);
-- 
2.37.1

