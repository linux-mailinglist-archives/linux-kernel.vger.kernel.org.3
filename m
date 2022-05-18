Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA9352B4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiERI1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbiERI1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:27:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEE7E277F;
        Wed, 18 May 2022 01:27:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gg20so1327306pjb.1;
        Wed, 18 May 2022 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6uhcCD9Q9c+zxCoqwp1SKWrlds09Ui+hTejJMadUYQ8=;
        b=knwLeeGs2uTSf5TwdhIm5ljqftyq1jOVfMGjDCVCBvz+83z5bXFaX8traenYQKYQ8C
         brZkSLz9KC2b8krw58NkVoJw7Ud89iYQwNAzPkIkOaQktOoSYrP6j4rCZhGuWN8TxEgN
         ramS9v19nXbCk8S71Wts7wJEb9/2SrRWIpcr/0kCAGD3cFI3+/6f26O729X1Jvv3O6c/
         errWLCITazNz03uyIZJu3618L0T9aO6RxfqzsuLLL3JSWeS+K80KJAvYlXERe1U787PE
         UJ7F/Mxg69KsqzhDiUwXkBXCrIplFXzYI3RGlELI/deqFj874rIBdROFxc2c0uUqVqxD
         vyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6uhcCD9Q9c+zxCoqwp1SKWrlds09Ui+hTejJMadUYQ8=;
        b=yDdSXrpKZVV9TMkXSGgKPdVhxB2WhxxTfm7/QDdNqkO4oetzljGburtAuASaJ7gkDD
         wtPK74GCJH5b62pYNz5j0pkEL6RQgEH0w/olDAgf2jp7wRyjLlToFVbDkv4VSo9/Ky6M
         FG+W6Xo9Ks3znO6sWOg7LAOVXtPHGb9yOgAfrElBi0o2TFgxdMAvBDMd4pxLNVM+3VxU
         2bIYS3lUyB3FEJDxO4rPxxxY+9Za1+f1uWFQX60XjqJg5rg30eW+Auv0fWWUxNTrAEh5
         ssLwuzV1r+EyBZZ/pYJ9zB/sgm9/lP0XP5cwL5McaS6el12gBFFMjCuSvqf0UdubTGuF
         Tbgg==
X-Gm-Message-State: AOAM530r8VASqmGkBjZy+Npjo98ZzL8gdO3EZzFxTuYznwmMzCECl/Dn
        Fmwrdrlh9W99YnmKPY9WsgI=
X-Google-Smtp-Source: ABdhPJzNcgMOvUnJ/r2cIpDRhf/x+W2Y7fPUMs3R1jptn1Ppwt0PjAo2/lB6RnG7YaR7+yNBtgjoxA==
X-Received: by 2002:a17:902:7781:b0:161:c85a:8fff with SMTP id o1-20020a170902778100b00161c85a8fffmr1444679pll.97.1652862424843;
        Wed, 18 May 2022 01:27:04 -0700 (PDT)
Received: from ip-172-31-7-97.ap-south-1.compute.internal (ec2-15-207-112-74.ap-south-1.compute.amazonaws.com. [15.207.112.74])
        by smtp.gmail.com with ESMTPSA id s26-20020a056a001c5a00b005180ea859d7sm1206643pfw.123.2022.05.18.01.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 01:27:04 -0700 (PDT)
From:   Praghadeesh T K S <praghadeeshthevendria@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "GitAuthor: Praghadeesh T K S" <praghadeeshthevendria@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org, praghadeeshtks@zohomail.in
Subject: [PATCH] Fixed 'make htmldocs' warning: Documentation/admin-guide/perf/hisi-pcie-pmu.rst: WARNING: document isn't included in any toctree
Date:   Wed, 18 May 2022 08:26:27 +0000
Message-Id: <20220518082627.9144-1-praghadeeshthevendria@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Cc: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Praghadeesh T K S <praghadeeshthevendria@gmail.com>
---
 Documentation/admin-guide/perf/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 5a8f252..69b23f0 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -8,6 +8,7 @@ Performance monitor support
    :maxdepth: 1
 
    hisi-pmu
+   hisi-pcie-pmu
    imx-ddr
    qcom_l2_pmu
    qcom_l3_pmu
-- 
2.34.1

