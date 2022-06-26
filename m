Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B0655B0AA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiFZJLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiFZJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E983812A92;
        Sun, 26 Jun 2022 02:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 753FA6117D;
        Sun, 26 Jun 2022 09:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72E9C34114;
        Sun, 26 Jun 2022 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234670;
        bh=cJAdzE6cV2DlHvyw9hpjiy9cvutFyMSVbizZ33cVoD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgxSIm1D9oSiXKcnmrXm4ggb0mKK6mHDif+GQKCkSYuZUO6Et2Z/rOkjicRy4aAcO
         xTmdKZy5Dt1PCKc95uyPr8nDIl47DeziSDeY65rdGfbWp/MU0gBcNI9Zj/sqSNjqiK
         WIhkphomy6RLKW5Qdz9yFDWP25wWC3lxHYdRgw1dYyDVKPjdZKPPbFf5DaL82jO2wO
         pz86sQmHE/GqU/4n0GfpHPBNTrWx+KJmUMWfCpar1HYzZoNv1oNPWeIhLlyUkYIG3/
         +pIBdcUBHIrd22GUme3ISMLY+xJgj0fnOoyxPgrzPIM83ShGxSEPRVpJNewXLtDp/w
         ZcB3B+PnUDO/Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIN-001coJ-Sl;
        Sun, 26 Jun 2022 10:11:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/20] docs: zh_CN: page_frags.rst: fix a broken reference
Date:   Sun, 26 Jun 2022 10:10:49 +0100
Message-Id: <a12e18044ddb2ca16a1fed10823d59558d6de405.1656234456.git.mchehab@kernel.org>
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
	page_frag.rst -> page_frags.rst

Fixes: f51debc256f8 ("docs/zh_CN: add vm page_frags translation")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

 Documentation/translations/zh_CN/vm/page_frags.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/vm/page_frags.rst b/Documentation/translations/zh_CN/vm/page_frags.rst
index ad27fed33634..38ecddb9e1c0 100644
--- a/Documentation/translations/zh_CN/vm/page_frags.rst
+++ b/Documentation/translations/zh_CN/vm/page_frags.rst
@@ -1,4 +1,4 @@
-:Original: Documentation/vm/page_frag.rst
+:Original: Documentation/vm/page_frags.rst
 
 :翻译:
 
-- 
2.36.1

