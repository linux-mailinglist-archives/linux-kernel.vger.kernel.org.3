Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6493257B538
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiGTLS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:18:25 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E30E81E3E4;
        Wed, 20 Jul 2022 04:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4DNzc
        vHvD7Osvf5FEeU23DapeDaX+IrlCy5j+eqTQ4A=; b=C9Fj3YdCMLO8boB+Kbbof
        3PqZcp8/3Kql94pHeh6RXiMBfmMAI8WSxksl4fwd8KfE/Wn/YWbwwqwMuSPc0iBP
        MU5IVWSCd53g0VcRYyEtNjlS3PxUhgME1+UrykE/6PqJzBLBxyIJCBiJ2qachisv
        SjGREdlntcgxMP5aWBR3I4=
Received: from localhost.localdomain (unknown [112.97.48.93])
        by smtp2 (Coremail) with SMTP id GtxpCgDHafRs5NdiEOjDQA--.467S2;
        Wed, 20 Jul 2022 19:18:07 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     corbet@lwn.net, tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] docs: core-api: Fix typo in comment
Date:   Wed, 20 Jul 2022 19:18:02 +0800
Message-Id: <20220720111802.17290-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgDHafRs5NdiEOjDQA--.467S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1UJr13WF4UJw1xWF45KFg_yoW3uFb_Xa
        yDJFsYyw4xtF1IqF45WasxXr4fuw4rKF4F9w1kGasxZ34UtrZrur98A343Z34Uuw15ur4F
        gF9Iy342grn7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_-VyDUUUUU==
X-Originating-IP: [112.97.48.93]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivw9EZFWB0iTmBwAAsT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the comment

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 Documentation/core-api/cpu_hotplug.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index c6f4ba2fb32d..f75778d37488 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -560,7 +560,7 @@ available:
   * cpuhp_state_remove_instance(state, node)
   * cpuhp_state_remove_instance_nocalls(state, node)
 
-The arguments are the same as for the the cpuhp_state_add_instance*()
+The arguments are the same as for the cpuhp_state_add_instance*()
 variants above.
 
 The functions differ in the way how the installed callbacks are treated:
-- 
2.25.1

