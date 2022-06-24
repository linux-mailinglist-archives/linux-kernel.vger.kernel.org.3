Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D61558CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 03:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiFXBNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 21:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiFXBNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 21:13:00 -0400
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB90E93
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 18:12:55 -0700 (PDT)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id SXK00150;
        Fri, 24 Jun 2022 09:12:50 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2308.27; Fri, 24 Jun 2022 09:12:50 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <robh+dt@kernel.org>, <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] of: base: Modify function description
Date:   Thu, 23 Jun 2022 21:12:47 -0400
Message-ID: <20220624011247.1735-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2022624091250600996e285f3d649f81acdce0972862c
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete duplicate words of "the".

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d4f98c8469ed..88f86ee54b9a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2077,7 +2077,7 @@ struct device_node *of_find_next_cache_node(const struct device_node *np)
  *
  * @cpu: cpu number(logical index) for which the last cache level is needed
  *
- * Return: The the level at which the last cache is present. It is exactly
+ * Return: The level at which the last cache is present. It is exactly
  * same as  the total number of cache levels for the given logical cpu.
  */
 int of_find_last_cache_level(unsigned int cpu)
-- 
2.27.0

