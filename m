Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04EA4CF1ED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiCGGf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiCGGf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:35:27 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17771409D;
        Sun,  6 Mar 2022 22:34:33 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id s11so12842219pfu.13;
        Sun, 06 Mar 2022 22:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Al0YeHlSZcSS4QCKRtFyAOPKrqPPjHztCvNSPqTvt8k=;
        b=lbFEXIgx3/FZzJ6Bpq6H23qkCE3wi0vEbHqKjS2245Rcdtk8FpXGyf/reYE1SG3o1l
         0gRmwxX+DGtWdcexzqQ0GiM1h81JP+jUIce0qrJTWhiwW6c1taOwb9KUGiHWsTtWdzym
         I97btsyrc3yLMNuWfdQ/rMmk4U1lZk/gR2NhvrV/ifpXhjZSgniJS6QST/sizaapVCSS
         KWGMmJJxCdIaVwVabncL2obmZAh0O7dvSUOkhdeVZRGZLJkLSPBhfzS6X1orrtRPpXjk
         JgWTLQHw2T+gAcAIQ9FK+UPFHkxGYwlbtVjC3BHYxUqpLgyr5vi6uBCQk2bkoERUZSu6
         Rkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Al0YeHlSZcSS4QCKRtFyAOPKrqPPjHztCvNSPqTvt8k=;
        b=S99Gr3sp1V0IEOGvJujUHAhyeqkfQg2R2RessohLuJQk82mexsb2w0ALOwWUsh7N49
         WrWABxiFJyOEGrm45KQkCh1hR0v3e8GQb4masYQc15hRU5LLMVbps1p5QB6IHX30DVmi
         Ukb8t4JEYfCfqsLwaWgXb6qC2DT7oiXSx5Q+2fSHmNHtAivPcxLvVUs03mUWazLnS3iC
         kPoKTlSZsV20rKrx8aEcE6j9TzfTKEW+hsFj16aCV/LkXKyf3vFfpw7feFkktQrNDJSc
         JUcR9t4AUvL1ClTvkUl2QK88Fqkzx4OUyGWm9t8efbOPTayy5kbV49P1FUkmMyuNtVia
         qR+w==
X-Gm-Message-State: AOAM530JZycgfqIZsy8042LAIhX6A08qKU4rYQTUOWj/i9/+6cw/4GUk
        S/6caP233xoiMo4npow09cB7q3hNBC8=
X-Google-Smtp-Source: ABdhPJz591+WWFKk5GdiNQr6RztVHEiWiiMANV9V95huqFPq+a3Wi2PBZzzvhNPCQbeFmQJag+hWNg==
X-Received: by 2002:a63:7c5c:0:b0:380:7412:341b with SMTP id l28-20020a637c5c000000b003807412341bmr172282pgn.38.1646634872466;
        Sun, 06 Mar 2022 22:34:32 -0800 (PST)
Received: from ubuntu.mate (subs02-180-214-232-81.three.co.id. [180.214.232.81])
        by smtp.gmail.com with ESMTPSA id x1-20020a637c01000000b0038007eeee0bsm4834288pgc.22.2022.03.06.22.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 22:34:31 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: describe how to apply incremental stable patches
Date:   Mon,  7 Mar 2022 13:33:41 +0700
Message-Id: <20220307063340.256671-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The applying patches document
(Documentation/process/applying-patches.rst) mentions incremental stable
patches, but there is no example of how to apply them. Describe the
process.

While at it, remove note about incremental patches and move the external
link of 5.x.y incremental patches to "Where can I download patches?"
section.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/process/applying-patches.rst | 28 ++++++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/process/applying-patches.rst b/Documentation/process/applying-patches.rst
index c2121c1e55d..c269f5e1a0a 100644
--- a/Documentation/process/applying-patches.rst
+++ b/Documentation/process/applying-patches.rst
@@ -249,6 +249,10 @@ The 5.x.y (-stable) and 5.x patches live at
 
 	https://www.kernel.org/pub/linux/kernel/v5.x/
 
+The 5.x.y incremental patches live at
+
+	https://www.kernel.org/pub/linux/kernel/v5.x/incr/
+
 The -rc patches are not stored on the webserver but are generated on
 demand from git tags such as
 
@@ -308,12 +312,11 @@ versions.
 If no 5.x.y kernel is available, then the highest numbered 5.x kernel is
 the current stable kernel.
 
-.. note::
+The -stable team provides normal as well as incremental patches. Below is
+how to apply these patches.
 
- The -stable team usually do make incremental patches available as well
- as patches against the latest mainline release, but I only cover the
- non-incremental ones below. The incremental ones can be found at
- https://www.kernel.org/pub/linux/kernel/v5.x/incr/
+Normal patches
+~~~~~~~~~~~~~~
 
 These patches are not incremental, meaning that for example the 5.7.3
 patch does not apply on top of the 5.7.2 kernel source, but rather on top
@@ -331,6 +334,21 @@ Here's a small example::
 	$ cd ..
 	$ mv linux-5.7.2 linux-5.7.3	# rename the kernel source dir
 
+Incremental patches
+~~~~~~~~~~~~~~~~~~~
+
+Incremental patches are different: instead of being applied on top
+of base 5.x kernel, they are applied on top of previous stable kernel
+(5.x.y-1).
+
+Here's the example to apply these::
+
+	$ cd ~/linux-5.7.2		# change to the kernel source dir
+	$ patch -p1 < ../patch-5.7.2-3	# apply the new 5.7.3 patch
+	$ cd ..
+	$ mv linux-5.7.2 linux-5.7.3	# rename the kernel source dir
+
+
 The -rc kernels
 ===============
 

base-commit: ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2
-- 
An old man doll... just what I always wanted! - Clara

