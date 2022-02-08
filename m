Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E89D4AE4D0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386535AbiBHWe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387244AbiBHWLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:11:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E54C0612B8;
        Tue,  8 Feb 2022 14:11:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5831B81AFA;
        Tue,  8 Feb 2022 22:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ECEC004E1;
        Tue,  8 Feb 2022 22:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644358281;
        bh=PjxTNsP9bD1JDK5Yw86+t2N+2x7ro0uvm/lVgqLSSjM=;
        h=From:To:Cc:Subject:Date:From;
        b=B2rqGFysMw+kjL94kZTf4z4W3FIWk/nbVwdfz/gqNF6+x70aBH0zUsLVj0OZx4Rqx
         +2q7NId8Er5wnZnUcKWJi8YgXZSu1lrQq4adfazaT9fJjwRYdKn1XVVXX1xZB/2hu8
         GVbciMkPCQCVG2oZ5GpcrQJb8MKpZgtLNxJbv1y4jsvzeV0c4BatMtXsQCz0RF+Y9Y
         N4CSayv2xo+/CsYqCnhOze7sbjKtWpFtYlkZmGYw0iErEVfRiBvqyzRqMGbNIop6WP
         iTfGISf1g2GRrdztJlHya/iLccs+Z1s5wK2steN8G7VgiZWdmGn29ZiDq5kC6zI+29
         8IDhMyjcfh2/g==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update Jiri's email address
Date:   Tue,  8 Feb 2022 23:11:17 +0100
Message-Id: <20220208221117.710405-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using my kernel.org email.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..d4248b02515b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15123,7 +15123,7 @@ M:	Ingo Molnar <mingo@redhat.com>
 M:	Arnaldo Carvalho de Melo <acme@kernel.org>
 R:	Mark Rutland <mark.rutland@arm.com>
 R:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
-R:	Jiri Olsa <jolsa@redhat.com>
+R:	Jiri Olsa <jolsa@kernel.org>
 R:	Namhyung Kim <namhyung@kernel.org>
 L:	linux-perf-users@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
-- 
2.34.1

