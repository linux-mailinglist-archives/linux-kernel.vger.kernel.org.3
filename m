Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D585ADD25
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiIFCGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIFCF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:05:59 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF46842ADE;
        Mon,  5 Sep 2022 19:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xmN1F
        CoHwFFxWoZVNoofoQFdyf4htAgoTRMoCaG/1Y8=; b=Gt9504JVSfg9QvkZhZylc
        Vs8Rqa6YklAvZg6PXYtEq7Mbn166EYDn1rP6JKYkqdwmYM8WD5jfy5QyVS9X8R8u
        8J1nziqGh+SuuZnl2/hyoG03Zyi/GnB24+RatxYf3q8NXzlOJ4hpFZhHDPZyF7cb
        z0gRQ3ILZQ9rcPSENNqFPs=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp2 (Coremail) with SMTP id GtxpCgA3NAfcqhZjHAaSbA--.23398S2;
        Tue, 06 Sep 2022 10:05:17 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     axboe@kernel.dk, roger.pau@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] xen-blkback/common.h: fix spelling typo in comment
Date:   Tue,  6 Sep 2022 10:05:14 +0800
Message-Id: <20220906020514.4169975-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgA3NAfcqhZjHAaSbA--.23398S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5Jw4rXFyUtrb_yoWDtFXEkr
        1UZanrXrWFyF4Sv3WjkF4Sqry2934UuFWkCFnaqa9agayUGa17X34qyr1fGFnxGrW8tw13
        C3ZxJrWUtF48JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU88sqJUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiyB10+1p7HnJeYwAAsq
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
 drivers/block/xen-blkback/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index a28473470e66..4223995642f4 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -132,7 +132,7 @@ struct blkif_x86_32_request {
 struct blkif_x86_64_request_rw {
 	uint8_t        nr_segments;  /* number of segments                   */
 	blkif_vdev_t   handle;       /* only for read/write requests         */
-	uint32_t       _pad1;        /* offsetof(blkif_reqest..,u.rw.id)==8  */
+	uint32_t       _pad1;        /* offsetof(blkif_request..,u.rw.id)==8  */
 	uint64_t       id;
 	blkif_sector_t sector_number;/* start sector idx on disk (r/w only)  */
 	struct blkif_request_segment seg[BLKIF_MAX_SEGMENTS_PER_REQUEST];
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

