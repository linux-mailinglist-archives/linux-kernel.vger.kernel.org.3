Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B496657F5F1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiGXQE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:04:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FF1DE89
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 09:04:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0AFFB80D8B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 16:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF35DC3411E;
        Sun, 24 Jul 2022 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658678661;
        bh=i8cM2SroiJ19CwKcvmUaKxaxxsAJ7vlEHa3KqITk9s4=;
        h=From:To:Cc:Subject:Date:From;
        b=QAsFZt68qcZrIdLOwQDw0hD0fG8hRZa2RMeHUpN85+OvpHrPeTkxpZxBwQGWGRgXG
         sQWL4Qb4UPkvF/ielk0jyov+RaiSn58yqJnbdYF9BGyFsLtGe+IxgFDwZPgTYi16E/
         zXelreInSmuKoAQGV6/fMitUwNI826dl9t13jR9LGnnHeg7R4WIx2+ZsVLrdWl+NXo
         Dw6W5Y0xg3JMejRnbPl5QANBfAvh2eWeEPugcV0D91w8rU89KQLfUpPGeHELRdQedQ
         9wChLMeN7tryeu7hgsPHfsWbM4wTfCxanbLB44BGNg9GyX5NEZ9Edp2R6b0Zjg2P5M
         iw8DMJo12BqFw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@oppo.com>
Subject: [PATCH] f2fs: obsolete unused MAX_DISCARD_BLOCKS
Date:   Mon, 25 Jul 2022 00:04:17 +0800
Message-Id: <20220724160417.18488-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <chao.yu@oppo.com>

After commit a7eeb823854c ("f2fs: use bitmap in discard_entry"),
MAX_DISCARD_BLOCKS became obsolete, remove it.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/f2fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3f669f851240..51b8cb5b29ba 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -230,7 +230,6 @@ enum {
 #define CP_PAUSE	0x00000040
 #define CP_RESIZE 	0x00000080
 
-#define MAX_DISCARD_BLOCKS(sbi)		BLKS_PER_SEC(sbi)
 #define DEF_MAX_DISCARD_REQUEST		8	/* issue 8 discards per round */
 #define DEF_MIN_DISCARD_ISSUE_TIME	50	/* 50 ms, if exists */
 #define DEF_MID_DISCARD_ISSUE_TIME	500	/* 500 ms, if device busy */
-- 
2.36.1

