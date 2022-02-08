Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD094ADB7E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378386AbiBHOr0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Feb 2022 09:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378299AbiBHOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:47:22 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81AE4C061577
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:47:21 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-Zlmn8wCQPUKaY_7CMNQhWw-1; Tue, 08 Feb 2022 09:47:17 -0500
X-MC-Unique: Zlmn8wCQPUKaY_7CMNQhWw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40AC11898296;
        Tue,  8 Feb 2022 14:47:16 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D3DE84A24;
        Tue,  8 Feb 2022 14:47:14 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: [PATCH V2] MAINTAINERS: Add RTLA entry
Date:   Tue,  8 Feb 2022 15:47:10 +0100
Message-Id: <50d8870522580905a1c7f3e6fb611a700f632af1.1643994005.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an RTLA entry in the MAINTAINERS file with Steven Rostedt and
myself as maintainers.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
Changes from V1:
 Add trailing slash after dir paths (Joe Perches)

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb83dcbcb619..fad694078b4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19581,6 +19581,14 @@ F:	Documentation/trace/timerlat-tracer.rst
 F:	Documentation/trace/hwlat_detector.rst
 F:	arch/*/kernel/trace.c
 
+Real-time Linux Analysis (RTLA) tools
+M:	Daniel Bristot de Oliveira <bristot@kernel.org>
+M:	Steven Rostedt <rostedt@goodmis.org>
+L:	linux-trace-devel@vger.kernel.org
+S:	Maintained
+F:	Documentation/tools/rtla/
+F:	tools/tracing/rtla/
+
 TRADITIONAL CHINESE DOCUMENTATION
 M:	Hu Haowen <src.res@email.cn>
 L:	linux-doc-tw-discuss@lists.sourceforge.net
-- 
2.34.1

