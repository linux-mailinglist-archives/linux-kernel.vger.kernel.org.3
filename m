Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EC0462690
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhK2WyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhK2WxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:53:23 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6F2C08EB4F;
        Mon, 29 Nov 2021 12:21:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a18so39489642wrn.6;
        Mon, 29 Nov 2021 12:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7gIeiPld9zLHugWa33z4cxIeDKg8lMMvyR8V+fYZSRU=;
        b=ozJ62MEtuU7hwSGRIjRdTImmV1wsksWSMmpW3R/9xrm6/FC6Bpo111l5Ez2bOWFEEO
         e2nJKH1iibcsLCU3PCBUhDy0sUjWKiqFfJ0T/wJUwvxZxlaxVmesQYxlPtVSBwtLFDKj
         t8Z4Z/uOg32QSLQMBBIsS/4hU8QUDuzsg5nwSWIpqnYVttWyyCO9aMxlSySLDbQ8FT5P
         mSOcY9b0fgJ+ldtXyCXE3f+t9JhUg8MOmw73zasTNhpvBZO0Efq+U6D82wxPCyGGFfb7
         /4P2UcvFy9a9H56d9220BzmxKNI/iybT2lYf82KlPsCRrdGcSce0GDsVWts/2RkJBeFx
         tuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gIeiPld9zLHugWa33z4cxIeDKg8lMMvyR8V+fYZSRU=;
        b=TEEddtjqMv0EZTU5Bd1GeaVOB19tEQ869hod3XHdHxnFqxuYyTFowSmEuc70wXluUF
         yg7OTDhgjKf2+oRTTlOTDslMFIdf7BXeqUdODKrZ2R7HO/nadRTiO3KH7SRBeDcAIHFY
         5SNVod/SBs6uVoDtWjos22Vo65nL54QRLRTu9aA/w10ZWLx3iaDHMfoqksUM3/i3w9UU
         8U/ZZL5ChTXzF86YqKW+7s7UrTFA6BueGC+Gbq6Scr1lZnAQYBoW2e/EHY9f6yrFYUUl
         pBcSvVmqH15W/JDISQOTFafxdzby2KX7mWSFWTcyYqsAzJGFvMcPt5ZGYdC9uAurFaIE
         bWQg==
X-Gm-Message-State: AOAM533piJfhwS9LKkv7Ibp6yvOAc39COYKzk4rgV0+K04p6C8QS3tMV
        dyUk4CwkyqFFTdr/a4FAtn7acVeAcZU6DA==
X-Google-Smtp-Source: ABdhPJwh67JHoWu8iWxdVopal7Q/Ny+oJcSNa8bO1ENTqBaL04B8qRvm7XXWsNg7uTaDZLsPDfL7Sg==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr35723785wrt.88.1638217303906;
        Mon, 29 Nov 2021 12:21:43 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06460b103a790e4c64a8.dip0.t-ipconnect.de. [2003:c7:8f4e:646:b10:3a79:e4c:64a8])
        by smtp.gmail.com with ESMTPSA id 9sm18599651wry.0.2021.11.29.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:21:43 -0800 (PST)
Date:   Mon, 29 Nov 2021 21:21:41 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 1/4] Docs: usb: update usb_bulk_msg receiving example
Message-ID: <28a76eedad7027277754cef84ca34810b0cfe6f4.1638152984.git.philipp.g.hortmann@gmail.com>
References: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarification that this example is not in the driver template anymore.
Update code example so that it fits best to usb-skeleton.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../driver-api/usb/writing_usb_driver.rst     | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index b43e1ce49f0e..a9608ad18d77 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -218,36 +218,36 @@ do very much processing at that time. Our implementation of
 ``skel_write_bulk_callback`` merely reports if the urb was completed
 successfully or not and then returns.
 
-The read function works a bit differently from the write function in
+This read function works a bit differently from the write function in
 that we do not use an urb to transfer data from the device to the
-driver. Instead we call the :c:func:`usb_bulk_msg` function, which can be used
+driver. Instead we call `usb_bulk_msg` function, which can be used
 to send or receive data from a device without having to create urbs and
-handle urb completion callback functions. We call the :c:func:`usb_bulk_msg`
+handle urb completion callback functions. We call `usb_bulk_msg`
 function, giving it a buffer into which to place any data received from
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
+Function `usb_bulk_msg` can be very useful for doing single reads
 or writes to a device; however, if you need to read or write constantly to
 a device, it is recommended to set up your own urbs and submit them to
-the USB subsystem.
+the USB subsystem. The template uses urbs for read and write.
 
 When the user program releases the file handle that it has been using to
 talk to the device, the release function in the driver is called. In
-- 
2.25.1

