Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2139D5A5564
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiH2UNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 16:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiH2UNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 16:13:22 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089269A9CE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:13:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m11-20020a17090a3f8b00b001fabfce6a26so3799056pjc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=VC8vXk4FOjSceP7/E2DfzH10PAfXYVNaW5zOB6Dmb1Q=;
        b=ACNc/cQFaJy4AIzG4EOsXsQjyWDSOETVFX10dAnkBsJDO9sqSKiuUrtVXSgryc+r2U
         Ij9Nlz+jswnlWZDNBQqmfRMU1qXFQz8R/NhBANXBySuZTKlph1PSwdL33hFPKKKPxtTE
         N3SVMmmlj+1GDH63YTUL5v3PuVK0t5O+tLYOH5DsgA9XMqR560OYp7Dn/4IzNkPDwd4D
         NiTqQGeAM3dsBANWNmtdn3lEfnJ5tCZvrdvYLTBQMWA6j95aUjWuVWGx+/IYnAOryI1Q
         mzcPHqC5hnKLXvnpQpEC2vOMEEOzKO5sHp9/qUjXi1wwFiYlQUxyew8+vFwLj5SN2ALL
         EISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=VC8vXk4FOjSceP7/E2DfzH10PAfXYVNaW5zOB6Dmb1Q=;
        b=Uw15IW+ai42c4g3b/Oz6j7fwHc6mWh/ERxVFK8ZeOSGaU04Ord7AUTY0HVxHmWW/l+
         gnWo/uRlh4O1V8nHlcUTojAfQRiNuqkGu0sEzewdtUZ7m6PKJKUIOGRyykZqa6wJKQz5
         OWpT5X/o6Z+M7gUkHvI0zoRRJZ7Veo1zn2Quf41R/4DsEtm/MMTRNnhLPCnd2C2oICxA
         G0Op1b+DOcq10/84NtInb98fGvv8pImyrYHWwi0tlKp2lSseXqz9g8FwNPrlpIlm3QuT
         lMTP6djJbnACZ7w+k3L2P6nV0St9f6UyHO/18pEXav6fB2XIqx/338Tks+VtiFh7mX1P
         d1cQ==
X-Gm-Message-State: ACgBeo3GUwcmOWYHOqAkoCY9JCpogBhb7O3KtTeU8xxNS+8vFQEQL43e
        kkBvL2fUncfzjuNmK6arMRx+u3m691yfPA==
X-Google-Smtp-Source: AA6agR7kUGq2vaqwjKHpnxoGBX1COG6g7EI/1oAQFxNqod8E3/2FGVGbUizyBTBQ8yahJIGKykeLlofwlDbYKA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a65:63c3:0:b0:42b:5b03:ce57 with SMTP id
 n3-20020a6563c3000000b0042b5b03ce57mr15158401pgv.436.1661803993083; Mon, 29
 Aug 2022 13:13:13 -0700 (PDT)
Date:   Mon, 29 Aug 2022 20:12:54 +0000
In-Reply-To: <20220829201254.1814484-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20220829201254.1814484-1-cmllamas@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829201254.1814484-8-cmllamas@google.com>
Subject: [PATCH 7/7] binderfs: remove unused INTSTRLEN macro
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

Fix the following W=1 build error:

drivers/android/binderfs.c:42: error: macro "INTSTRLEN" is not used [-Werror=unused-macros]
   42 | #define INTSTRLEN 21
      |

No functional changes in this patch.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binderfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 588d753a7a19..44939ea1874f 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -39,7 +39,6 @@
 #define FIRST_INODE 1
 #define SECOND_INODE 2
 #define INODE_OFFSET 3
-#define INTSTRLEN 21
 #define BINDERFS_MAX_MINOR (1U << MINORBITS)
 /* Ensure that the initial ipc namespace always has devices available. */
 #define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 4)
-- 
2.37.2.672.g94769d06f0-goog

