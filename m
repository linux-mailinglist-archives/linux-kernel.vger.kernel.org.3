Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88057D877
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiGVCV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiGVCVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:21:47 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 243F9974B2;
        Thu, 21 Jul 2022 19:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZVmSm
        fPea/8T1u5ERmrwfoVknS9hHZixK9cuPCErde8=; b=ITRElxZ6ClvFEf+8/lpiG
        8RZWVf0fOC+Jnu3/3rmQVualgZx0omf81BZdf5KLHb8WocgKkXCqUhF7CGm9yBey
        e5fa0Hg+T9MRwysM7KgVZVnbkT2LoA+RcVKw/ol3xwaHgmfK8+JxauvbsbTiCspV
        oMpooCsNUManIJVqGE//wU=
Received: from localhost.localdomain (unknown [223.104.68.59])
        by smtp8 (Coremail) with SMTP id DMCowACnfRXMBdpiMfFoOw--.44S2;
        Fri, 22 Jul 2022 10:05:03 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] media: ivtv: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 10:04:59 +0800
Message-Id: <20220722020459.64191-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowACnfRXMBdpiMfFoOw--.44S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1rGFy8uw15CF48JFb_yoWfurc_Wr
        nFqw4xWw4UAF9xtrn2yr1fZF90ga95ua4fAryFyryfJa48ur43WrWqvasrAFnxXF4fuF9r
        K34jqF15C348KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiApn5UUUUU==
X-Originating-IP: [223.104.68.59]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivxBGZFWB0jfvGAAAsL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/media/pci/ivtv/ivtv-yuv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ivtv/ivtv-yuv.c b/drivers/media/pci/ivtv/ivtv-yuv.c
index e79e8a5a744a..4ba10c34a16a 100644
--- a/drivers/media/pci/ivtv/ivtv-yuv.c
+++ b/drivers/media/pci/ivtv/ivtv-yuv.c
@@ -538,7 +538,7 @@ static void ivtv_yuv_handle_vertical(struct ivtv *itv, struct yuv_frame_info *f)
 	reg_2964 = (reg_2964 << 16) + reg_2964 + (reg_2964 * 46 / 94);
 
 	/* Okay, we've wasted time working out the correct value,
-	   but if we use it, it fouls the the window alignment.
+	   but if we use it, it fouls the window alignment.
 	   Fudge it to what we want... */
 	reg_2964 = 0x00010001 + ((reg_2964 & 0x0000FFFF) - (reg_2964 >> 16));
 	reg_2968 = 0x00010001 + ((reg_2968 & 0x0000FFFF) - (reg_2968 >> 16));
-- 
2.25.1

