Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1DD51828C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiECKvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiECKvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:51:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F998252BB;
        Tue,  3 May 2022 03:48:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d22so4442886plr.9;
        Tue, 03 May 2022 03:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCutMOU7tFkTVUJAgwrZTxo+r32SFj+LA9q/0ParFkE=;
        b=ipjee0thjs3h8ayFjPq9f47SPA6n7u6CfROJco0Cqvr7Ti2LqJKXDx7aqC3/WOYUGs
         juP1yaMmMKWxVbz+4dgPmV22GJKgI1wJwqf05lMJoXYn56+S+YVrfaQpdHhKPTt+HNbR
         jvVFIOisAF2nbabzq2Pys/xvI7muXGc7cSokoII1ZhJCDKFLhazyOUUjmeZI5DfwQajj
         /CvBmAcUu4Aq1whibvFeH7MEJGSb2c89VtRjaeKB3E67iiFpJfLut1aaFaAPPNu0/gFZ
         Nnk0IefNfiSYv5ebCv8ishS/AE3IHgdFDhqxb/3ISWwIYJhldE4xon2mCWB39ziJY3Rh
         M1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCutMOU7tFkTVUJAgwrZTxo+r32SFj+LA9q/0ParFkE=;
        b=FsTt696WOcQs6qX6NlxWYo5Xm04PobiZUaxIskYGX600k+GJtydfQn7OJand8ru0rp
         OX5/dC64/YwwMGUVCAeBSrVbd0nMcaJErITZ8WUhTrMOC62u0NZLEKYWSpQKXrSAeODu
         MfEcsLzEO/djUORwsnYfLjt0ncefTtvJCAE/U7x4vhRnP5Hv0MxfLTmOLdOq+FZc/gTL
         LmaJYacrG9FmfaL73AAtb6bWxD90qtsKVtMi3hVHNZevKoajsm924Cr1demXOtHHNB5p
         O2MI8BCGsjFcNdHHSTzVsngJjhleUdEVn8HPMFybkoQNkaRc36IE2jNOgrMoCi4ATFB3
         BpPw==
X-Gm-Message-State: AOAM531HfkNVQj1LGc5sbUlB/pCGWwg+zGEIyWiDsmMspOmFlcESp4Mg
        yyNPis1AKwb6wAqosMGpa5U=
X-Google-Smtp-Source: ABdhPJxT1Xe5fscZcg5UV+n7fJr627FqwcFcA64+3cOOhb8hG2Dm6h42OissBedtfcv7mJeNOBFeXw==
X-Received: by 2002:a17:90b:1c8e:b0:1bf:364c:dd7a with SMTP id oo14-20020a17090b1c8e00b001bf364cdd7amr3866678pjb.103.1651574886205;
        Tue, 03 May 2022 03:48:06 -0700 (PDT)
Received: from localhost.localdomain (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id v35-20020a634823000000b003c14af50633sm7199249pga.75.2022.05.03.03.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:48:05 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] docs/ja_JP/SubmittingPatches: Add Suggested-by as a standard signature
Date:   Tue,  3 May 2022 19:47:57 +0900
Message-Id: <20220503104757.49208-1-akiyks@gmail.com>
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

Reflect changes made in commit 8543ae1296f6 ("checkpatch: add
Suggested-by as a standard signature").

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
Cc: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/translations/ja_JP/SubmittingPatches | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index d3b16bd7fcc6..805886a695c8 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -399,7 +399,7 @@ Acked-by: が必ずしもパッチ全体の承認を示しているわけでは
 このタグはパッチに関心があると思われる人達がそのパッチの議論に含まれていたこと
 を明文化します。
 
-14) Reported-by と Tested-by: と Reviewed-by: の利用
+14) Reported-by:, Tested-by:, Reviewed-by: および Suggested-by: の利用
 
 他の誰かによって報告された問題を修正するパッチであれば、問題報告者という寄与を
 クレジットするために、Reported-by: タグを追加することを検討してください。
@@ -448,6 +448,13 @@ Reviewd-by タグはそのパッチがカーネルに対して適切な修正で
 レビューを実施したレビューアによって提供される時、Reviewed-by: タグがあなたの
 パッチをカーネルにマージする可能性を高めるでしょう。
 
+Suggested-by: タグは、パッチのアイデアがその人からの提案に基づくものである
+ことを示し、アイデアの提供をクレジットするものです。提案者の明示的な許可が
+ない場合、特にそのアイデアが公開のフォーラムで示されていない場合には、この
+タグをつけないように注意してください。とはいえ、アイデアの提供者をこつこつ
+クレジットしていけば、望むらくはその人たちが将来別の機会に再度力を貸す気に
+なってくれるかもしれません。
+
 15) 標準的なパッチのフォーマット
 
 標準的なパッチのサブジェクトは以下のとおりです。
-- 
2.25.1

