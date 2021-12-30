Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4AB481E94
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 18:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbhL3RUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 12:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbhL3RUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:20:05 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39581C061574;
        Thu, 30 Dec 2021 09:20:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v7so51567643wrv.12;
        Thu, 30 Dec 2021 09:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=n/qQDXJk2QbH2NGsjvFVJ3ub2PnKBdYzofoYgc2mPZM=;
        b=XrPlU1tx5TWNnHIjx83NHVcOfK6mlpBbpa6/8BUJlN94o4v8Y0mSY0zGWEf/hGvZ9L
         DtR0hvQ63iuj7i0ayJrqmb+dj1HaPslKmm795bNWjD7ajEfs4yLRZSdKoGr/Lklc+wA/
         hKQOvcEIw8ryMt+CytyyTcPTsXoMeJW8QbdN6zhq7XW7v2/eLicw3a+RobJCX4ayad90
         dctaa8htJdCK+U74RtDAlXV29k531+mjLHI88wdd09vc4jWFU3rUZC+EyJKOqBiyDl4g
         /ksAJG5UnfZGR2ybxW+YzobTlY1thsuJX02rNtDadTQcQZDm2asOTq+Ao1fXlvgFCc3L
         F6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n/qQDXJk2QbH2NGsjvFVJ3ub2PnKBdYzofoYgc2mPZM=;
        b=dCgEpLazT4ol3l6cQZCtnFYSTsBOO+QY7cyF/GzK2si21CuJQRxQmxU90Yn7kVXazT
         saOHmF2rNeXCEbGBGvDd1tB+Yz55cVB5AlEr6HQkU1lBBFnEGVarESra91jz/Wz0+13s
         5b+bxa9D5WEsIR7G7bJiuPr/l7PaXtuzccYR0+DzHcJvpX5tzasBRH46HF66JnKOGPvP
         Af8Rol6ulUDAH8HkwQsoSW2ljEmHGZKU5RURnmO7Fdw5tZwYJfpvTqjpRyJek+97eHb7
         MJCZXkI2i5gVk/l3th8EMPl75/yr4DSA288haITeZi0Z6jM6oOUESoBb6v0cV8fgacz9
         5vnA==
X-Gm-Message-State: AOAM53377+JEqXV48R/DdLGPy6HW39JHpBKCgdh4QZhvqWQ9CQvhfeVp
        t2+0flV4BbGplwpYW5SzRDAVwlnMtWQ=
X-Google-Smtp-Source: ABdhPJz7pk+TZP3KIA3Wu6oebLD35Y7oBH4hmjvWmB6lCBLzTaBGLJqkAUgaOh9+sgYOQjuXLiFIXg==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr26833990wrq.603.1640884803135;
        Thu, 30 Dec 2021 09:20:03 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2657:9600:789b:54e9:fc28:95aa])
        by smtp.gmail.com with ESMTPSA id z5sm23709975wru.87.2021.12.30.09.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 09:20:02 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Andi Kleen <ak@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] Documentation: refer to config RANDOMIZE_BASE for kernel address-space randomization
Date:   Thu, 30 Dec 2021 18:19:40 +0100
Message-Id: <20211230171940.27558-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config RANDOMIZE_SLAB does not exist, the authors probably intended to
refer to the config RANDOMIZE_BASE, which provides kernel address-space
randomization. They probably just confused SLAB with BASE (these two
four-letter words coincidentally share three common letters), as they also
point out the config SLAB_FREELIST_RANDOM as further randomization within
the same sentence.

Fix the reference of the config for kernel address-space randomization to
the config that provides that.

Fixes: 6e88559470f5 ("Documentation: Add section about CPU vulnerabilities for Spectre")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/admin-guide/hw-vuln/spectre.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index ab7d402c1677..a2b22d5640ec 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -468,7 +468,7 @@ Spectre variant 2
    before invoking any firmware code to prevent Spectre variant 2 exploits
    using the firmware.
 
-   Using kernel address space randomization (CONFIG_RANDOMIZE_SLAB=y
+   Using kernel address space randomization (CONFIG_RANDOMIZE_BASE=y
    and CONFIG_SLAB_FREELIST_RANDOM=y in the kernel configuration) makes
    attacks on the kernel generally more difficult.
 
-- 
2.17.1

