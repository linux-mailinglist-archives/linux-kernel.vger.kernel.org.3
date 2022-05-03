Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7714518EA9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiECU0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiECU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:26:09 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFE52DAAA;
        Tue,  3 May 2022 13:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1651609354; i=@motorola.com;
        bh=DckmQ8AS5uSG1WiLGCJHbdizSuuEX/2IoBc9bfkGBww=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=iL6Ej8AeSJHUYuceJu5Lf+jiYl0/TqMxNkjo9+CTXFza8+RGt6rHGar8AIZE2DPUF
         SGkoZI9EpcfyhRA3K2NcndTJdij/WGylaVy0ai6gj6RJVLtPPrTN0fG3+c+BEpe78w
         yIXSqvlpOoE/EhTat7lCd74fUSICJisOKgDtYpZnGoXfLD4eqDJgJ7yGLe8HZQIcbh
         oi6RwH4aajw9uzKRQFO8IqUAiQrKg6FFL7BBkyulNL2Ip97DejvDXjRIhRVEW2mds5
         /8pzoDrgAmfhAz2PA1EhSAZzw5px2kirjOYt+BB3/8SjzD0Cr/GAsa1NK9mblLi7ns
         7p7EayxyXVPVA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRWlGSWpSXmKPExsUyYU+Dsy5nf2G
  SwaWFRhbH2p6wWzQvXs9m0TlxCbvF5V1z2CwWLWtldmD1mN0xk9Vj06pONo/9c9ewe3zeJBfA
  EsWamZeUX5HAmrG4/wRTQaN2RdvCF6wNjCtUuxg5OYQEpjFJ/F7q1cXIBWQvYZLYcrWBGSTBJ
  qAmseD1KjBbREBW4vCV32A2s8A5RokHU0VBbGEBf4kbe++zdTFycLAIqEqsPlYHEuYVsJBou/
  GNCcSWEJCXOLXsIBNEXFDi5MwnLBBj5CWat85mnsDIPQtJahaS1AJGplWMVklFmekZJbmJmTm
  6hgYGuoaGJrqWlrrGhnqJVbqJeqXFuuWpxSW6RnqJ5cV6qcXFesWVuck5KXp5qSWbGIFBl1KU
  LL+Dsb//p94hRkkOJiVR3o9thUlCfEn5KZUZicUZ8UWlOanFhxhlODiUJHj/9gLlBItS01Mr0
  jJzgBEAk5bg4FES4Z3dBZTmLS5IzC3OTIdInWLU5bh06MpeZiGWvPy8VClxXsU+oCIBkKKM0j
  y4EbBovMQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmPcUyCU8mXklcJteAR3BBHTEsXiwI0o
  SEVJSDUzpSRu9ps6u43gy00g7o6r4MPtSr1UfNPw3FHpqTZ8xf7sO19m/dxJ6owvTC10XBAnO
  nvLxGf9v3fZZt/uyFPg1Qi4snOi03/j/o/97fh5LimnSYzU1m3KoofdQhjZfjX289rXAn9yvz
  bZY3EpZO7HHnEPaw3/HwXkHQ6YcsY9c/0yy9vUR8+j5oQmC4vMN1CZGrz9o8j3i3k3HG6/qpq
  b150+bXC29Q/HaxFd+h/JX/S/3Ku9kM3BZWvXSOObapFcmlv8WSnY9t9rAz/lSfn1J/jSxzTU
  Hnx+PWPsxRo41YLPGp/ni/AU8WgIHglRuZ5plvIv7vX7/PZeHrZsWn1kdkui2YM08gdnTO1YY
  +79VYinOSDTUYi4qTgQAIQn2gEEDAAA=
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-3.tower-636.messagelabs.com!1651609353!30361!1
X-Originating-IP: [144.188.128.67]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19944 invoked from network); 3 May 2022 20:22:33 -0000
Received: from unknown (HELO ilclpfpp01.lenovo.com) (144.188.128.67)
  by server-3.tower-636.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 May 2022 20:22:33 -0000
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4KtBGJ740YzfBZq;
        Tue,  3 May 2022 20:22:32 +0000 (UTC)
Received: from p1g3.. (unknown [10.45.5.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4KtBGJ44Lczf6f0;
        Tue,  3 May 2022 20:22:32 +0000 (UTC)
From:   Dan Vacura <w36195@motorola.com>
To:     linux-usb@vger.kernel.org
Cc:     Dan Vacura <w36195@motorola.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: uvc: allow for application to cleanly shutdown
Date:   Tue,  3 May 2022 15:10:38 -0500
Message-Id: <20220503201039.71720-1-w36195@motorola.com>
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
V1 -> V2:
- change some logging from uvcg_info to uvcg_dbg (calls dev_dbg)
- update wait_ret type from int to long to match return type

 drivers/usb/gadget/function/f_uvc.c    | 25 +++++++++++++++++++++++++
 drivers/usb/gadget/function/uvc.h      |  2 ++
 drivers/usb/gadget/function/uvc_v4l2.c |  3 ++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 50e6e7a58b41..a3cf470b3ec5 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -892,13 +892,37 @@ static void uvc_function_unbind(struct usb_configuration *c,
 {
 	struct usb_composite_dev *cdev = c->cdev;
 	struct uvc_device *uvc = to_uvc(f);
+	long wait_ret = 1;
 
 	uvcg_info(f, "%s()\n", __func__);
 
+	/* If we know we're connected via v4l2, then there should be a cleanup
+	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
+	 * though the video device removal uevent. Allow some time for the
+	 * application to close out before things get deleted.
+	 */
+	if (uvc->func_connected) {
+		uvcg_dbg(f, "waiting for clean disconnect\n");
+		wait_ret = wait_event_interruptible_timeout(uvc->func_connected_queue,
+				uvc->func_connected == false, msecs_to_jiffies(500));
+		uvcg_dbg(f, "done waiting with ret: %ld\n", wait_ret);
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
+		uvcg_dbg(f, "done waiting for release with ret: %ld\n", wait_ret);
+	}
+
 	usb_ep_free_request(cdev->gadget->ep0, uvc->control_req);
 	kfree(uvc->control_buf);
 
@@ -917,6 +941,7 @@ static struct usb_function *uvc_alloc(struct usb_function_instance *fi)
 
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

