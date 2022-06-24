Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46A3559ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiFXOEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiFXOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:04:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047174ECCD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA40DB828DE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF55AC34114
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656079479;
        bh=rbX4aFBS8SAFyLR0glqQvi20+W7N3nQGaOsW2HPUbuc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QJypiEkyuFAeDGL4N2lGmYAhXXk1E61bGEX9OkHAzUIzl1OhR0mFoRY2zL5ujLM9A
         3oNDkNP43/lufw67/KqAtqUMLy70Xiv4BK1MuY6lFoi19sGuz6i7qVQM/GCeNMhAil
         4iwbDWQpXT5N9dwNCKlWfvJU00Llh3uOX6/DXeYhFhwiUwjHSRhYPVGxwY9DRPwGx7
         02rD3kx4EJSqqxbQRcYqui8VCR33vCSJRr2dGVNEvqyyCtw8EivwGJx6Ys4cHqeMsK
         mzDSneaOIh5x/SbO7dddNM2sj+G1k8S014pqdDI6vfmZjtE8IGVfkEc/olmcplQRue
         urqQBX6zzbLtw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] habanalabs/gaudi: remove unused enum
Date:   Fri, 24 Jun 2022 17:04:29 +0300
Message-Id: <20220624140429.1778402-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624140429.1778402-1-ogabbay@kernel.org>
References: <20220624140429.1778402-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also beautify code by preferring single line wherever possible.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 31 ++++++++-------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 7d65260e46d7..478374418b90 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -241,12 +241,6 @@ gaudi_qman_arb_error_cause[GAUDI_NUM_OF_QM_ARB_ERR_CAUSE] = {
 	"MSG AXI LBW returned with error"
 };
 
-enum gaudi_sm_sei_cause {
-	GAUDI_SM_SEI_SO_OVERFLOW,
-	GAUDI_SM_SEI_LBW_4B_UNALIGNED,
-	GAUDI_SM_SEI_AXI_RESPONSE_ERR
-};
-
 static enum hl_queue_type gaudi_queue_type[GAUDI_QUEUE_ID_SIZE] = {
 	QUEUE_TYPE_EXT, /* GAUDI_QUEUE_ID_DMA_0_0 */
 	QUEUE_TYPE_EXT, /* GAUDI_QUEUE_ID_DMA_0_1 */
@@ -609,16 +603,14 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 
 	prop->dram_base_address = DRAM_PHYS_BASE;
 	prop->dram_size = GAUDI_HBM_SIZE_32GB;
-	prop->dram_end_address = prop->dram_base_address +
-					prop->dram_size;
+	prop->dram_end_address = prop->dram_base_address + prop->dram_size;
 	prop->dram_user_base_address = DRAM_BASE_ADDR_USER;
 
 	prop->sram_base_address = SRAM_BASE_ADDR;
 	prop->sram_size = SRAM_SIZE;
-	prop->sram_end_address = prop->sram_base_address +
-					prop->sram_size;
-	prop->sram_user_base_address = prop->sram_base_address +
-					SRAM_USER_BASE_OFFSET;
+	prop->sram_end_address = prop->sram_base_address + prop->sram_size;
+	prop->sram_user_base_address =
+			prop->sram_base_address + SRAM_USER_BASE_OFFSET;
 
 	prop->mmu_pgt_addr = MMU_PAGE_TABLES_ADDR;
 	if (hdev->pldm)
@@ -7766,8 +7758,7 @@ static int tpc_krn_event_to_tpc_id(u16 tpc_dec_event_type)
 	return (tpc_dec_event_type - GAUDI_EVENT_TPC0_KRN_ERR) / 6;
 }
 
-static void gaudi_print_clk_change_info(struct hl_device *hdev,
-					u16 event_type)
+static void gaudi_print_clk_change_info(struct hl_device *hdev, u16 event_type)
 {
 	ktime_t zero_time = ktime_set(0, 0);
 
@@ -7815,8 +7806,7 @@ static void gaudi_print_clk_change_info(struct hl_device *hdev,
 	mutex_unlock(&hdev->clk_throttling.lock);
 }
 
-static void gaudi_handle_eqe(struct hl_device *hdev,
-				struct hl_eq_entry *eq_entry)
+static void gaudi_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u64 data = le64_to_cpu(eq_entry->data[0]), event_mask = 0;
@@ -8103,8 +8093,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		hl_fw_unmask_irq(hdev, event_type);
 }
 
-static void *gaudi_get_events_stat(struct hl_device *hdev, bool aggregate,
-					u32 *size)
+static void *gaudi_get_events_stat(struct hl_device *hdev, bool aggregate, u32 *size)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 
@@ -8117,8 +8106,7 @@ static void *gaudi_get_events_stat(struct hl_device *hdev, bool aggregate,
 	return gaudi->events_stat;
 }
 
-static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
-					u32 flags)
+static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard, u32 flags)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	u32 status, timeout_usec;
@@ -8161,8 +8149,7 @@ static int gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
 	return hdev->asic_funcs->mmu_invalidate_cache(hdev, is_hard, flags);
 }
 
-static int gaudi_mmu_update_asid_hop0_addr(struct hl_device *hdev,
-					u32 asid, u64 phys_addr)
+static int gaudi_mmu_update_asid_hop0_addr(struct hl_device *hdev, u32 asid, u64 phys_addr)
 {
 	u32 status, timeout_usec;
 	int rc;
-- 
2.25.1

