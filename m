Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8377E468649
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 17:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355427AbhLDQjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 11:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355531AbhLDQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 11:39:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB5DC061A83;
        Sat,  4 Dec 2021 08:35:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l16so12585749wrp.11;
        Sat, 04 Dec 2021 08:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DlUMJFNyNRj/XgYSHRvRQioo+7kkX6yRCyniuTQc4VM=;
        b=jZr2sPuj+uvl+MV3O56PzBkPpoH5fkRGRfzTs5PbxVeFuwsCDTP5cdKWhYWLZ9SIRX
         C39FECrQIlSwB8QcvVH45d2QrNw2bE4bjAmlLSBetZHiDsR7Df2nHk3q6WHG12ZsgRaB
         Q9LB7jnKcJae5Ov0Ysjn22hYTZqel2pjQZ/hH/dU0GHS1NHC6ddF0jvvGKJv0p3e2w6G
         Wrn+iyuGEYUTvrt4g1VgsY1L2nk6jqMW+WO30+t4P+qBmPQeRf4tUT0UCwnNh2b3+qgT
         TA+FQ6CEgTEK9yeo7iGl4UljZfcCT46PlR4PE3mS89/RopdFTttHb/9g9SGJlasEKcRI
         cNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DlUMJFNyNRj/XgYSHRvRQioo+7kkX6yRCyniuTQc4VM=;
        b=Lai526kqlWvUFpzVXGgEeepYuHNBSDz/9m9qp1Vk9CqCLs0kFfMEuLOOGJ4Un20Hlw
         ysC+hZ9vggZ9HXNV+oj0SG55YHcRPewTPlp0rsDpycSTd3M76pGhjac5P/XRitbXvJJO
         XKy1IGUSFhS32cmwD+yTXZQmEZkpvDsKN5tKniQNRVsmkkEcPOhfD3Oj9W8viaGOqs06
         0d55D4DjVimhywAsEUfvOsruZzA1wRDVL7XzKWFkW1csfWKwo+9d/enQMhRHC/TqVQDZ
         kwXFjuznciAxxMmikrIb7f49Yq9xEGGBUd14eF08ShT1OkvMSIH7cXs+28Bjq9aVI9GW
         3YSg==
X-Gm-Message-State: AOAM530RZKfnUGESAr0zWI0hYOOfppJLXMLjyBZvE+mjTfat34PqUuXW
        oHRh03un26z/4RC7v1wG5gRvM7Bs+FJqCQ==
X-Google-Smtp-Source: ABdhPJxLD784pITzSQYTE5Vbf4jwLGCG0AGUN3aGvj8DMKQz18NvHFEeh+AhUFEF/LNxrcrpnXcJpw==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr31016436wrt.22.1638635734714;
        Sat, 04 Dec 2021 08:35:34 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e0685b3447c22a42fc55e.dip0.t-ipconnect.de. [2003:c7:8f4e:685:b344:7c22:a42f:c55e])
        by smtp.gmail.com with ESMTPSA id j17sm7229172wmq.41.2021.12.04.08.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 08:35:33 -0800 (PST)
Date:   Sat, 4 Dec 2021 17:35:32 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 4/4] Docs: usb: update explanation for device_present to
 disconnected
Message-ID: <41cc6dbe6a97b7e5bff08a81a6e2fec3561cda76.1638630342.git.philipp.g.hortmann@gmail.com>
References: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638630342.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update text for `device_present` flag to `disconnected` flag

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Corrected format of function name to skel_disconnect()
---
 .../driver-api/usb/writing_usb_driver.rst          | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index b459f9e089e0..fa795b8d7eac 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -277,15 +277,13 @@ skel_delete() is an example of how to do this::
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
+disconnected, skel_disconnect() is called. It sets ``disconnected``
+to true and cleans up.
 
 Isochronous Data
 ================
-- 
2.25.1

