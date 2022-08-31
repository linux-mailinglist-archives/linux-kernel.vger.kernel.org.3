Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C9E5A7300
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiHaAva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHaAv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:51:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07D442AD9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:51:23 -0700 (PDT)
X-QQ-mid: bizesmtp65t1661907076t71dp7kp
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 08:51:15 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: +Fw3Sd5mYDV3NXJYi2PUaOKmNOiSsq1mENG/uF0kFpWPZnXyZd8lJOxo46/7Y
        z37j57He1ZFbyt74DzNB1W2ltcRgdFyte9VG+z+Mupni0VYUrY3iHxnjp62bMZkbahC00Uw
        qy7T/E/rVtxE5ZvbXz9Hdsev+hhbzUUq8Q7LPFy8P3In4MbYVGQ/wj+VbgiDE+Zh/ZcadSq
        d5Xgq1UG3C/YhqnE2P0PXnxQ0/vv1atGJxHW7TzGEl3Mrlql2cp5ZfotzL3A/nYDBW1HkaX
        2LIUE+6DZSR2Yy5Kyg52YYjyqApFZPaBQ0UUNOK4t2VC8oDoKZQ75vkmhL0qPTcUCA2tmIz
        MEdIjtOG5paTN9jMvIBLBWTDjawtF9M9DwNB8hcscKfYfSWKSI=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] powerpc/mobility: fix repeated words in comments
Date:   Wed, 31 Aug 2022 08:51:09 +0800
Message-Id: <20220831005109.38314-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 3d36a8955eaf..c92c78332303 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -216,7 +216,7 @@ static int update_dt_node(struct device_node *dn, s32 scope)
 		nprops = be32_to_cpu(upwa->nprops);
 
 		/* On the first call to ibm,update-properties for a node the
-		 * the first property value descriptor contains an empty
+		 * first property value descriptor contains an empty
 		 * property name, the property value length encoded as u32,
 		 * and the property value is the node path being updated.
 		 */
-- 
2.36.1

