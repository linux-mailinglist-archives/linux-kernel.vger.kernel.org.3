Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70936589B69
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbiHDMFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiHDMF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:05:29 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91B764E8;
        Thu,  4 Aug 2022 05:05:26 -0700 (PDT)
X-QQ-mid: bizesmtp65t1659614711tvhl6s7u
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 20:05:10 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: +ynUkgUhZJkYSzTvO6aaQHbfYgpwblP5j23qQ9G8Nc+5eEKkyL920TNpM4+zr
        5/dHR6DNVR1D+WJhfGtG9TYeKLrbT6E+c5OtIstt7BUr6lGW9sMtBvA0Vf1sYQcbBLVbu2S
        K3kR3v3lZNe8wA5P4zelbnSSFGNNSaDHLuwUiSkJQK9RHakcYAgXL3LbLurEfJH4L42rTAR
        nVqOxP0RZwxbRM+wxCwB0xtGSZhLtLcdXd2pUqhE/UOW74axi5KfZmSCev0f8EJztnHCBCL
        LjmUu8URm6D2hY+z4kyB2Ld/lVaisPo+PS8TieYRD7wNoRaN7rzNtwJpc+DtESb19mq1WYJ
        Xgz+sHIRuY/tBjsIosdKCKXlREMtI9Hx9x2SqXet//rTRF+OuLa2p/TGfkkf/gXU3zpX4Vn
        UZvB8+M9amI=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        ezequiel@vanguardiasur.com.ar, sakari.ailus@linux.intel.com,
        ribalda@chromium.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: v4l2: Fix comment typo
Date:   Thu,  4 Aug 2022 20:05:04 +0800
Message-Id: <20220804120504.58083-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index e6fd355a2e92..af75edee898c 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1045,7 +1045,7 @@ static void v4l_sanitize_format(struct v4l2_format *fmt)
 	/*
 	 * The v4l2_pix_format structure has been extended with fields that were
 	 * not previously required to be set to zero by applications. The priv
-	 * field, when set to a magic value, indicates the the extended fields
+	 * field, when set to a magic value, indicates the extended fields
 	 * are valid. Otherwise they will contain undefined values. To simplify
 	 * the API towards drivers zero the extended fields and set the priv
 	 * field to the magic value when the extended pixel format structure
-- 
2.35.1

