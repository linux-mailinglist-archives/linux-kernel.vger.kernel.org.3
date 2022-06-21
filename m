Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D049F5537A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353909AbiFUQNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354146AbiFUQNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:13:37 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B3D6571;
        Tue, 21 Jun 2022 09:13:32 -0700 (PDT)
X-QQ-mid: bizesmtp71t1655828007t8vpf67v
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 00:13:24 +0800 (CST)
X-QQ-SSF: 0100000000700090B000B00A0000000
X-QQ-FEAT: kx8LQfRSHcHF5JzcuCS9S4UVM7t1hm1fZBjnpoMwStvQtf9I7TtB2rx9ZZGe2
        gzNsqLnzf1x4I8y/0lW4JSw19IUO4Oi6VWmphARxZ21mQzSBq3Xj/FrsOxXtnB6rOT+zKyy
        AeLeD1GIk08uN1HDav4ayVTtzrrB+wnXj6zcc5VJiWDkH11Hb54ET74p1HBvqnLzBgY3NuA
        bxrHIJqiPejTYpy0xmZSXolAckexncXiK9LIPCPzRmd7kXJZMb6YO+Z25VTPJp/x/DxSHsk
        zNOxU5Y0a/5ZT3hwnj34jkoDv54Ndg6X/CtxwIxIAyj/Rpmh8Io6bqdB8Eg10y3sFRL2Ufb
        zX78WTG
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] of: base: Remove duplicate 'of' in two places.
Date:   Wed, 22 Jun 2022 00:13:22 +0800
Message-Id: <20220621161322.17739-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file: drivers/of/base.c
line: 1152,1177
* @matches:    array of of device match structures to search in
changed to
* @matches:    array of device match structures to search in

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/of/base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d4f98c8469ed..f738939cd283 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1149,7 +1149,7 @@ const struct of_device_id *__of_match_node(const struct of_device_id *matches,
 
 /**
  * of_match_node - Tell if a device_node has a matching of_match structure
- * @matches:	array of of device match structures to search in
+ * @matches:	array of device match structures to search in
  * @node:	the of device structure to match against
  *
  * Low level utility function used by device matching.
@@ -1174,7 +1174,7 @@ EXPORT_SYMBOL(of_match_node);
  *		you pass will not be searched, only the next one
  *		will; typically, you pass what the previous call
  *		returned. of_node_put() will be called on it
- * @matches:	array of of device match structures to search in
+ * @matches:	array of device match structures to search in
  * @match:	Updated to point at the matches entry which matched
  *
  * Return: A node pointer with refcount incremented, use
-- 
2.17.1

