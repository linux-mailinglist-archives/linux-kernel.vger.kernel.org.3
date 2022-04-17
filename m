Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625AC5046E7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 09:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiDQHKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 03:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiDQHKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 03:10:40 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE9B3D48A;
        Sun, 17 Apr 2022 00:08:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s14so10165470plk.8;
        Sun, 17 Apr 2022 00:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XjCtvr+J3yinATZPEhst+mmG7OGWWwq+iEH9bKzy6zc=;
        b=qUc+mqkm9V90fn0T4zB46ZDeJ3kej8CPMqnQNHY01OOlPbLXM7y7EJfjdSpIM8HLBL
         rLWZGUlX09h08tFUp+GUQlgfjadDF32ERCbYRvtZp9lAfqihIzEOYOWyw2MHzXk2CkNr
         3p/LYneRGr4WR/e3gJ8TC6awAbk4o4uPqxWMUt6+xHIfhf3M9hNv0RGxVOcBztE/+yBY
         VA/rl8UdnMjjYOJP4aokydvF/WoBVVvPy7PaxmvQ7BsAKRqXEQeXvfiG+TCHIKdme6eG
         9P5TOt+E2Xv5TPnLD+wV4/8bKbUuhwkz3Sc/H44pto1sg6nPTdTg+1jzt62FAQh2G8Qx
         56eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XjCtvr+J3yinATZPEhst+mmG7OGWWwq+iEH9bKzy6zc=;
        b=pGXRg4hV6x5fO5VTFQuKwqgbrM48FMgt1WmmvjyU+vbVJRFaj1CzOAjLXaMjZsY2gv
         oOem8MUKtANbM5Jfcu1rUtJKn/xSbKB/H6BKMAyIgnvcCDu5pgfsw13mz9IaMv2/5lBI
         11qubwu6QoQuZz5MltPzDI6/nHWoOtd5ixWeVEp85ICiEHk3POmY7xgoXc5wE78Ioile
         Jvx7ldaawMNGPQryKMVfb4EzDuPyaDykAdM5mrGe0Up4IVBh+u9EZEGUVSEyMf1cWQJE
         Pi6HWtswhLyZZi22W3rTmKHYGIawYCtSJVIxB/OWY2wOwm8UZ57vcpAcb5F/dnacb4V9
         q5dA==
X-Gm-Message-State: AOAM530BC4lkNdhK+BqTX1lbHMJ5n0LZHB4oquPbP4mUiZFNnN2MR4Us
        J3YIm8sVHHjS1ZshPzgW3XU=
X-Google-Smtp-Source: ABdhPJx39nwnB1/kUE4+SOJ6IhiZT0sT75bKATGpZAoE0dH9iubOt8TGy3Z+mHboxnOpDHrJteshdA==
X-Received: by 2002:a17:902:7045:b0:157:144:57c5 with SMTP id h5-20020a170902704500b00157014457c5mr5889194plt.86.1650179284982;
        Sun, 17 Apr 2022 00:08:04 -0700 (PDT)
Received: from localhost.localdomain ([240b:12:16e1:e200:9fdb:b4b9:831e:2f4e])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090a0e4100b001ce188720e5sm9161763pja.53.2022.04.17.00.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 00:08:04 -0700 (PDT)
From:   Kosuke Fujimoto <fujimotokosuke0@gmail.com>
To:     akiyks@gmail.com
Cc:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        linux-doc@vger.kernel.org
Subject: [PATCH] docs/trans/ja_JP/howto: Don't mention specific kernel versions
Date:   Sun, 17 Apr 2022 16:04:51 +0900
Message-Id: <20220417070451.19736-1-fujimotokosuke0@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is based on commit d2b008f134b7 (Documentation/process/howto: Update for 4.x -> 5.x versioning)
Replace "4.x kernel version" with generic term such as "mainline tree"

Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-doc@vger.kernel.org
---
 Documentation/translations/ja_JP/howto.rst | 43 ++++++++++------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index d667f9d8a02a..9b711932ae6d 100644
--- a/Documentation/translations/ja_JP/howto.rst
+++ b/Documentation/translations/ja_JP/howto.rst
@@ -262,21 +262,21 @@ Linux カーネルの開発プロセスは現在幾つかの異なるメイン
 チ」と多数のサブシステム毎のカーネルブランチから構成されます。これらの
 ブランチとは -
 
