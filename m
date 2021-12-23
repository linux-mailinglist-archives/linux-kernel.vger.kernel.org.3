Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8266247E652
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349071AbhLWQXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:23:05 -0500
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:56689 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244591AbhLWQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:23:03 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 0QrtnMs08IEdl0QrtnhHRO; Thu, 23 Dec 2021 17:23:02 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 23 Dec 2021 17:23:02 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        lokeshvutla@ti.com, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] firmware: ti_sci: Fix compilation failure when CONFIG_TI_SCI_PROTOCOL is not defined
Date:   Thu, 23 Dec 2021 17:23:00 +0100
Message-Id: <e6c3cb793e1a6a2a0ae2528d5a5650dfe6a4b6ff.1640276505.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an extra ";" which breaks compilation.

Fixes: 53bf2b0e4e4c ("firmware: ti_sci: Add support for getting resource with subtype")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 include/linux/soc/ti/ti_sci_protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 0aad7009b50e..bd0d11af76c5 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -645,7 +645,7 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 
 static inline struct ti_sci_resource *
 devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
-			 u32 dev_id, u32 sub_type);
+			 u32 dev_id, u32 sub_type)
 {
 	return ERR_PTR(-EINVAL);
 }
-- 
2.32.0

