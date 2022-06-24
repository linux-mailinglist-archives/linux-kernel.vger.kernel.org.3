Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC61559ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiFXOEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiFXOEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:04:40 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1784ECC8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BAAF5CE2A53
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0EFC34114
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656079476;
        bh=1o3QjWI0urQVWSKLmYrAmxDK2Ekenl+Y86n1HJoVxlg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=F0XLs3CY+4cT0kR9C2xgICKq8Q9gZCDHW+urUWKRo7FYG6rALfwTHMyQqq84uZZh8
         v3Ydv4rt5+6fw+pyCnmRxxe3iACAgYPUg0C/Q+KRL6s22pce0PR/qOg5UMP9Dec9VI
         cv6r2M9OYlPbgw9zPXM3bNFRzISYjuZlGD0G13R+9qvFe+gYgQ07/h8opMDRxih+cy
         lLLCAOuYlb0A0jJRe5/dnXUaXzOpe1PjMXCyF1JyTk4RlmRaxLImiwKwQDAgrCmn/9
         +MqRZDBinZHLx+I0XKW0M7Tc3C/GwEiEdzA0v8fzXsvTpq2yt+GfbwRW+Lm8+d0uKh
         Glwe4h/R0RAGg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] habanalabs/gaudi: fix function name in comment
Date:   Fri, 24 Jun 2022 17:04:26 +0300
Message-Id: <20220624140429.1778402-2-ogabbay@kernel.org>
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

function name in comment didn't match actual function name.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
index 25ac87cebd45..81a3c79a8bc6 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_security.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
@@ -469,7 +469,7 @@ static u64 gaudi_rr_hbw_mask_high_ar_regs[GAUDI_NUMBER_OF_HBW_RR_REGS] = {
 };
 
 /**
- * gaudi_set_block_as_protected - set the given block as protected
+ * gaudi_pb_set_block - set the given block as protected
  *
  * @hdev: pointer to hl_device structure
  * @base: block base address
-- 
2.25.1

