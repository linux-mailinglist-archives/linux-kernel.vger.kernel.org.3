Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7728A547348
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiFKJbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFKJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:31:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5326B664
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 02:31:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6385B60B15
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 09:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DF9C3411E;
        Sat, 11 Jun 2022 09:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654939911;
        bh=LNnn8VP3ISoWCNHD4Uu1SypzJBaQWj8L3bMqjcuZP8Y=;
        h=From:To:Cc:Subject:Date:From;
        b=bpUbdcvkBoz/tFrK7bc5FMFtC8Cz7sAfTGRCJ1BVE+KYeGWeOIyS2f1ib2vSonciV
         rIpdOOjgo2RRm3FiRAuoM6KIMja2Nwpb2NW8+qY4/j2g38JvIPQ1oCrpdGckq0IuTv
         pWOrTjEFV5jySkMIkLXXZAPHnk9Mt1+6Xrg2cgcsHQrYz7S2odO9dwNFv+06nIobza
         ahzXsZMVbRwmUzPmnl1MAHWIYmeTV0SgtnOQi/+GfyMssGOsjwvXP+llU+fk+iY1IW
         rH5OwuJ1FZ+JW0j0N9P1CDQvO3l/hCEU5mM9UxeGEKT7pjkt5HJJWKMqhU0dA21cic
         TccR/bR+SNNdA==
From:   abelvesa@kernel.org
To:     Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@nxp.com>
Subject: [PATCH] MAINTAINERS: Update Abel Vesa's email
Date:   Sat, 11 Jun 2022 12:31:42 +0300
Message-Id: <20220611093142.202271-1-abelvesa@kernel.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abelvesa@nxp.com>

Use Abel Vesa's kernel.org account in maintainer entry and mailmap.

Signed-off-by: Abel Vesa <abelvesa@nxp.com>
---
 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index b2967aab5359..dda0030573ca 100644
--- a/.mailmap
+++ b/.mailmap
@@ -10,6 +10,8 @@
 # Please keep this list dictionary sorted.
 #
 Aaron Durbin <adurbin@google.com>
+Abel Vesa <abelvesa@kernel.org> <abel.vesa@nxp.com>
+Abel Vesa <abelvesa@kernel.org> <abelvesa@gmail.com>
 Abhinav Kumar <quic_abhinavk@quicinc.com> <abhinavk@codeaurora.org>
 Adam Oldham <oldhamca@gmail.com>
 Adam Radford <aradford@gmail.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 475e28365385..6af989d4cdd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14317,7 +14317,7 @@ F:	drivers/iio/gyro/fxas21002c_i2c.c
 F:	drivers/iio/gyro/fxas21002c_spi.c
 
 NXP i.MX CLOCK DRIVERS
-M:	Abel Vesa <abel.vesa@nxp.com>
+M:	Abel Vesa <abelvesa@kernel.org>
 L:	linux-clk@vger.kernel.org
 L:	linux-imx@nxp.com
 S:	Maintained
-- 
2.34.3

