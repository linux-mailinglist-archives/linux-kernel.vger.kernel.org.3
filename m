Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4311D51828B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiECKvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiECKvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:51:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5B224589;
        Tue,  3 May 2022 03:47:15 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 7so9839754pga.12;
        Tue, 03 May 2022 03:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aG/aVj/0In7nlCfbR9Z9KrTZBBSD3p1SNhXLiwsJA/g=;
        b=GpO8rnAR/dME4iamMQ8zzAZCRWBqhDhX5g7aSNqljX3bWS9BvCtq9sxh5vCRjMeBi1
         mTgqn3Thn5ihldNIF0S/J+qeA3MoaNzZNcOYFHa5xKD2KXK+EAe0b+ZnoIxqqdpk78ng
         jJPcJAPE6AFE9p0MEMDppLe8bolez3YdyEIRSmQJfqzkiE/fzsb6v2lJhAlJhM6/GdOu
         nS1mzgNIrh252QunHXrwmrWGeEiY7fXEYugE/pCvn5KtZyGob/KPaEOCZd3QTUIflmUg
         UiP6LPTb2lHvbaHsXEWzXG2VbrtKEuuxGKtd+6ZTO4M2BK3ZKMChsZysjrXUODucZkzj
         J9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aG/aVj/0In7nlCfbR9Z9KrTZBBSD3p1SNhXLiwsJA/g=;
        b=QX7I3Cp7WfK0Wm1S3QadGw7ftBslITpCzvsg6cR+u8NIWjFO7mvZglJXNaKjwVyV1s
         qpdDKXoOUNazAIml5wkDfCSWoug5r13ZD0+VCuLcU6qtZ/hotGga8eBUyoQrnQBY99L/
         D2H2gyOVDCJMm4nqnAX009Huek2h5zUCUklBTkKov5Gsedvl4jOwFbmsK7MpHrOaKfMw
         vDWiMbUuukOPWDo1CuJEFQdxzjKLthqZX39VOKrv8kDgJMtnAkS/LgamYgEY8p1JfsYG
         U+WS3ctxD5kc0jgaxQ5Es6WHM8syXhwonjDavJ62gPgWEhf7I6eIlHdfdzCJQt3haLvd
         BB+g==
X-Gm-Message-State: AOAM530/54vTkeM56C+CYZShkLFwLmQwj7AV8avDzUTcZJV69a0G43rD
        xn5DGYODz1aI+y7Nak3uFhfRgoXpHzw=
X-Google-Smtp-Source: ABdhPJy36XDIH1tWs8mU1C2Sy4+ydHmo/gCupYIDbBQ3hofF2PO26jlJlwoOqQJpoLaGt5MIAFoH8Q==
X-Received: by 2002:aa7:84cf:0:b0:50d:d25a:5d37 with SMTP id x15-20020aa784cf000000b0050dd25a5d37mr13741177pfn.84.1651574835041;
        Tue, 03 May 2022 03:47:15 -0700 (PDT)
Received: from localhost.localdomain (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78295000000b0050dc76281b7sm6270533pfm.145.2022.05.03.03.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:47:14 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] docs/ja_JP/SubmittingPatches: Suggest the use of scripts/get_maintainer.pl
Date:   Tue,  3 May 2022 19:46:50 +0900
Message-Id: <20220503104650.49068-1-akiyks@gmail.com>
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

Reflect changes made in commit e52d2e1f25f0
("Documentation/SubmittingPatches: suggested the use of
scripts/get_maintainer.pl").

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
Cc: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/translations/ja_JP/SubmittingPatches | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index c986d925de51..230e62401c78 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -162,7 +162,8 @@ http://savannah.nongnu.org/projects/quilt
 
 MAINTAINERS ファイルとソースコードに目を通してください。そして、その変
 更がメンテナのいる特定のサブシステムに加えられるものであることが分か
-れば、その人に電子メールを送ってください。
+れば、その人に電子メールを送ってください。その際
+./scripts/get_maintainers.pl のスクリプトが有用です。
 
 もし、メンテナが載っていなかったり、メンテナからの応答がないなら、
 LKML ( linux-kernel@vger.kernel.org )へパッチを送ってください。ほとんど
-- 
2.25.1

