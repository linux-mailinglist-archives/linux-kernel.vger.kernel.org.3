Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520A54A9CE8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiBDQYd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Feb 2022 11:24:33 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:45044 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376517AbiBDQYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:24:20 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-zNJQTjdLMpanzfGT6Hyhug-1; Fri, 04 Feb 2022 11:24:18 -0500
X-MC-Unique: zNJQTjdLMpanzfGT6Hyhug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BA31100C660;
        Fri,  4 Feb 2022 16:24:17 +0000 (UTC)
Received: from x1.com (unknown [10.22.33.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40D8E7E91A;
        Fri,  4 Feb 2022 16:24:16 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 3/4] rtla/trace: Error message fixup
Date:   Fri,  4 Feb 2022 17:24:04 +0100
Message-Id: <361697d27431afefa64c67c323564205385c418d.1643990447.git.bristot@kernel.org>
In-Reply-To: <cover.1643990447.git.bristot@kernel.org>
References: <cover.1643990447.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

