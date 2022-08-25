Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A425A0C37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiHYJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbiHYJEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:04:11 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B6CD1580D;
        Thu, 25 Aug 2022 02:04:10 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id B32931E80C99;
        Thu, 25 Aug 2022 17:00:03 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OUmu_zhShEh6; Thu, 25 Aug 2022 17:00:01 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: junming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 02E5B1E80C8D;
        Thu, 25 Aug 2022 17:00:01 +0800 (CST)
From:   shijm <junming@nfschina.com>
To:     lenb@kernel.org
Cc:     linux-kernel@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org, Shi junming <junming@nfschina.com>
Subject: [PATCH] tools: Delete the initialization value
Date:   Thu, 25 Aug 2022 17:03:47 +0800
Message-Id: <20220825090347.30555-1-junming@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shi junming <junming@nfschina.com>

From the perspective of commpier,delete the initialization value

Signed-off-by: Shi junming <junming@nfschina.com>
---
 tools/power/acpi/tools/pfrut/pfrut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/tools/pfrut/pfrut.c b/tools/power/acpi/tools/pfrut/pfrut.c
index d79c335594b2..52aa0351533c 100644
--- a/tools/power/acpi/tools/pfrut/pfrut.c
+++ b/tools/power/acpi/tools/pfrut/pfrut.c
@@ -190,7 +190,7 @@ int main(int argc, char *argv[])
 	void *addr_map_capsule;
 	struct stat st;
 	char *log_buf;
-	int ret = 0;
+	int ret;
 
 	if (getuid() != 0) {
 		printf("Please run the tool as root - Exiting.\n");
-- 
2.18.2

