Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7289A5AEDA2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242142AbiIFOlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242387AbiIFOjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:39:16 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16B19AFA2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:01:15 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p18-20020a170902e75200b00176c0e055c9so2287637plf.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=+Q6B/cTB5oT3fqaZDpIDHs2zE/85n+XEC/rzCUUmUUs=;
        b=fk3U/t/BSZPHw9Bf1Iqbtg/jRCq0HsROm/s9tfLAq/MH4ARIlquxqeYveq/8Imsj0C
         s7a9BkcLOkuascsOwBzQ2uL6ZJJ+or3McsNseAy6TDk5QhFiZtD8jrnZfUdhYArRglIt
         84Qy7/TpEcWoKipEsAeKVyTr+smrSgDovkV2e1mZc5IoCnsEbMwqIKRAUOjDRmCU/JxP
         IMfDX8IAgctbiS6sDOpD2GtS/EytuF6VbHaruYPZT/uUX8sKXgbpFGAG3Rtc+S/2nVsE
         YFPunQ+R61mHewEU6HMHYDzOaqHKIWLkn//+UDhsYk6JA7u9Ax/4PuJ4BTwKnzFhq6fE
         kuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=+Q6B/cTB5oT3fqaZDpIDHs2zE/85n+XEC/rzCUUmUUs=;
        b=SFvw2uBZPAq4siq1REf0RcJ4mTz/s7yltKHq76RvAnIiW8GyGx1Oxu7Fr1595VbsTW
         +2EszAUcX3rZY+XY8zIj/JAB1YF5ry0HIU51P0gFxwL8AR0Y8MrrgdHAf3b6SLzACQVH
         pzGeIXvq/me6yIueIXkCIQPv+xKPqQMK7RGrRMzI/n/GH1jFU55dDQTFVz/OBa9AHswB
         54xuH/ssjoMYddvz4kcaFISYHJ+z6QfOCY0Oh0Kdr6J6z5sJcqjckHez2lh/Y5dVgBYL
         51b7POqDEv59SKrROdlDvRgPJUO/O1Q1gIOIuJzEsSAdcuIgeznDdMaw23cDZEN40k8m
         TDUQ==
X-Gm-Message-State: ACgBeo2AIP7f8vHw8clX1PJJJFMebrBMGs2xdDPSXK5pC3RNehF+ih/4
        QV39QvnnPTH94yKYBJUj4q8RpXeki/KJOA==
X-Google-Smtp-Source: AA6agR4MuU2P2JcPxrTr4nNG0hdwb++wxvhKgALyWAzsPADtaWvGC72IlSRZ3HervIO7xpA5+te9svzAmKEqKQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:10cf:b0:528:48c3:79e0 with SMTP
 id d15-20020a056a0010cf00b0052848c379e0mr54787114pfu.18.1662472803931; Tue,
 06 Sep 2022 07:00:03 -0700 (PDT)
Date:   Tue,  6 Sep 2022 13:59:47 +0000
In-Reply-To: <20220906135948.3048225-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20220906135948.3048225-1-cmllamas@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220906135948.3048225-4-cmllamas@google.com>
Subject: [PATCH RESEND 3/3] binder: fix binder_alloc kernel-doc warnings
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     kernel-team@android.com, Todd Kjos <tkjos@google.com>,
        linux-kernel@vger.kernel.org
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
Acked-by: Todd Kjos <tkjos@google.com>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
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
2.37.2.789.g6183377224-goog

