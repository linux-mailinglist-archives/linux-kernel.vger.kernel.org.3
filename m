Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314A64743D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhLNNsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:48:41 -0500
Received: from smtpbgsg1.qq.com ([54.254.200.92]:52033 "EHLO smtpbgsg1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230387AbhLNNsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:48:40 -0500
X-QQ-mid: bizesmtp33t1639489698tnagib73
Received: from Z2zz.localdomain (unknown [218.17.40.219])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 14 Dec 2021 21:48:06 +0800 (CST)
X-QQ-SSF: 0140000000200060C000B00A0000000
X-QQ-FEAT: G+mSt178IQpUPdNu2IpKPULMu9tF9iwvGSJ9M9XoXRRNG4f4o/4vqVXy5kPUd
        x/DMOpX9QoywOXiabDy/MWYJZ8G71NWa42WxoNoJlxSzmp+Fzu9p17oxWKDWjx9LlCZZ4Ka
        g/f/40IbFrG6W4ejBVT9NzX8h92tJg589gJ6nALaMY02mYSEHBhW2NBb4ep8WE7DDK9DRcQ
        jPVCQs2c/xjIlLah0JLGbpa6qMD8Xk/4P5s/9vjfLpZmfDtKBFZpC8SSHZgjZDcDFpgLpCv
        h5xoEZOmB5m1g+OwLE7aJmWNOlDcrd/1sOBXBLAJDjxEn0GvmGOPlzxkd3chrxc6hytqJZ4
        z/o8XBhBK6ZrmY6u7VPVmA4qtTsK4lZ4dH3s1TZV5FkRqz6Aq4ddJJekRdvjw==
X-QQ-GoodBg: 2
From:   Shenghong Han <hanshenghong2019@email.szu.edu.cn>
To:     corbet@lwn.net
Cc:     akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz,
        georgi.djakov@linaro.org, lmark@codeaurora.org,
        tangbin@cmss.chinamobile.com, zhangshengju@cmss.chinamobile.com,
        weizhenliang@huawei.com, nixiaoming@huawei.com,
        Shenghong Han <hanshenghong2019@email.szu.edu.cn>
Subject: [PATCH] Documentation/vm/page_owner.rst: Update the documentation
Date:   Tue, 14 Dec 2021 21:47:36 +0800
Message-Id: <20211214134736.2569-1-hanshenghong2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation of ``page_owner``.

Signed-off-by: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
---
 Documentation/vm/page_owner.rst | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 9837fc8147dd..7a28e7b0d9c2 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -97,7 +97,7 @@ Usage
 
    The ``page_owner_sort`` tool ignores ``PFN`` rows, puts the remaining rows
    in buf, uses regexp to extract the page order value, counts the times
-   and pages of buf, and finally sorts them according to the times.
+   and pages of buf, and finally sorts them according to the parameter(s).
 
    See the result about who allocated each page
    in the ``sorted_page_owner.txt``. General output:
@@ -108,3 +108,22 @@ Usage
 
    By default, ``page_owner_sort`` is sorted according to the times of buf.
    If you want to sort by the pages nums of buf, use the ``-m`` parameter.
+   The detail parameters are shown as follows:
+
+   fundamental function:
+
+	Sort:
+		-a		Sort by memory allocate time.
+		-m		Sort by total memory.
+		-p		Sort by pid.
+		-r		Sort by memory release time.
+		-s		Sort by the stack trace.
+		-t		Sort by times (default).
+
+   additional function:
+
+	Cull:
+		-c		Cull by comparing stacktrace instead of total block.
+
+	Filter:
+		-f		Filter out the information of blocks whose memory has not been released.
-- 
2.30.1



