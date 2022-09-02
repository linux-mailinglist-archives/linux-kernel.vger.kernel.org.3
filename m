Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0789D5AA97D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiIBIIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiIBIIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:08:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB2CB729D;
        Fri,  2 Sep 2022 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662106093; x=1693642093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B8ofpabz8OrAnYU/UuLj8SXDHWJrJaWAuJy/DtjxDr4=;
  b=f+fmDK0j90DlwvSGcJwj5nnjns+qLlt2Zdh4/MJv2WGdmnXMlLVg8Yob
   agC+n+gyEg3g3S8ZR92k13Z4qgXTeClo6MHrQwIYTFwaCQPbZsSi3GsN7
   g/FLMzDZsXCLkk/xpz6KgcYGaKiac3x1FcQmNRpqXVeKBa6j/uJ8Ii1fs
   Z9hG27tQpN8kIZVCEkYVc+M87adxxMBJ5IsGauKM7NboJ0WFTeBL/uRsf
   b1roUlu4PTGS7u5NFqpGsLJ9J2BmE0ee9wO6PgqkxD3bs+n/c3pHmbBRa
   c3tB+LYiP+wMPN1wE7aeBk8T5T6uj6TDb7Y///VhLGCkRya5IfiE5C+dM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="282915926"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="282915926"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 01:08:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="589987118"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.132])
  by orsmga006.jf.intel.com with ESMTP; 02 Sep 2022 01:08:10 -0700
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <bobwxc@email.cn>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] Documentation/zh_CN: add latest kmap_local_page translation
Date:   Fri,  2 Sep 2022 16:13:04 +0800
Message-Id: <20220902081304.2259706-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_50,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Liu <zhao1.liu@intel.com>

Translate the lastest description of kmap_local_page into Chinese.

The translation is based on these commits:

commit 516ea046ec555 ("Documentation/mm: don't kmap*() pages which
can't come from HIGHMEM")

commit 6b3afe2eeec27 ("Documentation/mm: avoid invalid use of
addresses from kmap_local_page()")

commit 84b86f6054c42 ("Documentation/mm: rrefer kmap_local_page()
and avoid kmap()")

commit a9e9c93966afd ("Documentation/mm: add details about
kmap_local_page() and preemption")

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Suggested by credits.
        Ira: Referred to his task document.
        Fabio: Referred to his work on the original English document.

---
 .../translations/zh_CN/mm/highmem.rst         | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/translations/zh_CN/mm/highmem.rst b/Documentation/translations/zh_CN/mm/highmem.rst
index f74800a6d9a7..ac4c86ed74d8 100644
--- a/Documentation/translations/zh_CN/mm/highmem.rst
+++ b/Documentation/translations/zh_CN/mm/highmem.rst
@@ -58,14 +58,28 @@
   在可行的情况下，这个函数应该比其他所有的函数优先使用。
 
   这些映射是线程本地和CPU本地的，这意味着映射只能从这个线程中访问，并且当映射处于活动状
-  态时，该线程与CPU绑定。即使线程被抢占了（因为抢占永远不会被函数禁用），CPU也不能通过
-  CPU-hotplug从系统中拔出，直到映射被处理掉。
+  态时，该线程与CPU绑定。即使抢占永远不会被这个函数禁用，CPU也不能通过CPU-hotplug从系
+  统中拔出，直到映射被处理掉。
 
-  在本地的kmap区域中采取pagefaults是有效的，除非获取本地映射的上下文由于其他原因不允许
+  在本地的kmap区域中获取pagefaults是有效的，除非获取本地映射的上下文由于其他原因不允许
   这样做。
 
+  如前所述，pagefault和抢占永远不会被禁用。不需要禁用抢占，因为当上下文切换到不同的任务
+  时，传出任务的映射会被保存，而传入任务的映射会被恢复。
+
   kmap_local_page()总是返回一个有效的虚拟地址，并且假定kunmap_local()不会失败。
 
+  在CONFIG_HIGHMEM=n内核和低内存页面上，这将返回直接映射的虚拟地址。只有真正的高内存页
+  面会被临时映射。因此，用户可以为已知不是来自ZONE_HIGHMEM的页面调用普通的
+  page_address()，但是，使用kmap_local_page() / kunmap_local()总是安全的。
+
+  虽然它比kmap()快得多，但对于高内存情况，它带有指针有效性的限制。和kmap()映射相反，本地
+  映射仅在调用者的上下文中有效，并不能被交给其他的上下文。这意味着用户必须绝对确保返回的地址
+  仅在映射它的线程的本地使用。
+
+  大多数代码可以设计为使用线程本地映射。因此，用户应该尝试这样去设计他们的代码，在地址会被使
+  用的同一线程中映射页面来避免使用kmap()，并且更倾向于去使用kmap_local_page()。
+
   嵌套kmap_local_page()和kmap_atomic()映射在一定程度上是允许的（最多到KMAP_TYPE_NR），
   但是它们的调用必须严格排序，因为映射的实现是基于堆栈的。关于如何管理嵌套映射的细节，
   请参见kmap_local_page() kdocs（包含在 "函数 "部分）。
-- 
2.34.1

