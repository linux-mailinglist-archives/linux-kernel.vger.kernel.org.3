Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E19591B63
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbiHMPaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbiHMPaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:30:15 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D9D26F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 08:30:12 -0700 (PDT)
X-QQ-mid: bizesmtp66t1660404605ts1m9f53
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 13 Aug 2022 23:30:00 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: C2zsvWT0ctVka+Pbi9ARuIpWXMo/1VB59G5RYS6Ah1pW/doPLy747yNAdZCC0
        aTtuILaIGH8Ev6+R28f4IQ7u9w0Ech1bpUSPjMywCihXcGxpiOdvH9qq6cJ+l5i1ae/GRyh
        WNOfzqz4/vzOKYW3H1s2pwa8DqG9X69xLRYyJLXLInZks2OSYupA4TaNBJQnRKPGyWuLd4N
        z9+BLPVWcFOIvpx/6uKMy0s8X4MnyjkGuV3YIsD+8SQHV1UQgWIbWUUYlwhYy46DfXglYYj
        Vjw7EJ60WQk4G8jXijp64ckTDGNl3Yc1zAZxdmspuRvdbnNiqXJd8G03i0FvCytVHn6EngT
        RXUOxAC24UKSOljk7svEpV1dCzjKGiruVuZkg4mcwfmPqrwgKZQrlGum4NXPQ==
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, min tang <tangmin@cdjrlc.com>
Subject: [PATCH] treewide: Unneeded semicolon
Date:   Sat, 13 Aug 2022 23:29:49 +0800
Message-Id: <20220813152949.4615-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
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

There is no semicolon after '}' in line 78.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 tools/virtio/virtio-trace/trace-agent-ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/virtio-trace/trace-agent-ctl.c b/tools/virtio/virtio-trace/trace-agent-ctl.c
index 73d253d4b559..39860be6e2d8 100644
--- a/tools/virtio/virtio-trace/trace-agent-ctl.c
+++ b/tools/virtio/virtio-trace/trace-agent-ctl.c
@@ -75,7 +75,7 @@ static int wait_order(int ctl_fd)
 
 		if (ret)
 			break;
-	};
+	}
 
 	return ret;
 
-- 
2.17.1

