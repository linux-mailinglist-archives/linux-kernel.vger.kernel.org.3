Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6E46A8FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349983AbhLFVB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350115AbhLFVBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:01:47 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B411C061D60;
        Mon,  6 Dec 2021 12:58:18 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i5so25092035wrb.2;
        Mon, 06 Dec 2021 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DK4hAvvrL0g/m+zIiQELRMmxA9g3fGN68aSymQFpmw4=;
        b=ns+q3Q5a/YFhnnV6OVF+Mt3rUmr9uxUqqFynmSsthxdw9baWp1zLvrtmq2p5CHftOV
         M+7f1l6wrmMQyHblMftzJnSeGXh++0iiymEaqZ9TkqnGyxzpdhZGU7rEj1Zyp5H2FLDc
         grQd1lN/zGijD2p+r8brP/JZaAB49ZhBkfWIiB+KcQphK2LpzrY9G8XFFQHD8tZqwXY+
         hycl6tWZMSPLYXpqGHZWA0AJtaIShzSKUmQg917UdzCOe1aMKmUAxc2dhWvVthKSDIkK
         5em8JyL+2RhW7hQHDVGp1JPG6WVvTXoOM1YqCEvD9GOtMQjEAreFdRs8vAWksKSoQcqu
         Cmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DK4hAvvrL0g/m+zIiQELRMmxA9g3fGN68aSymQFpmw4=;
        b=KvDoR4ODh5Frgnx0+h0+6JSO1xNYp/1qz9U2HzZALkgJ48eGgS4KrBNoUwMFR8oPSF
         UoK+/MRRwmwMiO2gyl5nW/mxyrWlvLoD8xxpgaLRpqYczjJ0+l3XWULGc7PDlybfApky
         EFFElAojwFBSDSr/wmOk+4H93qAozaoQ0JOue/MENVaHnO3zvKiUCuVyyYJtJPfR3ZAC
         Hwg/eGQWGLy+ZDNj66JJnVbx71Rm6IckenHDmgmNMsSgO9ss5q106lA4cSkj4rxFuS5U
         K8crGVjE3GSB8cRXD5lZjseR4uxbJboSyzXAu3OFH1qfvW34d9odeRwJs/Jn5Ovw+7Ub
         5GcQ==
X-Gm-Message-State: AOAM533zOXXq8WepcHatAaaFOGpCVZyWfomh9/PFQ9a1JI8Y9h2T7h1y
        G+wvgpfRUOxQ+we5AbtVofE=
X-Google-Smtp-Source: ABdhPJwnO0TTqOoGSYCkB3lOmDvLnLodImOh+yQ3A1lfhP6Q0C/PqnUKVp5NE/Atd4UObejQZ5WWlA==
X-Received: by 2002:adf:e747:: with SMTP id c7mr46458155wrn.38.1638824297093;
        Mon, 06 Dec 2021 12:58:17 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06972f325cc5fe1c0146.dip0.t-ipconnect.de. [2003:c7:8f4e:697:2f32:5cc5:fe1c:146])
        by smtp.gmail.com with ESMTPSA id az15sm454600wmb.0.2021.12.06.12.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:58:16 -0800 (PST)
Date:   Mon, 6 Dec 2021 21:58:14 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v3 5/5] Docs: usb: correct format of function names in the
 explanations
Message-ID: <6ef296c812baabd973e5ae7b661b1620d5fd45be.1638771720.git.philipp.g.hortmann@gmail.com>
References: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct format of function names like the following example:
      "`usb_bulk_msg` function" to "usb_bulk_msg()"

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../driver-api/usb/writing_usb_driver.rst     | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 1968cf5c55f6..9f4181cafc41 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -220,10 +220,10 @@ successfully or not and then returns.
 
 This read function works a bit differently from the write function in
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
@@ -244,13 +244,13 @@ error message. This can be shown with the following code::
     }
 
 
-The :c:func:`usb_bulk_msg` function can be very useful for doing single reads
+usb_bulk_msg() can be very useful for doing single reads
 or writes to a device; however, if you need to read or write constantly to
 a device, it is recommended to set up your own urbs and submit them to
 the USB subsystem. The template uses urbs for read and write.
 
 When the user program releases the file handle that it has been using to
-talk to the device, the release function in the driver is called. In
+talk to the device, skel_release() in the driver is called. In
 this function we decrement our private usage count and wait for possible
 pending writes::
 
@@ -262,9 +262,8 @@ One of the more difficult problems that USB drivers must be able to
 handle smoothly is the fact that the USB device may be removed from the
 system at any point in time, even if a program is currently talking to
 it. It needs to be able to shut down any current reads and writes and
-notify the user-space programs that the device is no longer there. The
-following code (function ``skel_delete``) is an example of how to do
-this::
+notify the user-space programs that the device is no longer there.
+skel_delete() is an example of how to do this::
 
     static void skel_delete(struct kref *kref)
     {
@@ -283,8 +282,8 @@ is initialized and set to false. For every read, write and other
 functions that expect a device to be present, the driver first checks
 this flag to see if the device is still present. If not, a ``-ENODEV``
 error is returned to the user-space program. When the device is
-disconnected, the ``skel_disconnect`` function is called. It sets
-``disconnected`` to true and cleans up.
+disconnected, skel_disconnect() is called. It sets ``disconnected``
+to true and cleans up.
 
 Isochronous Data
 ================
-- 
2.25.1

