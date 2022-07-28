Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DDB5848C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiG1XqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG1XqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:46:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9288C193EC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:45:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id va17so5810831ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=M7/jd+TmiWFhj3BgYNw38FFZtKKvi/KFHz2HsNXDs8o=;
        b=ab7KO9rNYMJ04eu1ovs3n627vErNyTn4Qr0ffBAeHoPwjoWKJfzhmJSZht3uFKDOIy
         BsA5Axw+QLm8T0svdAoKAFsTMVj3dKdzlWIWUc0kD+3s0Lg0kVS9sPVA9WnkZfW+mQll
         SsMdT1lzJhwdxGyebu/q7bLiOoicJ5XHtkWzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=M7/jd+TmiWFhj3BgYNw38FFZtKKvi/KFHz2HsNXDs8o=;
        b=Uo7l4dTgKc8AjCAGisIde5xXtjGUTG7QpaQYp2DDsvFZQv6yiUpC02XtzG78A8idln
         Jz6FlC1tElxV/+8I+j8JjULOk9oVA9i8pTmSijT/2PFPpofWDc8x23lQBiHUrcmIRhTT
         6sfUkXIkKwywE4rYB413rsBbhRiBoMdNV2qNLKjN3B/5CwxkZB4Oxso8zLS8LA697ii6
         MfuLZL2W7cQvzLTNI5z3Mqrwo8wso9TOFcJvtM3ML+q4363F66b76yRMJBW9RGCt9o4H
         0H3tOwBo3bVX8T96W5WK+DX1/p1r27C82oS1T7BzPPn1kHtfoSdj63TICY4xMqbjrF0g
         9OsQ==
X-Gm-Message-State: AJIora8XUAk8wORxl7Pas1bAFimQe7lNviGhrnByJYRqy/fsoFU/ctdH
        nqUVXDX+QNG/3i/dMqotuWMRHw==
X-Google-Smtp-Source: AGRyM1spKku6z28jzABhGX8ROE6i2B6rgImRJKGH2zUtcivOilPVr8PR7m9m8IUElAd2rSBvfkx+Nw==
X-Received: by 2002:a17:907:8a1d:b0:72b:9e7b:802a with SMTP id sc29-20020a1709078a1d00b0072b9e7b802amr924882ejc.189.1659051957926;
        Thu, 28 Jul 2022 16:45:57 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709062f1700b0072ff4515792sm934822eji.54.2022.07.28.16.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 16:45:57 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] documentation: debufs: add a missing closing parenthesis
Date:   Fri, 29 Jul 2022 01:45:47 +0200
Message-Id: <20220728234547.647691-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The two impacted sentences ought to be one, concatenated at the point of
the missing parenthesis that has been added.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 Documentation/filesystems/debugfs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
index 71b1fee56d2a..a810eee40a8b 100644
--- a/Documentation/filesystems/debugfs.rst
+++ b/Documentation/filesystems/debugfs.rst
@@ -155,8 +155,8 @@ any code which does so in the mainline.  Note that all files created with
 debugfs_create_blob() are read-only.
 
 If you want to dump a block of registers (something that happens quite
-often during development, even if little such code reaches mainline.
-Debugfs offers two functions: one to make a registers-only file, and
+often during development, even if little such code reaches mainline),
+debugfs offers two functions: one to make a registers-only file, and
 another to insert a register block in the middle of another sequential
 file::
 
-- 
2.37.0

