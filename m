Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FD518290
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiECKwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiECKv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:51:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DED2CCA0;
        Tue,  3 May 2022 03:48:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o69so13616059pjo.3;
        Tue, 03 May 2022 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Abr4UlrooN3pax2nlp6THLBEHfqsVYmDojKEITg6swo=;
        b=STW1MV702DpzWhJhKgrKjaJrQxGycNxqH8WkBhDhFTuS+F9yzpdZsZfwbBsCeEjEv4
         ST5i15lJKcDZek9MBNMDb2Kz1C03hHdpHWtvWVCfZ6zb+De+HPhVlLzy+MCQkVqzfjCS
         lihyqICf/Rwclh5DCmqgTNbRkovwlzEZKRFqcoh+C9xyDtXwMdWmFHPXGHY3c72ySkP1
         VCSLeO4ZmXVBRHM8nm8dK1N1oYrfWmEWAkBlzPmfefcJzbQ9qgN3JO8xkEo9AyEqQCVu
         tYq5s4xydECVzXJw4su92Oylv+6Qv1Klbx8MXc0MCv46n1UqK9aLh4wJOxwYBl57030l
         cwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Abr4UlrooN3pax2nlp6THLBEHfqsVYmDojKEITg6swo=;
        b=oHutVh0WxMlTdHKfE40s2ikJFKouPVETb9ks61sY0YNKtjG48g2mF4vpyyYqbN4cwt
         NW4sz/7fEJ+bqT9DQOzUklXDWFnqP6689zhnxGAItNqnSt6dXBJldc3tgkigTNmX+QoZ
         oqPibTigwUPINi1InK2BuPIGfhypTqSrQCaTO2wynGTJaL0IiLRnIjZD2/5sDvJtv3CC
         Oaz5b0Zxys14yxXAPv5KHLPW6Pn9bsWjEvf6eQT6uSM6cWUjpOcvmT+v6c3EGo8sc1bF
         aPl7eniDVqTOb/R4X3HeRsDKPS1krzWBJvmcu9Mgc/4bShszrPxZMfSwGRv6A3meDe/F
         plHA==
X-Gm-Message-State: AOAM531PtnKmDnaN/i2StzWG+BtqhcUd9ZR6FMrOwrsueg16GScbJAfx
        G4cFKmYPvKo73k77ik4y+fU=
X-Google-Smtp-Source: ABdhPJyMd4qGqrcWtjGq5APS6N8sv4T+zqWUTx78k4O9VQIc7RBRkpIWHAD1z4g+79jJA0F17KkCig==
X-Received: by 2002:a17:90b:33c5:b0:1dc:35c:9e2c with SMTP id lk5-20020a17090b33c500b001dc035c9e2cmr3947418pjb.163.1651574905714;
        Tue, 03 May 2022 03:48:25 -0700 (PDT)
Received: from localhost.localdomain (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d71300b0015ea9aabd19sm2971853ply.241.2022.05.03.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:48:25 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] docs/ja_JP/SubmittingPatches: Request summaries for commit references
Date:   Tue,  3 May 2022 19:48:20 +0900
Message-Id: <20220503104820.49269-1-akiyks@gmail.com>
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

Reflect changes made in commit 0af5270324cc
("Documentation/SubmittingPatches: Request summaries for commit
references").

Note: Translated paragraph uses a slightly different structure and
omit a redundant phrase so that they are easier to follow.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
Cc: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/translations/ja_JP/SubmittingPatches | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index 805886a695c8..66ce0d8b0526 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -123,6 +123,17 @@ http://savannah.nongnu.org/projects/quilt
 登録済みのバグエントリを修正するパッチであれば、そのバグエントリを示すバグ ID
 や URL を明記してください。
 
+特定のコミットを参照したい場合は、その SHA-1 ID だけでなく、一行サマリ
+も含めてください。それにより、それが何に関するコミットなのかがレビューする
+人にわかりやすくなります。
+例 (英文のママ):
+
+       Commit e21d2170f36602ae2708 ("video: remove unnecessary
+       platform_set_drvdata()") removed the unnecessary
+       platform_set_drvdata(), but left the variable "dev" unused,
+       delete it.
+
+
 3) パッチの分割
 
 意味のあるひとまとまりごとに変更を個々のパッチファイルに分けてください。
-- 
2.25.1

