Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A0546A8F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350032AbhLFVBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350030AbhLFVBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:01:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3905C061359;
        Mon,  6 Dec 2021 12:58:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 133so9204014wme.0;
        Mon, 06 Dec 2021 12:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E2HX35lv9bDKnO4lFBuFX4Xmi03jMOcJniXoHiK6jHU=;
        b=ObjPGxXgS47W+YxYmtgbzwuUFSn4MvSUvTt4Xrt+pM+JmRdW1YWOgPT3/FOqxWUVu9
         Kxmot+F0OK6WerWjqgeAG0SCkegY6q6+m0HHWNT+pntDuX/kY5KdVmAaSMNxTqfSLULx
         HhUt8fDGT+qNAJQuaYem55yhQnEEC+8TcK7hbaYonoNJKiw6bGs5TO94APQ4OcckKyql
         TKOG93OWHjKeIzvERDdyG1oUgUc7Sqg9m10qP7SagfjGvuVJoer2Q0emhDWOK1KvjyFz
         AQsHAZTz/a59H424e6UdVJwcIXG11WWpWRWWkw0BeGXO+2rj58UsT4SqCMOKwsbPVBNy
         Fpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E2HX35lv9bDKnO4lFBuFX4Xmi03jMOcJniXoHiK6jHU=;
        b=vvoucsmdhDYVMIe9lwDwFD8MgpG5pBt+B+8+E/oqNTF83eSDvxRe3iPT0MC10+ir9n
         jg5lFsZ26AiW2uBaSo9uegfqdmxBcaOcBwclK/pMBi4Lt4IRRW1cbZhPJa/md3bifY7D
         YbupcDLyXsEzryuzLalZc08834gF8nw0IFQN2m8fJtMFchaD1XEXIgTF85HbYeJ5dHN/
         XpSvnimcf2DMgpYV1V3l/2/pVKutN0/ML1stpf7X4ECkRGT25e7N55CnxVlkub+iG0ps
         2sWDwVVE+l0JlKV2p9lcvTkPKdRcAeRivVnjTig8HJkJZzrsa/DVZFBUItWs+u/0AdwM
         PFCw==
X-Gm-Message-State: AOAM531vsrofXwD3e1Qr8QjvO+uoyL6jjFWSNCmbxKxODj3B7xk9nP14
        Vl9vp0wWE/ZhtK9G8t1dsUo=
X-Google-Smtp-Source: ABdhPJxtK0kucM1mh5Rovcj6r5jVVtCJ9DnMzIl3ZDlqesq9IJuz6HyW+Y+QbuwpE44oC5Yf7Q30yg==
X-Received: by 2002:a1c:1903:: with SMTP id 3mr1205934wmz.89.1638824290575;
        Mon, 06 Dec 2021 12:58:10 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06972f325cc5fe1c0146.dip0.t-ipconnect.de. [2003:c7:8f4e:697:2f32:5cc5:fe1c:146])
        by smtp.gmail.com with ESMTPSA id l11sm11806981wrp.61.2021.12.06.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:58:10 -0800 (PST)
Date:   Mon, 6 Dec 2021 21:58:08 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH v3 4/5] Docs: usb: update explanation for device_present to
 disconnected
Message-ID: <d81cd79c560877e1d2dbf3267f23a8f436b04417.1638771720.git.philipp.g.hortmann@gmail.com>
References: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638771720.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update text for `device_present` flag to `disconnected` flag

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Corrected format of function name to skel_disconnect()
V2 -> V3: Moved correction of the function name to an own patch in this
          patch series
---
 .../driver-api/usb/writing_usb_driver.rst          | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 6c487ac5eab2..1968cf5c55f6 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -278,15 +278,13 @@ this::
     }
 
 
-If a program currently has an open handle to the device, we reset the
-flag ``device_present``. For every read, write, release and other
+If the driver probed the device successfully, the flag ``disconnected``
+is initialized and set to false. For every read, write and other
 functions that expect a device to be present, the driver first checks
-this flag to see if the device is still present. If not, it releases
-that the device has disappeared, and a ``-ENODEV`` error is returned to the
-user-space program. When the release function is eventually called, it
-determines if there is no device and if not, it does the cleanup that
-the ``skel_disconnect`` function normally does if there are no open files
-on the device (see Listing 5).
+this flag to see if the device is still present. If not, a ``-ENODEV``
+error is returned to the user-space program. When the device is
+disconnected, the ``skel_disconnect`` function is called. It sets
+``disconnected`` to true and cleans up.
 
 Isochronous Data
 ================
-- 
2.25.1

