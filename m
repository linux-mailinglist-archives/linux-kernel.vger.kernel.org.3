Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41684C146C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241025AbiBWNmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiBWNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:42:17 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D27850059
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:41:44 -0800 (PST)
X-QQ-mid: bizesmtp76t1645623681t10dlvj5
Received: from localhost.localdomain (unknown [202.96.137.248])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 23 Feb 2022 21:41:07 +0800 (CST)
X-QQ-SSF: 01400000002000D0N000B00A0000000
X-QQ-FEAT: FXvDfBZI5O5sGOdRkLPXVG6Eb4fbEwp/IlmIxAq7UFvDk9EDMiwtbSlLouB9W
        6oo1ip+Zbdfkc7CsiEa4E96g+tI+hiXYvY1UUQkwDKi0T1O39vgbTS1/qeG7NmeXP+0lGF/
        p3QHbUMI2K0jBM6NCopwW/Bi9c6KwjlmdjP0I5URlZWEd59PBuhRbBF5dzWyr/2K8ysGJ5w
        gvgft6HD+5cg0UpSKinBdV3I+niu+wDTmKcB5QFdFO+2+0HSKhkDbDrf6F4A4cU/QJdLJ7W
        hbLEHHPPyBMSAg9OzA/uH5cRBVxCOiA8cA2tn1iYNsQ3elu7LOsO6Ub2qmh8GE6nyrCjDQ0
        6M/x754aCDmlh2TnIoKcgayxlKHNOWTanE9og5y1c5SkdCfL4c=
X-QQ-GoodBg: 2
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     corbet@lwn.net
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        hanshenghong2019@email.szu.edu.cn, weizhenliang@huawei.com,
        georgi.djakov@linaro.org, skhan@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] Documentation/vm/page_owner.rst: fix commends
Date:   Wed, 23 Feb 2022 21:41:04 +0800
Message-Id: <20220223134104.2663-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some commends that need to be fixed.

Thanks for Shuah Khan's constructive suggestions.
The commends have been fixed as follows.

a. So, if you'd like to use it, you need
to add "page_owner=on" into your boot cmdline.

Here, "into" has been replaced with "to".

b. ...page owner is disabled in runtime due to no
enabling, boot option, runtime overhead is marginal.

Here, "no" has been replaced with "not".

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 Documentation/vm/page_owner.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 2b54e82b9fe1..aec1906976f4 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -26,9 +26,9 @@ fragmentation statistics can be obtained through gfp flag information of
 each page. It is already implemented and activated if page owner is
 enabled. Other usages are more than welcome.
 
-page owner is disabled in default. So, if you'd like to use it, you need
-to add "page_owner=on" into your boot cmdline. If the kernel is built
-with page owner and page owner is disabled in runtime due to no enabling
+page owner is disabled by default. So, if you'd like to use it, you need
+to add "page_owner=on" to your boot cmdline. If the kernel is built
+with page owner and page owner is disabled in runtime due to not enabling
 boot option, runtime overhead is marginal. If disabled in runtime, it
 doesn't require memory to store owner information, so there is no runtime
 memory overhead. And, page owner inserts just two unlikely branches into
-- 
2.31.1



