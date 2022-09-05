Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9684B5ACA6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbiIEGSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbiIEGR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:17:58 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 407142AE2C
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5ebLN
        HNnVju2atnVAXNzQj0xN/kSmqc7gcfRYJ4Yjdk=; b=iGEJOIfpD1JhJ3R31vLzC
        mzZ3cLYEj0BcsUcfYnE5+XYZtSg0E1oXAvSTm6wqQX1+N2qdtXgizgRbtn45Hl5b
        caRQAX76jHYSP4yDHt/puggCO8aVf5+KkSB+rVxDcs6lher2uV2TEBXhlqAtYpMv
        bqNS6ImbNyhPfJRY57rvcQ=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgCXR4FclBVjjLb9aw--.33042S2;
        Mon, 05 Sep 2022 14:17:01 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] fs/ocfs2/suballoc.h: fix spelling typo in comment
Date:   Mon,  5 Sep 2022 14:16:56 +0800
Message-Id: <20220905061656.1829179-1-13667453960@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgCXR4FclBVjjLb9aw--.33042S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5GFy8Gw1xXwb_yoWfJFX_KF
        1UJ3yjgFW0yan3A3W8AwsYvrWFgw18Ca1jk3W5ZrnxGayrGa1Dtw1Dt3ySy34qqrWjv34r
        ZFyft34ftas7JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1GNtDUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiyB5z+1p7HmlhhAAAst
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/ocfs2/suballoc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/suballoc.h b/fs/ocfs2/suballoc.h
index 5805a03d100b..9c74eace3adc 100644
--- a/fs/ocfs2/suballoc.h
+++ b/fs/ocfs2/suballoc.h
@@ -106,7 +106,7 @@ int ocfs2_claim_clusters(handle_t *handle,
 			 u32 *cluster_start,
 			 u32 *num_clusters);
 /*
- * Use this variant of ocfs2_claim_clusters to specify a maxiumum
+ * Use this variant of ocfs2_claim_clusters to specify a maximum
  * number of clusters smaller than the allocation reserved.
  */
 int __ocfs2_claim_clusters(handle_t *handle,
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

