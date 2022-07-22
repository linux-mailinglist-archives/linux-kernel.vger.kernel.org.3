Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B551157DADF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiGVHOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVHN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:13:59 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D5B290DB7;
        Fri, 22 Jul 2022 00:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TbLZ1
        sgBcUIOUuRmaeXKp7Oof9LwZ+fGCngQOX7Qb7w=; b=f4fUwNmpRAggTkjzOwUrB
        cgUI/uj2khker5DLiiL77CzJCeqk/koYlOWEZy1CrBI8K4A1lTh2A+6yeQY71LII
        WRA5WKq5/Toa9SV/o95mZy3HBTx5tIN74lzLforwp9JceXS2wj6x9qeHtZRdDYyF
        8Ki7c73kPX+4tM9wnkMUvs=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp1 (Coremail) with SMTP id GdxpCgCHSmQsTtpiwBsWPw--.20630S2;
        Fri, 22 Jul 2022 15:13:50 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] media: uvc: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 15:13:43 +0800
Message-Id: <20220722071343.71527-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgCHSmQsTtpiwBsWPw--.20630S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr45JF1xtFWkArW8Zwb_yoW3trgE93
        s7K3y7X3Wj9rWjyr1ayanYyrWjga17Xr1v9F1SgrsxXryUCFsxCrn7Zws5J3WqyF13JFnx
        Xry5tF1xWw1akjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZF4_3UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivw5GZFWB0jsw+wAAsl
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
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 6d3dfa4e0bb2..5aaee916045d 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1077,7 +1077,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 	}
 
 	/* Synchronize to the input stream by waiting for the FID bit to be
-	 * toggled when the the buffer state is not UVC_BUF_STATE_ACTIVE.
+	 * toggled when the buffer state is not UVC_BUF_STATE_ACTIVE.
 	 * stream->last_fid is initialized to -1, so the first isochronous
 	 * frame will always be in sync.
 	 *
-- 
2.25.1

