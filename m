Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D828D4C5476
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 08:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiBZHny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 02:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiBZHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 02:43:53 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8371CFA3E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 23:43:17 -0800 (PST)
Received: from integral2.. (unknown [36.78.50.60])
        by gnuweeb.org (Postfix) with ESMTPSA id 310007E29C;
        Sat, 26 Feb 2022 07:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1645861396;
        bh=FAQAkTUMohRJ7s9YIqUGwpC1iUzmd1viaowHWRwBhow=;
        h=From:To:Cc:Subject:Date:From;
        b=c7aikUD+wjNYD4QEWV25f/AgvwNJK43qfhCVrgWMw2CQaVUfTbjp3SqqlXB37U12U
         0qupq5l5eu6pThnUGQwqLm8YiocJ41i7WaYXWP33YAN+Ba4HriUHhSu+v7GkbkpNvC
         tutC41RprR/XUszBJJYFVWAChSULvs+O4Cw2MPPsihbHuWIyoGB64pHKBoESgEBYJk
         lCAKwD5prMQEFtrOlTkLjuDnzBBXRFcIbMOE/8R6Nz2HShFTtRuOOHep8ZwXjcSLLt
         YnMzASQKhv2Vp0URzRyJE8je3oQ7pW/YHDF/rytY03z5sAldZQeAdTD+IgRyHAeqCE
         tiiItxWlIzuzw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH] MAINTAINERS: Remove dead patchwork link
Date:   Sat, 26 Feb 2022 14:40:56 +0700
Message-Id: <20220226074056.340055-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

The patchwork link is dead. It says:

  404: File not found
  The page URL requested (/project/LKML/list/) does not exist.

Remove it.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2524b75763cd..212b7861292f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21464,7 +21464,6 @@ THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
 S:	Buried alive in reporters
-Q:	http://patchwork.kernel.org/project/LKML/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 F:	*
 F:	*/
-- 
2.32.0

