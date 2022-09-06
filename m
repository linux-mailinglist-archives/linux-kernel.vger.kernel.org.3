Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011C05AEEE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiIFPeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbiIFPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:33:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EFE9E0CA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:44:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86172B818B8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD3EC433D7;
        Tue,  6 Sep 2022 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662475407;
        bh=7kWWoBnv6dcdqO1pAUBikpQuJTr5tlVus/ZoVD5Ti0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXtUJT2J0LxEe7RbRu3WSw1gslCRdA68ug8hlVOum7ehS1EADRFS5T0nHw4bmflty
         nPgcmyaSu5FCyZKvhLfA24udJVE5R0UJbk5uXrUl686EubJzinb1xml0OugraXlRqg
         e6ifcOeBUGHhMBTcHwCBlFtMETFwz1XXWJd7iY0ZDye2DYxwXNT28vFd8Ey2BVLVHb
         GakR1mFwcr4J+6Jf7UPs2ihvaSuKR/nCFPGZAMU9BeDk1vufLnrR2j/9AKIlLfO2bG
         QE0S7AddDRbh3ayw4Xj7LYwG3ONrATKOmPcE0sAhCj/zXKKBf6bV2tFb1+wYuTgjML
         i1kY04V/TP3HQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/9] habanalabs/gaudi: rename mme cfg error response print
Date:   Tue,  6 Sep 2022 17:43:12 +0300
Message-Id: <20220906144318.1890416-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906144318.1890416-1-ogabbay@kernel.org>
References: <20220906144318.1890416-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Current description is misleading hence we rename it to a more
suitable error description.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 330869cb4c0b..a0b15b2f2ea4 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -616,7 +616,7 @@ static const char * const guadi2_mme_error_cause[GAUDI2_NUM_OF_MME_ERR_CAUSE] =
 	"qman_axi_err",
 	"wap sei (wbc axi err)",
 	"arc sei",
-	"mme_cfg_unalign_addr",
+	"cfg access error",
 	"qm_sw_err",
 	"sbte_dbg_intr_0",
 	"sbte_dbg_intr_1",
-- 
2.25.1

