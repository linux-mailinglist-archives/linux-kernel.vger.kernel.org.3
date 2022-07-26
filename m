Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752545810E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiGZKMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbiGZKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:12:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A287F3054B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:12:48 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26Q4TP8N032253;
        Tue, 26 Jul 2022 05:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=lR4sbE6cBVTFNXJo/Ef8C3UIe40HJQG18tvv1wPDk08=;
 b=Xd864KQbsz3ExeGGVbLL5JRuB/1m7Yc6wEuZXzDU/4+xYvgquLwjGS99VNsPjXpGxEZo
 7nEiWRVJ34QaYCHmXBwrnl9CWcEK7NfuhO4Do1RJFBwo6l9LVDc4JqW8AWhUZ0rpowyM
 wdJOUlhrq38TkWZ738+pWu2NpL++dziLZguQG37faiOez7yKgUoNPCIm1r5lKazr1MiT
 8Y7OJashDgdn335sGw+CZF10rcklE8dUUrE9qtQ3M5bkOIev0kj/757D5dLAu9YRheUq
 WY++KM95354LaC96KcU5TpHGj4KkbO0Fsmn0JhxR6mLo6SKgr7E2xaB/65mu6OXlwIOj pg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hgddp3a2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jul 2022 05:12:04 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 26 Jul
 2022 05:11:35 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Tue, 26 Jul 2022 05:11:35 -0500
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.94])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A27FD2C5;
        Tue, 26 Jul 2022 10:11:32 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Cameron Berkenpas <cam@neo-zeon.de>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 0/2] Add support for CLSA0101
Date:   Tue, 26 Jul 2022 11:11:29 +0100
Message-ID: <20220726101131.68058-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2Mup4KydkpKEMchmdm81MhcBgOT1OBlb
X-Proofpoint-ORIG-GUID: 2Mup4KydkpKEMchmdm81MhcBgOT1OBlb
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for the CLSA0101 laptop, an Intel version of CLSA0100.
This patch has been tested using the CLSA0100, ensuring it
doesn't break the sound for it.
We appreciate it if someone with CLSA0101 could verify that this
the patch works for them.

Lucas Tanure (2):
  ALSA: hda: cs35l41: Use the CS35L41 HDA internal define
  ALSA: hda: cs35l41: Support CLSA0101

 sound/pci/hda/cs35l41_hda.c   | 67 +++++++++++++++++++++--------------
 sound/pci/hda/patch_realtek.c | 12 +++++++
 2 files changed, 53 insertions(+), 26 deletions(-)

-- 
2.37.1

