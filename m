Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A0856C8B7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiGIKIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiGIKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:07:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACD64E612;
        Sat,  9 Jul 2022 03:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED434B81B85;
        Sat,  9 Jul 2022 10:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8201FC36AE2;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=dHEaxf7bO6LYIJv1hiJfhIsQ7ihTLYPsh05dneOYEto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjntMzcGOpovzGor55NmNs2C8dY3M3yPLtwoUkXYnfH/ltt3FZAquKIQbnPTakAiT
         I//nlslheX6VGgmLuaH2RBSJCqe/jyMdY+ORElg1ATOLrhGhsKZxkWyXfWYEYkl5JR
         XrbYMCwPjQsbPHLUIj+Pge+HEhVQixSwedshT6V8io/IXYeMyayj2n+1QoIoVNVsrq
         rvcpFvQL39dQyvmAUAXWg532xxz7dvDjVuFBCLTFmQC6tVADPGShObHJPLgdPPxMUC
         kFl5EKhR+iTSGOHZ7eMjm19UHAltcjXjeY2TwDdXNv8pWnD5SFy1rTp1s9I5YWDegx
         FU9lq3aX/WVUg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EGW-Do;
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
Subject: [PATCH v3 02/21] docs: update vmalloced-kernel-stacks.rst reference
Date:   Sat,  9 Jul 2022 11:07:15 +0100
Message-Id: <71f4ccf95aa2de93be469b1e64606f9fc16dcaa2.1657360984.git.mchehab@kernel.org>
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

Changeset ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
renamed: Documentation/vm/vmalloced-kernel-stacks.rst
to: Documentation/mm/vmalloced-kernel-stacks.rst.

Update its cross-reference accordingly.

Fixes: ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

 Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst b/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst
index ad23f274f6d7..d02a23f7f07e 100644
--- a/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst
+++ b/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/vmalloced-kernel-stacks.rst
+:Original: Documentation/mm/vmalloced-kernel-stacks.rst
 
 :翻译:
 
-- 
2.36.1

