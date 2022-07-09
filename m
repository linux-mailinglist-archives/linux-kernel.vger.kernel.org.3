Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326DC56C8C2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiGIKIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiGIKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:07:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD6D4AD79;
        Sat,  9 Jul 2022 03:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55542B81B1A;
        Sat,  9 Jul 2022 10:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830D5C341E2;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=Cf8rdzXtBWb56Py9rE/FtY3/HNucORFD8nntHMZHLeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AGZnlO8nt8y+ajvsUg0xbappgBlJSJePT6oEYb6FNAPqPodR64eKG4TSutdUA6S17
         gbu5LfchxwbYtfifbmYMUauRKo+2EolToKl1zGQt14GcU9PDCJkJDgx2mDqQx6xMQ+
         ykPgsM4LUTz9sxrGbAWeyDEpstIQVNxjFPUv/4Gt77QpwEW7mDKbyQklv9O3mNWHHH
         07B5UcmuGdFKgGiaDXiTMVdKPBVdOdE2Hb35dw19v3p+1M68hg4YkL/fiSM3lR2Aei
         vsLAngxdtErEDWQtOrrCoTOTQZdsOXXWRTwzO/OfU1+wbB2TE7oHyJkF7zX4uZisE6
         j8yyfkLO66K7A==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EH0-Js;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/21] genalloc: add a description for start_addr parameter
Date:   Sat,  9 Jul 2022 11:07:25 +0100
Message-Id: <ae3b70d694924214ab708d60d2a30d7f2622d2c2.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
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

Copy the same description as found at lib/genalloc.c, fixing
this warning:

	include/linux/genalloc.h:54: warning: Function parameter or member 'start_addr' not described in 'genpool_algo_t'

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

 include/linux/genalloc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
index 0bd581003cd5..2a67a54e5018 100644
--- a/include/linux/genalloc.h
+++ b/include/linux/genalloc.h
@@ -44,6 +44,7 @@ struct gen_pool;
  * @nr: The number of zeroed bits we're looking for
  * @data: optional additional data used by the callback
  * @pool: the pool being allocated from
+ * @start_addr: virtual starting address of memory chunk to add to pool
  */
 typedef unsigned long (*genpool_algo_t)(unsigned long *map,
 			unsigned long size,
-- 
2.36.1

