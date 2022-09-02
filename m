Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9405AA61F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiIBDEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiIBDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:04:01 -0400
X-Greylist: delayed 471 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Sep 2022 20:03:59 PDT
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E00A89F8E6;
        Thu,  1 Sep 2022 20:03:59 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowAD37FHMcBFjLoZuAA--.13835S2;
        Fri, 02 Sep 2022 10:56:12 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     deller@gmx.de, broonie@kernel.org,
        maarten.lankhorst@linux.intel.com, daniel.vetter@ffwll.ch
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH 2/2] video: fbdev: gbefb: Remove unproper information
Date:   Fri,  2 Sep 2022 10:56:12 +0800
Message-Id: <20220902025612.3833972-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD37FHMcBFjLoZuAA--.13835S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw4DKw4kKF13Jw1xGr15Jwb_yoW3JFcEkw
        s8ZFZxWryqkr1vg3W8Kr4Y9ry0kF1qqFy3XFn3Kryft343Ar1rX34UZr1Fg398ZF4jvFnx
        X3Z09r4xZ3sakjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_
        Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW8JVW3JwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOyCGUUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When drivers are working properly, they are quiet.
Therefore, the fb_info() should be removed.

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/video/fbdev/gbefb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 1582c718329c..7e39ab939691 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -1217,10 +1217,6 @@ static int gbefb_probe(struct platform_device *p_dev)
 
 	platform_set_drvdata(p_dev, info);
 
-	fb_info(info, "%s rev %d @ 0x%08x using %dkB memory\n",
-		info->fix.id, gbe_revision, (unsigned)GBE_BASE,
-		gbe_mem_size >> 10);
-
 	return 0;
 
 out_gbe_unmap:
-- 
2.25.1

