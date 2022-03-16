Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CA34DAC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343653AbiCPHxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354361AbiCPHxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:53:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01DB5D5D3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647417106; x=1678953106;
  h=from:to:cc:subject:date:message-id;
  bh=vKvbQwYgcjb2VBnqEZFgMX1Gx5eolCjtlW5mckiZ48U=;
  b=SDnCCwwubVVhayZRPjBTY8Maa7d8MWIpRm9TyolQZ5xPjfUsmgRcROUE
   J3jAym9vZ2LUJwvjyxGvXmFv3KsWnvpihJzmfo8xsOkqNZTxe9cs2Zz8J
   aEMLx7KYua1UJ6kkGmhOC65mRwSHkonsmlcD+Y1WOPhNhfl+RaNQIzQZo
   aC41t7NM2WuvpVJBcyitc+/Oouj25jGJS/qKZcr0xEo2Xy9rA9h/PrYuY
   SvamuCsmMa+zHYrJgWcS8zTncwxcZ+3WIpAjvVCf9mRt+mgUaYEjQ0LW+
   m4cs8j7o864MrgMpBxhH9y5wUnBx+/unhoEirzsXHiREe554TxoEoUoQz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281295414"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="281295414"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:51:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="557328291"
Received: from basccgtest09.gar.corp.intel.com (HELO localhost.localdomain) ([10.223.165.104])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:51:23 -0700
From:   monish.kumar.r@intel.com
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     abhijeet.rao@intel.com, monish.kumar.r@intel.com
Subject: [PATCH] Revert "Adding quirk changes for Samsung X5 device"
Date:   Wed, 16 Mar 2022 13:23:12 +0530
Message-Id: <20220316075313.18853-1-monish.kumar.r@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Monish Kumar R <monish.kumar.r@intel.com>

This reverts commit 1c1b18c97b441cb1a4eb9c6e95d9c357b687cdd0.
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c01cb381c3ff..8bb184a7479c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3463,10 +3463,14 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
 				NVME_QUIRK_SKIP_CID_GEN },
+<<<<<<< HEAD
 	{ PCI_DEVICE(0x144d, 0xa808), /* Samsung X5 */
 		.driver_data =  NVME_QUIRK_DELAY_BEFORE_CHK_RDY|
 				NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+=======
+
+>>>>>>> parent of 1c1b18c97b44... Adding quirk changes for Samsung X5 device
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
-- 
2.17.1

