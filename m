Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B73506113
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiDSAqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241156AbiDSApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96792AC79
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18154613B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E68AC385CF;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=EnqCsnUKai4u5M/XWwiBMkwKvoG6dGydw1Q83m4mYW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmqBzm/9oocXTeceMy8rN6/PF8T65Gb2SX/AsjzmtC8i0OEP2ulloSpGcI9cjTrcT
         2Gpf2UvGdjKyrTxDZpNvduwrGNnQLpIu8IV6DffJHAFhIOApvL/sBgRGhEumBM/tiK
         MeeOXIOh1EzEn2Ugo/SXeQuN17Z6bRJ3JXiV6CMTcpQNNOSPtGYgCE6FjbwW295mXe
         1sFmDWRvKjN3OYeDN9vaeCunRgGhpzXDZAMpOAFDziz16jgj5JqsaTXLT6Xl/FMg/l
         xyqep3NnqBEb/vaOyVhzO0d0kgkDMpe9mef/OGArnJY+C3/wt6ByDnOHfn/sD54KRo
         KceBd4cqzXUuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2F7365C30EF; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 22/61] tools/nolibc/types: define EXIT_SUCCESS and EXIT_FAILURE
Date:   Mon, 18 Apr 2022 17:41:46 -0700
Message-Id: <20220419004225.3952530-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willy Tarreau <w@1wt.eu>

These ones are found in some examples found in man pages and ease
portability tests.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index b1bff5e717b6..e0749dc0bd06 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -71,6 +71,9 @@
 #define WEXITSTATUS(status) (((status) & 0xff00) >> 8)
 #define WIFEXITED(status)   (((status) & 0x7f) == 0)
 
+/* standard exit() codes */
+#define EXIT_SUCCESS 0
+#define EXIT_FAILURE 1
 
 /* for select() */
 typedef struct {
-- 
2.31.1.189.g2e36527f23

