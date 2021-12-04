Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C189468646
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355516AbhLDQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 11:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355388AbhLDQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:38:54 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203C2C061354;
        Sat,  4 Dec 2021 08:35:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so12559922wru.13;
        Sat, 04 Dec 2021 08:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U5oa62j24xavZIhW1pQBwsS9AFzTZJdQ7fQ+VSov/gU=;
        b=QjujrxabGjUpNmt2NhBglQ8VAZ2txQBLtVcB/rzT2wSaX9OWozOLfKMb6CNyQTcV07
         sG1VUu6P3i/MFJO5EMQyehuOBadwrxyW3ypLcLR885EaQy8F9T3GZO6YXDxc7UBIUMb7
         eyh2s0R0ozfhA/fIqENgPzYmUyfX/jZg+vspyzQm9Ui5bO7uhHHiP8xzoW1EEF8VJ6yH
         mChbLelF2crp7dWgMk/bjvkk+/M9W1Wv3S98UzxRWOFnZHoeD1dZNPHQ7aAB6hnvW86M
         OjzmiCAqBIVnESAj0MAQqtzU43txdeDJoy+swGJyHbvy7pjNAH/iGIu4cd9DY2JAH7Oj
         ap6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U5oa62j24xavZIhW1pQBwsS9AFzTZJdQ7fQ+VSov/gU=;
        b=JmcX9m1nG0vhIluFXnZP4I61mgmEU6QcCU4356MDAJzP+t7kxChDTGDFFuRDVaO3bK
         k8dZ1VTDV98qoMWex9vV68ly/t8S17UbzAgZZoVWxjd3bQBZ5d0eEqTkNyhTmYB+A1qg
         mEgGQ7N5gk3x2PUbc6THz81opPKSX8+tRVrbfT6kgC+Nt8zQZk1mldMyVU0fJBEEWEcd
         w5MUQAhi4a7R0uqf8w64mPUSiGOUAQkfnKslJIeSkXAYs27ng0kOcTlwhxCdHq2jJgy1
         CUjp8CvNar4rh2EY+4y0fR8YTKMq5gGTsRA9iTjV8VAHvcQ6PQam7KFzUniK1hqR2c+j
         mntg==
X-Gm-Message-State: AOAM530oF0nn9+sto7ypEEAekiK7aWS2cOzWINz++GuU1lxKB4svtgvJ
        Nmd479zC8tFt4cx+t9hdX0s=
X-Google-Smtp-Source: ABdhPJyIdX2n3WId2lMyChYLev51YRiEPslY7xT8mJ3MVirL5jdU0inRbWxNlxnNlUeCjkxuOIKEUQ==
X-Received: by 2002:a5d:47c9:: with SMTP id o9mr8826548wrc.55.1638635726766;
        Sat, 04 Dec 2021 08:35:26 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0685b3447c22a42fc55e.dip0.t-ipconnect.de. [2003:c7:8f4e:685:b344:7c22:a42f:c55e])
        by smtp.gmail.com with ESMTPSA id n13sm6053915wrt.44.2021.12.04.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 08:35:26 -0800 (PST)
Date:   Sat, 4 Dec 2021 17:35:24 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 3/4] Docs: usb: update comment and code of function
 skel_delete
Message-ID: <cff10de3381deedd002e2e8cda884593400b42cb.1638630342.git.philipp.g.hortmann@gmail.com>
References: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put skel_delete function in the document typical form
Update code according to usb-skeleton.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Corrected format of function name to skel_delete()
---
 .../driver-api/usb/writing_usb_driver.rst     | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 297b622f5438..b459f9e089e0 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -262,19 +262,18 @@ One of the more difficult problems that USB drivers must be able to
 handle smoothly is the fact that the USB device may be removed from the
 system at any point in time, even if a program is currently talking to
 it. It needs to be able to shut down any current reads and writes and
-notify the user-space programs that the device is no longer there. The
-following code (function ``skel_delete``) is an example of how to do
-this::
+notify the user-space programs that the device is no longer there.
+skel_delete() is an example of how to do this::
 
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

