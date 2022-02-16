Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A447B4B8F54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbiBPRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:40:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiBPRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:40:25 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0372B2AE05C;
        Wed, 16 Feb 2022 09:40:11 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21G6UxbE014900;
        Wed, 16 Feb 2022 11:14:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Uh8AyLBAG4qIzsXNtiDc4oAV8d43DRpyK27/SmkxrXI=;
 b=C4FEsU/SbZiEN/V7aec/JvBlpjAIru3LwG4yVGURFOzXtQJAnRpCohYRsW9GJhG8CHW3
 kb59zC86EV44kf97PCU+0/6+CaR3WZu4l5lBl77JoYHEMEA5sSkFj3xzBdMGe4jsWRIB
 0gpPauDbWX69viYFia6ifoAi7auQCrxwxRm8Ztz68bTYDTAWmEAibiwsm/qy4rYaEx0f
 2QnXF4ytHDV/DA6kzqTlamotXaGZMBfrGEVxMncbBAWbV1A1ol1PK52X5zUn+vNnuL72
 lKJt3bmmO6FLvNQPlAh1b2RRUJs3joKn0QeAHf4DFnk7elvA4MuybZBhp7PkxSxuHzaD Nw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3e8nyd93rr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Feb 2022 11:14:15 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 17:14:13 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 16 Feb 2022 17:14:13 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.199])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2B1E811DC;
        Wed, 16 Feb 2022 17:14:13 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: dt-bindings: audio-graph-port: Add dai-tdm-slot-width-map
Date:   Wed, 16 Feb 2022 17:14:07 +0000
Message-ID: <20220216171408.265605-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220216171408.265605-1-rf@opensource.cirrus.com>
References: <20220216171408.265605-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ipEvqLdick702ohdfgV-Ews6s1a_3PFl
X-Proofpoint-ORIG-GUID: ipEvqLdick702ohdfgV-Ews6s1a_3PFl
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some audio hardware cannot support a fixed slot width or a slot width
equal to the sample width in all cases. This is usually due either to
limitations of the audio serial port or system clocking restrictions.

This property allows setting a mapping of sample widths and the
corresponding tdm slot widths.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 .../devicetree/bindings/sound/audio-graph-port.yaml        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 476dcb49ece6..420adad49382 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -71,4 +71,11 @@ patternProperties:
         description: CPU to Codec rate channels.
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      dai-tdm-slot-width-map:
+        description: Mapping of sample widths to slot widths. For hardware that
+          cannot support a fixed slot width or a slot width equal to sample
+          width. An array containing one or more pairs of values. Each pair
+          of values is a sample_width and the corresponding slot_width.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+
 additionalProperties: true
-- 
2.30.2

