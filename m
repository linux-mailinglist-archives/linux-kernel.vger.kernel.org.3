Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DDC53D73C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiFDOaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiFDOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:30:13 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9905BE0BB;
        Sat,  4 Jun 2022 07:30:06 -0700 (PDT)
X-QQ-mid: bizesmtp76t1654352981tdo4up2s
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Jun 2022 22:29:29 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: SIq+DGERJtyI6RKuQYueQXROGRMfUPPiYgXDgh8wk2AvR0Fhz/v/qZXP4iF/X
        gnGmg7IJ2Z7hiF8oFZX7j3SzKxjfDcRaNThyntl4UFcqcizZSgBeDG5FzkNdFjWjfFQicL9
        oADLQ0S6vls2UDbqpY7p8H/4na0P266GwfTAS7SYAPwAG1ncFgBGBeirYqLTJw/kcEk70pq
        aoCeybCnqdrT8yBO8tzpxEQcVN4vVkxhZ4sFgJtcswJooAsCaFKWf47mVKVLwZ82Ikf4Dt9
        t2a+Kn6LHRFxVlYyJgbrqGCsq0T2mh3DpRJf0ECp06WsVOBX9n1xVhS5u/t2arHcmwrulT3
        tXXI9RGJM12pXMFjw4=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] ata: libata: Fix syntax errors in comments
Date:   Sat,  4 Jun 2022 22:29:27 +0800
Message-Id: <20220604142927.15286-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/ata/libata-transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index ca129854a88c..3a71107169ae 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -9,7 +9,7 @@
  * and various sysfs attributes to expose these topologies and management
  * interfaces to user-space.
  *
- * There are 3 objects defined in in this class:
+ * There are 3 objects defined in this class:
  * - ata_port
  * - ata_link
  * - ata_device
-- 
2.36.1

