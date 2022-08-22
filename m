Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D771459BC92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiHVJQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiHVJPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:15:16 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 219212B1BB;
        Mon, 22 Aug 2022 02:14:35 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id B5AB81E80D2C;
        Mon, 22 Aug 2022 17:10:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nNW8Pz23E0UV; Mon, 22 Aug 2022 17:10:52 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 12A381E80CD1;
        Mon, 22 Aug 2022 17:10:52 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] power/acpi: Remove unnecessary return in acpi_os_** function;
Date:   Mon, 22 Aug 2022 17:14:16 +0800
Message-Id: <20220822091416.6177-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the return in the function; it looks clearer.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 tools/power/acpi/os_specific/service_layers/osunixxf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index b3651a04d68c..127630c38f1a 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -510,8 +510,6 @@ void *acpi_os_map_memory(acpi_physical_address where, acpi_size length)
 
 void acpi_os_unmap_memory(void *where, acpi_size length)
 {
-
-	return;
 }
 #endif
 
@@ -1313,5 +1311,4 @@ acpi_os_execute(acpi_execute_type type,
 
 void acpi_os_wait_events_complete(void)
 {
-	return;
 }
-- 
2.18.2

