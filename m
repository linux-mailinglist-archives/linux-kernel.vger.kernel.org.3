Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A725B46863C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355343AbhLDQim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 11:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355312AbhLDQil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:38:41 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7386BC0613F8;
        Sat,  4 Dec 2021 08:35:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d24so12779601wra.0;
        Sat, 04 Dec 2021 08:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gx0uXkDZfAezvx2UPITjgfJR6vkopVeUq+GbwzqBDgM=;
        b=DHII9CGr3LVdJWaYU5QSMAQ+pWXY/6v6xondHK2AywQF/qyRm82HZK4xsSEv6kDklM
         Lw9msnenQScFykTzmX/0N7zSRjEr136FVQwS//6SApdl7+hrNABVuqxaOPdnXPhfWwGM
         nSDX4a8D6zwimgPBYJ672g2P8Q+bDoNHuvma8Wt3LLP7xxbXBg3PMeC0TI7ZEcdIrss8
         YW+RpWTDX/YQhwzwW+1gC3+EApXF6vCLcq56KD4eWs4VLH370FhP5QTeFQGiL5eMvHcR
         OX9I682skdtWc1XupJyIEucAFMqm2j6efgxKyKsuXAOQUjyKIF86CuAkZuLy3uLa+RdD
         qKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gx0uXkDZfAezvx2UPITjgfJR6vkopVeUq+GbwzqBDgM=;
        b=5uJFKfnI3W5K2EWpN3NlMmsALpMcZ2HhejID5SjEniks+AQTXbyMknj/UmvvS5qZkH
         GBdB/gHuDeqv+dYDHJfTBpaupwS+89XljasiBSnrnmAtQN2xbLd2AFPCv8RDDWnu3euK
         4b6NdPG+QCP6o+++C9UldvnNzjEhmrNuCoqW78LOXTz3FKm5LBharwetqjt7tuMxj93T
         H9dPODpXoNvkseciZIZuJJRZ+MsIMDZr9fbLuGBw9Soqa77MV8akcVwpyUc4ybREaN0T
         Jy6KGmG0QtqwuDwWNkYVcLg9nB/rNMk+GhpXRD43wylmLKGc4cQtKPZcG2f3kpSInJbB
         p5ng==
X-Gm-Message-State: AOAM532RNrXs2GtRDpZ3wzUCByQl9r/EHTFlBkUBXPpHcoEXDCvZhj6L
        7iHQEnl8+Yuo49jOZndPiElai3He9sRadg==
X-Google-Smtp-Source: ABdhPJygaBhVFTZHWcRr9CPvNWh/1p+DMl8B8G3Xm0krV5okVkgk+eZJLPsQubzn6J4df0fo2pO3fg==
X-Received: by 2002:adf:e848:: with SMTP id d8mr30602169wrn.3.1638635714091;
        Sat, 04 Dec 2021 08:35:14 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0685b3447c22a42fc55e.dip0.t-ipconnect.de. [2003:c7:8f4e:685:b344:7c22:a42f:c55e])
        by smtp.gmail.com with ESMTPSA id h17sm5702674wrp.34.2021.12.04.08.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 08:35:13 -0800 (PST)
Date:   Sat, 4 Dec 2021 17:35:11 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 1/4] Docs: usb: update usb_bulk_msg receiving example
Message-ID: <0bd9336e18abad338b4967664a4667b96dae6be6.1638630342.git.philipp.g.hortmann@gmail.com>
References: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarification that this example is not in the driver template anymore.
Update code example so that it fits best to usb-skeleton.c
Update format of function names

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Added "Update format of function names" to patch description
          Corrected format of function names like the following example:
          "`usb_bulk_msg` function" to "usb_bulk_msg()"
---
 .../driver-api/usb/writing_usb_driver.rst     | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index b43e1ce49f0e..ed11398837e5 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -218,36 +218,36 @@ do very much processing at that time. Our implementation of
 ``skel_write_bulk_callback`` merely reports if the urb was completed
 successfully or not and then returns.
 
-The read function works a bit differently from the write function in
+This read function works a bit differently from the write function in
 that we do not use an urb to transfer data from the device to the
-driver. Instead we call the :c:func:`usb_bulk_msg` function, which can be used
+driver. Instead we call usb_bulk_msg(), which can be used
 to send or receive data from a device without having to create urbs and
-handle urb completion callback functions. We call the :c:func:`usb_bulk_msg`
-function, giving it a buffer into which to place any data received from
+handle urb completion callback functions. We call usb_bulk_msg(),
+giving it a buffer into which to place any data received from
 the device and a timeout value. If the timeout period expires without
 receiving any data from the device, the function will fail and return an
 error message. This can be shown with the following code::
 
     /* do an immediate bulk read to get data from the device */
-    retval = usb_bulk_msg (skel->dev,
-			   usb_rcvbulkpipe (skel->dev,
-			   skel->bulk_in_endpointAddr),
-			   skel->bulk_in_buffer,
-			   skel->bulk_in_size,
-			   &count, 5000);
+    rv = usb_bulk_msg(dev->udev,
+		      usb_rcvbulkpipe (dev->udev,
+		      dev->bulk_in_endpointAddr),
+		      dev->bulk_in_buffer,
+	              dev->bulk_in_size,
+		      &len, 5000);
     /* if the read was successful, copy the data to user space */
-    if (!retval) {
-	    if (copy_to_user (buffer, skel->bulk_in_buffer, count))
-		    retval = -EFAULT;
+    if (!rv) {
+	    if (copy_to_user (buffer, dev->bulk_in_buffer, len))
+		    rv = -EFAULT;
 	    else
-		    retval = count;
+		    rv = len;
     }
 
 
-The :c:func:`usb_bulk_msg` function can be very useful for doing single reads
+usb_bulk_msg() can be very useful for doing single reads
 or writes to a device; however, if you need to read or write constantly to
 a device, it is recommended to set up your own urbs and submit them to
-the USB subsystem.
+the USB subsystem. The template uses urbs for read and write.
 
 When the user program releases the file handle that it has been using to
 talk to the device, the release function in the driver is called. In
-- 
2.25.1

