Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DB05A5565
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiH2UNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiH2UNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:13:04 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F23498A51
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:13:02 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id i25-20020a635859000000b0042bbb74be8bso2551804pgm.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=c+V6ZZoSbyilAuCWrSUmpUH+8o9/Xyf5DRUIoUPm6XI=;
        b=th/mrIVRwJZnvQWDY6W+eVycuyURZk0Sl/DjLPmvcO2BzkGBlZiaYmgNMHCqciDIBC
         V7M8xdsyYeHngANpHKmlWYvdoHwzHDpr//zBG5r5kPHUUlXESeMRq4b24K5J7E2yCVoz
         SJN6h+D1T04ZqWqYO/TLu+tpQ9CtmIp5ja2b6jxhfvSXJNlbnqO5uvM8jgEokHoBB18R
         BQHQzBoVYIDu5NcHN3bYKiAnRjl1yRcPOT4HZLDwBK8rMPZflq/UENqZNFseuG9hZTQ8
         5DzDl0s+12Qj4N9QzPk8rE/nuIn3Tz0f7w+C8XZmGCoK9cnQCtaMYnLQwg5e3KO6IyOo
         EmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=c+V6ZZoSbyilAuCWrSUmpUH+8o9/Xyf5DRUIoUPm6XI=;
        b=Y76j4KihWbdsjT06bBC7awT3+dNPBE/BGY/wSjsfXcEpEdRp5bqgtTdi9HoZXso66X
         OgZQC0L46kLLve4xcqIJMTNf3B/AyNWcp5Mph47F2dF7vomQYpflLxCuczd5haOjHmtK
         yBDt92ldQbRhne0PhfiixaBgk12nWiDuGSFF/t5nIJlucyaOFcziR8HD1eVdRhJElmoT
         Xr8FwxjF6XZf51wq/9OS2foSBvNC0Um+bwQwGmRejxCG8NIoktW0jGmYekaq66YkCzEU
         aHJKpwntd60Im3JIe0SnXh35xxBHhuj+f36Pujn0n9/IJaBbtoav4SSh871yCqcLOBIv
         LrqQ==
X-Gm-Message-State: ACgBeo0OKiMEmkKX83UgZJweP/BH19QeJVk0DeEiKwJL+x4BTmsg95CC
        aeBDoTUALtpa8d4hg6/Z0k9GnQMkUXmsvA==
X-Google-Smtp-Source: AA6agR6256IN6UnhHmY7Mc33PGDMwJCHqWrhB3Iam39aDneViP7+0NCT5g95gwDa5PcKe+BSqZqdnVGMX0mbVg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:d81:b0:1fd:7fed:4a9c with SMTP id
 bg1-20020a17090b0d8100b001fd7fed4a9cmr14793656pjb.127.1661803982164; Mon, 29
 Aug 2022 13:13:02 -0700 (PDT)
Date:   Mon, 29 Aug 2022 20:12:49 +0000
In-Reply-To: <20220829201254.1814484-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20220829201254.1814484-1-cmllamas@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829201254.1814484-3-cmllamas@google.com>
Subject: [PATCH 2/7] binder: fix trivial kernel-doc typo
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

Correct the misspelling of 'invariant' in kernel-doc section.

No functional changes in this patch.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index 1e4fd37af5e0..0c37935ff7a2 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -75,10 +75,10 @@ struct binder_lru_page {
 /**
  * struct binder_alloc - per-binder proc state for binder allocator
  * @vma:                vm_area_struct passed to mmap_handler
- *                      (invarient after mmap)
+ *                      (invariant after mmap)
  * @tsk:                tid for task that called init for this proc
  *                      (invariant after init)
- * @vma_vm_mm:          copy of vma->vm_mm (invarient after mmap)
+ * @vma_vm_mm:          copy of vma->vm_mm (invariant after mmap)
  * @buffer:             base of per-proc address space mapped via mmap
  * @buffers:            list of all buffers for this proc
  * @free_buffers:       rb tree of buffers available for allocation
-- 
2.37.2.672.g94769d06f0-goog

