Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BFE58FDE9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiHKN6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbiHKN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:57:54 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013FD81B36
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:57:52 -0700 (PDT)
X-QQ-mid: bizesmtp84t1660226268tlmonl37
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 21:57:47 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: D2GZf6M6C/hr+2yB39PrCViDgEXAc6iDufKPtA3sEet/sciEm9iJ9nvlBZ6/f
        U3KaqOXh+oP5iNQ5hJo7e0YhLBDhuM5I09IYlrKKpkk2YnCRoDIYTcFS5McOiTO1m0fwynG
        V3TC5j278AnA5X5/glvqvbRxFMCn7OLpnJh/uIr0YcyU/Pz2y6WprSmD86A97EcG+080xjJ
        pnf+9zGGb/DlRhAOX+McOyTwXbTtcSpaO0j48Hl2Sda+acU3nHWX3qrsA1+1kO2WtwdmG0H
        0cx129cN9fgS7BjIMXPxYjkoCU6ZzPqOiYpoEtj8EuRDyC62E9lY3QCJs/kNunkCIuJBG7Z
        3ynJq5D3xXwY/JVmpUeFjhey6TWxih8KuUAo9mgTSjKOEBBh9viuueDFczxxJlTURHN7t7Q
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     vigneshr@ti.com
Cc:     richard@nod.at, miquel.raynal@bootlin.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ubi: ubi-media.h: Fix comment typo
Date:   Thu, 11 Aug 2022 21:57:30 +0800
Message-Id: <20220811135730.25480-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/mtd/ubi/ubi-media.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/ubi-media.h b/drivers/mtd/ubi/ubi-media.h
index 386db0598e95..2c9cd3b6434f 100644
--- a/drivers/mtd/ubi/ubi-media.h
+++ b/drivers/mtd/ubi/ubi-media.h
@@ -131,7 +131,7 @@ enum {
  * is changed radically. This field is duplicated in the volume identifier
  * header.
  *
- * The @vid_hdr_offset and @data_offset fields contain the offset of the the
+ * The @vid_hdr_offset and @data_offset fields contain the offset of the
  * volume identifier header and user data, relative to the beginning of the
  * physical eraseblock. These values have to be the same for all physical
  * eraseblocks.
-- 
2.36.1

