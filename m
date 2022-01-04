Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37122483E69
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiADIoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:44:09 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54427 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231322AbiADIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:44:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V0vK7xY_1641285841;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V0vK7xY_1641285841)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jan 2022 16:44:01 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     myungjoo.ham@samsung.com
Cc:     cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] extcon: Fix some kernel-doc comments
Date:   Tue,  4 Jan 2022 16:43:59 +0800
Message-Id: <20220104084359.41051-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @id in extcon_sync() kernel-doc comment
and @edev, @id, @prop in extcon_set_property_sync() kernel-doc
comment to remove warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.
drivers/extcon/extcon.c:409: warning: Function parameter or 
member 'id' not described in 'extcon_sync'
drivers/extcon/extcon.c:750: warning: Function parameter or 
member 'edev' not described in 'extcon_set_property_sync'
drivers/extcon/extcon.c:750: warning: Function parameter or 
member 'id' not described in 'extcon_set_property_sync'
drivers/extcon/extcon.c:750: warning: Function parameter or 
member 'prop' not described in 'extcon_set_property_sync'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/extcon/extcon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index a09e704fd0fa..1e71ad489a83 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -399,6 +399,7 @@ static ssize_t cable_state_show(struct device *dev,
 /**
  * extcon_sync() - Synchronize the state for an external connector.
  * @edev:	the extcon device
+ * @id:		the unique id indicating an external connector
  *
  * Note that this function send a notification in order to synchronize
  * the state and property of an external connector.
@@ -736,6 +737,9 @@ EXPORT_SYMBOL_GPL(extcon_set_property);
 
 /**
  * extcon_set_property_sync() - Set property of an external connector with sync.
+ * @edev:	the extcon device
+ * @id:		the unique id indicating an external connector
+ * @prop:	the property id indicating an extcon property
  * @prop_val:	the pointer including the new value of extcon property
  *
  * Note that when setting the property value of external connector,
-- 
2.20.1.7.g153144c

