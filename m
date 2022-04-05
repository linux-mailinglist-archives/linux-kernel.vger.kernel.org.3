Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511D24F4E50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588757AbiDFARO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382821AbiDEMRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:17:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F4CA995D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 04:29:35 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g24so16670185lja.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 04:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7Dz2SM4siYuIwun2XwY0DhLNucqTdTNXSHP2yr5LeM=;
        b=LOZVvXl9gGJ+RVI+ER6bknQlWcr4u1GnvrXJnh2Co/+eTsN7luh1C3Ee0mUUk7al2r
         t2m4jmv1poxLlbvcPQalpmOl6QF6PZToWLJzEGtxHUHUOow0QixXBBqXN+q6MnnViKK1
         XsrjEDIsj6GfB6OliOuv4Rt2ysL2QpB9/AcGir/3uX5+WhOM24y3lF/ICwjrems7FBS9
         NfbOV0Uhv2sP0RxDI3KP2NwHlJNaSJpB8NVxC8piuaUGbuue6AyRmiEXGFL8bVaufne+
         amNRUjuaCjpTKyTg5WYFGebmAsAk7hpgWJ1iGlXqR6cS7m5MTvQ5/xyYtM497wTWJat3
         RujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=b7Dz2SM4siYuIwun2XwY0DhLNucqTdTNXSHP2yr5LeM=;
        b=7/K0bJmchZyJiL1sJukh+9qGqHNf1r7Kph3Nkj6t/z9IwoOQPwI83QbQnuJlV9HBrx
         rpfmtGPoMofWYKyLW8nulin0Y7mikQyP7xW9FdxM15XVeAq75NgJqBv6Ngl+a9Rsqiwj
         13I7ofM12ZK8rVUWRDqK4UaGTkLCKyAyMw4MqLVvBPZXyIhGmauPsFc1I15keGoxq5SU
         ZCzJwnTs6YEEWmv6CLjmDBpqj9XxJAhVwewLXELeBF/3QCduUI0uZ7vnIOiSvToBJhW9
         VGBgMuKvu08Bdt/XQ5yZ1MVN4aqK5yt4NHVEDD8hoJwOxsbV9/pFZw5Z5+jzWCiWkV6+
         flaw==
X-Gm-Message-State: AOAM532lb13YH7I7sxE8DAGqDvSidkT4c4vlbkdredv4ZW7CwHIrO5E5
        9p6oMnh/pZyER4MThPM60GfWcI8PoUI=
X-Google-Smtp-Source: ABdhPJwglmhlytZL6pt8DIvGFjc+vbkjL17UA6JUrkyOQV1Hp23dghj+SmtXzqlQgSqw6XJ9RjxJJw==
X-Received: by 2002:a2e:150d:0:b0:24b:30d:dae with SMTP id s13-20020a2e150d000000b0024b030d0daemr1822212ljd.23.1649158174017;
        Tue, 05 Apr 2022 04:29:34 -0700 (PDT)
Received: from uncleman.upcloud.com (dyjc2gkmpr6qcv38v66ry-4.rev.dnainternet.fi. [2001:14bb:1c5:62a1:4c76:9a28:df91:d69c])
        by smtp.gmail.com with ESMTPSA id v6-20020a2ea446000000b0024b0abb3984sm1093423ljn.134.2022.04.05.04.29.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 04:29:33 -0700 (PDT)
Sender: =?UTF-8?Q?Ville_Skytt=C3=A4?= <vskytta@gmail.com>
From:   "=?UTF-8?q?Ville=20Skytt=C3=A4?=" <ville.skytta@iki.fi>
X-Google-Original-From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@upcloud.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] docs/kernel-parameters: Note nopku AMD applicability
Date:   Tue,  5 Apr 2022 14:29:32 +0300
Message-Id: <20220405112932.416098-1-ville.skytta@upcloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pku is no longer Intel specific.

Signed-off-by: Ville Skyttä <ville.skytta@upcloud.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..d227539c52fe 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1120,7 +1120,7 @@
 			for details.
 
 	nopku		[X86] Disable Memory Protection Keys CPU feature found
-			in some Intel CPUs.
+			in some Intel and AMD CPUs.
 
 	<module>.async_probe [KNL]
 			Enable asynchronous probe on this module.
-- 
2.25.1

