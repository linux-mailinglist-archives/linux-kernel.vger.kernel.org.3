Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4567E5163A2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245559AbiEAK0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 06:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbiEAK03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 06:26:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA441C920;
        Sun,  1 May 2022 03:23:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso14013117pjb.1;
        Sun, 01 May 2022 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIcjCIE+821m+IWtooO9mfLI7f6RDT26Z08POJoaqYU=;
        b=WBrrUvpQr+8M2uys/q8rKRcOBjJ/BHWVt7WZMK2alpYC+3R0u9Nh0Cfr3SDjhc8uwZ
         RXDxHNvWTtOmjbcFjeJcFAps4wYAhZ9NShQ+ZrQYZu0F5DfdQUj/NEjzHHVeKar8Bg7f
         6ZSFlv8rXCd3+axM78i+BIZibLX2eNevQNEVoif01K7iiSWAgNrS8Lrfw+MzyqJcgSuL
         KjGh8PWSNq2l2eHkquFQnU4bAsiM5jOMHxC+L4WGcngNcTK22F7F187ABrieKB0Of28t
         3ZygR3NXScMN+hZG2xKnblt1qVolPALWgif3BXl1cmIfC4reMEbnYKN3bQhZw77fMMje
         zg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIcjCIE+821m+IWtooO9mfLI7f6RDT26Z08POJoaqYU=;
        b=MgbAbhTpAJJprLQiFvtwrGVo6dOCLUXMEbSPPeC+vQGXpifDs8tv1OFsp+aB48PCwt
         cP8iUNUZboLwUXk6CxbMOyQnZjAP1Y8Z/tKtOAFtaMXMQSR/ktFbdI0L/uSxbTqd6Tbe
         Bysarvho/GaJlh66UjzSSeuplnNHibB/XZbEJw3w6M8NIURhI2XQLFkMiOg11Vx6doRt
         BXWw2BfoyGfSBZeQme0WnkF1npljM5/JmEOyVMN631HIOMZgz7+o4vuWSE19dgDH3rUq
         8o8UqK1UgstUmLYwJJ+fuvs1HbmuCrCCdJsYyxuvj5CMrn5T3jG7WCDbGDda0IwWd0Jz
         rrPg==
X-Gm-Message-State: AOAM533q0ewWk0VL43WAcdlkt3hDPulfXwarF11+u1IrXw4QJ/YXz59I
        dIZXlLvfxnZJh7AIv8ucIVw=
X-Google-Smtp-Source: ABdhPJx6vbu/y4WRqtx+l8hEQqtX3dIhG1q+B9OQhBo0sDUN5GZeqT/00FPhX85+RqXmm9j2EjRHRQ==
X-Received: by 2002:a17:902:a714:b0:154:6dfe:bba9 with SMTP id w20-20020a170902a71400b001546dfebba9mr7060966plq.124.1651400582690;
        Sun, 01 May 2022 03:23:02 -0700 (PDT)
Received: from localhost.localdomain (164.174.128.101.dy.bbexcite.jp. [101.128.174.164])
        by smtp.gmail.com with ESMTPSA id n15-20020a17090a928f00b001d903861194sm17606060pjo.30.2022.05.01.03.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 03:23:01 -0700 (PDT)
From:   Kosuke Fujimoto <fujimotokosuke0@gmail.com>
To:     shibata@linuxfoundation.org
Cc:     Kosuke Fujimoto <fujimotokosuke0@gmail.com>, corbet@lwn.net,
        akiyks@gmail.com, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5]     docs/trans/ja_JP/howto: Don't mention specific kernel versions
Date:   Sun,  1 May 2022 19:22:56 +0900
Message-Id: <20220501102256.6379-1-fujimotokosuke0@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
    V2: Reformatted commit log message (Yokosawa-san)
    V3: Updated some expressions (Shibata-san)
    - added "version number" in mainline tree section
    - updated from "stable kernel" to "stable tree"
    V4: Added reviewed by tag and removed extra characters (Yokosawa-san)
  　V5: Removed an extra character (Shibata-san)
---
 Documentation/translations/ja_JP/howto.rst | 44 +++++++++++-----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/Documentation/translations/ja_JP/howto.rst b/Documentation/translations/ja_JP/howto.rst
index d667f9d8a02a..38fed6fe62fe 100644
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
+ラインにマージされるか、おおまかな展望を提供します。
+linux-next の実行テストを行う冒険好きなテスターは大いに歓迎されます。
 
 バグレポート
 -------------
-- 
2.25.1

