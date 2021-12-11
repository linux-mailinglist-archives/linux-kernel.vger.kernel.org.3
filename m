Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2475B471310
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 10:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhLKJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 04:04:23 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:65310 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229455AbhLKJEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 04:04:22 -0500
X-QQ-mid: bizesmtp37t1639213344tpu7n3p3
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 11 Dec 2021 17:02:22 +0800 (CST)
X-QQ-SSF: 01000000008000D0H000B00A0000000
X-QQ-FEAT: hR9GyqeohSghM1ElQrnkgPt45yK/ReYtV8IATSrO12n/1LVzMECKREz9LKXxC
        Jj+Ww9DYFJb5BM0tEI+ngLwy2S4h2Fm759cFAoNFF+hFEHJaUSFY6zfw1t5TrIfln+XavwL
        pgZnhWWwI1y7a1Wm5nLtQBKcYz77nK78N2QlnttRcK7TzvRv+F5IKAxQWx6wKhdAd2u+W3W
        mf96YeNKKAYLaY0zNAHbkxe2xF7I8e1UcuGwcAxrewG3uea2U5lrMqmf6fewdb2/xedTn2/
        pq2PDBVjnC6AbnR7BHD4fKk1umJGI+gGSiTaoFw0ChR69BnYsoUGGXIKOuFELAe+iFmvlJ3
        quBpcTUednpYkItf51zypBYoXkdNS5ok+prynfl7wK0Afb9p0k=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     suzuki.poulose@arm.com
Cc:     mathieu.poirier@linaro.org, alexander.shishkin@linux.intel.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] coresight: core: fix typo in a comment
Date:   Sat, 11 Dec 2021 17:02:21 +0800
Message-Id: <20211211090221.241529-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' in the comment in line 732 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 8a18c71df37a..88653d1c06a4 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -729,7 +729,7 @@ static inline void coresight_put_ref(struct coresight_device *csdev)
  * coresight_grab_device - Power up this device and any of the helper
  * devices connected to it for trace operation. Since the helper devices
  * don't appear on the trace path, they should be handled along with the
- * the master device.
+ * master device.
  */
 static int coresight_grab_device(struct coresight_device *csdev)
 {
-- 
2.34.1