-  - メインの 4.x カーネルツリー
-  - 4.x.y -stable カーネルツリー
-  - サブシステム毎のカーネルツリーとパッチ
-  - 統合テストのための 4.x -next カーネルツリー
+  - Linus のメインラインツリー
+  - メジャー番号をまたぐ数本の安定版ツリー
+  - サブシステム毎のカーネルツリー
+  - 統合テストのための linux-next カーネルツリー
 
-4.x カーネルツリー
+メインラインツリー
 ~~~~~~~~~~~~~~~~~~
 
-4.x カーネルは Linus Torvalds によってメンテナンスされ、
-https://kernel.org の pub/linux/kernel/v4.x/ ディレクトリに存在します。
+メインラインツリーは Linus Torvalds によってメンテナンスされ、
+https://kernel.org のリポジトリに存在します。
 この開発プロセスは以下のとおり -
 
   - 新しいカーネルがリリースされた直後に、2週間の特別期間が設けられ、
     この期間中に、メンテナ達は Linus に大きな差分を送ることができます。
-    このような差分は通常 -next カーネルに数週間含まれてきたパッチです。
+    このような差分は通常 linux-next カーネルに数週間含まれてきたパッチです。
     大きな変更は git(カーネルのソース管理ツール、詳細は
     http://git-scm.com/ 参照) を使って送るのが好ましいやり方ですが、パッ
     チファイルの形式のまま送るのでも十分です。
@@ -303,20 +303,17 @@ Andrew Morton が Linux-kernel メーリングリストにカーネルリリー
         前もって決められた計画によってリリースされるものではないから
         です。」*
 
-4.x.y -stable カーネルツリー
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+メジャー番号をまたぐ数本の安定版ツリー
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 バージョン番号が3つの数字に分かれているカーネルは -stable カーネルです。
-これには、4.x カーネルで見つかったセキュリティ問題や重大な後戻りに対す
-る比較的小さい重要な修正が含まれます。
+これには最初の2つの数字に対応した、メインラインリリースで見つかったセキュリティ問題や
+重大な後戻りに対する比較的小さい重要な修正が含まれます。
 
 これは、開発/実験的バージョンのテストに協力することに興味が無く、最新
 の安定したカーネルを使いたいユーザに推奨するブランチです。
 
-もし、4.x.y カーネルが存在しない場合には、番号が一番大きい 4.x が最新
-の安定版カーネルです。
-
-4.x.y は "stable" チーム <stable@vger.kernel.org> でメンテされており、
+安定版カーネル は "stable" チーム <stable@vger.kernel.org> でメンテされており、
 必要に応じてリリースされます。通常のリリース期間は 2週間毎ですが、差
 し迫った問題がなければもう少し長くなることもあります。セキュリティ関
 連の問題の場合はこれに対してだいたいの場合、すぐにリリースがされます。
@@ -326,7 +323,7 @@ Documentation/process/stable-kernel-rules.rst ファイルにはどのような
 類の変更が -stable ツリーに受け入れ可能か、またリリースプロセスがどう
 動くかが記述されています。
 
-サブシステム毎のカーネルツリーとパッチ
+サブシステム毎のカーネルツリー
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 それぞれのカーネルサブシステムのメンテナ達は --- そして多くのカーネル
@@ -351,19 +348,19 @@ quilt シリーズとして公開されているパッチキューも使われ
 けることができます。大部分のこれらの patchwork のサイトは
 https://patchwork.kernel.org/ でリストされています。
 
-統合テストのための 4.x -next カーネルツリー
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+統合テストのための linux-next カーネルツリー
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-サブシステムツリーの更新内容がメインラインの 4.x ツリーにマージされる
+サブシステムツリーの更新内容がメインラインツリーにマージされる
 前に、それらは統合テストされる必要があります。この目的のため、実質的に
 全サブシステムツリーからほぼ毎日プルされてできる特別なテスト用のリポジ
 トリが存在します-
 
        https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
 
-このやり方によって、-next カーネルは次のマージ機会でどんなものがメイン
-ラインカーネルにマージされるか、おおまかなの展望を提供します。-next カー
-ネルの実行テストを行う冒険好きなテスターは大いに歓迎されます。
+このやり方によって、linux-next は次のマージ機会でどんなものがメイン
+ラインにマージされるか、おおまかなの展望を提供します。
+linux-next の実行テストを行う冒険好きなテスターは大いに歓迎されます。
 
 バグレポート
 -------------
-- 
2.25.1

