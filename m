Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8405E5A5562
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiH2UNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiH2UNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:13:19 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845969A98B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:13:12 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id k16-20020a635a50000000b0042986056df6so4470419pgm.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=XHiRVH6PvcnEh6Bc/jOcBi/Pai5dajqR1Td589CcaX4=;
        b=b2rdg09HH56XEAzAC/mnFioEDHIK8e9YWkW4UtXLOwPhXtdR7Kz9/hfYREFa7bAKLO
         NoIoDIuvxdaRExyNpRawdqUKzvoCFy3Nrh1pTjSCM5WV2w8XHB9VYOyd+e2Tzk0+zMtZ
         UGYe8amFUD2IJu6oFITRCGHJz1VZ8Z5inkAmA8pYgpD9S65qaY2EkkjPqYm4VNtrZc3b
         44LkpB/v4G7AvrehKVefyn2y9cmmJYsa0dO8AvrbyaGCAY8PMyROuU9Ibd4u4O3O8UtD
         nCyp0Fb4W29v+lMre3HibWk8p+2QubU+F9K74+/OB4/HEGwkJ6+PnaSsdhi0NO8brqLI
         5Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=XHiRVH6PvcnEh6Bc/jOcBi/Pai5dajqR1Td589CcaX4=;
        b=rfSwJA3dVfVIgSX/C9s8z0Pbf+LTGGXpadg+4ioNA+4gG2wG4+RNPhmYScjX6nnwxl
         UvemhFq9nBHdN4Zp2/z9B9cL9VDNzesNkjBmZ3nIGJJyvf+KgqvJi4FkHF+zm+mXzoGP
         NMc/ujgPYJI5a2JUyURNWO9Oedn65Uk3DLoJjBhiS5U8NjoJnP188vlUOOp4K06pxAN4
         zWjoP3Mf9xMsrJJmWYO9HlLbfmpjA7XyEFx+I5Gh0/6XWc3Fx2WqI96nuuTDIa2omwtS
         G6waGHdzWu2et2m7kOjaqvzVCYs1zsi+dNji8ehN6k43mQUNQc5E9sxbq63EY1UGdHTE
         z21g==
X-Gm-Message-State: ACgBeo22XWrvqcJQvjLt2jxL+4tb7kEEurE05TSRwrWSyNXmJq2YGBrn
        E/pqmr3CF+fRm/cxIbrvdhudO4zO/5Gm0g==
X-Google-Smtp-Source: AA6agR44COTEqaAcWNGnUJ4oOepGsgnQDx4nBKvNIKkPfzk0jx7N9GoRr1NmaEchICodaprh/rn3F775T1Z9Uw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:810:b0:52e:7dc8:c868 with SMTP
 id m16-20020a056a00081000b0052e7dc8c868mr17903095pfk.36.1661803991361; Mon,
 29 Aug 2022 13:13:11 -0700 (PDT)
Date:   Mon, 29 Aug 2022 20:12:53 +0000
In-Reply-To: <20220829201254.1814484-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20220829201254.1814484-1-cmllamas@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829201254.1814484-7-cmllamas@google.com>
Subject: [PATCH 6/7] binder: fix binder_alloc kernel-doc warnings
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the kernel-doc section of struct binder_alloc to fix the
following warnings reported by ./scripts/kernel-doc:

  warning: Function parameter or member 'mutex' not described in 'binder_alloc'
  warning: Function parameter or member 'vma_addr' not described in 'binder_alloc'

No functional changes in this patch.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index ab3b027bcd29..0f811ac4bcff 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -74,10 +74,9 @@ struct binder_lru_page {
 
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
- * @vma:                vm_area_struct passed to mmap_handler
+ * @mutex:              protects binder_alloc fields
+ * @vma_addr:           vm_area_struct->vm_start passed to mmap_handler
  *                      (invariant after mmap)
- * @tsk:                tid for task that called init for this proc
- *                      (invariant after init)
  * @mm:                 copy of task->mm (invariant after open)
  * @buffer:             base of per-proc address space mapped via mmap
  * @buffers:            list of all buffers for this proc
-- 
2.37.2.672.g94769d06f0-goog

