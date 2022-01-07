Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A14487D64
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiAGT62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:58:28 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:22418 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231377AbiAGT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:58:26 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 207Fo27U008191;
        Fri, 7 Jan 2022 13:58:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=mtESrcOKgKXQmkilrqoNob9Tn40gKNW7FNM5KPZ6lbo=;
 b=otW07zScz2YLzJEEM/HVrSHwyN2F/djLUeGgSLyX+MTI1HTdb7k7oeTwWuGgvjcztPDw
 pNjphlG2r2jEn98gl1XyqAJBdaPaPYK2Gtw1DO/i3hUN24I2uuKfm+tXQjyEB807WEXW
 pUPTBPipfuGpfVsASbAk8EER42w1jplKdKmyWX5nv45JgIfgY5wcEY0zHAxJ2NUVkIbB
 kJXRbjXbIMpJIetzvjJ0HBfjDqPZvuhsqBKw1u3pAY0XbEd61S/eaDoqqVkZemkuo0wy
 b7/GbOZMHmj/Unq6TKClZ2erIxmOfyPvHSSJ46nhiXhSNl3e0mwlTtpxn7/ya9sKA0gN lQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dergng88h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 07 Jan 2022 13:58:23 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 19:58:21 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 7 Jan 2022 19:58:21 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.206.19])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DBA4E2A9;
        Fri,  7 Jan 2022 19:58:19 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [PATCH v2 0/2] Introduces bypass charge type property
Date:   Fri, 7 Jan 2022 13:58:04 -0600
Message-ID: <20220107195806.100956-1-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: uoxMeuUJ0Ge2r1-NdkQrl5DjQSOZmnNg
X-Proofpoint-ORIG-GUID: uoxMeuUJ0Ge2r1-NdkQrl5DjQSOZmnNg
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series introduces a new POWER_SUPPLY_CHARGE_TYPE for bypass charging
operation.

In fast charging ICs, the bypass operation is used to bypass the charging path
around the charging IC's integrated power converter to its load. This allows
for "smart" wall adaptors (such as USB PPS standard power adaptors) to handle
the power conversion and heat dissipation externally.

Best Regards,
Ricardo

Ricardo Rivera-Matos (2):
  power: supply: Introduces bypass charging property
  power: supply: bq25980: Implements POWER_SUPPLY_CHARGE_TYPE_BYPASS

 drivers/power/supply/bq25980_charger.c    | 2 +-
 drivers/power/supply/power_supply_sysfs.c | 1 +
 include/linux/power_supply.h              | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.25.1

