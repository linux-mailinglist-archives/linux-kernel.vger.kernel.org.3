Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BAA5961C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 20:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbiHPSBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbiHPSBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 14:01:48 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9189A832F2;
        Tue, 16 Aug 2022 11:01:45 -0700 (PDT)
X-QQ-mid: bizesmtp88t1660672884t597l1k2
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 17 Aug 2022 02:01:12 +0800 (CST)
X-QQ-SSF: 0100000000000060D000B00A0000020
X-QQ-FEAT: 7L1V3dHhUFMh2NTXhq053RQm9at6l8q/2ycR4yxNdMJftm3mj9Jly9K7yivRd
        iLJ4k/eq41tID1yIYaDqUkPq1CF+Jdj8bKua422fur/yXFDPRcPFn3BX5HXdetF7Rma2hUH
        wgG9yN84vniTqaiyoHkztEuwaB87xgazBbdNzykhv2hzo2QX6Verh5mJc5S2mCePHGyH9w6
        mp+8KwZYolp2BLbJ/y2X0W8VCAFar+mw1eaME5OThSckJTAFmFM39aNTcEb/oTuRSVA47R3
        VEukSayidimeSO1eRDE9aDPzwb5ckR4DTAxUi/PMEvUKJwVwaeJN0ZUKUzbgdW3/3p1ltsU
        Ygvo6aCHr3WtgK/DNgfUM1ae+F1qg6r67hqDCRYuMB6t6nq/L4QJ/5tEd1qag==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     dhowells@redhat.com, jarkko@kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] KEYS: Variable type completion
Date:   Wed, 17 Aug 2022 02:01:10 +0800
Message-Id: <20220816180110.8625-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' is better than 'unsigned'.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 security/keys/keyctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 96a92a645216..4564505e7594 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -44,7 +44,7 @@ static const unsigned char keyrings_capabilities[2] = {
 
 static int key_get_type_from_user(char *type,
 				  const char __user *_type,
-				  unsigned len)
+				  unsigned int len)
 {
 	int ret;
 
-- 
2.30.2

