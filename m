Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1749D515465
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380295AbiD2TXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380279AbiD2TXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:23:43 -0400
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9650BDF69;
        Fri, 29 Apr 2022 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1651260018; i=@motorola.com;
        bh=lBsFaHd+QeW7GWXld2WKmUbZKO4xq3nXEJC9yAr2wco=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=ndxa+MX0Aj4mFIbevnWYeX/b9KFmsujDSRs6HJ9f44cHRZrsI5GRyZjE7kY2VxyBC
         JXNRFf4gBMMCU0f863pvgXKmGoeKvlF/puDEUR92FpuQ2dO0tEHAaywYpMFYhZTUmv
         IhPFpo8Ecqp74OJLXCWVSvEZJO4RKqhbMBnnDJ5IQAAdQ0jG+dik4si0d23tnHxnOw
         83Zjqf7gtbsX2Q6zRbSBlOBY35CNVCcruJvaUNVDHx7/y4S2+/xJPWBIzrFt8QwLd2
         dZUxsViVlORLAQxIhyUSM72u5e/85HZU+o/tD3+kvpD75opzOGEL11GxRViwIWCJfy
         F2W4GRagcwyfA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRWlGSWpSXmKPExsWS8eKJqG6hVU6
  Swd5H+hbH2p6wWzQvXs9m0TlxCbvF5V1z2CwWLWtldmD1mN0xk9Vj06pONo/9c9ewe3zeJBfA
  EsWamZeUX5HAmtG29Dd7wWnNiiV991kbGCerdDFycQgJTGeSaD1ymhnCWcok8Wb9NtYuRk4ON
  gE1iQWvVzGD2CICshKHr/wGs5kFzjFKPJgqCmILC/hI/N/8jg3EZhFQldi3eD8jiM0rYClx6P
  sVJhBbQkBe4tSyg0wQcUGJkzOfsEDMkZdo3jqbeQIj9ywkqVlIUgsYmVYxWiYVZaZnlOQmZub
  oGhoY6Boamuia6lpY6iVW6SbqlRbrpiYWl+ga6iWWF+ulFhfrFVfmJuek6OWllmxiBIZdShFr
  5A7G2T0/9Q4xSnIwKYnyVljmJAnxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4K21AMoJFqWmp1akZ
  eYAYwAmLcHBoyTCW20GlOYtLkjMLc5Mh0idYtTluHToyl5mIZa8/LxUKXHeMyDzBUCKMkrz4E
  bA4vESo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHe0yBTeDLzSuA2vQI6ggnoiJVFmSBHlCQ
  ipKQamIQq8/dd7+LYOO/+ot13XwtGTuUVMbFfLx4251+3U1W6ZwVr7H61akHlpPTTa0NMlQU/
  iIiplrAxzGu/x1SuZyz8WG33JN8e2YJil6yMtpMX7N6LzzTKN2Coq/uUv3xxQvrl1S634jPz/
  /VsDPXMmssX9OTZlLDfFfZHmGe4pr/wWvfiqu3ruG97GBzszvee++DZcuNty+fUH78vzKzykS
  vZlZBvIuj8eqv38nnnpSR9G+9dltsTarzydXzav+zbd/IMapbedZLP3v1oZx67pMGhjF16Ck/
  6zeYeEviw8/J3N4ukmL9vXqlwOLVf0GD9/nG9vnL2UeOIliSPY19yNMN3P5MqKS15/83avX+O
  EktxRqKhFnNRcSIAiCGqj0IDAAA=
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-11.tower-706.messagelabs.com!1651260017!82!1
X-Originating-IP: [104.232.228.21]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20191 invoked from network); 29 Apr 2022 19:20:17 -0000
Received: from unknown (HELO va32lpfpp01.lenovo.com) (104.232.228.21)
  by server-11.tower-706.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Apr 2022 19:20:17 -0000
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4Kqj4K3smvzgQ3G;
        Fri, 29 Apr 2022 19:20:17 +0000 (UTC)
