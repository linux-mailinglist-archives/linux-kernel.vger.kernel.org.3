Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D664FFF21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiDMT1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbiDMT06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:26:58 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F1A488A7;
        Wed, 13 Apr 2022 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1649877873; i=@motorola.com;
        bh=BA0XI/pY4GAqU+H82UiMPh8CZ4CTNm1Fwle+HxTdIKk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=c9zMeUlyBIthifOIOb+QCShAIDN7d5h3USKGQZEAypv2QuU4Zq2SR3U7hAFZHXDc9
         XM7v8l1IJF6I7fKapIKhfbsS6yQ/Hms//GI+at+uTZa6cdP7Xi+3mgLytDZwx6/FQK
         uzqaHbeyfAuPwtlAoNpjgXlW0ubRKQ15/rC7k6cWS7lpDQksPYWW6i6B/StZI82Gfl
         8/Es6Zhvr6Ve9wNk2fXLMbhr6NXuGSlSA/Q5S0iDlh5ocGbOqmb0fjNmSauT7OEbGr
         ExPiB4WlLbDU+aBjH/KPLcWaaksqOtMcpnDhuM7E49l7+OG8G1tqK4WV2jrQUimnka
         oPlYMXimnrbYw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRWlGSWpSXmKPExsWS8eKJqG6Bcni
  SQetzI4tjbU/YLZoXr2ez6Jy4hN3i8q45bBaLlrUyW5yYHOvA5jG7Yyarx6ZVnWwe++euYffo
  /2vg8XmTXABrFGtmXlJ+RQJrxvwPRxgLGgQrVn+awd7AeJevi5GLQ0hgKpNE75uFzBDOEiaJp
  jVdTF2MnBxsAmoSC16vYgaxRQRkJQ5f+Q1WxCzwnVHi+6kDLCAJYQELiSNzf7KB2CwCqhKrFt
  5lBLF5geKTJ9xlBbElBOQlTi07yAQRF5Q4OfMJWC8zULx562zmCYzcs5CkZiFJLWBkWsVolVS
  UmZ5RkpuYmaNraGCga2hoomtmDqT0Eqt0E/VKi3VTE4tLdI30EsuL9VKLi/WKK3OTc1L08lJL
  NjECQzGlyJl7B+OvlT/1DjFKcjApifJyfQ1LEuJLyk+pzEgszogvKs1JLT7EKMPBoSTB26sYn
  iQkWJSanlqRlpkDjAuYtAQHj5IIb4Q0UJq3uCAxtzgzHSJ1ilFRSpyXQRwoIQCSyCjNg2uDxe
  IlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsIQ23ky80rgpr8CWswEtPjbqlCQxSWJCCmpBiY
  1HbaQ2gX6mhtrSt5XOx2fM8/b+7hj6hbvvl+Wx3dIht6N99vsyeRTYa3xXLnzT9gzTs5zNiu3
  2NmynfJgSpt0ulbu6IvkokOf6/8vM0y5zs2+qunLdJnwiKVvp6Q/OXfa/rmIuyRLYAAzU5zP3
  n8Hr5Q9upowdf7dwNuLxWwKHrYlrlM/WaclubH5xwLhz2s+8/y7M7lEXeCbhRcXF5PoLeW+Lw
  tdy27oGbw5dOtYn0WvQWvqRx7ZSRKCZUHTFNTKv3JuXuUusLpI+sq7D3nmji9q5IXP7haI52F
  f71C8eadXQIXN812b9d7t9BVweW7456jcn9SL0xO2W5/tkTnfctJrltLUmK3570qFw5RYijMS
  DbWYi4oTARCYCRxAAwAA
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-2.tower-715.messagelabs.com!1649877872!29433!1
X-Originating-IP: [104.232.228.21]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31032 invoked from network); 13 Apr 2022 19:24:32 -0000
Received: from unknown (HELO va32lpfpp01.lenovo.com) (104.232.228.21)
  by server-2.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 13 Apr 2022 19:24:32 -0000
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4Kdswc3Qsdzf6nb;
        Wed, 13 Apr 2022 19:24:32 +0000 (UTC)
Received: from p1g3.. (unknown [10.45.4.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4Kdswc0t4XzbvDf;
        Wed, 13 Apr 2022 19:24:32 +0000 (UTC)
From:   Dan Vacura <w36195@motorola.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Grzeschik <mgr@pengutronix.de>,
        Dan Vacura <w36195@motorola.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: uvc: remove pause flag use
Date:   Wed, 13 Apr 2022 14:24:02 -0500
Message-Id: <20220413192402.26063-1-w36195@motorola.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pause flag doesn't appear to serve a purpose as it is possible for
the pump worker thread to not be running when new buffers are queued.
Before the following change was introduced: "43cd0023872e usb: gadget:
uvc_video: add worker to handle the frame pumping", the pause flag
status was discarded and never returned. This masked a current issues of
the userspace receiving non-zero values (considered unsuccessful) and
prevents trace_v4l2_qbuf() from being called.

Signed-off-by: Dan Vacura <w36195@motorola.com>
---
 drivers/usb/gadget/function/uvc_queue.c | 15 +--------------
 drivers/usb/gadget/function/uvc_queue.h |  1 -
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index d852ac9e47e7..8fd2f4a3dc4c 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -185,18 +185,7 @@ int uvcg_query_buffer(struct uvc_video_queue *queue, struct v4l2_buffer *buf)
 
 int uvcg_queue_buffer(struct uvc_video_queue *queue, struct v4l2_buffer *buf)
 {
-	unsigned long flags;
-	int ret;
-
-	ret = vb2_qbuf(&queue->queue, NULL, buf);
-	if (ret < 0)
-		return ret;
-
-	spin_lock_irqsave(&queue->irqlock, flags);
-	ret = (queue->flags & UVC_QUEUE_PAUSED) != 0;
-	queue->flags &= ~UVC_QUEUE_PAUSED;
-	spin_unlock_irqrestore(&queue->irqlock, flags);
-	return ret;
+	return vb2_qbuf(&queue->queue, NULL, buf);
 }
 
 /*
@@ -362,8 +351,6 @@ struct uvc_buffer *uvcg_queue_head(struct uvc_video_queue *queue)
 	if (!list_empty(&queue->irqqueue))
 		buf = list_first_entry(&queue->irqqueue, struct uvc_buffer,
 				       queue);
-	else
-		queue->flags |= UVC_QUEUE_PAUSED;
 
 	return buf;
 }
diff --git a/drivers/usb/gadget/function/uvc_queue.h b/drivers/usb/gadget/function/uvc_queue.h
index 05360a0767f6..42aaf8b227dd 100644
--- a/drivers/usb/gadget/function/uvc_queue.h
+++ b/drivers/usb/gadget/function/uvc_queue.h
@@ -43,7 +43,6 @@ struct uvc_buffer {
 
 #define UVC_QUEUE_DISCONNECTED		(1 << 0)
 #define UVC_QUEUE_DROP_INCOMPLETE	(1 << 1)
-#define UVC_QUEUE_PAUSED		(1 << 2)
 
 struct uvc_video_queue {
 	struct vb2_queue queue;
-- 
2.32.0

