Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158DA46A8E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349976AbhLFVB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349957AbhLFVBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:01:25 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C8C061746;
        Mon,  6 Dec 2021 12:57:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i12so9140972wmq.4;
        Mon, 06 Dec 2021 12:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HP8SKA09sXO9NSVfX3UQ4Y1Z+0wRgCYWOwD6pVkBing=;
        b=IxnIWTVAz+ekMsTnsuiEWfIaiRpsnREU+/L7Fgk+Vkc/dCjlnasjva2vyrvOaibCOV
         mkrFI1T4vTvagMtvMVNUJWNPHUs21sKKUDZWxZ2NcPTVpw3v8UgdPCvGRpil4hkcTWPC
         C8gqC5fyzcKPhpvMwfbTnhFAmHN01mnCaTlyH72uhvvRnV764Rad4BERhwkh3s4KSjaN
         QibnSXICZU+3hgOoK/XlQM8nmJ3OlAH1fsq1OqPSVCQ3AFBBC4mqHY7sEHriZYJudkkL
         RUrb09SYnkHaBbelTrc5DaUmWuwji80J10ZdXvxh8zySrnFgIBiV/prulaHN4U1eoGyu
         ODuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HP8SKA09sXO9NSVfX3UQ4Y1Z+0wRgCYWOwD6pVkBing=;
        b=UvnUEcFdCnE/nTi8qnnHqbdxlxXHHiOVnObMUWS4R1qK81N+L4NLOtLk4maOHcuJFx
         QRe8JmQptNpZxZjoDSqsi2PsE8wi0WawmPrsv5u4li6Mh416mPtg8AgpRJuw5j6V+vEc
         iwE1U5M3ke7WNT0hHLJkbUakWJMyrpm6og7GnfVdcejtu3L6xezJtCOh328nKbGOs8xo
         Al4jARKu/0f2aWU92qBiYVwa7KFwK4UQlMcQTv52wP89w18WfFKga3z/0mPn1CJ04d04
         fOqsajJsBCIaIIGKee9IoOCBaJEKjiAKoEbOptuTKg0O2wIchLRuv+Mq5thFyKHPpEt5
         PO/w==
X-Gm-Message-State: AOAM533ZCO65s42ITBE5sjRiop2BLePYDCcavO88gl6FmjjZ1ngsDMPB
        MwkxdxQwRmB+45siGUyVKEA=
X-Google-Smtp-Source: ABdhPJzQ/eqF4ADe1MjYVK9V8uA61GeT0FHVneXcmHMfXu9Ta31/XXek4zy85vMhDf/9La3Mxzzn5g==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr1274003wmi.2.1638824274448;
        Mon, 06 Dec 2021 12:57:54 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06972f325cc5fe1c0146.dip0.t-ipconnect.de. [2003:c7:8f4e:697:2f32:5cc5:fe1c:146])
        by smtp.gmail.com with ESMTPSA id l26sm500587wms.15.2021.12.06.12.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:57:54 -0800 (PST)
Date:   Mon, 6 Dec 2021 21:57:52 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v3 1/5] Docs: usb: update usb_bulk_msg receiving example
Message-ID: <3b794ef1936eb410b60cb536e47a0a00e36611d4.1638771720.git.philipp.g.hortmann@gmail.com>
References: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarification that this example is not in the driver template anymore.
Update code example so that it fits best to usb-skeleton.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Added "Update format of function names" to patch description
          Corrected format of function names like the following example:
          "`usb_bulk_msg` function" to "usb_bulk_msg()"
V2 -> V3: Moved corrections of the function name to an own patch in this
          patch series
          Took back change of variable from retval to rv
---
 .../driver-api/usb/writing_usb_driver.rst     | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index b43e1ce49f0e..1fd7bf1dbdb0 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -218,7 +218,7 @@ do very much processing at that time. Our implementation of
 ``skel_write_bulk_callback`` merely reports if the urb was completed
 successfully or not and then returns.
 
-The read function works a bit differently from the write function in
+This read function works a bit differently from the write function in
 that we do not use an urb to transfer data from the device to the
 driver. Instead we call the :c:func:`usb_bulk_msg` function, which can be used
 to send or receive data from a device without having to create urbs and
@@ -229,25 +229,25 @@ receiving any data from the device, the function will fail and return an
 error message. This can be shown with the following code::
 
     /* do an immediate bulk read to get data from the device */
-    retval = usb_bulk_msg (skel->dev,
-			   usb_rcvbulkpipe (skel->dev,
-			   skel->bulk_in_endpointAddr),
-			   skel->bulk_in_buffer,
-			   skel->bulk_in_size,
-			   &count, 5000);
+    retval = usb_bulk_msg(dev->udev,
+			 usb_rcvbulkpipe (dev->udev,
+			 dev->bulk_in_endpointAddr),
+			 dev->bulk_in_buffer,
+			 dev->bulk_in_size,
+			 &len, 5000);
     /* if the read was successful, copy the data to user space */
     if (!retval) {
-	    if (copy_to_user (buffer, skel->bulk_in_buffer, count))
+	    if (copy_to_user (buffer, dev->bulk_in_buffer, len))
 		    retval = -EFAULT;
 	    else
-		    retval = count;
+		    retval = len;
     }
 
 
 The :c:func:`usb_bulk_msg` function can be very useful for doing single reads
 or writes to a device; however, if you need to read or write constantly to
 a device, it is recommended to set up your own urbs and submit them to
-the USB subsystem.
+the USB subsystem. The template uses urbs for read and write.
 
 When the user program releases the file handle that it has been using to
 talk to the device, the release function in the driver is called. In
-- 
2.25.1

