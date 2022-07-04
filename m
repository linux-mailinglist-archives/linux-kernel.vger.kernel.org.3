Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77FF5650D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiGDJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiGDJaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:30:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD351B1F6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60B84B80909
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CFEC341CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656927001;
        bh=SOlLgkkqre79ZMVWGw6bXAzpcTiYFAjEQeVYuOMbr1Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OVVyh6zwl+e2UAVHghgvsRDlwRaWPm/F/FYGJ/3x6Z9BLtVXY6zRLmhZoit5JaUFU
         8M4B1rLOsLi0J6vOJe3o7QdJ88KpYkAC5uq15/U0omRPyIIe/EJXIlbWw96SuK9j8G
         sxzn8bIIPyIrxZGC4la84q2P4reIZJQDDwymkx9h8t0zZTZDf0UEM926/H+0VzB1eC
         Vh7eoxuyxAetxRxjaAE8JbIee8maDllQvT/WUiS73V/LnLwH6ep2DtIBUxOOPLkYSh
         K6qpaHn8GeYT20QrgivHPFocR7mius4nNfOmez0RYAhC2kJyCJpPvCGc+o+/UWqT7d
         VAUpwM2ZagiHA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] habanalabs/gaudi2: remove unused defines
Date:   Mon,  4 Jul 2022 12:29:41 +0300
Message-Id: <20220704092941.2237683-12-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704092941.2237683-1-ogabbay@kernel.org>
References: <20220704092941.2237683-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were some defines that are unused in the current upstreamed
code.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c             | 7 -------
 drivers/misc/habanalabs/gaudi2/gaudi2.c           | 4 ----
 drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c | 2 --
 3 files changed, 13 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 31a2589929f2..1f84dd6f3adb 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -97,15 +97,8 @@
 
 #define GAUDI_ARB_WDT_TIMEOUT		0xEE6b27FF /* 8 seconds */
 
-#define GAUDI_CLK_GATE_DEBUGFS_MASK	(\
-		BIT(GAUDI_ENGINE_ID_MME_0) |\
-		BIT(GAUDI_ENGINE_ID_MME_2) |\
-		GENMASK_ULL(GAUDI_ENGINE_ID_TPC_7, GAUDI_ENGINE_ID_TPC_0))
-
 #define HBM_SCRUBBING_TIMEOUT_US	1000000 /* 1s */
 
-#define GAUDI_PLL_MAX 10
-
 #define BIN_REG_STRING_SIZE	sizeof("0b10101010101010101010101010101010")
 
 #define MONITOR_SOB_STRING_SIZE		256
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index dbf273d96b00..919e5028f341 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -74,10 +74,6 @@
 #define GAUDI2_NUM_OF_HIF_FATAL_ERR_CAUSE	2
 #define GAUDI2_NUM_OF_AXI_DRAIN_ERR_CAUSE	2
 #define GAUDI2_NUM_OF_HBM_MC_SPI_CAUSE		5
-#define GAUDI2_NUM_OF_NIC_RXB_CORE_SEI_CAUSE	2
-#define GAUDI2_NUM_OF_NIC_RXB_CORE_SPI_CAUSE	6
-#define GAUDI2_NUM_OF_NIC_RXE_SEI_CAUSE		4
-#define GAUDI2_NUM_OF_NIC_RXE_SPI_CAUSE		24
 
 #define GAUDI2_MMU_CACHE_INV_TIMEOUT_USEC	(MMU_CONFIG_TIMEOUT_USEC * 10)
 #define GAUDI2_PLDM_MMU_TIMEOUT_USEC		(MMU_CONFIG_TIMEOUT_USEC * 200)
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c b/drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c
index cf70735bf1e3..56c6ab692482 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2_coresight.c
@@ -9,8 +9,6 @@
 
 #define GAUDI2_PLDM_CORESIGHT_TIMEOUT_USEC	(CORESIGHT_TIMEOUT_USEC * 2000)
 #define SPMU_MAX_COUNTERS			6
-/* SPMU should also include overflow_idx and cycle_cnt_idx */
-#define SPMU_DATA_LEN				(SPMU_MAX_COUNTERS + 2)
 
 #define COMPONENT_ID_INVALID ((u32)(-1))
 #define MAX_BMONS_PER_UNIT 8
-- 
2.25.1

