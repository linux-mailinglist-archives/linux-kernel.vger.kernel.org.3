Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E5F4626BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbhK2W4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbhK2W4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:56:12 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606B4C09CE47;
        Mon, 29 Nov 2021 12:21:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so13254817wmb.0;
        Mon, 29 Nov 2021 12:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fb86c64AAxfgKMIhtfj1EvABb44FROtjYen1/0oh/7E=;
        b=gDbo1dVJn1Pl7Vg552yy2coDXPNYenyEMsjHS0rQawHS1B2l3k0mtDIglMGgRwlA4/
         H+k6yywj73T4bG0x7Nr/n0U4IhX6k48/oKy/T8t5l8kHU3F/UML3PS2Igq0W+NCy/SPR
         bwJ69n/C0Gc71wzQGgFSmHdFPPPzovkHX2cGzz/jGHrNZiN3mLOevE5ledsmAVgYkHCi
         tJjdZ12XvDZjsk5QSru3kuiu+rNW6wJin4zHg+botRjOZCCX8Rq2c/eAmEafJCdW+ntt
         BuTpSp49vW/lVlplrmHnXpoHROICJ7SBjiR09M6sYFu7fZEOQn+HvhuvsWG5IDPib1gp
         bYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fb86c64AAxfgKMIhtfj1EvABb44FROtjYen1/0oh/7E=;
        b=THLr6ZZzytkHtiOXzD/HuxA8wfGjwGYeXL+C7E5JAVFis9SsiWu+IQv9MNN34GpJmL
         L62bcppsefSFiW9mCnRi2qUMgMN1jhHNPPS7r8vwRaexRo0fY8coAcDyVBlIAsc43F1n
         3rS6hHvDSa3kvkAVHgcunEkxibDT8KWIxM510HYxvLoNun6DQL4miQzrhrCgEoRx8eFb
         0v6p9AWR+8Hx6xYiStXTMstx7Wscoa0m2yoeihnOIlmyu+p3BOtUJM4ny/Sp/cCmn/SV
         5pz16hcO7dqERHrg5s8bb51rDu5rOsifbhS7VULdxKUsAE8wKCYzs/tQihyR5N46Pzc/
         snaw==
X-Gm-Message-State: AOAM530z3m8KF/FkEVrqVKriQOLt0PLbw+pZbtonUwYiKGuwh1Azjs7U
        9Ya6nvWnx4Wmsah+bxSNMkFoCZ+WcdcOfg==
X-Google-Smtp-Source: ABdhPJyFDhJ0eC4nxYqZ0esW8KwbVh+54Ab+svmQe19/xmGfPC0ceJBssaQACJCxGZiy8zCfgr0Ymw==
X-Received: by 2002:a7b:c94e:: with SMTP id i14mr249770wml.85.1638217309076;
        Mon, 29 Nov 2021 12:21:49 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p200300c78f4e06460b103a790e4c64a8.dip0.t-ipconnect.de. [2003:c7:8f4e:646:b10:3a79:e4c:64a8])
        by smtp.gmail.com with ESMTPSA id h2sm14315553wrz.23.2021.11.29.12.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 12:21:48 -0800 (PST)
Date:   Mon, 29 Nov 2021 21:21:47 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH 2/4] Docs: usb: update comment and code near decrement our
 usage count for the device
Message-ID: <75317b591c0da0d32be77b819680733a44f6f70b.1638152984.git.philipp.g.hortmann@gmail.com>
References: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put release function in the document typical form
Update comment: decrement our usage count ..
and code according to usb-skeleton.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index a9608ad18d77..b16e4e76d472 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -250,12 +250,12 @@ a device, it is recommended to set up your own urbs and submit them to
 the USB subsystem. The template uses urbs for read and write.
 
 When the user program releases the file handle that it has been using to
-talk to the device, the release function in the driver is called. In
+talk to the device, the `skel_release` function in the driver is called. In
 this function we decrement our private usage count and wait for possible
 pending writes::
 
-    /* decrement our usage count for the device */
-    --skel->open_count;
+    /* decrement the count on our device */
+    kref_put(&dev->kref, skel_delete);
 
 
 One of the more difficult problems that USB drivers must be able to
-- 
2.25.1

