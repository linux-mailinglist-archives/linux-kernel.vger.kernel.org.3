Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42575B2B26
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIIAoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIIAoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:44:11 -0400
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3141C116B5F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 17:44:09 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id DZA00104;
        Fri, 09 Sep 2022 08:43:04 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201609.home.langchao.com (10.100.2.9) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 9 Sep 2022 08:43:03 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <agk@redhat.com>, <snitzer@kernel.org>, <dm-devel@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] dm raid: fix spelling typo in comment
Date:   Thu, 8 Sep 2022 20:43:01 -0400
Message-ID: <20220909004301.1514-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20229090843046010acde93eee3f4acb457c60445ce8d
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling typo in comment.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/md/dm-raid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index e448fd45a914..54263679a7b1 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2590,7 +2590,7 @@ static int analyse_superblocks(struct dm_target *ti, struct raid_set *rs)
 
 /*
  * Adjust data_offset and new_data_offset on all disk members of @rs
- * for out of place reshaping if requested by contructor
+ * for out of place reshaping if requested by constructor
  *
  * We need free space at the beginning of each raid disk for forward
  * and at the end for backward reshapes which userspace has to provide
-- 
2.27.0

