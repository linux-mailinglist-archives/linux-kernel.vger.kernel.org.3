Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4818857449E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiGNFke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiGNFkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:40:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A7528E0A;
        Wed, 13 Jul 2022 22:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8EA1B82331;
        Thu, 14 Jul 2022 05:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB13C34114;
        Thu, 14 Jul 2022 05:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657777227;
        bh=sQeo6HldtXN8M4W0pVBmML4XesDPzY/D6bMZad4+vpU=;
        h=From:To:Cc:Subject:Date:From;
        b=MTK72L0eGaI3hw+pAexW8Y0mSgy7+ctoJJol7ZJjt0TWT8fxoworx4od1K1fA7UbF
         TyjulKrVHYktWttXX8gEs0/E5mX7QJEuxaA4cFSYkMmRUHelubjuGB/J/yq4O2DXv5
         q8h3AQJcVCQUHObrstoAj6qRsKDuxXIcQZ/VSHQ0VEgXatbPvWwnfRrgMssUJhE8qw
         nB0jULbfnDXc/TbvdOciLuJI4v0xRcgzdB8262WGnN4ykbAVwlCULy0SI708D+rIPP
         chiBbLPhOVOsFsmwKpMJdThljkoCREb72vQ7RxMXp5siG6SjRDymLACB45Y+3pPkEP
         hEvExqDBhJqyw==
From:   alexs@kernel.org
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>, Hu Haowen <src.res@email.cn>,
        Jiri Kosina <jkosina@suse.cz>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Pan Yunwang <panyunwang849@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: [PATCH] doc/zh_CN: remove submitting-driver reference from docs
Date:   Thu, 14 Jul 2022 13:40:13 +0800
Message-Id: <20220714054013.214031-1-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

The doc is removed, so related reference should be removed too.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Alex Shi <alexs@kernel.org> 
Cc: Yanteng Si <siyanteng@loongson.cn> 
Cc: Jonathan Corbet <corbet@lwn.net> 
Cc: Hu Haowen <src.res@email.cn> 
Cc: Jiri Kosina <jkosina@suse.cz> 
Cc: Thorsten Leemhuis <linux@leemhuis.info> 
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org> 
Cc: Pan Yunwang <panyunwang849@gmail.com> 
Cc: linux-doc@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
Cc: linux-doc-tw-discuss@lists.sourceforge.net 
---
 Documentation/translations/zh_CN/process/8.Conclusion.rst     | 1 -
 .../translations/zh_CN/process/submitting-patches.rst         | 4 +---
 Documentation/translations/zh_TW/process/8.Conclusion.rst     | 1 -
 .../translations/zh_TW/process/submitting-patches.rst         | 4 +---
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/8.Conclusion.rst b/Documentation/translations/zh_CN/process/8.Conclusion.rst
index 4707f0101964..643b88af97bb 100644
--- a/Documentation/translations/zh_CN/process/8.Conclusion.rst
+++ b/Documentation/translations/zh_CN/process/8.Conclusion.rst
@@ -19,7 +19,6 @@
 :ref:`Documentation/translations/zh_CN/process/howto.rst <cn_process_howto>`
 文件是一个重要的起点；
 :ref:`Documentation/translations/zh_CN/process/submitting-patches.rst <cn_submittingpatches>`
-和 :ref:`Documentation/translations/zh_CN/process/submitting-drivers.rst <cn_submittingdrivers>`
 也是所有内核开发人员都应该阅读的内容。许多内部内核API都是使用kerneldoc机制
 记录的；“make htmldocs”或“make pdfdocs”可用于以HTML或PDF格式生成这些文档
 （尽管某些发行版提供的tex版本会遇到内部限制，无法正确处理文档）。
diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
index a9570165582a..ebb7f37575c1 100644
--- a/Documentation/translations/zh_CN/process/submitting-patches.rst
+++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
@@ -23,9 +23,7 @@
 以下文档含有大量简洁的建议， 具体请见：
 :ref:`Documentation/process <development_process_main>`
 同样，:ref:`Documentation/translations/zh_CN/process/submit-checklist.rst <cn_submitchecklist>`
-给出在提交代码前需要检查的项目的列表。如果你在提交一个驱动程序，那么
-同时阅读一下:
-:ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
+给出在提交代码前需要检查的项目的列表。
 
 其中许多步骤描述了Git版本控制系统的默认行为；如果您使用Git来准备补丁，
 您将发现它为您完成的大部分机械工作，尽管您仍然需要准备和记录一组合理的
diff --git a/Documentation/translations/zh_TW/process/8.Conclusion.rst b/Documentation/translations/zh_TW/process/8.Conclusion.rst
index 7572b17667d9..044fcc118bef 100644
--- a/Documentation/translations/zh_TW/process/8.Conclusion.rst
+++ b/Documentation/translations/zh_TW/process/8.Conclusion.rst
@@ -22,7 +22,6 @@
 :ref:`Documentation/translations/zh_TW/process/howto.rst <tw_process_howto>`
 文件是一個重要的起點；
 :ref:`Documentation/translations/zh_TW/process/submitting-patches.rst <tw_submittingpatches>`
-和 :ref:`Documentation/translations/zh_TW/process/submitting-drivers.rst <tw_submittingdrivers>`
 也是所有內核開發人員都應該閱讀的內容。許多內部內核API都是使用kerneldoc機制
 記錄的；「make htmldocs」或「make pdfdocs」可用於以HTML或PDF格式生成這些文檔
 （儘管某些發行版提供的tex版本會遇到內部限制，無法正確處理文檔）。
diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
index c4fd48f5bd8b..3f77ef5d48a0 100644
--- a/Documentation/translations/zh_TW/process/submitting-patches.rst
+++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
@@ -26,9 +26,7 @@
 以下文檔含有大量簡潔的建議， 具體請見：
 :ref:`Documentation/process <development_process_main>`
 同樣，:ref:`Documentation/translations/zh_TW/process/submit-checklist.rst <tw_submitchecklist>`
-給出在提交代碼前需要檢查的項目的列表。如果你在提交一個驅動程序，那麼
-同時閱讀一下:
-:ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
+給出在提交代碼前需要檢查的項目的列表。
 
 其中許多步驟描述了Git版本控制系統的默認行爲；如果您使用Git來準備補丁，
 您將發現它爲您完成的大部分機械工作，儘管您仍然需要準備和記錄一組合理的
-- 
2.25.1

