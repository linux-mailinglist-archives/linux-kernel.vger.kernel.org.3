Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8728D4E80EF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 13:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiCZMwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 08:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbiCZMwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 08:52:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEF149FB0;
        Sat, 26 Mar 2022 05:50:58 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id o13so8587801pgc.12;
        Sat, 26 Mar 2022 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRHlffwsBpvAEuc4uVYZ11IJj6FLwF+HYabRWnbz4S4=;
        b=M7lx1oLAGmw866FgDSxQmOSpgu/MKYVmka/Buj3k2sjG6/s8dSPxVtkiaEG4j0CFYO
         HD1RrAZ78nh5OhzsLKZiepdQS4pfHDGNT2TApWWJPyWL67d2GnPkMADNJ9zwHhzDWFRa
         XbVbJWt+UV+U+ebBdcphDeQscKjPA4CmF6/zeyAlLfWEwdRYtjIBabo1oeCJsCHuzmmn
         0FPEquiT8XAzCnE7kf/lT1ZZ4sr2R7pxy32MsFz9W81ud+OShjeJKPyLdEt1pjn3Mfa9
         knS0v4w1qiZQcnIlomEtKMAUJJ4d/6Cu0j0JbVFRqMJW4ytEtD6Yf5wBMnDQRYGKGx75
         c4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRHlffwsBpvAEuc4uVYZ11IJj6FLwF+HYabRWnbz4S4=;
        b=7fDzmTA+xz6EO/pXJu7X9mf+Rt3xIkiO++w/BrJXYoP4twvBVqwl+/9Q12IJeLvYhq
         9JDmT0cnhEiXZNVjcXwMkUigLxB18nbunUVY6yPwoU3pOQ7oxuRl6vZBSglaYBRei0YA
         Ypbl5LaNOnVAV3uVgA7qrNQnhOoWlLWxdyxfR4vD1s4Kj/KADihOzuQHtMC7FU6Yh19v
         gN/j9IJrSJ1i+LowNK6nb7wOatLurh9b4EkMgjAK/NFKXnIEzQUNaEGCTtSHtcVbqpM/
         5pgDvPR9Voyk2DilcByBMkBRAuAT/vZnFfkODDKmLJSmd/v5RrIovfhj0Po3GpSF+Zsu
         YvhQ==
X-Gm-Message-State: AOAM530AbXkJhoVJ7GWQNUhM5fdG3MI62HpWgqvtuhVlY/9+bxymnCgI
        i5VGQj9SFU45h3UIuud1TdFFDlMPfDyJlgT6
X-Google-Smtp-Source: ABdhPJxVLsq9JmMOTem/L3m5ZMXRzpPELi6NMrdNprwBb7KTFUq+CII3PXeIAbNsUEZHj3c866rX6A==
X-Received: by 2002:a65:6a13:0:b0:373:14f6:5d33 with SMTP id m19-20020a656a13000000b0037314f65d33mr3522798pgu.62.1648299057641;
        Sat, 26 Mar 2022 05:50:57 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-2.three.co.id. [116.206.28.2])
        by smtp.gmail.com with ESMTPSA id z16-20020a637e10000000b00382b21c6b0bsm8101661pgc.51.2022.03.26.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 05:50:57 -0700 (PDT)
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
Subject: [PATCH] Documentation: kernel-doc: Use descriptive mood for chapter headings
Date:   Sat, 26 Mar 2022 19:50:37 +0700
Message-Id: <20220326125036.667960-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Use descriptive mood (with present continous) instead of interrogative
mood (without question mark) for writing chapter headings.

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
 This patch is applied on top of "Add missing page title" series [1].

 [1]: https://lore.kernel.org/linux-doc/20220326123337.642536-1-bagasdotme@gmail.com/

 Documentation/doc-guide/kernel-doc.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index ea41e05d0e8903..fbcd9f553a8382 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -31,8 +31,8 @@ documentation for private (file ``static``) routines, for consistency of
 kernel source code layout. This is lower priority and at the discretion
 of the maintainer of that kernel source file.
 
-How to format kernel-doc comments
-=================================
+Formatting kernel-doc comments
+==============================
 
 The opening comment mark ``/**`` is used for kernel-doc comments. The
 ``kernel-doc`` tool will extract comments marked this way. The rest of
@@ -524,8 +524,8 @@ source.
 
 .. _kernel_doc:
 
-How to use kernel-doc to generate man pages
-===========================================
+Using kernel-doc to generate man pages
+======================================
 
 If you just want to use kernel-doc to generate man pages you can do this
 from the kernel git tree::

base-commit: c4118934eeb6b26b20d52cd0a1f326440ac8f763
-- 
An old man doll... just what I always wanted! - Clara

