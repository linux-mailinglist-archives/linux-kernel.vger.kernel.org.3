Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61004576E1D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiGPNK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 09:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGPNKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 09:10:24 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4751E2125A;
        Sat, 16 Jul 2022 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1657977022;
        bh=vUqUtmUEDZfWFKsn92CnDaPfM6DHV7s9AN7k1vumVNc=;
        h=Message-ID:Subject:From:To:Date:From;
        b=wjfxfVjIuAA4L96If5G0Vwo3f+5ZuByCh3iUH+Wkouoe13ize9JG5j0keerAbnts2
         cH2CtLYDO3eW/oMoOZDIy6R0Tw0+EY2fghsgeujP0Q4ImRQtIGBMYRbtuSaQMobBIk
         lmtl43pSIz6IERD9n5bwnN8ymS91ZxNgHp/9hVaI=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 174BF1280DB8;
        Sat, 16 Jul 2022 09:10:22 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VAhJjgHU5la5; Sat, 16 Jul 2022 09:10:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1657977021;
        bh=vUqUtmUEDZfWFKsn92CnDaPfM6DHV7s9AN7k1vumVNc=;
        h=Message-ID:Subject:From:To:Date:From;
        b=KNgeYhkV09nGBIhz3i7jhYhn6solcdxTWdTP39oQ8xoPt/v/YScXkcdyQvD9+dz3m
         +RG00X2jt1sQsEhYLqqeiQKjCpDiXTQXk3mlKMKX/ulhLhsr5jJViG6MWYCqmh5n9u
         VI2O8qiqgGr7mztIyDK/GPZnYe66Ku/4Rrsq4zu0=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6BFF11280C16;
        Sat, 16 Jul 2022 09:10:21 -0400 (EDT)
Message-ID: <ce185648f24041886a7194ab8eee23f9649b8a85.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.19-rc6
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 16 Jul 2022 09:10:20 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Six small and reasonably obvious fixes, all in drivers.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Bjorn Andersson (1):
      scsi: ufs: core: Drop loglevel of WriteBoost message

Changyuan Lyu (2):
      scsi: pm80xx: Set stopped phy's linkrate to Disabled
      scsi: pm80xx: Fix 'Unknown' max/min linkrate

Mike Christie (1):
      scsi: target: Fix WRITE_SAME No Data Buffer crash

Ming Lei (1):
      scsi: megaraid: Clear READ queue map's nr_queues

Po-Wen Kao (1):
      scsi: ufs: core: Fix missing clk change notification on host reset

And the diffstat:

 drivers/scsi/megaraid/megaraid_sas_base.c |  3 +++
 drivers/scsi/pm8001/pm8001_hwi.c          | 19 +++----------------
 drivers/scsi/pm8001/pm8001_init.c         |  2 ++
 drivers/scsi/pm8001/pm80xx_hwi.c          |  6 +++++-
 drivers/target/target_core_file.c         |  3 +++
 drivers/target/target_core_iblock.c       |  4 ++++
 drivers/target/target_core_sbc.c          |  6 ++++++
 drivers/ufs/core/ufshcd.c                 |  4 ++--
 8 files changed, 28 insertions(+), 19 deletions(-)

With full diff below.

James

---

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index c95360a3c186..0917b05059b4 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3195,6 +3195,9 @@ static int megasas_map_queues(struct Scsi_Host *shost)
 	qoff += map->nr_queues;
 	offset += map->nr_queues;
 
+	/* we never use READ queue, so can't cheat blk-mq */
+	shost->tag_set.map[HCTX_TYPE_READ].nr_queues = 0;
+
 	/* Setup Poll hctx */
 	map = &shost->tag_set.map[HCTX_TYPE_POLL];
 	map->nr_queues = instance->iopoll_q_count;
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index f7466a895d3b..991eb01bb1e0 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -3145,15 +3145,6 @@ void pm8001_bytes_dmaed(struct pm8001_hba_info *pm8001_ha, int i)
 	if (!phy->phy_attached)
 		return;
 
