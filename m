Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93373581FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiG0Fwf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Jul 2022 01:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiG0Fwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:52:33 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD31513F91;
        Tue, 26 Jul 2022 22:52:31 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 3E8CA122271;
        Wed, 27 Jul 2022 07:52:28 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 283A81221BB;
        Wed, 27 Jul 2022 07:52:28 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Wed, 27 Jul 2022 07:52:28 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 27 Jul
 2022 07:52:27 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Wed, 27 Jul 2022 07:52:27 +0200
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Chevron Li <chevron.li@bayhubtech.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "shaper.liu@bayhubtech.com" <shaper.liu@bayhubtech.com>,
        "shirley.her@bayhubtech.com" <shirley.her@bayhubtech.com>,
        "xiaoguang.yu@bayhubtech.com" <xiaoguang.yu@bayhubtech.com>
Subject: RE: [PATCH V1 1/1] mmc:sdhci-pci-o2micro:fix some SD cards
 compatibility issue at ddr50 mode
Thread-Topic: [PATCH V1 1/1] mmc:sdhci-pci-o2micro:fix some SD cards
 compatibility issue at ddr50 mode
Thread-Index: AQHYoWlno1kp0slQZkeMqH8J4oyD662Rtw4A
Date:   Wed, 27 Jul 2022 05:52:27 +0000
Message-ID: <5a26ec8c0d804626b9bbd43fbdb56725@hyperstone.com>
References: <20220727033123.304-1-chevron.li@bayhubtech.com>
In-Reply-To: <20220727033123.304-1-chevron.li@bayhubtech.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.18]
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27040.005
X-TMASE-Result: 10--11.343500-10.000000
X-TMASE-MatchedRID: 9zTThWtzImtHRiy/ZowS2TCIlN/eSPB9Ud7Bjfo+5jSWwuVcTMXFdHJ4
        s8xhkfjuDgNcVt6u2k3c7yKmgXECvRqAfzsUlMDKDDzmS9l9fYrBOVz0Jwcxl6vCrG0TnfVULPJ
        tWpbJjY11PKUF8F0EwiEJJrkZUnH61OA1SJ4kORERW4LR41Fi8gK0ZgbTOeKUyiLz1Vtc/pXX7Q
        qxdrFbPuLzNWBegCW2ak1q2nxhDrwLbigRnpKlKSPzRlrdFGDw2PnnatD5t5vq5aIsMP28nkYeB
        uLroGWZYcl7yWnrIuFMRmFqMX+aaw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 1cf51bd0-d47a-42d5-b396-925d4d6886d1-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just be aware that cards may support one but not the other, so this doesn't come without cost.

-----Original Message-----
From: Chevron Li <chevron.li@bayhubtech.com> 
Sent: Mittwoch, 27. Juli 2022 05:31
To: adrian.hunter@intel.com; ulf.hansson@linaro.org; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
Cc: shaper.liu@bayhubtech.com; shirley.her@bayhubtech.com; xiaoguang.yu@bayhubtech.com
Subject: [PATCH V1 1/1] mmc:sdhci-pci-o2micro:fix some SD cards compatibility issue at ddr50 mode

Bayhub chips have better compatibility support for sdr50 than ddr50 and both mode have the same R/W performance.
Disable ddr50 mode and use sdr50 instead.

Signed-off-by: Chevron Li<chevron.li@bayhubtech.com>
---
Changes on V1:
1.Set quirks2 flag SDHCI_QUIRK2_BROKEN_DDR50 for bayhub chips.
2.Use bayhub hardware input tuning for SDR50 mode instead of standard tuning flow.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 0d4d343dbb77..ad457cd9cbaa 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -317,11 +317,12 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	u32 reg_val;
 
 	/*
-	 * This handler only implements the eMMC tuning that is specific to
+	 * This handler implements the hardware tuning that is specific to
 	 * this controller.  Fall back to the standard method for other TIMING.
 	 */
 	if ((host->timing != MMC_TIMING_MMC_HS200) &&
-		(host->timing != MMC_TIMING_UHS_SDR104))
+		(host->timing != MMC_TIMING_UHS_SDR104) &&
+		(host->timing != MMC_TIMING_UHS_SDR50))
 		return sdhci_execute_tuning(mmc, opcode);
 
 	if (WARN_ON((opcode != MMC_SEND_TUNING_BLOCK_HS200) && @@ -631,6 +632,8 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 		if (reg & 0x1)
 			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
+
 		sdhci_pci_o2_enable_msi(chip, host);
 
 		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD0) {

base-commit: 68e77ffbfd06ae3ef8f2abf1c3b971383c866983
--
2.32.0

Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
Managing Director: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

