Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5F85A6783
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiH3PeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH3PeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:34:02 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE711C16F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:34:00 -0700 (PDT)
X-QQ-mid: bizesmtp70t1661873633t77pc55n
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 Aug 2022 23:33:52 +0800 (CST)
X-QQ-SSF: 01000000002000D0E000B00A0000000
X-QQ-FEAT: clvrxl8qrW5NfTa6nDrmlsgYdEBTLnYi+F+F82Xvu2S8KhQU4rjrlODVQOa4u
        6Aa3el1z8IqH1FdPwOfr3VpKtznPYY7nbN8/WMxpQOql35GhzFd0RqQTr7a5a6ptzH3EI85
        0CjGKq1TZAk+Re2IjEu62PBh7S37kUO0CepEIdI363gg+3aqV8wa5ZrIGBZdtn6SW21M1YM
        BOcvJvxU/ks4WFft0w7iMSkutVA5Nxwn7LzPSO2gjughqUgISumebv8siHUZuFTPHilR7Xp
        fDMpP+4nueCmnqK9fLrd7D/8Ldu8u10upYsnvmy7HZw6C/wlhsgaG75qoSF1HhxsNRLk50w
        FmJhyPpEdrAjOyJ2xhZZH2XYj0P9e3Icy2BasSXcwcC9bEVEz80wdLHLaGx+g==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     agk@redhat.com, snitzer@kernel.org
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] md: fix repeated words in comments
Date:   Tue, 30 Aug 2022 23:33:45 +0800
Message-Id: <20220830153345.18687-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'that'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/md/dm-raid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index c640be453313..e448fd45a914 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2529,7 +2529,7 @@ static int analyse_superblocks(struct dm_target *ti, struct raid_set *rs)
 		 * of the "sync" directive.
 		 *
 		 * With reshaping capability added, we must ensure that
-		 * that the "sync" directive is disallowed during the reshape.
+		 * the "sync" directive is disallowed during the reshape.
 		 */
 		if (test_bit(__CTR_FLAG_SYNC, &rs->ctr_flags))
 			continue;
-- 
2.36.1

