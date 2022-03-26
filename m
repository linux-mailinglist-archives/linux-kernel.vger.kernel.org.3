Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE37C4E80FD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 14:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiCZNPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 09:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiCZNPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 09:15:14 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195592610C;
        Sat, 26 Mar 2022 06:13:34 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c11so8619742pgu.11;
        Sat, 26 Mar 2022 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2+eIxZqOe1Mjhf8cNcbX7USgWsl2vUVVnTGEjRC7N0w=;
        b=EhbOaNm9b/gV+8+y0Y/4ONHt1vg8NQxn1EYZZo5K3DIjtbs0J6QA+ODLeHVRk4XbEs
         QXqdUi820CxbqTzTO0hrvxxrt34d8aKJuv0yj/1R85tnMzA7MhDXJnGQZ/jbTszN/BV2
         Z8WfAgDMrVTkATtJiOfpgJoqi5Ws+Ui7XeIPGrxwZ0ZJHcBjphDofOm2Mv64zorRZcrF
         k0X4qiDSdAe3IQyiMr6qNVrlLUd7+ezVVyyCeI7vi0IYC5+cDSPOiucNurnSfjjsZpYA
         Meb5+PWZ9g6n++SXjSnOuJKRvVvCGk4WEkowL6/AeYynyL1ezQ4Pb67gdi4aYBpCetlF
         7V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2+eIxZqOe1Mjhf8cNcbX7USgWsl2vUVVnTGEjRC7N0w=;
        b=L/YsAQ5GgYYspUkReocOkVGyOoKQFjm7bSbGwhbDSu2sAxbsuRnfjnMHrB3PoQUjxc
         oGqrMdZhMGkhLYPMblBZPf8qeZlpTNo9Muqd3vv8QH2HAr9oIGpHXqc5mQB+KirHbRCI
         NtazLbDu6XF2icjVSYizrdi3/IjHhd/ugGkVuLIpreXJOs1U4vvG95EsmmvGyA7PSlxk
         7YcQNEf8kiyDK1Tnifsc3MIxB8E6E2XbVQyds0NL6CJYcRO9YLyTK4rR71IzprOXVwnc
         ioVI3obyX9ixbSpDRQgh2nysrld3iV+QwVcaebzWp6+oZh+49v60eyRc7+xX9HXR9DUw
         JW8g==
X-Gm-Message-State: AOAM533y6np2aAWu70T093Ti2874OW7cF49lYGwCvP8GjOufC+sEh/WT
        qusLk4aNdoTDAvgb+5bwgRZH52Zv4fkAq6b/
X-Google-Smtp-Source: ABdhPJxITfRKtGZ+rCAWC+cPUlLWbvPlZgN4OMToB2Ca8oZRwme+PxNZWWOCjusVc5kHV4rHg1jMJw==
X-Received: by 2002:a63:5014:0:b0:380:132:6b25 with SMTP id e20-20020a635014000000b0038001326b25mr3415576pgb.211.1648300413220;
        Sat, 26 Mar 2022 06:13:33 -0700 (PDT)
Received: from ubuntu.mate (subs32-116-206-28-2.three.co.id. [116.206.28.2])
        by smtp.gmail.com with ESMTPSA id k3-20020a056a00168300b004f7e60da26csm10689421pfc.182.2022.03.26.06.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 06:13:32 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: arch_pgtable_helpers: demote pgtable list headings
Date:   Sat, 26 Mar 2022 20:13:14 +0700
Message-Id: <20220326131313.691027-1-bagasdotme@gmail.com>
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

Demote pgtable list headings from title heading to chapter heading.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/vm/arch_pgtable_helpers.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
index f8b225fc919047..cbaee9e592410f 100644
--- a/Documentation/vm/arch_pgtable_helpers.rst
+++ b/Documentation/vm/arch_pgtable_helpers.rst
@@ -13,7 +13,7 @@ Following tables describe the expected semantics which can also be tested during
 boot via CONFIG_DEBUG_VM_PGTABLE option. All future changes in here or the debug
 test need to be in sync.
 
-======================
+
 PTE Page Table Helpers
 ======================
 
@@ -79,7 +79,7 @@ PTE Page Table Helpers
 | ptep_set_access_flags     | Converts into a more permissive PTE              |
 +---------------------------+--------------------------------------------------+
 
-======================
+
 PMD Page Table Helpers
 ======================
 
@@ -153,7 +153,7 @@ PMD Page Table Helpers
 | pmdp_set_access_flags     | Converts into a more permissive PMD              |
 +---------------------------+--------------------------------------------------+
 
-======================
+
 PUD Page Table Helpers
 ======================
 
@@ -209,7 +209,7 @@ PUD Page Table Helpers
 | pudp_set_access_flags     | Converts into a more permissive PUD              |
 +---------------------------+--------------------------------------------------+
 
-==========================
+
 HugeTLB Page Table Helpers
 ==========================
 
@@ -235,7 +235,7 @@ HugeTLB Page Table Helpers
 | huge_ptep_set_access_flags  | Converts into a more permissive HugeTLB        |
 +---------------------------+--------------------------------------------------+
 
-========================
+
 SWAP Page Table Helpers
 ========================
 

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
An old man doll... just what I always wanted! - Clara

