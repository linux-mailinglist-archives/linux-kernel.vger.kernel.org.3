Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB5488EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 04:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiAJDUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 22:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiAJDUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 22:20:04 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68046C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 19:20:04 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641784801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ar8u2jdWuvWV/AaGRT7JUxOrCy4wBo/tTTJT4exP7SA=;
        b=TrAOj1dP7bDNVM7fIXyPNjrfzBUVsJIg8lwhwFFX7169BBbazTiQZQs7esbwxhmKLGsel/
        Esy7Xh6MC88gOxFPIncHY3Vd5yn7JMoTK7D1Qu4PT3nKchvkvgwCbpH2rv5JTg5T505j0l
        MgJd4V+PbLKNDclRcVFY0WOjZIAmTzw=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     christian.brauner@ubuntu.com, repnop@google.com, david@redhat.com,
        jack@suse.cz
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] pid: move open brace after struct pid
Date:   Mon, 10 Jan 2022 11:19:32 +0800
Message-Id: <20220110031932.1926827-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The open brace should be after a struct of define, that's good
for searching.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/pid.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 343abf22092e..b54031931565 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -56,8 +56,7 @@ struct upid {
 	struct pid_namespace *ns;
 };
 
-struct pid
-{
+struct pid {
 	refcount_t count;
 	unsigned int level;
 	spinlock_t lock;
-- 
2.25.1

