Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2CE55F67A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiF2GYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiF2GYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:24:51 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 129AC23BF1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:24:45 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.141.245])
        by APP-05 (Coremail) with SMTP id zQCowABnb7Mr8LtisqNwCA--.20398S2;
        Wed, 29 Jun 2022 14:24:43 +0800 (CST)
From:   sunying@nj.iscas.ac.cn
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ying Sun <sunying@nj.iscas.ac.cn>
Subject: [PATCH] block: remove "select BLK_RQ_IO_DATA_LEN" from BLK_CGROUP_IOCOST dependency
Date:   Wed, 29 Jun 2022 14:24:09 +0800
Message-Id: <20220629062409.19458-1-sunying@nj.iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowABnb7Mr8LtisqNwCA--.20398S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFW3KF15Wr4fGFy3Jr1xuFg_yoW3JFc_X3
        9xKF1jkw1DZ398Cr90vF4rAF1Igay8JFWIyw13tFsIqa42vF17Wa43Xr13ZFnrAa1jgF1a
        q39YvFsFyr9YkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
        Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
        c2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7VUb5fHUUUUUU==
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ying Sun <sunying@nj.iscas.ac.cn>

The configuration item BLK_RQ_IO_DATA_LEN is not declared in the kernel.
Select BLK_RQ_IO_DATA_LEN is meaningless which could be removed.

Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
---
 block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index 50b17e260fa2..444c5ab3b67e 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -147,7 +147,6 @@ config BLK_CGROUP_FC_APPID
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP
-	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
 	help
 	Enabling this option enables the .weight interface for cost
-- 
2.17.1

