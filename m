Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004D151B9AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346652AbiEEIOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiEEINs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:13:48 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174663F893
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:10:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VCKXnSF_1651738196;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCKXnSF_1651738196)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 May 2022 16:10:06 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     patrik.r.jakobsson@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/gma500: Clean up some inconsistent indenting
Date:   Thu,  5 May 2022 16:09:54 +0800
Message-Id: <20220505080954.84416-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

drivers/gpu/drm/gma500/cdv_device.c:250 cdv_errata() warn:
inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/gma500/cdv_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
index dd32b484dd82..09684c42cbf6 100644
--- a/drivers/gpu/drm/gma500/cdv_device.c
+++ b/drivers/gpu/drm/gma500/cdv_device.c
@@ -247,7 +247,7 @@ static void cdv_errata(struct drm_device *dev)
 	 *	Bonus Launch to work around the issue, by degrading
 	 *	performance.
 	 */
-	 CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
+	CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
 }
 
 /**
-- 
2.20.1.7.g153144c

