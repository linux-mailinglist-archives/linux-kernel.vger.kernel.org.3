Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043BD55D392
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbiF1GWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245459AbiF1GW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:22:29 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3304D9FD5;
        Mon, 27 Jun 2022 23:22:23 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 6B0281E80CEF;
        Tue, 28 Jun 2022 14:21:20 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XxYXRSnOoWi0; Tue, 28 Jun 2022 14:21:17 +0800 (CST)
Received: from localhost.localdomain (unknown [112.65.12.78])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 1BFAF1E80C3F;
        Tue, 28 Jun 2022 14:21:16 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] device_cgroup: Fix a spelling mistake
Date:   Tue, 28 Jun 2022 14:22:09 +0800
Message-Id: <20220628062209.20560-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'acessed' to 'accessed'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 security/device_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index a9f8c63a96d1..0a4373d2a1f2 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -410,7 +410,7 @@ static bool verify_new_ex(struct dev_cgroup *dev_cgroup,
 		} else {
 			/*
 			 * new exception in the child will add more devices
-			 * that can be acessed, so it can't match any of
+			 * that can be accessed, so it can't match any of
 			 * parent's exceptions, even slightly
 			 */ 
 			match = match_exception_partial(&dev_cgroup->exceptions,
-- 
2.25.1

