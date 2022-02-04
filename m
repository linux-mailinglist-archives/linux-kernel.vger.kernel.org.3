Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135B04A9D8C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376848AbiBDRSR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Feb 2022 12:18:17 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:25863 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241131AbiBDRSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:18:15 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-sOCQrqzDM2mlds-J4_ejXQ-1; Fri, 04 Feb 2022 12:18:09 -0500
X-MC-Unique: sOCQrqzDM2mlds-J4_ejXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 593DE101F7A4;
        Fri,  4 Feb 2022 17:18:08 +0000 (UTC)
Received: from x1.com (unknown [10.22.11.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41F037DE58;
        Fri,  4 Feb 2022 17:18:06 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add RTLA entry
Date:   Fri,  4 Feb 2022 18:18:00 +0100
Message-Id: <50d8870522580905a1c7f3e6fb611a700f632af1.1643994005.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an RTLA entry in the MAINTAINERS file with Steven Rostedt and
myself as maintainers.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
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
+F:	tools/tracing/rtla
+F:	Documentation/tools/rtla
+
 TRADITIONAL CHINESE DOCUMENTATION
 M:	Hu Haowen <src.res@email.cn>
 L:	linux-doc-tw-discuss@lists.sourceforge.net
-- 
2.34.1

