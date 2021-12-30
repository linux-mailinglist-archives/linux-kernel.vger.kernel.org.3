Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E417C481E99
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 18:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbhL3RYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 12:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241440AbhL3RYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:24:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E47C061574;
        Thu, 30 Dec 2021 09:24:39 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so7941320wme.2;
        Thu, 30 Dec 2021 09:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=6vTt0sPTxRfRnwBDC4e+K/XdNIJukWXPcDujgrHoT4o=;
        b=eJDrVz1NU+ONBzKG4ThrQEtMofLMh5ZhLIay3cQ7wx+ox56pzk0/XLMFosO8hlT45A
         etxIuzwRZRiId08xrIb0g/0w60BkBjfQH/9HkEHX+8pC2rAr6pIoOvLDqttuL//8ivpn
         D/XYvWNbru27I+iMpKpTlfNpls7zQKzLQ4eU5iNnhrZQFQ4t69jh9Hu8eL9o7VOw7yKK
         C7vU4p7Lt5pCd++qOp7XNGTp8wIrF9uQLkaJc2xc0Fdoy6yv0vCfDp4UulRMfNj02P+I
         iq6nI2HbBTeIofBGNt5MBVbkqZeNCsonfdDT3czbVImvKVYTCH5M5r1oYZsxAJADX+zP
         2Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6vTt0sPTxRfRnwBDC4e+K/XdNIJukWXPcDujgrHoT4o=;
        b=QkSVisbNcHH39+VhECasJnocIn5kS7e1elyBCKdbfSz/ahAjoIanUznW+HaN03K7a3
         Xvrjmm3zRheznQEFqqFGX3PKTjpI1IGFCHWTmtyxVmVkSRnJx0Qyyh+xUiLezInFJy5U
         D82Fanu3shj5339AgL+D39GNDPtmxcEdYbRMGCImv5Pf3ZTfvqNYGtQqxfvMOERKI/MU
         tRF96iYGgnu6Bq+F+CMnv2ybVqZ2vWbZza3xMGBnmZI2nTf8jos5KAstKO2LZtDJXWOO
         YC2armFtn6zYTBhVDHyTIOxzrL129IfXkcargyGvO3vPMxPP+dAz1bhLvOpzNNo+6ndc
         jUuQ==
X-Gm-Message-State: AOAM532x02dDS2I4uQWfGF78l5eCKWoid2dNsgxLoBb093AJlkezKMVy
        mP2J7EnJ1/EXtvUGN+P4IpI=
X-Google-Smtp-Source: ABdhPJzaRsPj9c7kb9qvOWtmeBfPFyfJGIUOuJPs+l8QumnmnvBhQj/v/qhgVjBQz0iibeJndx2YDw==
X-Received: by 2002:a05:600c:348a:: with SMTP id a10mr26647064wmq.165.1640885078101;
        Thu, 30 Dec 2021 09:24:38 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2657:9600:789b:54e9:fc28:95aa])
        by smtp.gmail.com with ESMTPSA id n1sm25951857wri.46.2021.12.30.09.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 09:24:37 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] Documentation: kgdb: properly capitalize the MAGIC_SYSRQ config
Date:   Thu, 30 Dec 2021 18:24:23 +0100
Message-Id: <20211230172423.30430-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most readers are probably going to figure out that the config is actually
all upper-case letters, as all Kconfig symbols are this way.

Properly capitalizing makes the script ./scripts/checkkconfigsymbols.py
happy, which otherwise would report this as a reference to a non-existing
Kconfig symbol.

So, use the right capitalization for the MAGIC_SYSRQ config in the kgdb
documentation.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/dev-tools/kgdb.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kgdb.rst b/Documentation/dev-tools/kgdb.rst
index 43456244651a..3e3f7bca937d 100644
--- a/Documentation/dev-tools/kgdb.rst
+++ b/Documentation/dev-tools/kgdb.rst
@@ -402,7 +402,7 @@ This is a quick example of how to use kdb.
 2. Enter the kernel debugger manually or by waiting for an oops or
    fault. There are several ways you can enter the kernel debugger
    manually; all involve using the :kbd:`SysRq-G`, which means you must have
-   enabled ``CONFIG_MAGIC_SysRq=y`` in your kernel config.
+   enabled ``CONFIG_MAGIC_SYSRQ=y`` in your kernel config.
 
    -  When logged in as root or with a super user session you can run::
 
@@ -461,7 +461,7 @@ This is a quick example of how to use kdb with a keyboard.
 2. Enter the kernel debugger manually or by waiting for an oops or
    fault. There are several ways you can enter the kernel debugger
    manually; all involve using the :kbd:`SysRq-G`, which means you must have
-   enabled ``CONFIG_MAGIC_SysRq=y`` in your kernel config.
+   enabled ``CONFIG_MAGIC_SYSRQ=y`` in your kernel config.
 
    -  When logged in as root or with a super user session you can run::
 
-- 
2.17.1

