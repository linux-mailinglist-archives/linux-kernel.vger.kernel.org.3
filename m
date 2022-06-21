Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951BC553466
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351303AbiFUOUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350589AbiFUOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:20:30 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCD3140CD;
        Tue, 21 Jun 2022 07:20:24 -0700 (PDT)
X-QQ-mid: bizesmtp87t1655821217tp8rfu89
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 22:20:14 +0800 (CST)
X-QQ-SSF: 0100000000700060B000D00A0000000
X-QQ-FEAT: RKCwGdK8Yfg7VxFNpIqXTE0grhkMICdJ+CsRucJlPWC1m9niPrQ9sW1JDn21B
        6RVWkPULMyA/QOh2SXDdLb5c5nsd57IznTuJp+KlQQSK1mMN2Q7CH4qBzNESwVJBhjZzszS
        ohr8bxrhRIpGGB7C/dzy+qZxuZez1M3lsbWqFr6kslf8id1tlcR4HmieH/7m8UJ9GZiJxJr
        grdKtzMY044sVBLe32+AgVqH4/XVbADzGod32P/xhv9yM8EL56RWml8LwjTVXWGlPRjLi+9
        aI/XUUueipg2mveaL7x5iayAAXH7GvMkNHmp7AqhM0jSF9k0c0F6SoQxr+YtmHRL3CENm0c
        AMjcxG7iCyEBL3m1l2BwXNDMfqD7a2dWWR/eeI0
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] scsi: target: Remove duplicate 'the' in two places.
Date:   Tue, 21 Jun 2022 22:20:12 +0800
Message-Id: <20220621142012.4622-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file: drivers/target/target_core_alua.c
line: 388
 * the Target Port in question for the the incoming
changed to
 * the Target Port in question for the incoming

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/target/target_core_alua.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index b56ef8af66e7..58df0145e8d0 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -385,7 +385,7 @@ target_emulate_set_target_port_groups(struct se_cmd *cmd)
 
 			/*
 			 * Extract the RELATIVE TARGET PORT IDENTIFIER to identify
-			 * the Target Port in question for the the incoming
+			 * the Target Port in question for the incoming
 			 * SET_TARGET_PORT_GROUPS op.
 			 */
 			rtpi = get_unaligned_be16(ptr + 2);
-- 
2.17.1

