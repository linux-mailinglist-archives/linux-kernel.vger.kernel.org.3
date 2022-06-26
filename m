Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996B655B0B8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiFZJLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiFZJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E1412A92;
        Sun, 26 Jun 2022 02:11:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49311B80D39;
        Sun, 26 Jun 2022 09:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0A5C341E7;
        Sun, 26 Jun 2022 09:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234671;
        bh=oe4XGUteu+bS5KGF6YR5qXiChD2hr0+u8pCP0xqfxhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyjooB1G2w1byargxJNcLDK2S37LvjDE592jLB2kyLxw6RUEeQA/kd3ObnGOMDmxq
         2CoC/L+XJMdjzDWuEEdRYGwFdTVaZcOqgT3cBjVF7f+49ntSKd14czSJKFtQDAhjH9
         ulwi5QXfZ8lVPn7pjM17i2vung+QvLE4T1ghwphYsmIIufa9pomgxxSJM52vU6v2tX
         9BFb2lAOWEXa137t1p9DRDMy+nEiLMF5wEt8qOtzeREf5Cj59SELHyyLz/WHj43re9
         e2k0UNAlZXSPVx7g/2z85jgpcOLKy24FApDfI+6jwNasDVuwQ/e6UuE7Ob0WJTZLcY
         T0Rvppssee13w==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIO-001cob-0a;
        Sun, 26 Jun 2022 10:11:08 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Tang Yizhou <tangyizhou@huawei.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/20] docs: zh_CN/vm/index.rst: fix a broken reference
Date:   Sun, 26 Jun 2022 10:10:55 +0100
Message-Id: <ee45d72ff3e3b2ba8245fa01a35a46fed72664c3.1656234456.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656234456.git.mchehab@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_50,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference is missing a .rst on it, causing its cross-reference
to not work.

Fixes: 9c3519d2b509 ("docs/zh_CN: add vm/index translation")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

 Documentation/translations/zh_CN/vm/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/vm/index.rst b/Documentation/translations/zh_CN/vm/index.rst
index a1c6d529b6ff..81a9b782a427 100644
--- a/Documentation/translations/zh_CN/vm/index.rst
+++ b/Documentation/translations/zh_CN/vm/index.rst
@@ -15,7 +15,7 @@ Linux内存管理文档
 这是一个关于Linux内存管理（mm）子系统内部的文档集，其中有不同层次的细节，包括注释
 和邮件列表的回复，用于阐述数据结构和算法的基本情况。如果你正在寻找关于简单分配内存的建
 议，请参阅(Documentation/translations/zh_CN/core-api/memory-allocation.rst)。
-对于控制和调整指南，请参阅(Documentation/admin-guide/mm/index)。
+对于控制和调整指南，请参阅(Documentation/admin-guide/mm/index.rst)。
 TODO:待引用文档集被翻译完毕后请及时修改此处）
 
 .. toctree::
-- 
2.36.1

