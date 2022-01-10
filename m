Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C94898A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245523AbiAJMci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245514AbiAJMc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:32:27 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB7DC061748;
        Mon, 10 Jan 2022 04:32:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so15739239pjp.0;
        Mon, 10 Jan 2022 04:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8f+HhcBrytvxuT0kdBuqtyDhxCeCfr8PL72aOvaq+P4=;
        b=dagvX/AQRygmfsEdlzIS8/A8PyMPxJSlg7c/Dk8qKsj+ZNmRhMGw3QYCSjGcwMZXxi
         sts3fzm6DBjEW++DZJ1yHE2IhoO+T8YXQEhr4Biz9IVWKzDD09SoqRbB62gi8lWT6d1f
         u/woskXs8HEvfxALRaT4RNYeFUqPgqlSSdD64XRarZ0QSxBfqDsOe6YCaajYUVyL/efS
         GTJNuyQJ3mLDjX4gCV2psl6luu3tUqtc58OiOqeboP3WbtuQrdnXdEz6TLAxPZC92+w6
         4xuXVQiv656ccom8kXz7rI1kzEpKhz2Lcjy3/UMExu9XgxJwClyLTjuoSKyw/j7ZNngT
         /yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8f+HhcBrytvxuT0kdBuqtyDhxCeCfr8PL72aOvaq+P4=;
        b=W/yEBX+ZGTClhpmgWuAm9ou7w287ivAN9pALahwPDB8afvlif53QRq4+3cuARJXZew
         zwmkbO4pNbWjj5sgNa9kWf83PNqgtRM9EaqZCIEH+nd38T1ZzyYCVLsZ7+8j3+95FVI8
         RZ52SX485Zt2kn6oWMZsNAXkVsrt8yfAbIDSL6Ai8spPnB6qqQKRoFpjsRYE12Oa5Yhf
         6YQTT0NGohqA7abaXqJjLtiP41+FsDaL+pzSNhU6olO503PDsMCCBqUtOSa9Hgz5EQ2h
         EFi74bkrBha7lHeLuPQOCmz0UHA5NQinmvDAmkIo8KfUATPtuVeOzxDgueqo2ZVDlHLz
         t2Bg==
X-Gm-Message-State: AOAM533M+NXEuHzzlUXZgna8QaLyf16iIgcVbc1KP0f3iv2wvxH+rzQv
        MDHq+X/tqAEGfNblOMelBNE=
X-Google-Smtp-Source: ABdhPJzfZxkRayYZgDGauIb1JXuyyclg4OUYR5P3ZeM+8YwnYnJraQh9jDxhbxj5z++xri5PutyHQw==
X-Received: by 2002:a17:90a:6683:: with SMTP id m3mr11072585pjj.172.1641817946115;
        Mon, 10 Jan 2022 04:32:26 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n10sm7770265pje.0.2022.01.10.04.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 04:32:25 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     alexs@kernel.org
Cc:     xu.xin16@zte.com.cn, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH 2/4] docs/zh_CN: Add zh_CN/admin-guide/mm/index.rst
Date:   Mon, 10 Jan 2022 12:32:21 +0000
Message-Id: <20220110123221.647693-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110122929.647573-1-xu.xin16@zte.com.cn>
References: <20220110122929.647573-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

This patch adds zh_CN/admin-guide/mm/index.rst.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 .../translations/zh_CN/admin-guide/mm/index.rst    | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/index.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/mm/index.rst b/Documentation/translations/zh_CN/admin-guide/mm/index.rst
new file mode 100644
index 0000000..c11976b
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/mm/index.rst
@@ -0,0 +1,47 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:原文Original:   Documentation/admin-guide/mm/index.rst
+
+:译者Translator: 徐鑫 xu xin <xu.xin16@zte.com.cn>
+
+
+========
+内存管理
+========
+
+Linux内存管理子系统，顾名思义，是负责系统中的内存管理。它包括了虚拟内存与请求
+分页的实现，内核内部结构和用户空间程序的内存分配、将文件映射到进程地址空间以
+及许多其他很酷的事情。
+
+Linux内存管理是一个具有许多可配置设置的复杂系统, 且这些设置中的大多数都可以通
+过``/proc``文件系统获得，并且可以使用``sysctl``进行查询和调整。这些API接口被
+描述在Documentation/admin-guide/sysctl/vm.rst文件和`man 5 proc`中。
+
+.. _man 5 proc: http://man7.org/linux/man-pages/man5/proc.5.html
+
+Linux内存管理有它自己的术语，如果你还不熟悉它，请考虑阅读下面参考：
+:ref:`Documentation/admin-guide/mm/concepts.rst <mm_concepts>`.
+
+在此目录下，我们详细描述了如何与Linux内存管理中的各种机制交互。
+
+.. toctree::
+   :maxdepth: 1
+
+   ksm
+
+Todolist:
+   concepts
+   cma_debugfs
+   damon/index
+   hugetlbpage
+   idle_page_tracking
+   memory-hotplug
+   nommu-mmap
+   numa_memory_policy
+   numaperf
+   pagemap
+   soft-dirty
+   swap_numa
+   transhuge
+   userfaultfd
+   zswap
-- 
2.15.2


