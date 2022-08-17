Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1791F596E64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbiHQMYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiHQMYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:24:03 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103ED48C84
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:24:03 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HBro3R026619;
        Wed, 17 Aug 2022 07:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=VA5vWp42DoWBFcE2Kvw+j15+d9nh9dAmeHthWqfIebQ=;
 b=BhnX2kXkirBkHX+pfvQCTZ8YW6M0xcH7JnbycwnYiCuMJWzFTexoxnkhHGHkMB+qF8x+
 MMzx/168z4ZuLbAaiz2xpgKgXJYZ2rOf1JGogVO62t8Kp6dKZ3vUqvQMpGVx9RtNPSv1
 +u7R6CKWaNQ7PQ8ISN00y/2pEzIW/gYi9umn9Npub9y5OYssRGYamfP3Y6b5o6DcIDkz
 6I0rriuP7+oB8GQkRU1/SkomSrssW0H6W16QijNWvoct9ojaNCVLHvi++Vn397ySkFN/
 Y1NxJERkMPToidKb5KEiR5iJ7+SBm2d5id7lhmAAHHy/iKklx/H0dj0ONfULfFUc8qaP mg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpcueb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 07:23:49 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 17 Aug
 2022 07:23:47 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Wed, 17 Aug 2022 07:23:47 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9AF887C;
        Wed, 17 Aug 2022 12:23:47 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/5] ASoC: cs42l42: Some small code improvements
Date:   Wed, 17 Aug 2022 13:23:42 +0100
Message-ID: <20220817122347.1356773-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TwERGpnE9xlKupjCGNCzyGKLaWKW5XbJ
X-Proofpoint-GUID: TwERGpnE9xlKupjCGNCzyGKLaWKW5XbJ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a collection of minor improvements to the code or comments.

Richard Fitzgerald (5):
  ASoC: cs42l42: Don't include kernel.h
  ASoC: cs42l42: Add include dependencies to cs42l42.h
  ASoC: cs42l42: Move cs42l42_supply_names to .c file
  ASoC: cs42l42: Fix comment typo in cs42l42_slow_start_put()
  ASoC: cs42l42: Use snd_soc_tdm_params_to_bclk()

 sound/soc/codecs/cs42l42.c | 24 ++++++++++++++++--------
 sound/soc/codecs/cs42l42.h | 13 +++++--------
 2 files changed, 21 insertions(+), 16 deletions(-)

-- 
2.30.2

