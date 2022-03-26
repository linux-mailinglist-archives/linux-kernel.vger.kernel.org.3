Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE74E80D5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiCZMfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 08:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiCZMfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 08:35:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BB52980D;
        Sat, 26 Mar 2022 05:34:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t13so7345814pgn.8;
        Sat, 26 Mar 2022 05:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jgkmVRw33cX5eU3+HJbr4zgKWyD0n7D37hzktMfdhRM=;
        b=DbFGbOoqdtTpEFBDkVze6Lp/tTALmrnhxWDULMi76rKyHrftlo7jj+T2P/4h/T6doG
         Obk7lBd/Ztc37QBx4pY//rzuMFqUmchdXq6Q/3il0AfKC9FV8xSmAJbF1Ydxuxjx80DV
         FP1pz0MrVC+NFjr97wRL8erfvF/C1O+RTEsFYIDayyyLOJPIZx1alKx+ZmAwrmxU+ly1
         TPbFanlZsyynNMgB0zb3P7InMzD90wWucO4fM+ocURmq+5fDWJeAXLt4++fV0NDjv0CJ
         8lpJDxt3CLdS0AO3mCc4xlwdnlar/FrUMWH9JcvpC6obcrTFPw9UxsoxzHNwDKU13GcD
         DqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jgkmVRw33cX5eU3+HJbr4zgKWyD0n7D37hzktMfdhRM=;
        b=tfaONmWHFZF18CY5VyLswLmpHadjb1fqtsmhpG6SdtvPgAqWtv3yoSBoA61W/AJmwU
         KZDoh+9rmd92N9o2UOinjWeoVXSg/ORJ4Vn2ieVEScgoDqVu7iE6T4l6AwsTddWls8ZR
         kQLFlMasS0sCg3FfvcsOfg3e0NhqBZf2tqYG+hIJI8YgolA0udRaVlVNmEyAWERwPlsT
         lgqJ0rfTPLXNEoA86zar6laWJl6RPTtS3L8M8sN50W+Hk4QFbVZ2fe7Zqe6R86WPquOp
         RF6MdfwVAzFAjrHlOlC9u23qHxI7oqulIWiAUsY4WUOREixVqrWZJZbPb4lZtSYWB4bC
         qc2A==
X-Gm-Message-State: AOAM53368tf7dIlddvjTd9RvvdrQUqKtgneLeRWeQHiQSmngNyZyeu4E
        eeHhHR/XcZSiMzdj/WtCa3PXbVDz0LuqsRsE
X-Google-Smtp-Source: ABdhPJyigG8laCdXxJmEZ3HnYdsBnKLPIxi++ETu/SyYvTGzrUNNtCDHw/Mdaat1zkh1M2y+VIIDpQ==
X-Received: by 2002:a65:6a46:0:b0:37f:ef34:7b8e with SMTP id o6-20020a656a46000000b0037fef347b8emr3226414pgu.503.1648298047274;
        Sat, 26 Mar 2022 05:34:07 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-2.three.co.id. [116.206.28.2])
        by smtp.gmail.com with ESMTPSA id k62-20020a17090a4cc400b001c7ea7f487asm4872920pjh.39.2022.03.26.05.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 05:34:06 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Documentation: sphinx: replace "Introduction" chapter heading with page title
Date:   Sat, 26 Mar 2022 19:33:38 +0700
Message-Id: <20220326123337.642536-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220326123337.642536-1-bagasdotme@gmail.com>
References: <20220326123337.642536-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace first chapter heading ("Introduction") with page title named
"Using Sphinx for kernel documentation". This way, the first-level TOC
for doc-guide contains title instead of chapter headings for this page.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/doc-guide/sphinx.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index bb36f18ae9ac3e..2ff1ab4158d48e 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -1,7 +1,8 @@
 .. _sphinxdoc:
 
-Introduction
-============
+=====================================
+Using Sphinx for kernel documentation
+=====================================
 
 The Linux kernel uses `Sphinx`_ to generate pretty documentation from
 `reStructuredText`_ files under ``Documentation``. To build the documentation in
-- 
An old man doll... just what I always wanted! - Clara

