Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5635530E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349377AbiFULdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiFULc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:32:58 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC1A396
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:32:54 -0700 (PDT)
X-QQ-mid: bizesmtp74t1655811164tal19zhj
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 19:32:37 +0800 (CST)
X-QQ-SSF: 0100000000700040B000B00A0000000
X-QQ-FEAT: ZHWZeLXy+8d2xuswuyUwRi0lS84veAPfD6Hezb0MfVUM+ugSTumRnET3T1Yk3
        EYFF/an33BSniNIqs89pyDNLXWfNAWQ+jqYXe4IW2NpwK3FcYWvKX+hgfO8o5PXAN/l0N/j
        vMXHKqblTjZfRCpcJwCHfoQJXxECYVT7qmrrWErWN6FXEby5stq1LXGTYZskBvlw7at8KiF
        Lf53+44eAqHJSk74ag1cm2pZPObUfeLb1y4gVPIWomiBMqZE5Sd2iUOpO3YhuS8eO3q8khH
        SazdqzbI/I+HO19KBZr+pAwAi+WpOr1TKfQFxR4fhaopp57+vOlHh3gLuEMlTDdYz+ffMP1
        0aSgsfJvjphvdyw/uu4Fvf/wXejmA==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] dm raid: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 19:32:34 +0800
Message-Id: <20220621113234.99140-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/md/dm-raid.c
line: 1370
 /* Userspace passes new data_offset after having extended the data image LV */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/md/dm-raid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 9526ccbedafb..a438efc70e87 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -1367,7 +1367,7 @@ static int parse_raid_params(struct raid_set *rs, struct dm_arg_set *as,
 			}
 			rs->md.bitmap_info.daemon_sleep = value;
 		} else if (!strcasecmp(key, dm_raid_arg_name_by_flag(CTR_FLAG_DATA_OFFSET))) {
-			/* Userspace passes new data_offset after having extended the the data image LV */
+			/* Userspace passes new data_offset after having extended the data image LV */
 			if (test_and_set_bit(__CTR_FLAG_DATA_OFFSET, &rs->ctr_flags)) {
 				rs->ti->error = "Only one data_offset argument pair allowed";
 				return -EINVAL;
-- 
2.17.1

