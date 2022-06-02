Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AEF53B44F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiFBH1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiFBH1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:27:51 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBD529FE6C;
        Thu,  2 Jun 2022 00:27:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g205so4022551pfb.11;
        Thu, 02 Jun 2022 00:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dO8F4huKrg7HK40w6R+II0EDqtahfzCwucyNeG/6yhE=;
        b=YbmlsAf5cKN+CIdt4ksyeiFsXj0EO16r04pJvRYTBKJYl61jvLfDPpgpGksmXE6pna
         f0o9KsvP7NHWOUk3Me3mfFvf89XjY/S+STrfm10JmnFCI8kJdybbtZGmP7v0QqyXOvec
         /b3p05S/iWQNhtPipEU3TFT8HplJgJtc8UaN9lMK4BIhSD6WSw73oa0z82tkxZQEiDtp
         VmNI88iAEOPDH7L0GG78ABi26dMu5+TROVORxgoYoCMbFyveOI6jW1eBZoNAW0umuoG8
         7mT7ZOkcL4pfHlESth8wdpUw5eoe2Kkl2Ac/EZ0AaEsqX8SotY9JRn8hmEzfUrRoDf49
         y/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dO8F4huKrg7HK40w6R+II0EDqtahfzCwucyNeG/6yhE=;
        b=r0WPwzDZENiT5NqF0Z6ctHI+V2ONG6onaTY+BOVBR48lE6aH1z8S2etVFK5E8hDTKX
         tlR3GCE0fYTij9aqy3lTu9eNBS4j+6pDDs9Kay3XaTEtNCCZwlBhkQ4/Szt39mt6mYYO
         FCILQ/qOtNuHT66BnIaP7h0KAdYiq/nq4cHnt3t/zs3W8qK8YiF+KM9S9A24Qddgz/B2
         5Ouul8lGm3i6iO0fBTjYr9cKb7ttTltzVuqZGjEjEP466wq5HavR1KwjimbN+2xlcefg
         2agwE0kiNwjrt8vj/nGz9jGZjYkDWLLH8rAxZIKh+ZQH2VGB5RQkwOp3W2WyZmXC1nho
         twng==
X-Gm-Message-State: AOAM533vsVj+FJ2FcbZYVotUHRnbt7/jq7tIyHWFmF417H7MVCqFsW7w
        ncJWn5pmKAEUJY8qtiRmdw8=
X-Google-Smtp-Source: ABdhPJxSXbdQaUbjNS/QdVvu+sLCgGBWTdnUUVvw1xqzChxB+sM8bBLz7d44zgYoS4w2B8l5C/3ElQ==
X-Received: by 2002:a63:114d:0:b0:3fc:cfa3:52f0 with SMTP id 13-20020a63114d000000b003fccfa352f0mr2978866pgr.243.1654154869625;
        Thu, 02 Jun 2022 00:27:49 -0700 (PDT)
Received: from localhost.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id c7-20020aa79527000000b0050dc76281ecsm2705091pfp.198.2022.06.02.00.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 00:27:48 -0700 (PDT)
From:   Chao Liu <chaoliu719@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: [PATCH] docs: filesystems: f2fs: fix description about compress ioctl
Date:   Thu,  2 Jun 2022 15:25:40 +0800
Message-Id: <20220602072540.998638-1-chaoliu719@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

From: Chao Liu <liuchao@coolpad.com>

Since commit c61404153eb6 ("f2fs: introduce FI_COMPRESS_RELEASED
instead of using IMMUTABLE bit"), we no longer use the IMMUTABLE
bit to prevent writing data for compression. Let's correct the
corresponding documentation.

BTW, this patch fixes some alignment issues in the compress
metadata layout.

Signed-off-by: Chao Liu <liuchao@coolpad.com>
---
 Documentation/filesystems/f2fs.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index ad8dc8c040a2..98dc24f5c6f0 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -818,10 +818,11 @@ Compression implementation
   Instead, the main goal is to reduce data writes to flash disk as much as
   possible, resulting in extending disk life time as well as relaxing IO
   congestion. Alternatively, we've added ioctl(F2FS_IOC_RELEASE_COMPRESS_BLOCKS)
-  interface to reclaim compressed space and show it to user after putting the
-  immutable bit. Immutable bit, after release, it doesn't allow writing/mmaping
-  on the file, until reserving compressed space via
-  ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or truncating filesize to zero.
+  interface to reclaim compressed space and show it to user after setting a
+  special flag to the inode. Once the compressed space is released, the flag
+  will block writing data to the file until either the compressed space is
+  reserved via ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or the file size is
+  truncated to zero.
 
 Compress metadata layout::
 
@@ -830,12 +831,12 @@ Compress metadata layout::
 		| cluster 1 | cluster 2 | ......... | cluster N |
 		+-----------------------------------------------+
 		.           .                       .           .
-	.                       .                .                      .
+	  .                      .                .                      .
     .         Compressed Cluster       .        .        Normal Cluster            .
     +----------+---------+---------+---------+  +---------+---------+---------+---------+
     |compr flag| block 1 | block 2 | block 3 |  | block 1 | block 2 | block 3 | block 4 |
     +----------+---------+---------+---------+  +---------+---------+---------+---------+
-	    .                             .
+	       .                             .
 	    .                                           .
 	.                                                           .
 	+-------------+-------------+----------+----------------------------+
-- 
2.36.1

