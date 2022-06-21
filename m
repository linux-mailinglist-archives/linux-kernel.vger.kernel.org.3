Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025F9552CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348010AbiFUIKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345752AbiFUIKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:10:09 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9510FFD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:10:03 -0700 (PDT)
X-QQ-mid: bizesmtp84t1655798932tl93vu9g
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 16:08:46 +0800 (CST)
X-QQ-SSF: 01000000007000109000B00A0000000
X-QQ-FEAT: sQLI5RVGcj9DRAt/UNTtu0QDAwWw/d6pI+ETYO0dwnhsudqy8lPlWOgYHsnHb
        l/sZ+yBJSjUP6reEnrLkdFBo258g+mGTOAz3rKcOeY6XLF7/yrkfiB/QRFqzzJuZIAg7Ot/
        lB1Ol46X1+7qb3ZYQATLklYWa21V4wDTUxyDI8OyMAzeAMLFHQfNDvyyHF4Ois16XYdC69n
        vAz7OYqUNrk5/YC9vJyF7RGsopE+L8uFjrAEYWewIehOzfpuwOIqyOfDE9SALCm/tLnsLXd
        o72r8Og73HZf0vjAr9YWbNa90jsMW6IaEDULkd5TzywZitXRCYj2MH4H/ea5faG7xG2EJy7
        ppkNpSn
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiangjian@cdjrlc.com
Subject: [PATCH] fs: remove unexpected words "the"
Date:   Tue, 21 Jun 2022 16:08:45 +0800
Message-Id: <20220621080845.45772-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is unexpected word "the" in comments need to remove

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 fs/afs/flock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index c4210a3964d8..801fe305878f 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -152,7 +152,7 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 }
 
 /*
- * Kill off all waiters in the the pending lock queue due to the vnode being
+ * Kill off all waiters in the pending lock queue due to the vnode being
  * deleted.
  */
 static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
-- 
2.17.1