-	if (sas_phy->phy) {
-		struct sas_phy *sphy = sas_phy->phy;
-		sphy->negotiated_linkrate = sas_phy->linkrate;
-		sphy->minimum_linkrate = phy->minimum_linkrate;
-		sphy->minimum_linkrate_hw = SAS_LINK_RATE_1_5_GBPS;
-		sphy->maximum_linkrate = phy->maximum_linkrate;
-		sphy->maximum_linkrate_hw = phy->maximum_linkrate;
-	}
-
 	if (phy->phy_type & PORT_TYPE_SAS) {
 		struct sas_identify_frame *id;
 		id = (struct sas_identify_frame *)phy->frame_rcvd;
@@ -3177,26 +3168,22 @@ void pm8001_get_lrate_mode(struct pm8001_phy *phy, u8 link_rate)
 	switch (link_rate) {
 	case PHY_SPEED_120:
 		phy->sas_phy.linkrate = SAS_LINK_RATE_12_0_GBPS;
-		phy->sas_phy.phy->negotiated_linkrate = SAS_LINK_RATE_12_0_GBPS;
 		break;
 	case PHY_SPEED_60:
 		phy->sas_phy.linkrate = SAS_LINK_RATE_6_0_GBPS;
-		phy->sas_phy.phy->negotiated_linkrate = SAS_LINK_RATE_6_0_GBPS;
 		break;
 	case PHY_SPEED_30:
 		phy->sas_phy.linkrate = SAS_LINK_RATE_3_0_GBPS;
-		phy->sas_phy.phy->negotiated_linkrate = SAS_LINK_RATE_3_0_GBPS;
 		break;
 	case PHY_SPEED_15:
 		phy->sas_phy.linkrate = SAS_LINK_RATE_1_5_GBPS;
-		phy->sas_phy.phy->negotiated_linkrate = SAS_LINK_RATE_1_5_GBPS;
 		break;
 	}
 	sas_phy->negotiated_linkrate = phy->sas_phy.linkrate;
-	sas_phy->maximum_linkrate_hw = SAS_LINK_RATE_6_0_GBPS;
+	sas_phy->maximum_linkrate_hw = phy->maximum_linkrate;
 	sas_phy->minimum_linkrate_hw = SAS_LINK_RATE_1_5_GBPS;
-	sas_phy->maximum_linkrate = SAS_LINK_RATE_6_0_GBPS;
-	sas_phy->minimum_linkrate = SAS_LINK_RATE_1_5_GBPS;
+	sas_phy->maximum_linkrate = phy->maximum_linkrate;
+	sas_phy->minimum_linkrate = phy->minimum_linkrate;
 }
 
 /**
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 9b04f1a6a67d..01f2f41928eb 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -143,6 +143,8 @@ static void pm8001_phy_init(struct pm8001_hba_info *pm8001_ha, int phy_id)
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
 	phy->phy_state = PHY_LINK_DISABLE;
 	phy->pm8001_ha = pm8001_ha;
+	phy->minimum_linkrate = SAS_LINK_RATE_1_5_GBPS;
+	phy->maximum_linkrate = SAS_LINK_RATE_6_0_GBPS;
 	sas_phy->enabled = (phy_id < pm8001_ha->chip->n_phy) ? 1 : 0;
 	sas_phy->class = SAS;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 01c5e8ff4cc5..303cd05fec50 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3723,8 +3723,12 @@ static int mpi_phy_stop_resp(struct pm8001_hba_info *pm8001_ha, void *piomb)
 	pm8001_dbg(pm8001_ha, MSG, "phy:0x%x status:0x%x\n",
 		   phyid, status);
 	if (status == PHY_STOP_SUCCESS ||
-		status == PHY_STOP_ERR_DEVICE_ATTACHED)
+		status == PHY_STOP_ERR_DEVICE_ATTACHED) {
 		phy->phy_state = PHY_LINK_DISABLE;
+		phy->sas_phy.phy->negotiated_linkrate = SAS_PHY_DISABLED;
+		phy->sas_phy.linkrate = SAS_PHY_DISABLED;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index e68f1cc8ef98..6c8d8b051bfd 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -448,6 +448,9 @@ fd_execute_write_same(struct se_cmd *cmd)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 	}
 
+	if (!cmd->t_data_nents)
+		return TCM_INVALID_CDB_FIELD;
+
 	if (cmd->t_data_nents > 1 ||
 	    cmd->t_data_sg[0].length != cmd->se_dev->dev_attrib.block_size) {
 		pr_err("WRITE_SAME: Illegal SGL t_data_nents: %u length: %u"
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 378c80313a0f..1ed9381751e6 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -494,6 +494,10 @@ iblock_execute_write_same(struct se_cmd *cmd)
 		       " backends not supported\n");
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 	}
+
+	if (!cmd->t_data_nents)
+		return TCM_INVALID_CDB_FIELD;
+
 	sg = &cmd->t_data_sg[0];
 
 	if (cmd->t_data_nents > 1 ||
diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index ca1b2312d6e7..f6132836eb38 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -312,6 +312,12 @@ sbc_setup_write_same(struct se_cmd *cmd, unsigned char flags, struct sbc_ops *op
 		pr_warn("WRITE SAME with ANCHOR not supported\n");
 		return TCM_INVALID_CDB_FIELD;
 	}
+
+	if (flags & 0x01) {
+		pr_warn("WRITE SAME with NDOB not supported\n");
+		return TCM_INVALID_CDB_FIELD;
+	}
+
 	/*
 	 * Special case for WRITE_SAME w/ UNMAP=1 that ends up getting
 	 * translated into block discard requests within backend code.
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index ce86d1b790c0..c7b337480e3e 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5738,7 +5738,7 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
 	}
 
 	hba->dev_info.wb_enabled = enable;
-	dev_info(hba->dev, "%s Write Booster %s\n",
+	dev_dbg(hba->dev, "%s Write Booster %s\n",
 			__func__, enable ? "enabled" : "disabled");
 
 	return ret;
@@ -7253,7 +7253,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	hba->silence_err_logs = false;
 
 	/* scale up clocks to max frequency before full reinitialization */
-	ufshcd_set_clk_freq(hba, true);
+	ufshcd_scale_clks(hba, true);
 
 	err = ufshcd_hba_enable(hba);
 

