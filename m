Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE296589B43
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbiHDL4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDL4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:56:33 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0949C28E13;
        Thu,  4 Aug 2022 04:56:31 -0700 (PDT)
X-QQ-mid: bizesmtp91t1659614182t6urspv6
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 19:56:21 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: 6/K5pWSRdGqKU+5qIPGW7ynf6+YrFwnG84tNX2VzQTL5ZqnkFBr9FJfM0g/aU
        HV0RQlYbKCqjBekHNMaONqr4IXlJ/PkigPsxUvLQFqIpWlfQNsjIQddoCxqU+HGFyNE1OGT
        mYb0yOF74cUhdsDog7yLUAaxhSKfVJqEECYHRoewcdYF6q1nfV5BsH+XLIonpDBVh6RKuib
        cjH5gE7Il5IeQclmDj27dC6mVyUaIuLUnzJKS49qna8g0TWpRPT7v+sbQtjRH5wZAX3FLKf
        HsRZoOD2m2SDI65A7SUGBF5dd80wGFURUxVUIOqoueHYf50lWQm4hMzQUqtS7D70QJ+sir5
        lJvY3vnyuT0JeBbcwe91CqxSAl51Rqa44gwBomVCzf5OkfSNmPITouyDpCXOD2zzn4PF7Yc
        vV9cvEstFcQ=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     laurent.pinchart@ideasonboard.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: uvcvideo: Fix comment typo
Date:   Thu,  4 Aug 2022 19:56:20 +0800
Message-Id: <20220804115620.52384-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 170a008f4006..d2eb9066e4dc 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1095,7 +1095,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 
 	/*
 	 * Synchronize to the input stream by waiting for the FID bit to be
-	 * toggled when the the buffer state is not UVC_BUF_STATE_ACTIVE.
+	 * toggled when the buffer state is not UVC_BUF_STATE_ACTIVE.
 	 * stream->last_fid is initialized to -1, so the first isochronous
 	 * frame will always be in sync.
 	 *
-- 
2.35.1

