Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2D347A49F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 06:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhLTFhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 00:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhLTFhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 00:37:17 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58948C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 21:37:17 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id 8so8783741qtx.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 21:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHAFcs23FVd+LLKCG5BENoMpJ5aSln69iW1WacMxcaI=;
        b=RDaodyT/b/rrB5FcPWYPDpy8BAjvmRsX9zZu3Fik9S4mXNF94N+xbEOgNHir8bt0PN
         /2JuVGlk8W25rFP0mgxEukIa37P7uRfOIPd2tbP/ENA7rKg15JS8ec9+sN1nkeLEQLLP
         xpFLDfl/5RITOro1fwqM0E9d+HDcFeBu80iKvprljrLeJ3uYoXCOO+27ggFdko46Lm2Y
         dtl+XX+HZ9nBOvaD9buxrK1Yl/cfV/S5xYfZLJw/1edP2E9p0Ejf1ZpDAtWm/o0+sFCT
         8BltCsfNdrOX5qbTEE8nK3PRAA7tainf9JxoLx3t9TMbv28o2tYdzvcTVsXaKeIeCBxV
         clmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHAFcs23FVd+LLKCG5BENoMpJ5aSln69iW1WacMxcaI=;
        b=dTQ9NVPUKCVntKnhgxO6LyBXyY14tlQYsTE/Th1AEea7ptBQTmjU/nS5+9QtoDRHBA
         J2NQegLWLhSkQAibsVtxJbRfX5wwi9+RKk/nxXiNEgrIFZT8MrighxJhKP3dC0U/W/0X
         6C89+7UiXb+e6RysLG2BfWdd3VtF4K33/DU+zqKGQfc2RbLVoZqkgvRo/1F6wQGpjKqk
         auUtzRIw1TsJ4xoK1eNSKOSBaYLT8FH+iVZIVjITVkYxq6inLL/+2Sg6zcNUH830uYxD
         a3m6Wshh/rjhgoHjYsC6xV7kvypZLg9SRDqLbGqfLdAd1xfRwj5s3xVJA2VbiiHvLMye
         0FlQ==
X-Gm-Message-State: AOAM533dzADCRf8cTwaj+o3ByFNledmO49iaSOrfs7clf2EzoM49MDep
        3grBnL+4+TFPfzAWVRXCAsA=
X-Google-Smtp-Source: ABdhPJxeze2edNWKSIb9+Qvy6UkIocmeNz6ZZf+6jQswz4khAzGrGC9O0QDpP1IYe567GLHOd2R5Jg==
X-Received: by 2002:ac8:4e56:: with SMTP id e22mr5342391qtw.72.1639978636462;
        Sun, 19 Dec 2021 21:37:16 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.98])
        by smtp.gmail.com with ESMTPSA id m9sm12562843qtn.73.2021.12.19.21.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 21:37:15 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     luc.vanoostenryck@gmail.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        corbet@lwn.net, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] Sparse: Remove dead url
Date:   Mon, 20 Dec 2021 11:04:21 +0530
Message-Id: <20211220053421.29848-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luc,

I stumble upon a dead URL on the user-facing page ,so took it away.


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index e29a5643849a..f96a67b16882 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -72,7 +72,6 @@ Bugs can also be reported and tracked via the `Linux kernel's bugzilla for spars
 Some interesting external documentation:

 * `Sparse: a look under the hood <https://lwn.net/Articles/689907/>`_
-* `Sparse: a short overview <https://sil2.osadl.org/events/ewc-2019-hands-on/sparse_slides.pdf>`_

 .. toctree::
    :caption: Development
--
2.32.0

