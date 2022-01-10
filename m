Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1B54898AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245604AbiAJMdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245544AbiAJMdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:33:11 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E567CC06173F;
        Mon, 10 Jan 2022 04:33:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id pf13so4664701pjb.0;
        Mon, 10 Jan 2022 04:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LmM4UPDvSTD8BLbbDOd9jP1H2HunbATjZDOgTYVCrug=;
        b=XmiEHMH1QWcjjYuF2od/gxB2qV0YD1OgIkbLb5fp2lLK9Vj7zf9ZpPDI8mcyfPA/H8
         wfooPeJgFYGFgXEiuoTq0xH9FilA5xpJYq9lfrNg0Gd3qWm47SLLcgCw+44qnR/H7E5T
         5aKC/FUq0JeqdDeemF5KoB38RJsXUPDFmOZNj4vJd3XqGQcs1xmT6GSCetBNxigzWiMy
         VrOCvgu7RufaR3A7U8CU3IWL95nEbXVXPWeNM6W0Xf3JawpcjeaOoCXfEYYllM51sL1s
         EtyekhlffoiFstjchIotVCF3jGMavtk1RiBjKnA/J3uHiKM/UwSwHiLDMz1WSOCu9HXe
         p8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmM4UPDvSTD8BLbbDOd9jP1H2HunbATjZDOgTYVCrug=;
        b=u5XSzSKNrncTdTjFfHwnYzE04FCsL5Q+2Xvekrn3Ju2WH35fJbsqiEISoLXQZfdZAH
         k/NgsqdPtj6vAiwil+WfR9NnAtWlFZOleLHW7OTtKp4UKeFKCDu/8ag7vsU0bRiiZrgy
         lYUX6S+pUmX+E0hKEnTj17WFa4f0NZjy3QQ00iXIdhALbobz/EBpJJY4vcZ/SY5jp8rT
         0xMOrNecidmjbA+BOFBGWQjReWW51ixVLehUZZgjiuiyXWp4MPuK3j0WSS18v2/aPXGI
         kwlLVgeCwJVh81XYtq60UNl0mnfwscHAwGPQUT97G7dgyRgjDZqal74d5zUizm6PQTVp
         qSPQ==
X-Gm-Message-State: AOAM531RD4gD5WkXcXo6gIOK4LCFe1SNe7TSMThkz/oqR5C3PuJtjnAm
        ZWPgscw0e6CY7F82VnKYKHg=
X-Google-Smtp-Source: ABdhPJx9W0ixkxAqFR4HnB+WyVagX2I2F4MQAGqy+Ez2qaahuICuLmf+XZ9uX/wgYw2WLPniVTDh/w==
X-Received: by 2002:a17:90a:ce92:: with SMTP id g18mr5218961pju.204.1641817990449;
        Mon, 10 Jan 2022 04:33:10 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h8sm1156521pfv.4.2022.01.10.04.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 04:33:10 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     alexs@kernel.org
Cc:     xu.xin16@zte.com.cn, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH 4/4] docs/zh_CN: Add zh_CN/vm/ksm.rst
Date:   Mon, 10 Jan 2022 12:33:07 +0000
Message-Id: <20220110123307.647802-1-xu.xin16@zte.com.cn>
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

This add zh_CN/vm/ksm.rst.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 Documentation/translations/zh_CN/vm/ksm.rst | 77 +++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/vm/ksm.rst

diff --git a/Documentation/translations/zh_CN/vm/ksm.rst b/Documentation/translations/zh_CN/vm/ksm.rst
new file mode 100644
index 0000000..952089b
--- /dev/null
+++ b/Documentation/translations/zh_CN/vm/ksm.rst
@@ -0,0 +1,77 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:原文Original:    Documentation/vm/ksm.rst
+
+:译者Translator:  徐鑫 xu xin <xu.xin16@zte.com.cn>
+
+:校译Proofreader: 杨洋 Yang Yang <yang.yang29@zte.com.cn>
+
+.. _ksm:
+
+============
+内核同页合并
+============
+
+KSM 是一种节省内存的数据去重功能，由CONFIG_KSM=y启用，并在2.6.32版本时被添加
+到Linux内核。详见 ``mm/ksm.c`` 的实现，以及http://lwn.net/Articles/306704和
+https://lwn.net/Articles/330589
+
+KSM的用户空间的接口在 `Documentation/admin-guide/mm/ksm.rst <admin_guide_ksm>`
+文档中有描述。
+
+设计
+====
+
+概述
+----
+
+.. kernel-doc:: mm/ksm.c
+   :DOC: Overview
+
+逆映
+------
+KSM维护着稳定树中的KSM页的逆映射信息。
+
+当KSM页面的共享数小于 ``max_page_sharing`` 的虚拟内存区域(VMAs)时，则代表了
+KSM页的稳定树其中的节点指向了一个rmap_item结构体类型的列表。同时，这个KSM页
+的 ``page->mapping`` 指向了该稳定树节点。
+
+如果共享数超过了阈值，KSM将给稳定树添加第二个维度。稳定树就变成链接一个或多
+个稳定树"副本"的"链"。每个副本都保留KSM页的逆映射信息，其中 ``page->mapping``
+指向该"副本"。
+
+每个链以及链接到该链中的所有"副本"强制不变的是，它们代表了相同的写保护内存
+内容，尽管任中一个"副本"是由同一片内存区的不同的KSM复制页所指向的。
+
+这样一来，相比与无限的逆映射链表，稳定树的查找计算复杂性不受影响。但在稳定树
+本身中不能有重复的KSM页面内容仍然是强制要求。
+
+由 ``max_page_sharing`` 强制决定的数据去重限制是必要的，以此来避免虚拟内存
+rmap链表变得过大。rmap的遍历具有O(N)的复杂度，其中N是共享页面的rmap_项（即
+虚拟映射）的数量，而这个共享页面的节点数量又被 ``max_page_sharing`` 所限制。
+因此，这有效地将线性O(N)计算复杂度从rmap遍历中分散到不同的KSM页面上。ksmd进
+程在稳定节点"链"上的遍历也是O(N)，但这个N是稳定树"副本"的数量，而不是rmap项
+的数量，因此它对ksmd性能没有显著影响。实际上，最佳稳定树"副本"的候选节点将
+保留在"副本"列表的开头。
+
+``max_page_sharing`` 的值设置得高了会促使更快的内存合并（因为将有更少的稳定
+树副本排队进入稳定节点chain->hlist）和更高的数据去重系数，但代价是在交换、压
+缩、NUMA平衡和页面迁移过程中可能导致KSM页的最大rmap遍历速度较慢。
+
+``stable_node_dups/stable_node_chains`` 的比值还受 ``max_page_sharing`` 调控
+的影响，高比值可能意味着稳定节点dup中存在碎片，这可以通过在ksmd中引入碎片算
+法来解决，该算法将rmap项从一个稳定节点dup重定位到另一个稳定节点dup，以便释放
+那些仅包含极少rmap项的稳定节点"dup"，但这可能会增加ksmd进程的CPU使用率，并可
+能会减慢应用程序在KSM页面上的只读计算。
+
+KSM会定期扫描稳定节点"链"中链接的所有稳定树"副本"，以便删减过时了的稳定节点。
+这种扫描的频率由 ``stable_node_chains_prune_millisecs`` 这个sysfs 接口定义。
+
+参考
+====
+.. kernel-doc:: mm/ksm.c
+   :functions: mm_slot ksm_scan stable_node rmap_item
+
+--
+徐鑫
+2022年1月9日

