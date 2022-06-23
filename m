Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D275557809
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiFWKkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiFWKk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:40:28 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636A213E07;
        Thu, 23 Jun 2022 03:40:23 -0700 (PDT)
X-QQ-mid: bizesmtp86t1655980818t092s0u9
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 18:40:14 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000D00A0000000
X-QQ-FEAT: +i7PuHLNsE7UBD9BC541qmopyEJf9ANnuoidtz228/fn941NgbHUZVlS/arGo
        kR64QH6WMQaNvjkjfJvzS1AjS30RJN8BBLRGx8GSCkfAAnza3nSVQw+j0dUcbkqoLtIY+iS
        MBQGaqENOAlnaLuhvBm+1tW6e1by7CpBoQKXgieW4+PsBfkDIY2t/OcF/l0Yw3keW/d0qmk
        1QeN7HPMyDJ9y+2J4FLaf/iDH8JZQT7nq2O4Qf5uykeNIMUfhw7xaOdYJchBa3ZK5eUPc3q
        2rOn5IwJyf6JZYMs+Xb5l39+i20YlDxOYEq1g01AojcXuGjEdjZS2NYvjLzLeZLMweTADBs
        4LlbBZ0+Tbfn8gC5feJaacgNRHW0g==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     jiangjian@cdjrlc.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb-frontends: drxk_hard.c - drop unexpected word 'for' in comments
Date:   Thu, 23 Jun 2022 18:40:12 +0800
Message-Id: <20220623104012.44107-1-jiangjian@cdjrlc.com>
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

there is an unexpected word 'for' in the comments that need to be dropped

file - drivers/media/dvb-frontends/drxk_hard.c
line - 3519

/* window size for for sense pre-SAW detection */

changed to:

/* window size for sense pre-SAW detection */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/media/dvb-frontends/drxk_hard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index 9430295a8175..47d83e0a470c 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -3516,7 +3516,7 @@ static int set_dvbt_standard(struct drxk_state *state,
 	status = write16(state, IQM_AF_CLP_LEN__A, 0);
 	if (status < 0)
 		goto error;
-	/* window size for for sense pre-SAW detection */
+	/* window size for sense pre-SAW detection */
 	status = write16(state, IQM_AF_SNS_LEN__A, 0);
 	if (status < 0)
 		goto error;
-- 
2.17.1

