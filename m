Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408F55AC528
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiIDP6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiIDP6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:58:09 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475272F01E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 08:58:02 -0700 (PDT)
X-QQ-mid: bizesmtp83t1662307075tmb8563g
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 04 Sep 2022 23:57:50 +0800 (CST)
X-QQ-SSF: 01000000002000C0C000B00A0000000
X-QQ-FEAT: xqT8U4SkSpiIB5z0Hu95yECpJaE5fCl+c/d/YmousacjABDUFmPy7QmoUA2pM
        caSqPuiInk+ceyas9YGV28opibaowRftm/aeRbc9drTt1UYlEnbZQKSYWWBjdnCQ1ilRbi3
        PSln4ADQcElKpJ3oE/YBje3rojZkmFY/YDGzqav1w7GWQ2twsSaB051QYJIkZcpVd7kz0/y
        Tl3HcerhaustDXYMkTDhpmvNHpvMUkgKFPY/iDxU8+aAwdMkR4bGd6kLjqZVQjrb5NMAMzF
        +xo0MkwXaldqqn56Rb8rTGifY5ZtrrxdCyuV2FyuhkiS4Z4Gv+WdHbjw3A54YUHTypreDjO
        1/u/JCATnS4OJHuLTKrJQEpuWOIj+NUyH4pXpHU+cDkfUIBys2JKCSzG5+D9mDm+js05jxv
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] pcmcia: Fix double word in comments
Date:   Sun,  4 Sep 2022 11:57:49 -0400
Message-Id: <20220904155749.29026-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "really" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/pcmcia/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index ace133b9f7d4..05d18614f6b4 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -1304,7 +1304,7 @@ static int pcmcia_bus_early_resume(struct pcmcia_socket *skt)
  * physically present, even if the call to this function returns
  * non-NULL. Furthermore, the device driver most likely is unbound
  * almost immediately, so the timeframe where pcmcia_dev_present
- * returns NULL is probably really really small.
+ * returns NULL is probably really small.
  */
 struct pcmcia_device *pcmcia_dev_present(struct pcmcia_device *_p_dev)
 {
-- 
2.35.1

