Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5BD5530E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348707AbiFULbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiFULbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:31:37 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683D9B7F5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:31:31 -0700 (PDT)
X-QQ-mid: bizesmtp74t1655811081tarqjyg8
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 19:31:16 +0800 (CST)
X-QQ-SSF: 0100000000700040B000B00A0000000
X-QQ-FEAT: FD+6NgJX7e4dWuNFedCyJOrBBS+15CwHkrSPEzAmeeApVBXGEbQudpw2IhfYs
        wKMlCgsqqQaSp+gEZXUJZX5fAsZr5v7B5Vn5zSyYTJycZCiX0GX4j61rZnvtNeX4MB8XsNh
        tFWdokoOtHZHsVP6hdi8K6TYs1NnOryavYpvQhy+dQn+4sggdoGVQpYKMK5Lbg5IHvVJH/m
        fY7+GcgGFzn2HV8gC2/6dizizp93nmCY4oipH23WXlz8KOgtc6jHbX/iW9nibsHLoh1TnYJ
        oMqmewSVh4NekyMmtlNXbGlCa8eYPQgTf5uyMmWZs9K7q/89t5yX+CWlqZlcOBmHHJAdyX0
        eftQqxP34H9PnG/Vak=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     agk@redhat.com, snitzer@kernel.or, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] dm raid: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 19:31:14 +0800
Message-Id: <20220621113114.98823-1-jiangjian@cdjrlc.com>
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

