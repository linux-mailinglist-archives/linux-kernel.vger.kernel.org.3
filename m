Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AF95158C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381671AbiD2XDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381665AbiD2XDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:03:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D964317AAB;
        Fri, 29 Apr 2022 16:00:19 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d15so8368495plh.2;
        Fri, 29 Apr 2022 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlmPAtCVXUFto+oenKYnRNw/Xs3pnpINvENJYUeN16c=;
        b=cJF2fEOEEoqrAx/jcayEkxBxGGDVlNLpslj3mUsd8/B4N7l8kBmhGf0vYnVWCW/cKZ
         bczgoiLlyKfezu90N/Yd/NGxR5Z1RjL/QdrooC7XIbzV997qqTjc5p6hA88y3Ex46Iba
         +MaWxBvWg1zn4gAyJdD4iuHUgYo2ke8OV1Bk+wpxbkkb9FPVUPBT98m6Cqd5uFvUlA66
         sDDhF6ZK77uKamkbP0Czt8781Uz/BPfSls5HwoUIRlySZyw9UMd0PZgbkXPtvzxIwHsu
         Gs8CX+hkzgCb3HuhbxzqNFaP7lGFWnyCxkiDmVpskJfZ0r7LLBTgOKAGVsmYnasrJdVB
         jJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dlmPAtCVXUFto+oenKYnRNw/Xs3pnpINvENJYUeN16c=;
        b=DBoWSz6680Spxn98W5beaIB97AfC8RuMtexapylndgml5O5DFPsOFygKXQJ6FZhmYa
         XzyLZHAd+4yZ+I8budzN736TGEmxNNoqAg23tVfO7StGN4Qexz9/AYRPUhGO/wpelAI3
         zzSeEmrx6Lbtx3KmZq3K/D5cwcRxn+igzGq99e/f/ujNVjEP/r4h71YID1mTuf3um3Eh
         lxhfX/ZsOqykFte2puX2TPTZdx/QVqfd/cTxf7AKusmVrx54/YHTvzOmrSwTkprMGPKk
         Bz/P7sGpB/dll9a9M/Id4pFHTXYzQ4c3174LRpEYaZNTP8RBv4u/MgRXnKD/oyPHLipw
         Rksg==
X-Gm-Message-State: AOAM530V/Eyj57E7a3Ey+Bbo/udaEi8f288onxskf1SbkVlbz/3f0iWz
        944zDfeSAoKypKfxdqy8BJg=
X-Google-Smtp-Source: ABdhPJy6tKo3op8pC1HVFCOodWCd18LjL3zXn+zhgLtkD6QGn8EKs5nxc71an7cx2vr0s06sClN83g==
X-Received: by 2002:a17:902:9b94:b0:156:2c08:14a5 with SMTP id y20-20020a1709029b9400b001562c0814a5mr1332397plp.60.1651273219221;
        Fri, 29 Apr 2022 16:00:19 -0700 (PDT)
Received: from localhost.localdomain (164.174.128.101.dy.bbexcite.jp. [101.128.174.164])
        by smtp.gmail.com with ESMTPSA id s14-20020a170902ea0e00b0015e8d4eb29esm63140plg.232.2022.04.29.16.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 16:00:18 -0700 (PDT)
From:   Kosuke Fujimoto <fujimotokosuke0@gmail.com>
To:     shibata@linuxfoundation.org
Cc:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>, corbet@lwn.net,
        akiyks@gmail.com, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] docs/trans/ja_JP/howto: Don't mention specific kernel versions
Date:   Sat, 30 Apr 2022 08:00:01 +0900
Message-Id: <20220429230001.6124-1-fujimotokosuke0@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change is based on commit d2b008f134b7
("Documentation/process/howto: Update for 4.x -> 5.x versioning").

Replace "4.x kernel version" with generic term such as "mainline tree"

Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
---
V2: Reformatted commit log messagae (Yokosawa-san)
V3: Updated some expressions (Shibata-san)
- added "version number" in mainline tree section
- updated from "stable kernel" to "stable tree"
V4: Added reviewed by tag and removed extra characters (Yokosawa-san)
---
 Documentation/translations/ja_JP/howto.rst | 44 +++++++++++-----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index d667f9d8a02a..deac41eb038a 100644
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
@@ -303,20 +303,18 @@ Andrew Morton が Linux-kernel メーリングリストにカーネルリリー
         前もって決められた計画によってリリースされるものではないから
         です。」*
 
-4.x.y -stable カーネルツリー
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+メジャー番号をまたぐ数本の安定版ツリー
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 バージョン番号が3つの数字に分かれているカーネルは -stable カーネルです。
-これには、4.x カーネルで見つかったセキュリティ問題や重大な後戻りに対す
-る比較的小さい重要な修正が含まれます。
+これには最初の2つのバージョン番号の数字に対応した、
+メインラインリリースで見つかったセキュリティ問題や
+重大な後戻りに対する比較的小さい重要な修正が含まれます。
 
 これは、開発/実験的バージョンのテストに協力することに興味が無く、最新
 の安定したカーネルを使いたいユーザに推奨するブランチです。
 
-もし、4.x.y カーネルが存在しない場合には、番号が一番大きい 4.x が最新
-の安定版カーネルです。
-
-4.x.y は "stable" チーム <stable@vger.kernel.org> でメンテされており、
+安定版ツリーは"stable" チーム <stable@vger.kernel.org> でメンテされており、
 必要に応じてリリースされます。通常のリリース期間は 2週間毎ですが、差
 し迫った問題がなければもう少し長くなることもあります。セキュリティ関
 連の問題の場合はこれに対してだいたいの場合、すぐにリリースがされます。
@@ -326,7 +324,7 @@ Documentation/process/stable-kernel-rules.rst ファイルにはどのような
 類の変更が -stable ツリーに受け入れ可能か、またリリースプロセスがどう
 動くかが記述されています。
 
-サブシステム毎のカーネルツリーとパッチ
+サブシステム毎のカーネルツリー
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 それぞれのカーネルサブシステムのメンテナ達は --- そして多くのカーネル
@@ -351,19 +349,19 @@ quilt シリーズとして公開されているパッチキューも使われ
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

