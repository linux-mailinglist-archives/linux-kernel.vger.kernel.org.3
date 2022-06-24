Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3C559ACA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiFXN6u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Jun 2022 09:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiFXN6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:58:47 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92CE4DF4C;
        Fri, 24 Jun 2022 06:58:46 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id EE26B462FA7;
        Fri, 24 Jun 2022 15:58:44 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id DCEF9462F67;
        Fri, 24 Jun 2022 15:58:44 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Fri, 24 Jun 2022 15:58:44 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 24 Jun
 2022 15:58:44 +0200
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Fri, 24 Jun
 2022 15:58:44 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Fri, 24 Jun 2022 15:58:44 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: block: Add single read for 4k sector cards
Thread-Topic: [PATCH] mmc: block: Add single read for 4k sector cards
Thread-Index: AdiH0i+lOTiMmBAQQCyuCs385lDFyw==
Date:   Fri, 24 Jun 2022 13:58:44 +0000
Message-ID: <9e171c7ba27b4377872379f7e211715c@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.44]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-26974.007
X-TMASE-Result: 10-1.440300-10.000000
X-TMASE-MatchedRID: xSJL/ht5SGDUL3YCMmnG4pTQgFTHgkhZ6FML6creK7lM+b8yxBqvAyTn
        lmLOiwp22XHJ0L4jOITmn3xyPJAJoh2P280ZiGmR9k5nZzZVBSBHyz3bB5kG58bl1d1BOPY4A1/
        8jb+tZ/Tiu4lpe6VcbrQeFj3sWOU1XHEPHmpuRH0TNCcUsR4xSWrz/G/ZSbVq+gtHj7OwNO2I9t
        8DSRevIQUgC/isct8xoUq2kgYY6i9QN35Inoone6nVU1udGaNpw8g2HBNcF5k=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 7e22f89b-23e0-432a-8b9d-b6306215b4f0-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone wanting to test this and does not have a way to disturb eMMC signals,
use mmc-utils to disable 512B emulation and something along the lines of:

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 4b70cbfc6d5d..bc0b9241a00f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -32,6 +32,8 @@
 #include <linux/mmc/sd.h>
 #include <linux/mmc/slot-gpio.h>
 
+#include <linux/sched/clock.h>
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mmc.h>
 
@@ -141,6 +143,12 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 	struct mmc_command *cmd = mrq->cmd;
 	int err = cmd->error;
 
+	if (mrq->data && !mrq->data->error && mrq->data->flags & MMC_DATA_READ)
+		if ((sched_clock() % 1000) == 0) {
+			mrq->data->bytes_xfered = 0;
+			mrq->data->error = -EILSEQ;
+		}
+
 	/* Flag re-tuning needed on CRC errors */
 	if (cmd->opcode != MMC_SEND_TUNING_BLOCK &&
 	    cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200 &&
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

