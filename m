Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9722851828D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiECKvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbiECKvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:51:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C026127FF4;
        Tue,  3 May 2022 03:47:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p8so14389461pfh.8;
        Tue, 03 May 2022 03:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M831zgFZPJf91GoKbF5rVl08cyTEueCU811TN2qJoB8=;
        b=buN3id0tHHZL4QpfQvAdzzLdZmWLwsujfs5+XWdRu98lf2sCL4YIPiv6L+0E1rfVOR
         3kRyLUVBD4K5CU3ZBTwtlDe5ZhW6+44xfpTS1uThnLWWsu0NpmM3iX+HDjkIAIEQxCvM
         bAlF3kbh06lkHTU4F87zgLx+M2Ul1jGQ2HM1TZvyx6AVXUgWYql1Nx4CyN6VynOVK7Sx
         i0gXjE84AHkRlwPIA7Og6XeDrNLreygBCmlhrkJHuwj7YpB+pGIu0RwfR7tHYwKqlZ5e
         pkTIiy8gnbTEH9AsdZDuKc5fPTdOhH6NtvFdXltJ0hAcaQIn9W1Lk9Ksj9Q8FHU0Dp16
         CMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M831zgFZPJf91GoKbF5rVl08cyTEueCU811TN2qJoB8=;
        b=fiO10EX1ZRBUWYdOilDTuE77v0RFtBGNY7VhtvMRzt4GsPsBrbU4zs2uUIph3Bfzjs
         crQQdyBpmjxKCe6qDYV/ifeB+KQiojzgSwL3s5x562BN2VJvQf+1j1q9ujU8AsuY+X95
         9Xl+vvaDUyJYDBQ4I7L7jJ5sxl9CKjFddkSh05uil/kTwxO4uGj/H3Ne9GtW5Hrh68KE
         pmQdg7mVcbWizo4xF+C/owbbFdRIcz7FOJn/PgkMg77/Htf7eI37ohS02VwZsNZIWZ6s
         /5WJiavuQx95ThtNLhCKjBx/hAiygR8cZdXxrDIsRfMPS/8ZhTXkdQwKazBjibuql1KW
         um8Q==
X-Gm-Message-State: AOAM530HpbPdmqxeROnFuYdCy9GXeIZs0GTs1SwrRJ6ZVFhdm+BFDH1V
        fU3FiVw1ET4Fqs0aVOCdUvM=
X-Google-Smtp-Source: ABdhPJzDutjgF+a/24kr3j6RXxdZauA7klExgG4W+s7+JSD5nlaWvEeLujZqHPRKsZ/a4EhH9Q0oCg==
X-Received: by 2002:a63:4722:0:b0:3a9:fd43:fce9 with SMTP id u34-20020a634722000000b003a9fd43fce9mr13240784pga.620.1651574862387;
        Tue, 03 May 2022 03:47:42 -0700 (PDT)
Received: from localhost.localdomain (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b0015e8d4eb212sm6126447plx.92.2022.05.03.03.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:47:41 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] docs/ja_JP/SubmittingPatches: Randy has moved
Date:   Tue,  3 May 2022 19:47:29 +0900
Message-Id: <20220503104729.49140-1-akiyks@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503102429.48304-1-akiyks@gmail.com>
References: <20220503102429.48304-1-akiyks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reflect changes made in commit 755727b7fb1e ("Randy has moved").

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
Cc: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/translations/ja_JP/SubmittingPatches | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index 230e62401c78..d3b16bd7fcc6 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -81,9 +81,7 @@ Linux カーネルに対する全ての変更は diff(1) コマンドによる
 dontdiff ファイルには Linux カーネルのビルドプロセスの過程で生成された
 ファイルの一覧がのっています。そして、それらはパッチを生成する diff(1)
 コマンドで無視されるべきです。dontdiff ファイルは 2.6.12 以後のバージョ
-ンの Linux カーネルソースツリーに含まれています。それより前のバージョン
-の Linux カーネルソースツリーに対する dontdiff ファイルは、
-<http://www.xenotime.net/linux/doc/dontdiff>から取得することができます。
+ンの Linux カーネルソースツリーに含まれています。
 
 投稿するパッチの中に関係のない余分なファイルが含まれていないことを確
 認してください。diff(1) コマンドで生成したパッチがあなたの意図したとお
-- 
2.25.1

