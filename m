Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232434ED4D0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiCaHba convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Mar 2022 03:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiCaHb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:31:27 -0400
Received: from mail3.swissbit.com (mail3.swissbit.com [176.95.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598BF433A0;
        Thu, 31 Mar 2022 00:29:39 -0700 (PDT)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 706F8462580;
        Thu, 31 Mar 2022 09:29:38 +0200 (CEST)
Received: from mail3.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 5A213462537;
        Thu, 31 Mar 2022 09:29:38 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail3.swissbit.com (Postfix) with ESMTPS;
        Thu, 31 Mar 2022 09:29:38 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 31 Mar
 2022 09:29:37 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.0986.022; Thu, 31 Mar 2022 09:29:37 +0200
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "digetx@gmail.com" <digetx@gmail.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>
Subject: [PATCH 2/2] mmc: mmc_spi: enable Highspeed for above 25MHz
Thread-Topic: [PATCH 2/2] mmc: mmc_spi: enable Highspeed for above 25MHz
Thread-Index: AQHYRNET6fGEHIFWCkie/s3TyF86+Q==
Date:   Thu, 31 Mar 2022 07:29:37 +0000
Message-ID: <5eaae8e215d84dd3a4f7e09782478a29@hyperstone.com>
References: <20c6efa9a4c7423bbfb9352705c4a53a@hyperstone.com>
In-Reply-To: <20c6efa9a4c7423bbfb9352705c4a53a@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.154.1.4]
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1000-26804.006
X-TMASE-Result: 10--1.650500-10.000000
X-TMASE-MatchedRID: oCMH03eFz6A8g1fEYZ38207nLUqYrlslFIuBIWrdOePfUZT83lbkEEJn
        SqMrU6ESduRFO7j4H00XIQarK0WBEFxxDx5qbkR9EzQnFLEeMUljtslS0wA5rWbAhi1JhpZ+5MI
        x11wv+CM7AFczfjr/7IdkpRw99KlXsEX7PGskxPf2BcRn1XxtLxK9slNBhdAQVBqhwt6IXBw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 2605bab8-5430-4ccb-8379-ed77654b1a55-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any setup supporting more than 25MHz is able to utilize
highspeed, so enable it even when not explicitly specified.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/host/mmc_spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 106dd204b1a7..0a74c2f55542 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1378,6 +1378,9 @@ static int mmc_spi_probe(struct spi_device *spi)
 	mmc->f_min = 400000;
 	mmc->f_max = spi->max_speed_hz;
 
+	if (mmc->f_max > 25000000)
+		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
+
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->spi = spi;
-- 
2.34.1
Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

