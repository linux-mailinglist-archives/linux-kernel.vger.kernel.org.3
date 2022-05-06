Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF5551D2B3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389779AbiEFICU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 04:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389776AbiEFICO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:02:14 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1E2674F7;
        Fri,  6 May 2022 00:58:31 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VCR2-To_1651823896;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCR2-To_1651823896)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 May 2022 15:58:29 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ssb: remove unreachable code
Date:   Fri,  6 May 2022 15:58:14 +0800
Message-Id: <20220506075814.115059-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the following smatch warning:

drivers/ssb/pci.c:917 ssb_pci_sprom_get() warn: ignoring unreachable
code.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/ssb/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ssb/pci.c b/drivers/ssb/pci.c
index 148bcb99c212..493bebbba521 100644
--- a/drivers/ssb/pci.c
+++ b/drivers/ssb/pci.c
@@ -914,7 +914,6 @@ static int ssb_pci_sprom_get(struct ssb_bus *bus,
 				err = 0;
 				goto out_free;
 			}
-			pr_warn("WARNING: Invalid SPROM CRC (corrupt SPROM)\n");
 		}
 	}
 	err = sprom_extract(bus, sprom, buf, bus->sprom_size);
-- 
2.20.1.7.g153144c

