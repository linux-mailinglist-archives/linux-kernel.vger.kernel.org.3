Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019C64767BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhLPCHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:07:39 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:29199 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbhLPCHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:07:37 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JDwS1693lz8vsJ;
        Thu, 16 Dec 2021 10:05:21 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:07:35 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>,
        <keescook@chromium.org>, <gustavoars@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH -next, v3 2/2] audit: replace zero-length array with flexible-array member
Date:   Thu, 16 Dec 2021 10:08:31 +0800
Message-ID: <20211216020831.93674-2-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216020831.93674-1-xiujianfeng@huawei.com>
References: <20211216020831.93674-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated and should be replaced with
flexible-array members.

Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/uapi/linux/audit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 9176a095fefc..8eda133ca4c1 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -514,7 +514,7 @@ struct audit_rule_data {
 	__u32		values[AUDIT_MAX_FIELDS];
 	__u32		fieldflags[AUDIT_MAX_FIELDS];
 	__u32		buflen;	/* total length of string fields */
-	char		buf[0];	/* string fields buffer */
+	char		buf[];	/* string fields buffer */
 };
 
 #endif /* _UAPI_LINUX_AUDIT_H_ */
-- 
2.17.1

