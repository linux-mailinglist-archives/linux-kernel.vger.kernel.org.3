Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE47598470
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245157AbiHRNjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245002AbiHRNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C67157890;
        Thu, 18 Aug 2022 06:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BEBF61697;
        Thu, 18 Aug 2022 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667C8C433D6;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=Na6TYZ3zAjY4iPAdALwjXhE+bOFkmaLzJP+2aO45Scc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsCXCah8Tvgp+EqTrblWcLkwwWv34XTpn11liR3NUUdMtmwytU15cP8UGI/bFZmL7
         ZoQfdnsRet7l8xwEqWMhfcaVFKs2pQ7SoUCleq+HAl+QBg8YVHvqFipJiZzBFpr0ak
         kbVtlSzlLdyPqInB1gHE0oqIQoO3yWZhrCOyqHlWx3Glrsc5P6MNQTyp3QymJd9WOq
         wKkQWwXe9AEdnOK8crfOFyolhRyVDZMy3worpHFaZJak9qQhNgNQBrvmUN643PYEIi
         b7yWXjH3HZGscaxSa24vHgMVttAPViIg/tpHc5ZDLD6OV3fv6RW/4lDnGt7RUilWh2
         tb79va3iVVACQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY7I-57;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Wu XiangCheng <bobwxc@email.cn>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 02/13] docs: update vmemmap_dedup.rst reference
Date:   Thu, 18 Aug 2022 15:38:48 +0200
Message-Id: <2c81bc7ef207f0a84387a5d714601513f4bf1960.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660829433.git.mchehab@kernel.org>
References: <cover.1660829433.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
renamed: Documentation/vm/vmemmap_dedup.rst
to: Documentation/mm/vmemmap_dedup.rst.

Update its cross-reference accordingly.

Fixes: ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/

 mm/hugetlb_vmemmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 25bd0e002431..b8fc23c8763f 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -16,7 +16,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 
 /*
  * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
- * Documentation/vm/vmemmap_dedup.rst.
+ * Documentation/mm/vmemmap_dedup.rst.
  */
 #define HUGETLB_VMEMMAP_RESERVE_SIZE	PAGE_SIZE
 
-- 
2.37.1

