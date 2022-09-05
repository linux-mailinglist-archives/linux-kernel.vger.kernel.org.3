Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1E25AC8E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbiIECqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 22:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIECqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 22:46:21 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18CDB22BEC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 19:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JgwtF
        B9LwoFi8ct0Lz2Q1kSS3Gq5kftHyzncsKPswMY=; b=cF+SYLUBdDDFm7Sm2xhTQ
        tAT+WXz8kbbmx3Y3nYyNz2O7JJmvBhz7FLGNiCdVYnMyKH0DpOIBhrL0+c5JWe/A
        m/PX9s5h/ryvW0y/RtOnPDlcCJeMZeRF7R4QRxWVHJdi3EMvezD3odfwp0cqw/Cg
        BgW8npQlg6Dg6F1qYAopyY=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp2 (Coremail) with SMTP id GtxpCgA32ubnYhVjnBptaw--.45088S2;
        Mon, 05 Sep 2022 10:46:01 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     agk@redhat.com, snitzer@kernel.org
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] dm-raid: fix spelling typo in comment
Date:   Mon,  5 Sep 2022 10:45:52 +0800
Message-Id: <20220905024552.1200248-1-13667453960@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgA32ubnYhVjnBptaw--.45088S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5GrW8Kr13CFg_yoWfZrX_uw
        18X34jgrWUG34F9w15ta1avFy0ya98WrWkXF1avanxZa98Zw47CayDCr13K3WDCFyUtF15
        Zwn8t3WrA3s0qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU16BT7UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiyBJz+1p7HmciEQABs4
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
 drivers/md/dm-raid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index c640be453313..0a30a22bebf0 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2590,7 +2590,7 @@ static int analyse_superblocks(struct dm_target *ti, struct raid_set *rs)
 
 /*
  * Adjust data_offset and new_data_offset on all disk members of @rs
- * for out of place reshaping if requested by contructor
+ * for out of place reshaping if requested by constructor
  *
  * We need free space at the beginning of each raid disk for forward
  * and at the end for backward reshapes which userspace has to provide
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

