Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3B5553295
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350652AbiFUMyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350637AbiFUMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:54:49 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC3E12ADD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:54:44 -0700 (PDT)
X-QQ-mid: bizesmtp85t1655816007tx16ubgh
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 20:53:22 +0800 (CST)
X-QQ-SSF: 0100000000700050B000B00A0000000
X-QQ-FEAT: rCzLTtzQ0geQp+pbd93/gnp9dHiIBybiXO88mAETAH6V50Mq1S6Da4uNbPpKg
        hutvFwg6dHO7XAmvQgxuOW0+u4ckVI2yIZbf5JH/TsbWo6GkMAhl+x0iofAybpKF8Z4JKxs
        b/7pGt+Qs17VqDN4zMVjTtZ2UcIMyhIwujdv9NK0wWOh48Xtis1rL7TlXv/ecZAZ0xeclVy
        zlJUB6Y3a2oQfouHuRFEb5DVsRC1Nku/jzJtAQLIT1ZsJHADUFKx9x4hPQg3VBcsdNMdoTB
        mJY4CmnHOOn8A2G3EyAx81cBQBBf2x9LzhD9j2Htn8vjw2QToIjTalS64tkiEqJVLD1uUHg
        Oi6XsErJHDKu7zmxPcVBSC2CI7MCw==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de
Cc:     gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] cxl: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 20:53:21 +0800
Message-Id: <20220621125321.122280-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/misc/cxl/cxl.h
line: 1107
+/* check if the given pci_dev is on the the cxl vphb bus */
changed to
+/* check if the given pci_dev is on the cxl vphb bus */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/misc/cxl/cxl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 7a6dd91987fd..0562071cdd4a 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -1104,7 +1104,7 @@ extern const struct cxl_backend_ops cxl_native_ops;
 extern const struct cxl_backend_ops cxl_guest_ops;
 extern const struct cxl_backend_ops *cxl_ops;
 
-/* check if the given pci_dev is on the the cxl vphb bus */
+/* check if the given pci_dev is on the cxl vphb bus */
 bool cxl_pci_is_vphb_device(struct pci_dev *dev);
 
 /* decode AFU error bits in the PSL register PSL_SERR_An */
-- 
2.17.1

