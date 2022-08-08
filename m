Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8758CB03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbiHHPGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiHHPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:06:15 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310D2FF9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:06:12 -0700 (PDT)
X-QQ-mid: bizesmtp70t1659971164tpy5v4k0
Received: from harry-jrlc.. ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:05:44 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: RLrSOnjbvYHQT9W7jQ2E2lkwAXoPLOCWCJqpHnB1PX4tx/G3aaeVw4KNd1sD+
        CjssKkLIi8GbwZlobZmztKjerTbb1aFBcEKEHVpKOqK1r+rqnPqTajG9iuDtsyVnH3ocp7k
        Xvnj6uP2BOjNSHbvV3KV2msprzByouHFl1ZWf8ev+GD4wl+/wBB9iQHLwXlRQMt4XO2+vlj
        fbUSUDX9JxU0dPD21U7pb1I4OrqJHRSlIr3EUInOPwyLpRAV11I47kP0ELeIg0VyXyNDyKJ
        uR8cLP+jboeDOaTrY1JdAW4XNnS85bEysvDxf+Wg56zKrZ/19wFh0L+/aF3bYUSHxvbyHes
        8z2MsIWN3ZMjePZflsyk3BY2bzsZ6ywnDVw21ykwaRJUXI/K0nlI1l/z6dckg==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] ringtest: Variable type completion
Date:   Mon,  8 Aug 2022 23:05:42 +0800
Message-Id: <20220808150542.58937-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' is better than 'unsigned'.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 tools/virtio/ringtest/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
index 5a18b2301a63..01ed3ced4533 100644
--- a/tools/virtio/ringtest/main.c
+++ b/tools/virtio/ringtest/main.c
@@ -26,7 +26,7 @@ bool do_sleep = false;
 bool do_relax = false;
 bool do_exit = true;
 
-unsigned ring_size = 256;
+unsigned int ring_size = 256;
 
 static int kickfd = -1;
 static int callfd = -1;
-- 
2.30.2

