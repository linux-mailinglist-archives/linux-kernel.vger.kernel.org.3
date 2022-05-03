Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902F3518281
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiECKuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiECKt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:49:56 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2651E3ED;
        Tue,  3 May 2022 03:46:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o69so13612115pjo.3;
        Tue, 03 May 2022 03:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uv29XzlfJotxtpA2xDWU9p+9n0jURpOMge0Zxy9CFQ=;
        b=NGd8BS+q7B8v3GbSUsa00znrn/4O1l0MGv9SzYs6ausuBzmcDsIj9xzsVveUi6eLxU
         5/Azu310vYWRnZvlSE5Hx6dalPb0TY0v9ojqYyQkafSlcpLf9Sc2S/75EnlMk5Vld6RB
         XtjDg5rkmpN+4mfPW2C7v6MeauNXdCM5Lfxc8ZyaAq0GJ7+0dQFVyAW7l/s96Kjkfjjs
         uY52pTLkgv5utHV9GVJ4WHt+IscPoR72pw+Z1sZNpgeHYf4yCayELJgxY3jEdLFKyX0v
         By7QTN1CtRoVkpjxMdwMtOIC2YJwOSdEVYXzcFPdflu/rX9iHP1cHYuZ8SnV2ZHUeiTp
         cGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uv29XzlfJotxtpA2xDWU9p+9n0jURpOMge0Zxy9CFQ=;
        b=N+c7V0dCbd3EBBAwznsmhu2HRnelToBWD/Ogk3gM3/3EAX9pKBX4pfEpf4fZ+DOFZD
         412UCgB1YVeePY+b1fL1LwnH1zxvamNTDxiSnVFCv25x1udzvksgMK419aR5y4Hi4kPQ
         U6PuBdsDkT+c99UOLRA5qFq9lFBRE+aHuDQXkwQtaqizuQZCghc8ERyonEyFKgjdgqsn
         LbVCbJB1IzptAwJxRKZ1hBjJjR64LsXlT+mDXvWsCtOSTDEcI4uBx8QXFGUiOBR0DeLA
         eYCz6k16lteNzHCZAc7bVVM2TFabsnXoWA1xA06NgZQDnB0MTa8b0oUYWvxPda8+eoSo
         8p2Q==
X-Gm-Message-State: AOAM53168G29SyHamWdkPNeHNryXqJu/wtbpcLaasTNQD08aEcrNw/4L
        YddLswSq6XOfknABXum5pMlgr/VXFIQ=
X-Google-Smtp-Source: ABdhPJxou7TVqai248MMrhvQiF8ZR8tB1frIze9Hj5mIuhQiu9xb895IsbibbpRCGsOfKiwnV/NorQ==
X-Received: by 2002:a17:902:d510:b0:15e:afc4:85a0 with SMTP id b16-20020a170902d51000b0015eafc485a0mr5811446plg.64.1651574783560;
        Tue, 03 May 2022 03:46:23 -0700 (PDT)
Received: from localhost.localdomain (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k11-20020aa792cb000000b0050dc762812bsm6035769pfa.5.2022.05.03.03.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:46:22 -0700 (PDT)
From:   Akira Yokosawa <akiyks@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] docs/ja_JP/SubmittingPatches: Update GregKH links
Date:   Tue,  3 May 2022 19:46:13 +0900
Message-Id: <20220503104613.49001-1-akiyks@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503102429.48304-1-akiyks@gmail.com>
References: <20220503102429.48304-1-akiyks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reflect changes made in commit f5039935ac68 ("Documentation: update
GregKH links").

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
Cc: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/translations/ja_JP/SubmittingPatches | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/translations/ja_JP/SubmittingPatches b/Documentation/translations/ja_JP/SubmittingPatches
index 0d308edef781..c986d925de51 100644
--- a/Documentation/translations/ja_JP/SubmittingPatches
+++ b/Documentation/translations/ja_JP/SubmittingPatches
@@ -681,10 +681,11 @@ Jeff Garzik, "Linux kernel patch submission format".
   <https://web.archive.org/web/20180829112450/http://linux.yyz.us/patch-format.html>
 
 Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
-  <http://www.kroah.com/log/2005/03/31/>
-  <http://www.kroah.com/log/2005/07/08/>
-  <http://www.kroah.com/log/2005/10/19/>
-  <http://www.kroah.com/log/2006/01/11/>
+  <http://www.kroah.com/log/linux/maintainer.html>
+  <http://www.kroah.com/log/linux/maintainer-02.html>
+  <http://www.kroah.com/log/linux/maintainer-03.html>
+  <http://www.kroah.com/log/linux/maintainer-04.html>
+  <http://www.kroah.com/log/linux/maintainer-05.html>
 
 NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
   <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
-- 
2.25.1

