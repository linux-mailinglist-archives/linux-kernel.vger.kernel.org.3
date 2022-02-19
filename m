Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090594BC902
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 16:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbiBSPBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 10:01:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiBSPB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 10:01:29 -0500
X-Greylist: delayed 1776 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 19 Feb 2022 07:01:04 PST
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEEC184638
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 07:01:03 -0800 (PST)
X-QQ-mid: bizesmtp82t1645282837tbq8knbj
Received: from localhost.localdomain (unknown [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 19 Feb 2022 23:00:21 +0800 (CST)
X-QQ-SSF: 01400000002000C0N000000A0000000
X-QQ-FEAT: 4LFlwc+MlXnQvAP4Ajb6R2e304rC6lITEw06KnD5KDTOjjqHu3c+0XEuEMol1
        ZyMSPjX7s9bdfKW/wZSZpy2YbJQlOf+B8J0sJEJPWb+xxhx63+2cv3g0Cs6efuT30B7vVzc
        nfFztjNY6+H9Tomaj5KlqR+6cDNa0DC5C3XXxUfMRchNAMb4vSjSzRwSnhGH8v10UMk6xIt
        b+3RRB/fUlcYDnMiWmZeP2Jxx1Dd8KVL9r2UCoCx86K40DRVdynf/LuLVlE0zMJto+QJoEj
        3V74q9Rh+2HR1YBk4+KsVZzBNxKbIA1q3ZXkSab+98sxIJ0bqz91osmF20QEQv2LXXjfOnp
        BymMyjXnt+pBVovvsVAc3bHbN9BqsfNnFREivWl
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     corbet@lwn.net
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        hanshenghong2019@email.szu.edu.cn, weizhenliang@huawei.com,
        georgi.djakov@linaro.org, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] Documentation/vm/page_owner.rst: fix a function's description
Date:   Sat, 19 Feb 2022 23:00:19 +0800
Message-Id: <20220219150019.3565-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In "additional function",
The description of "-f" option should be
Filter out the information of blocks whose memory has been released.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 Documentation/vm/page_owner.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 2b54e82b9fe1..d371f631b60e 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -126,4 +126,4 @@ Usage
 		-c		Cull by comparing stacktrace instead of total block.
 
 	Filter:
-		-f		Filter out the information of blocks whose memory has not been released.
+		-f		Filter out the information of blocks whose memory has been released.
-- 
2.31.1



