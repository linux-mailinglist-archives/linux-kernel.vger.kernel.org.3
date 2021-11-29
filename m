Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F384F46260C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhK2Wqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbhK2WqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:46:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8779C09CE48;
        Mon, 29 Nov 2021 12:21:55 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d9so18570827wrw.4;
        Mon, 29 Nov 2021 12:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yr7Pm1zMDL+waiXGnmgDPUcvU9J11jTasCepYE2XOcI=;
        b=LiiAhDbYWHpCwYtAa2MJumN97/cy1tI6b39nZ5sEpep8M7bmVXwMNhhnacI1jZh779
         dglz9rJF/4h4heP1VBuF9fpEVK/B1WFEGD1SjlivBXiRrVLtsk6Lfcracj0nHg9w3F/k
         fyuxa3wFU8MW5BuOzJTpZG5IKQpGXktpS1VAskhKFnbjbtAmX0aIAvh3KQ/S4Co6+8pO
         +4sBr1SGcX0/rASd4P22u64snuSmRDGbM1QXs1qmf+SYhfMg+c1k3PcWbOtdiXNSmZaz
         SY2rpLmC3ODQDruPCIMSqUTR01Rj5V+g3JiYpkDFBuXRFjKuJrICF5HDFCh5mpuFHgQC
         CCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yr7Pm1zMDL+waiXGnmgDPUcvU9J11jTasCepYE2XOcI=;
        b=047kRsTFYwCtvH07KvmbACY0msd3Zhh2Mq9IafPZtlx+4E49/VtzuUN7IlZ2YITJBx
         m4+Qp6zZvr+5pmflsei0YGKktQ7fFvf5Y6GoHKvnkiUnUC9etLk8/ppO50lcLRv3Oj0+
         Zl9vVyEQZFcZYlN+SiwNh+JLE8tgJkwkXbkwBOSY5jYjYPA5oTz25gMyMHwp0h0vnFCn
         dLVEjzdiwvJNujSIxAIsiU2ZyM0wA+pGTGMTpqhF1oyt+Hz6+jS9kkkvYgOe2xy8EuOC
         U6j/sk5BfZBFQxVHXgCqeDJ0OgMy7dTTnUJgE981ZEe9HXSTXxVChOGt5t7a2zA9CgUN
         56oA==
X-Gm-Message-State: AOAM532IOX2Ph31LBjUAgnjbwgfxuogGw0KnzQTv34CRCKa1AzDx5QgW
        7wZtRSP7NcrTVn7wn8AB8R8=
X-Google-Smtp-Source: ABdhPJx07ZTKQZSdjG2iCwY0lEujg0Naxur5L4l+SvNUdnLbUrbaNbWRNTlTwHTqXyH4JnDkNq/mcw==
X-Received: by 2002:a05:6000:1acd:: with SMTP id i13mr36406501wry.398.1638217314493;
        Mon, 29 Nov 2021 12:21:54 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06460b103a790e4c64a8.dip0.t-ipconnect.de. [2003:c7:8f4e:646:b10:3a79:e4c:64a8])
        by smtp.gmail.com with ESMTPSA id o9sm14710006wrs.4.2021.11.29.12.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:21:54 -0800 (PST)
Date:   Mon, 29 Nov 2021 21:21:52 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 3/4] Docs: usb: update comment and code of function
 skel_delete
Message-ID: <76757c4fc1f5001c3285a9a071055e8715985604.1638152984.git.philipp.g.hortmann@gmail.com>
References: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put skel_delete function in the document typical form
Update code according to usb-skeleton.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../driver-api/usb/writing_usb_driver.rst     | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index b16e4e76d472..74bb72a2f0ac 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -263,18 +263,17 @@ handle smoothly is the fact that the USB device may be removed from the
 system at any point in time, even if a program is currently talking to
 it. It needs to be able to shut down any current reads and writes and
 notify the user-space programs that the device is no longer there. The
-following code (function ``skel_delete``) is an example of how to do
-this::
+`skel_delete` function is an example of how to do this::
 
-    static inline void skel_delete (struct usb_skel *dev)
+    static void skel_delete(struct kref *kref)
     {
-	kfree (dev->bulk_in_buffer);
-	if (dev->bulk_out_buffer != NULL)
-	    usb_free_coherent (dev->udev, dev->bulk_out_size,
-		dev->bulk_out_buffer,
-		dev->write_urb->transfer_dma);
-	usb_free_urb (dev->write_urb);
-	kfree (dev);
+	struct usb_skel *dev = to_skel_dev(kref);
+
+	usb_free_urb(dev->bulk_in_urb);
+	usb_put_intf(dev->interface);
+	usb_put_dev(dev->udev);
+	kfree(dev->bulk_in_buffer);
+	kfree(dev);
     }
 
 
-- 
2.25.1

