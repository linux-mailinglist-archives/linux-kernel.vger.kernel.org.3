Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F9946A8FF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350088AbhLFVBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350024AbhLFVBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:01:36 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE21C061359;
        Mon,  6 Dec 2021 12:58:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 133so9203877wme.0;
        Mon, 06 Dec 2021 12:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/6TXMCjmZMjMTXVDAGqRENQL5FuXlJEx6FcJui0lUVI=;
        b=nrax9v2Tf28pHs4A+QcLepaXnYTnUIjOzRA8KmSXbjCYQRRqNDDugbbzeKKfT6vh2h
         oPoW8D1XnxZi0c+CHt8KWiNCwanM126NPz/pDLkhAo9oEnSjueDAoIWQuhZxZaR1cnw/
         gQeNuQUL/M9BK47V6oCDQtFbGZKbcaawdx5O+W1jCNXHKVsGDgjQHdUc92JyHgMBlOUS
         DuSbN0KA9gdqM71iVVXC6hAzLcf1GUOwLXiEs4bhzFQGuyiWEBwstn7haPy70rHT9tGu
         3mQfJrh3BJbDPbQSymzv8A/8TDBMhvyOPGIg2khpEvSSf12tHpxcuq82RPmR5bLAVbPw
         i/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/6TXMCjmZMjMTXVDAGqRENQL5FuXlJEx6FcJui0lUVI=;
        b=B8uo3QmiZ4AABEUx+SWQTuLsRqso4VHSDK2GjG5e6ka3rKc+1gHE7y/I3nZXwtkiBL
         UFmcH32B/VRn/opB2lJTBIHf0iW0/LDelg+eKvkJieq6fhq6Gppa6G2ycCdl9L7BrlZS
         1TgGb0Ck2LpbG0+8yngZsvo+Z0u56Ydp5HO4wHHD3M7R4cdlWnp93r/AMoRm+tnOZGO1
         vLeSXF1WmbuO5H3Foy/bI1tIHwQRUuqx+x7Ve+JyD1id8pLZQFHk5EXsk3TM/Rl3TQtN
         BZVqvMjF/20OUaY+Ubope+Mq1kGZRf3i2QxAXKdUjsFGEtYIejT3SLHccaJRg34+k7sb
         oF/A==
X-Gm-Message-State: AOAM531ksQFSo614ga7WW9cObIwnhDKcyxbedjdvZFd0uRXgvkqXNpLy
        A23Ndwbg9kfrA3/JkmL0WYk=
X-Google-Smtp-Source: ABdhPJyaB0FMJEEgxGGhPArvXaTPcwiHc1ly+78X900aejXIq13cB1WjtUvs2NxK1zXwF2xw1z4IzQ==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr816726wma.162.1638824285171;
        Mon, 06 Dec 2021 12:58:05 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06972f325cc5fe1c0146.dip0.t-ipconnect.de. [2003:c7:8f4e:697:2f32:5cc5:fe1c:146])
        by smtp.gmail.com with ESMTPSA id u15sm490981wmq.13.2021.12.06.12.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:58:04 -0800 (PST)
Date:   Mon, 6 Dec 2021 21:58:03 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v3 3/5] Docs: usb: update comment and code of function
 skel_delete
Message-ID: <f1a52071a29fbd6fa983392e7864eb5819ffc258.1638771720.git.philipp.g.hortmann@gmail.com>
References: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update code according to usb-skeleton.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Corrected format of function name to skel_delete()
V2 -> V3: Moved correction of the function name to an own patch in this
          patch series
---
 .../driver-api/usb/writing_usb_driver.rst        | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index c336dfd82426..6c487ac5eab2 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -266,15 +266,15 @@ notify the user-space programs that the device is no longer there. The
 following code (function ``skel_delete``) is an example of how to do
 this::
 
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

