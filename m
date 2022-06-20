Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE584551B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345393AbiFTNO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344129AbiFTNJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:09:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622B11C130
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:05:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4502AB811C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66425C3411B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730299;
        bh=9i/D3QJwEdtdyBMppG/X0qyMbuiUjiOLcaTCZ4ZlkH0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RPMXlzvCJ9cjasqmfgSDxUlo/iuduEWQxgq0680Hw8EXoWzF68BZgm846YIzl9jwq
         dlmwyUlKKGVq+eaI8UBpklfxKcEQkx3DaYg56E+3ZTDdz/yhIY1MYFr1kybQySd8Cr
         UCudo/snvzmHCMSFKxkdM6oGxpnr4Vpfu6BIW9gMATghNgu0brDIe0wL9M7nK8F3dv
         CTGdTgOSc7LOBjbF3NdZDq2L5FcVeoPuGAsT+sCOmR2JQj6PQBr69pri0aXev63pLk
         Kga92NTFGbHOY4DYIWZqCt7S/97v+Qi4ukhVQ1a6lVbCY1fuVAh0tS/WmAIjIm3pO6
         KIScQp1JgcxsA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] habanalabs: fix comment style
Date:   Mon, 20 Jun 2022 16:04:32 +0300
Message-Id: <20220620130432.1180451-17-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
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

function name should not be preceded with @

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index ea5f2bd31b0a..56df962d2f3c 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -135,7 +135,7 @@ int hl_mmap_mem_buf_put_handle(struct hl_mem_mgr *mmg, u64 handle)
 }
 
 /**
- * @hl_mmap_mem_buf_alloc - allocate a new mappable buffer
+ * hl_mmap_mem_buf_alloc - allocate a new mappable buffer
  *
  * @mmg: parent unifed memory manager
  * @behavior: behavior object describing this buffer polymorphic behavior
-- 
2.25.1