Received: from p1g3.. (unknown [10.45.4.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4Kqj4K1z6Dzf6Wp;
        Fri, 29 Apr 2022 19:20:17 +0000 (UTC)
From:   Dan Vacura <w36195@motorola.com>
To:     linux-usb@vger.kernel.org
Cc:     Dan Vacura <w36195@motorola.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: uvc: allow for application to cleanly shutdown
Date:   Fri, 29 Apr 2022 14:20:01 -0500
Message-Id: <20220429192001.385636-1-w36195@motorola.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several types of kernel panics can occur due to timing during the uvc
gadget removal. This appears to be a problem with gadget resources being
managed by both the client application's v4l2 open/close and the UDC
gadget bind/unbind. Since the concept of USB_GADGET_DELAYED_STATUS
doesn't exist for unbind, add a wait to allow for the application to
close out.

Some examples of the panics that can occur are:

<1>[ 1147.652313] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000028
<4>[ 1147.652510] Call trace:
<4>[ 1147.652514]  usb_gadget_disconnect+0x74/0x1f0
<4>[ 1147.652516]  usb_gadget_deactivate+0x38/0x168
<4>[ 1147.652520]  usb_function_deactivate+0x54/0x90
<4>[ 1147.652524]  uvc_function_disconnect+0x14/0x38
<4>[ 1147.652527]  uvc_v4l2_release+0x34/0xa0
<4>[ 1147.652537]  __fput+0xdc/0x2c0
<4>[ 1147.652540]  ____fput+0x10/0x1c
<4>[ 1147.652545]  task_work_run+0xe4/0x12c
<4>[ 1147.652549]  do_notify_resume+0x108/0x168

<1>[  282.950561][ T1472] Unable to handle kernel NULL pointer
dereference at virtual address 00000000000005b8
<6>[  282.953111][ T1472] Call trace:
<6>[  282.953121][ T1472]  usb_function_deactivate+0x54/0xd4
<6>[  282.953134][ T1472]  uvc_v4l2_release+0xac/0x1e4
<6>[  282.953145][ T1472]  v4l2_release+0x134/0x1f0
<6>[  282.953167][ T1472]  __fput+0xf4/0x428
<6>[  282.953178][ T1472]  ____fput+0x14/0x24
<6>[  282.953193][ T1472]  task_work_run+0xac/0x130

<3>[  213.410077][   T29] configfs-gadget gadget: uvc: Failed to queue
request (-108).
<1>[  213.410116][   T29] Unable to handle kernel NULL pointer
dereference at virtual address 0000000000000003
<6>[  213.413460][   T29] Call trace:
<6>[  213.413474][   T29]  uvcg_video_pump+0x1f0/0x384
<6>[  213.413489][   T29]  process_one_work+0x2a4/0x544
<6>[  213.413502][   T29]  worker_thread+0x350/0x784
<6>[  213.413515][   T29]  kthread+0x2ac/0x320
<6>[  213.413528][   T29]  ret_from_fork+0x10/0x30

Signed-off-by: Dan Vacura <w36195@motorola.com>
---
 drivers/usb/gadget/function/f_uvc.c    | 24 ++++++++++++++++++++++++
 drivers/usb/gadget/function/uvc.h      |  2 ++
 drivers/usb/gadget/function/uvc_v4l2.c |  3 ++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 50e6e7a58b41..3cc8cf24a7c7 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -892,13 +892,36 @@ static void uvc_function_unbind(struct usb_configuration *c,
 {
 	struct usb_composite_dev *cdev = c->cdev;
 	struct uvc_device *uvc = to_uvc(f);
+	int wait_ret = 1;
 
 	uvcg_info(f, "%s()\n", __func__);
 
+	/* If we know we're connected via v4l2, then there should be a cleanup
+	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
+	 * though the video device removal uevent. Allow some time for the
+	 * application to close out before things get deleted.
+	 */
+	if (uvc->func_connected) {
+		uvcg_info(f, "%s waiting for clean disconnect\n", __func__);
+		wait_ret = wait_event_interruptible_timeout(uvc->func_connected_queue,
+				uvc->func_connected == false, msecs_to_jiffies(500));
+		uvcg_info(f, "%s done waiting with ret: %u\n", __func__, wait_ret);
+	}
+
 	device_remove_file(&uvc->vdev.dev, &dev_attr_function_name);
 	video_unregister_device(&uvc->vdev);
 	v4l2_device_unregister(&uvc->v4l2_dev);
 
+	if (uvc->func_connected) {
+		/* Wait for the release to occur to ensure there are no longer any
+		 * pending operations that may cause panics when resources are cleaned
+		 * up.
+		 */
+		uvcg_warn(f, "%s no clean disconnect, wait for release\n", __func__);
+		wait_ret = wait_event_interruptible_timeout(uvc->func_connected_queue,
+				uvc->func_connected == false, msecs_to_jiffies(1000));
+	}
+
 	usb_ep_free_request(cdev->gadget->ep0, uvc->control_req);
 	kfree(uvc->control_buf);
 
@@ -917,6 +940,7 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
 
 	mutex_init(&uvc->video.mutex);
 	uvc->state = UVC_STATE_DISCONNECTED;
+	init_waitqueue_head(&uvc->func_connected_queue);
 	opts = fi_to_f_uvc_opts(fi);
 
 	mutex_lock(&opts->lock);
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 9eec104b3666..58e383afdd44 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -14,6 +14,7 @@
 #include <linux/spinlock.h>
 #include <linux/usb/composite.h>
 #include <linux/videodev2.h>
+#include <linux/wait.h>
 
 #include <media/v4l2-device.h>
 #include <media/v4l2-dev.h>
@@ -130,6 +131,7 @@ struct uvc_device {
 	struct usb_function func;
 	struct uvc_video video;
 	bool func_connected;
+	wait_queue_head_t func_connected_queue;
 
 	/* Descriptors */
 	struct {
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index a2c78690c5c2..fd8f73bb726d 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -253,10 +253,11 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
 
 static void uvc_v4l2_disable(struct uvc_device *uvc)
 {
-	uvc->func_connected = false;
 	uvc_function_disconnect(uvc);
 	uvcg_video_enable(&uvc->video, 0);
 	uvcg_free_buffers(&uvc->video.queue);
+	uvc->func_connected = false;
+	wake_up_interruptible(&uvc->func_connected_queue);
 }
 
 static int
-- 
2.32.0

