Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16F572C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiGMEJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiGMEJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:09:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104BA2F011;
        Tue, 12 Jul 2022 21:09:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd6so12546012edb.5;
        Tue, 12 Jul 2022 21:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=uwhVGOtXVEbD4bfgEJTYjAAgvUjp7mu9HgJ6ft1n1lA=;
        b=dn9V3qRoGTvfRYbOmPA4I39IFupZn2Yi//Pycls2RbWE66Q3nQlNOk7b4HsJn11M2I
         S3A6ShIGZt0yTTvRK5UOzCsJofKBZ7748n1jnhaXhPs9zmd0Why9GnSme8ynZwqsPl+J
         Ag7nDDxPJLFyPEH5FmI0dDXJPoR+wZwqfomULLR2i2eubl9CuDbr0I7KDu8bDaZPes9R
         KCgBWh4weQGTU4nh+rFYIKbMBD04VSgVUTwMXZZF2rQ1IuwZf1fUTfxPzWoBU9boWi4g
         46h0O4FBC2VG5IHvXIFzo01pna9Fzk+oteZ0DgHarkqS/XZ0PSzZBFEQiAcPDIwy6zov
         91YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uwhVGOtXVEbD4bfgEJTYjAAgvUjp7mu9HgJ6ft1n1lA=;
        b=gRIzLH6pnPNTSXtPaeaY7jF1860uRrx0J/07GQQtgFmz2ERF/dZq+rDIZLQm8UaEP6
         EeIrAiEn8S47M5r3pjWr0rfE3ANKhyKqDXnh9R3t2GnPEVr4xHEm7wZjpbl2NGQzbdw3
         kN69OnZz1RRKn7MoiA3hEpno/W9Xpx5QONqtzfjNQnCdxGc50odu3SvN5qS/npeSuLXT
         h4VOSjtolyqCZ7a1QhYiIiI2NwNtgEcTQ33wupjWhX7XSLZnbYHY2y7d4AuanfrcjWsQ
         bOPsxehnx+ISQDqKpA9yIKrdqdAvxLZH6o8QPNd3DW0NX9SwDOYkkSInahUX4PnGrgAu
         TJYw==
X-Gm-Message-State: AJIora/6pcKNohzxTkfxF2WEmO9sHdu4kLYTkqhzVopt4wbtIHK6O8/S
        cxu/gFlVUTAU7+xz+YWN2DM=
X-Google-Smtp-Source: AGRyM1svfhRgGyYmYm3IXekdiv6FmTJelab6KJb7XWuX7JK0UalwiBGbHKZvA7AUrAShTyzfe1NW8Q==
X-Received: by 2002:a05:6402:3041:b0:43a:d8b1:8b5 with SMTP id bs1-20020a056402304100b0043ad8b108b5mr2017165edb.242.1657685372505;
        Tue, 12 Jul 2022 21:09:32 -0700 (PDT)
Received: from felia.fritz.box (200116b826b4e8009cf80f75265d524b.dip.versatel-1u1.de. [2001:16b8:26b4:e800:9cf8:f75:265d:524b])
        by smtp.gmail.com with ESMTPSA id kb13-20020a1709070f8d00b00718e4e64b7bsm4447829ejc.79.2022.07.12.21.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:09:32 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair file entry in MICROSOFT SURFACE AGGREGATOR TABLET-MODE SWITCH
Date:   Wed, 13 Jul 2022 06:09:16 +0200
Message-Id: <20220713040916.1767-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9f794056db5b ("platform/surface: Add KIP/POS tablet-mode switch
driver") adds the section MICROSOFT SURFACE AGGREGATOR TABLET-MODE SWITCH
with a file entry, but the file that is added with this commit is actually
named slightly differently.

  file entry name: drivers/platform/surface/surface_aggregator_tablet_switch.c
  added file name: drivers/platform/surface/surface_aggregator_tabletsw.c

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair this file entry to the actual file name added with the commit above.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bfd69e2b83d..9ec738419526 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13440,7 +13440,7 @@ MICROSOFT SURFACE AGGREGATOR TABLET-MODE SWITCH
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	drivers/platform/surface/surface_aggregator_tablet_switch.c
+F:	drivers/platform/surface/surface_aggregator_tabletsw.c
 
 MICROSOFT SURFACE BATTERY AND AC DRIVERS
 M:	Maximilian Luz <luzmaximilian@gmail.com>
-- 
2.17.1

