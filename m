Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3710757E002
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiGVK3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGVK3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:29:22 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91247D9F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xT1pJ
        H4eJqZodNQi//RNQKe8R4D1it8QYX/YOD3AtVs=; b=f6EO0FRkt9IqoIWfjJxzI
        QNv9DoRFxpCwoH0loJzapQbXW2SOpl+ZjRGdKA4jYH0a3uCy+cf89Y6mWKZfEjrI
        frryXFMvK4rpSwqXlZn8tNHCp8J+JPjKq6n0I6l8Km7FzwRqzEp2GdxQ0YyVwpQ7
        rQfLEDk2/++jmYdrUIo8yU=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp2 (Coremail) with SMTP id GtxpCgAHVwL4e9pi+UtrQg--.23192S2;
        Fri, 22 Jul 2022 18:29:14 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     suhui@zeku.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] scripts:/tracing: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 18:29:07 +0800
Message-Id: <20220722102907.81949-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgAHVwL4e9pi+UtrQg--.23192S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyDCF1UJFWrJF1rKFWDXFb_yoWfXrgEqr
        nrK3Z7X3y8GwsFvF1fArs5ZFy8KanYgrW8Zr1UWr9I9345Krs3WFn3KFyvyryfWFsFqF97
        WrW3XF18J34avjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtzuX3UUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQNGZGBbEb3ulwAAs6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 scripts/tracing/draw_functrace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
index 7011fbe003ff..438516bdfb3c 100755
--- a/scripts/tracing/draw_functrace.py
+++ b/scripts/tracing/draw_functrace.py
@@ -8,7 +8,7 @@ This script parses a trace provided by the function tracer in
 kernel/trace/trace_functions.c
 The resulted trace is processed into a tree to produce a more human
 view of the call stack by drawing textual but hierarchical tree of
-calls. Only the functions's names and the the call time are provided.
+calls. Only the functions's names and the call time are provided.
 
 Usage:
 	Be sure that you have CONFIG_FUNCTION_TRACER
-- 
2.25.1

