Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D027B498206
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbiAXOYy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jan 2022 09:24:54 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:53974 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238192AbiAXOYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:24:40 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-e_ljM9I4OtK-40tQjdMCZA-1; Mon, 24 Jan 2022 09:24:38 -0500
X-MC-Unique: e_ljM9I4OtK-40tQjdMCZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB073100CCC6;
        Mon, 24 Jan 2022 14:24:37 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53F98798C1;
        Mon, 24 Jan 2022 14:24:36 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 8/8] rtla/trace: Error message fixup
Date:   Mon, 24 Jan 2022 15:24:11 +0100
Message-Id: <a93c01023602ac087dd3e3c60a4d1020de1d601a.1643033113.git.bristot@kernel.org>
In-Reply-To: <cover.1643033113.git.bristot@kernel.org>
References: <cover.1643033113.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use capital and change "tracer %s" to "%s tracer".

No functional change.

Fixes: b1696371d865 ("rtla: Helper functions for rtla")
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 107a0c6387f7..83de259abcc1 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -20,14 +20,14 @@ int enable_tracer_by_name(struct tracefs_instance *inst, const char *tracer_name
 
 	tracer = TRACEFS_TRACER_CUSTOM;
 
-	debug_msg("enabling %s tracer\n", tracer_name);
+	debug_msg("Enabling %s tracer\n", tracer_name);
 
 	retval = tracefs_tracer_set(inst, tracer, tracer_name);
 	if (retval < 0) {
 		if (errno == ENODEV)
-			err_msg("tracer %s not found!\n", tracer_name);
+			err_msg("Tracer %s not found!\n", tracer_name);
 
-		err_msg("failed to enable the tracer %s\n", tracer_name);
+		err_msg("Failed to enable the %s tracer\n", tracer_name);
 		return -1;
 	}
 
@@ -44,7 +44,7 @@ void disable_tracer(struct tracefs_instance *inst)
 
 	retval = tracefs_tracer_set(inst, t);
 	if (retval < 0)
-		err_msg("oops, error disabling tracer\n");
+		err_msg("Oops, error disabling tracer\n");
 }
 
 /*
-- 
2.34.1

