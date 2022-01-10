Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B43C4898AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245554AbiAJMda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245530AbiAJMdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:33:00 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A642CC061756;
        Mon, 10 Jan 2022 04:33:00 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so15691462pjb.5;
        Mon, 10 Jan 2022 04:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wMbT/FSujSenRpXSHeeu1Hw7q4++c7MIS+3moYnfH8w=;
        b=RhfmCV/fisAKvCF0awi665jdiR9WQu8oYCVq3BhtGUyt5I9/16WNk7wAZ5R7KfCly0
         /TnObTrMY6flsdmyz6xFhxgON3/Hg55ZzLD6eOpnnmnXxDeWnJbkO4X+2nfF/cr2SKHf
         fXK5GTh8AYV/U/cNIoJPRhhT8WN4t6OEAYGQaCp83bFgMs74aU/g3y9cQyDcmaoRxEwT
         mC8gp2rOa2O/9/zPYWFOAd5xZHifceKqOGDMgLxTjfmYuK7SLDl8dqHfMwhmqkvB/GFo
         A2muhLegg8LXOzZr+wtnd7StB1JIJDdGQgQZ/qXk6er2i3ir86InYToE2522vMJk0nH8
         Evqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wMbT/FSujSenRpXSHeeu1Hw7q4++c7MIS+3moYnfH8w=;
        b=erjApT5GwRs7vkuXjhyzwLXSps0Z1g335v1Gb5ly84nWah6qT9xFp1galwrsP6YcgB
         rswsZ01v/1p/A9kFuJ4S1CMNC2KrlyUyLJEkJFXJdWY2vukEQMTZ8Ms2FtVIT5hUycIC
         Jl3tiBGf11ncBEGYsdUP1w1BwnDFVZf8SOkY+6n/Mb/HjnNkvC9sZAEqNxny9WcqzEC3
         iC3dHIZefdlRfIIiG5zse+cNtMP4Nw1iSuErWIHsS97dygjYmAstoB/2INTq7LmiUn86
         FIvudklX/6w5RkvJ76kAmd3b0coHsRfn4MadvGFxf3GJYDtXVjdQrx0yU2iEPHqw/+f4
         k9Lg==
X-Gm-Message-State: AOAM531HkiWDwGBKJ18fJHePYH8jKfTaVlA78wLr9aOWs3W9rWKrIhJM
        9zjtlqlt1d7RTlcpjJcyLLQ=
X-Google-Smtp-Source: ABdhPJzTRlpWhT0VhCNB9muEL2OUEhAX8xNKZpx9LfjQ9uaxlcYTnels0gYbUZo0NX5jhB4SLjV1yA==
X-Received: by 2002:a63:6bc3:: with SMTP id g186mr18128816pgc.192.1641817980311;
        Mon, 10 Jan 2022 04:33:00 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k62sm8741974pja.23.2022.01.10.04.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 04:33:00 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     alexs@kernel.org
Cc:     xu.xin16@zte.com.cn, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH 3/4] docs/zh_CN: Add zh_CN/vm/index.rst
Date:   Mon, 10 Jan 2022 12:32:56 +0000
Message-Id: <20220110123256.647748-1-xu.xin16@zte.com.cn>
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

This patch adds zh_CN/vm/index.rst.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Documentation/translations/zh_CN/vm/index.rst | 49 +++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/vm/index.rst

diff --git a/Documentation/translations/zh_CN/vm/index.rst b/Documentation/translations/zh_CN/vm/index.rst
new file mode 100644
index 0000000..27f8405
--- /dev/null
+++ b/Documentation/translations/zh_CN/vm/index.rst
@@ -0,0 +1,49 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:原文Original:    Documentation/vm/index.rst
+
+:译者Translator:  徐鑫 xu xin <xu.xin16@zte.com.cn>
+
+:校译Proofreader: 杨洋 Yang Yang <yang.yang29@zte.com.cn>
+
+===================
+Linux内存管理的文档
+===================
+
+这是一个关于Linux内存管理（mm）子系统的文档集合，其内部具有不同层级的详细信息，
+包括注释和邮件列表，用于详细描述数据结构和算法。如果您正在寻找有关简单内存分
+配的建议，请参阅:ref:`memory_allocation` 。有关控制和调整指南，请参阅
+:doc: `admin guide <../admin-guide/mm/index>` 。
+
+.. toctree::
+   :maxdepth: 1
+
+   ksm
+
+Todolist:
+   active_mm
+   arch_pgtable_helpers
+   balance
+   damon/index
+   free_page_reporting
+   frontswap
+   highmem
+   hmm
+   hwpoison
+   hugetlbfs_reserv
+   memory-model
+   mmu_notifier
+   numa
+   overcommit-accounting
+   page_migration
+   page_frags
+   page_owner
+   page_table_check
+   remap_file_pages
+   slub
+   split_page_table_lock
+   transhuge
+   unevictable-lru
+   vmalloced-kernel-stacks
+   z3fold
+   zsmalloc
-- 
2.15.2


