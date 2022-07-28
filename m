Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217D85848D5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiG1Xzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiG1XzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:55:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147011928B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:55:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i13so3996024edj.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=PR2g7EG7sP3ZrKB5jtxwTJwCSPOaOLj4Nh76QscH7Q0=;
        b=C94F3jKJb6dzeORs7XX/pGVTpxhjREhHluNRo9dqoQEx9YnN4qsCcY6GRdCa/8j4DI
         +iIQt1T2yzhkNLYedmfrfmdBJsOPDg5u1CyaXD5xbA9/OpDecgOFJNosiGdBlN3W367U
         uLhyCcWZ4otNM3/bp50wHK31vUP+eJ0YxFDR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=PR2g7EG7sP3ZrKB5jtxwTJwCSPOaOLj4Nh76QscH7Q0=;
        b=g7z3TyEGDUaN2B3dlB+9GvKakzv1OxTbpXQn1knI2v6Jg4BCZhrrc060t0vvpZFUoJ
         xAZidxagTMd5dDzXcUvZHRYnJpjMJbI9dKQTqzeHnEhMvtM7F7gYw4C6RZ4XT36n4PEO
         VbIOpScNpjyl3ZquKk7a9TCCTh3StrOJ51WUaScBhLnQDZviurOBZD0Ksx8xFckmx8pL
         kwymzV54z07OSvyhBhUHh7Gi6qH+t9rxng7OJy9KmTnYEMQvYBmgBpVG8CyhdviN0xCW
         ddQfbJzxURzNzcQ0u4zx1z8VReuCdF5jOV8Nxe4dRPsK/O23LB920kDmN0J5nc8cTj/x
         rS4w==
X-Gm-Message-State: AJIora/bRMlzlgRSSflMOhzk1+QqR0MwOg/ttzwzQLsFTQRyA+wiW7yP
        ZYE64wpBUPCF1O2nhZWsJnheaAx39eS5Lw==
X-Google-Smtp-Source: AGRyM1vqW8H84F0zeaHSSa6xgxseUIZe6OkYYIVJveO7Ku6P+EHynMnmekorcGus6dCFNxce5Mghnw==
X-Received: by 2002:aa7:cd84:0:b0:43c:532b:65e9 with SMTP id x4-20020aa7cd84000000b0043c532b65e9mr1271957edv.330.1659052515697;
        Thu, 28 Jul 2022 16:55:15 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906308500b0072b32de7794sm950648ejv.70.2022.07.28.16.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 16:55:15 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] documentation: debugfs: add a missing closing parenthesis
Date:   Fri, 29 Jul 2022 01:55:03 +0200
Message-Id: <20220728235503.651254-1-alvin@pqrs.dk>
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
v1 -> v2:

In disgrace, I made typo in the subject of v1. Here is a v2 without that
typo.
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

