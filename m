Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C931C547D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 04:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiFMCIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 22:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiFMCIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 22:08:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AE201B0;
        Sun, 12 Jun 2022 19:08:37 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2817381pjl.5;
        Sun, 12 Jun 2022 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+3pr9uOc2+xB/06ujAwee6065J1tqxQJUyenAY58NrY=;
        b=XLPFoFjeAFpIhjYc7RrxDgI1JQQcEA6qdwX654uAfMjDFJLTmESBCwnOMqHgfX0g+r
         LzgC/VYxpsUgjBFYHH/I2ubbNdEeHXZG4bthbrUpcX4Cr5QLW9Ck2zXqfROKCIO7acRO
         FS0lPxc74W/q+u0aFFyPk88zyg16grTaVKOTPLhEgQFjGvZLqY8jWCct0RCVIDvNk3jv
         9tK9vcKVcKvI1TG5775bl2f5zPxDNJqWzXzUrrypXsl/66d43PsN+pVO4tcI/2wKAmkX
         QbtmB0NDhE02JCksbm974cHWRJGr/6q8auFq+upwKRC4cqFimhRNeyQkIJdKXwEyj/yj
         UMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+3pr9uOc2+xB/06ujAwee6065J1tqxQJUyenAY58NrY=;
        b=hEOODaUBbnWRK6D3bxkQ32KtLO2gvyHGXtjN8CRIGZZHW2QIAQE7IOC/3AqgnAkPBw
         R1uUeDUIDnI/g6BTGl1rDmKjC8JyZ6wJqbadvTG5GhM9DXOZh8aUtQdlt0QGuEfpAKoY
         Tr1eMflWUjp4pJKinCApOErrPhlmAxr613PE8deWHynyQi5igoCLNWTuPhHN/vccd9ya
         KHxiyJQQnUPiXroX1iyt8S8n7OIf9Z4NbBEsPC3kh6GMWinBy+6kgVb+0ffCHuacriLC
         xnDSpclWQIZfQC4vb7VwuNxPYuHexHqDJaH51rAMvNGGFBaHDvXFbwlVVQs40pXOTX+1
         RysA==
X-Gm-Message-State: AOAM531vrOrCXEPzW79MHU67C43PagakKlBFs+uW3LVuC97AGSL0Nv2j
        iDrAkRtUw40p/ev6wqORzxM=
X-Google-Smtp-Source: ABdhPJwk9edjXzK1cRjyu7FIFuyGFeOmiuXy87Jlhm5MaGBv8fbIwrnZBH1j3UjyOkQETO3j1+Y+tw==
X-Received: by 2002:a17:902:e8d6:b0:161:ea52:cd52 with SMTP id v22-20020a170902e8d600b00161ea52cd52mr55528700plg.71.1655086117029;
        Sun, 12 Jun 2022 19:08:37 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id l130-20020a633e88000000b003fdf49f161bsm4009285pga.21.2022.06.12.19.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 19:08:36 -0700 (PDT)
From:   Chao Liu <chaoliu719@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: [PATCH v2] docs: filesystems: f2fs: fix description about compress ioctl
Date:   Mon, 13 Jun 2022 10:08:00 +0800
Message-Id: <20220613020800.3379482-1-chaoliu719@gmail.com>
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
v2:
- s/file size/filesize/
 Documentation/filesystems/f2fs.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index ad8dc8c040a2..531b0f8a3946 100644
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
+  reserved via ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or the filesize is
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

