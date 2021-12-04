Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743E8468641
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355358AbhLDQiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 11:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355368AbhLDQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:38:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5179C061751;
        Sat,  4 Dec 2021 08:35:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso7223421wms.3;
        Sat, 04 Dec 2021 08:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u3KULnMm+NurqHrJGvU91cGjIx8E0SlKbgyOAzOc/P8=;
        b=o/q4NKNPWU+/+Q7uJ2QnVJNjV/l1DQgTt3tS0zxSf9jLrpPUikVG3f0xrC80TVbALT
         7WuW6ZPUHvbU2fU714ZfFpFt5o/cJT0ASlF+blHSBVvDm5dkjumhV3OXLp/op7tQwMF8
         rMqscaP9Q3QzBybWBbzhMQ88OKqSnpFgldYJGqfm+2BhUvIDeJd3xpyE1FdXF1GEzkZ7
         8jhwoZsvV1ltqUpGonw8SwJbo3+zcFr87kpze3/QRGIAwALSg2cfUqHf2GalDkDBvWc8
         Ff4Oxn578jCy0eTD2Q1mAmfV6nVC3X/0lkZ3RGZ5dE4scOO53TFVQh8L+w1ivnLNLAXV
         AEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u3KULnMm+NurqHrJGvU91cGjIx8E0SlKbgyOAzOc/P8=;
        b=66Q3xxvXzeGr6yBHMpVBZSLLhRwyzQ8Ze1E5ncSOqaQ8889aHqB/mk6gM107rjgXMR
         L0yP9+INxbfeSlPajiXHxuk4F1hyxT28axZdY7ENUKQ85gPelHLMEs3zn3ZkuRcX1+AG
         MXQC6pLxzBS9A0VXgqnKkxAj1X5FUQVmk7RfauvKg9inQ4ekTZbyZPf/tuW0Ao+xCgUO
         LCgkX++1ro3walhXbkYOr23gqTl2D8kZOUkZuOCKwKIJF1oxtEWWvSSoeXKR8qO2og5A
         Jnqcr/3t8SPvR1A4vogep6cy0v1RkvBEjo2pMa4b0JT7auueJj1/rL5BfBgFgr9eFMrH
         LGkw==
X-Gm-Message-State: AOAM532fj31j587iQzSAu+Oh1qRSMyFZPKVVyHlTfT0aWQoW88mjW1fk
        9jtSWx84E86UkmSGPP97KhwvmI+k2WtqCw==
X-Google-Smtp-Source: ABdhPJx/F75BE2+08L0UH9gcthsmKQ303WAiJM2UNJLWXarJwnkDq+Y1nxiH1H9cxgtSSApIoqDVuw==
X-Received: by 2002:a05:600c:b43:: with SMTP id k3mr24354880wmr.159.1638635720232;
        Sat, 04 Dec 2021 08:35:20 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0685b3447c22a42fc55e.dip0.t-ipconnect.de. [2003:c7:8f4e:685:b344:7c22:a42f:c55e])
        by smtp.gmail.com with ESMTPSA id az4sm8680185wmb.20.2021.12.04.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 08:35:19 -0800 (PST)
Date:   Sat, 4 Dec 2021 17:35:18 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 2/4] Docs: usb: update comment and code near decrement our
 usage count for the device
Message-ID: <40aa115e18d1139a7642bf4034835cdfb9f5b066.1638630342.git.philipp.g.hortmann@gmail.com>
References: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put release function in the document typical form
Update comment: decrement our usage count ..
and code according to usb-skeleton.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Corrected format of function name to skel_release()
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index ed11398837e5..297b622f5438 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -250,12 +250,12 @@ a device, it is recommended to set up your own urbs and submit them to
 the USB subsystem. The template uses urbs for read and write.
 
 When the user program releases the file handle that it has been using to
-talk to the device, the release function in the driver is called. In
+talk to the device, skel_release() in the driver is called. In
 this function we decrement our private usage count and wait for possible
 pending writes::
 
-    /* decrement our usage count for the device */
-    --skel->open_count;
+    /* decrement the count on our device */
+    kref_put(&dev->kref, skel_delete);
 
 
 One of the more difficult problems that USB drivers must be able to
-- 
2.25.1

