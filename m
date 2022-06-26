Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7555B0A1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiFZJL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiFZJLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECA912AB5;
        Sun, 26 Jun 2022 02:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7535A61197;
        Sun, 26 Jun 2022 09:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56F4C36AFE;
        Sun, 26 Jun 2022 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234671;
        bh=kSmvldrnBKLAUF+/2e4vcVlSti8QpYvHvcfOW+vjwCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7bCsCNMI3sPLiq81Njm9urEkODF3YSSK/radH8r9Htrr1iuLGtoxuMeekUtOAsQf
         FpLMDdO16rmyTsLEY6g0S7ubKPaEy3s7pCjnFTfSpoS+AQtkJ3pgjq2BVl4wyK3O+o
         SEDAM8F5hTN/Bygh+PLnahqc1OYKMuYotMsc7mmb87RBcUH3/hg62R+sCjNvuWKArU
         bWAECAQrbkskMCLddfyex9YkhUi2/+1uczpBX8PcuqpwcG1rQXllYt+BK6JLzRDC6f
         rxU72NIA9Y2+3lh/hPNQ2VoltSCrirOZtyEmT5IieyXoGOp8dwwFvNvfofqCsU/YWR
         c+yew2lmI7U0A==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIN-001coV-VX;
        Sun, 26 Jun 2022 10:11:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/20] docs: zh_CN/vm: fix a typo for page reporting ReST file
Date:   Sun, 26 Jun 2022 10:10:53 +0100
Message-Id: <c7db8f975f461eaebd7ea7489ff9666d89e121c6.1656234456.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656234456.git.mchehab@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typo:
	_free_page_reporting.rst -> free_page_reporting.rst

Fixes: 9859b277bffe ("docs/zh_CN: add vm frontswap translation")
Fixes: adeacecbd36c ("docs/zh_CN: add free_page_reporting translation")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

 Documentation/translations/zh_CN/vm/free_page_reporting.rst | 2 +-
 Documentation/translations/zh_CN/vm/frontswap.rst           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/vm/free_page_reporting.rst b/Documentation/translations/zh_CN/vm/free_page_reporting.rst
index 31d6c34b956b..14336a3aa5f4 100644
--- a/Documentation/translations/zh_CN/vm/free_page_reporting.rst
+++ b/Documentation/translations/zh_CN/vm/free_page_reporting.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: Documentation/vm/_free_page_reporting.rst
+:Original: Documentation/vm/free_page_reporting.rst
 
 :翻译:
 
diff --git a/Documentation/translations/zh_CN/vm/frontswap.rst b/Documentation/translations/zh_CN/vm/frontswap.rst
index 3eb07870e2ef..98aa6f581ea7 100644
--- a/Documentation/translations/zh_CN/vm/frontswap.rst
+++ b/Documentation/translations/zh_CN/vm/frontswap.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/_free_page_reporting.rst
+:Original: Documentation/vm/free_page_reporting.rst
 
 :翻译:
 
-- 
2.36.1

