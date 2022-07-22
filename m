Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA64257DB12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiGVHTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiGVHTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:19:03 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEF50B481;
        Fri, 22 Jul 2022 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LVFEW
        1WjS4Y0AHdM67vx0ek+MLWElmRsBHZBwRQJjWI=; b=mZIZD4tj4oBT3lJEAn4ve
        v61KAk4b4CLe+ou+XZqFSiizkIM7Okjo1SFK3b09B2lennLAXVAPoO2BMeSnlMVg
        nKj3LxRFe61vfvmPdLxLaxMugBVs21KrYHGW2Ti31RigSuOLLOFNAGeWdsf433FP
        CAn3gfEXfNOcKZu/kOeOqg=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp1 (Coremail) with SMTP id GdxpCgD3CHRbT9piVeYWPw--.1201S2;
        Fri, 22 Jul 2022 15:18:52 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] media: v4l2-ioctl: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 15:18:50 +0800
Message-Id: <20220722071850.71901-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgD3CHRbT9piVeYWPw--.1201S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr48JrW3Xw1xAw13Jwb_yoWDAwb_Wa
        s5G3Z2qF1UA3W8Kwn0y343Z3yrt3yUurn3JF98trZIqFy8Z3WYkr92yr4UJrZ7uanFyws8
        Xr9xXw1Fyw4UWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR9Yr95UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBAxpGZGB0LoMRTQAAse
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 0866dd485ee6..25aa55317dc6 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1020,7 +1020,7 @@ static void v4l_sanitize_format(struct v4l2_format *fmt)
 	/*
 	 * The v4l2_pix_format structure has been extended with fields that were
 	 * not previously required to be set to zero by applications. The priv
-	 * field, when set to a magic value, indicates the the extended fields
+	 * field, when set to a magic value, indicates the extended fields
 	 * are valid. Otherwise they will contain undefined values. To simplify
 	 * the API towards drivers zero the extended fields and set the priv
 	 * field to the magic value when the extended pixel format structure
-- 
2.25.1

