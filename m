Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613A056C8CB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiGIKIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiGIKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432764B0FA;
        Sat,  9 Jul 2022 03:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D648F60E7F;
        Sat,  9 Jul 2022 10:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8387DC341E1;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=AoO2bODaPYczS1FHedFs6C5nKY1V+/HnQtEe231t02s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6K74ZKH7OyD+GFYnhuJeXS5rSYOniRVlu5JCSssHL/Y8g/pJNxXwIsirK1VL35r/
         XNh1WSDjXR16avRlQDusm0iGOOTHOPxrqlvCbFl4wMsSeSWIc6l43WrfqE8hlTqNva
         UKkTYpWdIPNhiGabhEoKFI8S6ImrDCK5uzyPeZr/PypnDOUeEUA/zvYA6TWaWGwP+R
         h3lQl5gdW8bV7U8vmHV5GX9zEvQ5h6RWgSHB4OO/oQ6RosnZtdKrzEi+A0knwyTEV5
         jSsIAy/haUrVfQzACn3h2B7zWwRZmNKKOvLBL0eJoU0dyYE2fXfc8DHTnSRzpna0/8
         XVG8keLa5Xj9g==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EGc-F5;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Wu XiangCheng <bobwxc@email.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/21] docs: zh_CN: page_migration: fix reference to mm index.rst
Date:   Sat,  9 Jul 2022 11:07:17 +0100
Message-Id: <b263eef6480040befa582e8e00162e6fb4407853.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This got renamed, so we need to also rename at page_migration.rst.

Fixes: ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

 Documentation/translations/zh_CN/mm/page_migration.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/mm/page_migration.rst b/Documentation/translations/zh_CN/mm/page_migration.rst
index 566880a41ea0..ea9647d060fb 100644
--- a/Documentation/translations/zh_CN/mm/page_migration.rst
+++ b/Documentation/translations/zh_CN/mm/page_migration.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/index.rst
+:Original: Documentation/mm/index.rst
 
 :翻译:
 
-- 
2.36.1

