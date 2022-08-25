Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712055A17FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242615AbiHYRbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiHYRbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:31:53 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2562EB600F;
        Thu, 25 Aug 2022 10:31:45 -0700 (PDT)
X-QQ-mid: bizesmtp82t1661448589tbgqaz6c
Received: from wuhui-virtual-machine.localdoma ( [116.7.245.180])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 26 Aug 2022 01:29:35 +0800 (CST)
X-QQ-SSF: 01400000002000E0T000B00A0000000
X-QQ-FEAT: 3M0okmaRx3hU7bf7kODaNBIBB2rrtblyiMQOLkf+ftjfLU3x7cvQV2De3c4nZ
        qhRkOtSglXZ730gsqEhRVMDJCHjzY7ENiP4QQ+q/FqNOmcYotIzYEiyT17i8IwCDlbvGpL9
        jFzeAThNxJa4PSRkrDSM+D1mwrfa/Cm554cbAmD4N3xEwIkC7tbwxgxAaDpR3elTweHfUW9
        txJIWOFs6sQvxCcK7smIcO4AKO6WRGDH+qaGOO7oHsvxTqkWJdXd9payFFScHzse7C65EHY
        L5OA7nQaK+69vHbLAL6UcVkttHpkQ7k1qUx8HpVPxsG1aIpuuvs/lDOQHlKR8d62YYgjeB9
        yuW16AAI1EX4Bu+MczwlbVczJDEIFG4lakzRBfvSMa99FRP5oA=
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, yejiajian2018@email.szu.edu.cn,
        skhan@linuxfoundation.org, akiyks@gmail.com, rppt@kernel.org,
        zhangyinan2019@email.szu.edu.cn, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] Documentation/mm/page_owner.rst: update experimental data
Date:   Fri, 26 Aug 2022 01:29:34 +0800
Message-Id: <20220825172934.4344-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed some experimental data need to be updated.

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 Documentation/mm/page_owner.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
index f18fd8907049..8e2545bb4e17 100644
--- a/Documentation/mm/page_owner.rst
+++ b/Documentation/mm/page_owner.rst
@@ -41,17 +41,17 @@ size change due to this facility.
 - Without page owner::
 
    text    data     bss     dec     hex filename
-   48392   2333     644   51369    c8a9 mm/page_alloc.o
+   58581   3166     652   62399    f3bf mm/page_alloc.o
 
 - With page owner::
 
    text    data     bss     dec     hex filename
-   48800   2445     644   51889    cab1 mm/page_alloc.o
-   6662     108      29    6799    1a8f mm/page_owner.o
-   1025       8       8    1041     411 mm/page_ext.o
+   59085   3294     652   63031    f637 mm/page_alloc.o
+   7464     125      28    7617    1dc1 mm/page_owner.o
+   1396      32       8    1436     59c mm/page_ext.o
 
-Although, roughly, 8 KB code is added in total, page_alloc.o increase by
-520 bytes and less than half of it is in hotpath. Building the kernel with
+Although, roughly, 9 KB code is added in total, page_alloc.o increase by
+632 bytes and less than half of it is in hotpath. Building the kernel with
 page owner and turning it on if needed would be great option to debug
 kernel memory problem.
 
-- 
2.17.1


