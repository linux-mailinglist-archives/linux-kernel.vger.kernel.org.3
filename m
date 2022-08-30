Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6CE5A63A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 14:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiH3MkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 08:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiH3Mj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:39:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341481100;
        Tue, 30 Aug 2022 05:39:47 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MH6GL1ycTzYcmn;
        Tue, 30 Aug 2022 20:35:22 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 30 Aug 2022 20:39:45 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 20:39:45 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <corbet@lwn.net>, <bp@suse.de>, <keescook@chromium.org>,
        <aarcange@redhat.com>, <daniel.sneddon@linux.intel.com>,
        <longman@redhat.com>, <lukas.bulwahn@gmail.com>,
        <peterz@infradead.org>, <kim.phillips@amd.com>,
        <linyujun809@huawei.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] Documentation/hw-vuln: Update spectre doc
Date:   Tue, 30 Aug 2022 20:36:14 +0800
Message-ID: <20220830123614.23007-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 7c693f54c873691 ("x86/speculation: Add spectre_v2=ibrs
option to support Kernel IBRS") adds the "ibrs " option  in
Documentation/admin-guide/kernel-parameters.txt but omits it to
Documentation/admin-guide/hw-vuln/spectre.rst, add it.

Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 Documentation/admin-guide/hw-vuln/spectre.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 2ce2a38cdd55..c4dcdb3d0d45 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -613,6 +613,7 @@ kernel command line.
                 eibrs                   enhanced IBRS
                 eibrs,retpoline         enhanced IBRS + Retpolines
                 eibrs,lfence            enhanced IBRS + LFENCE
+                ibrs                    use IBRS to protect kernel
 
 		Not specifying this option is equivalent to
 		spectre_v2=auto.
-- 
2.17.1

