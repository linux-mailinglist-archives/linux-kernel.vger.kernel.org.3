Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8254C730D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiB1Rbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiB1RaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:30:06 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAABC39141;
        Mon, 28 Feb 2022 09:28:16 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21SFwZIi005113;
        Mon, 28 Feb 2022 11:28:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=hJyMgu10+wDVVVmx3Uz2z1AZCqWoyXyWQeA8jODxgcU=;
 b=NWo0/pFmdBE5l35It4SLiVOMW9FocenTW9+5OPtfww8JmLcwKzYOcBAn/3/McZMoam3b
 gZ3ErTzwRqClezgiRYhZsmcxRZenjBClcpnu7ZEyEumMGnbcrnbP3q/q1/h7CUuW321N
 9cmIxGkJizYUliXOI8rVHJIm5HTL7S8KwnGljUGsd4tSrWUkYofKPFQikGFod6mdpLeO
 Xt4Nfxx/l7vXkogCGkbdwdnVFEjz44E7fiqN9pBbsrT6zOPE2nfuXS+af5+RWPti8m61
 5xaM3ehjXN59dq7ERyRF+m6Esanmb2bl1NirhCOXq2eOJ5LmPeFihZFD3tqHSxca0yIk GQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3efjg5thq9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Feb 2022 11:28:00 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 17:27:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 28 Feb 2022 17:27:58 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.213])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D0E3B11D1;
        Mon, 28 Feb 2022 17:27:57 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH V3 1/2] ASoC: dt-bindings: audio-graph-port: Add dai-tdm-slot-width-map
Date:   Mon, 28 Feb 2022 17:27:53 +0000
Message-ID: <20220228172754.453783-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220228172754.453783-1-rf@opensource.cirrus.com>
References: <20220228172754.453783-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: gjOhI31-cuws5YeiF9dweQtsVHZUV4Wf
X-Proofpoint-ORIG-GUID: gjOhI31-cuws5YeiF9dweQtsVHZUV4Wf
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some audio hardware cannot support a fixed slot width for all sample
widths, or a slot width equal to the sample width for all sample widths.
This is usually due either to limitations of the audio serial port or
system clocking restrictions.

This property allows setting a mapping of sample widths and the
corresponding tdm slot widths. The slot count is also provided for
each slot width - although this would almost always be the same for
all slot widths this allows for possibly adding extra padding slots
to maintain a fixed bitclock frequency.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 .../bindings/sound/audio-graph-port.yaml      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 476dcb49ece6..5c368674d11a 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -71,4 +71,24 @@ patternProperties:
         description: CPU to Codec rate channels.
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      dai-tdm-slot-width-map:
+        description: Mapping of sample widths to slot widths. For hardware
+          that cannot support a fixed slot width or a slot width always
+          equal to sample width. A matrix of one or more 3-tuples.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        items:
+          items:
+            -
+              description: Sample width in bits
+              minimum: 8
+              maximum: 64
+            -
+              description: Slot width in bits
+              minimum: 8
+              maximum: 256
+            -
+              description: Slot count
+              minimum: 1
+              maximum: 64
+
 additionalProperties: true
-- 
2.30.2

