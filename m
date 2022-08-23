Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D81559E86B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343916AbiHWRD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245431AbiHWRBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:01:41 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4A89819
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:09:12 -0700 (PDT)
X-QQ-mid: bizesmtp85t1661263742t9yhkbf8
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:09:01 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: 7jw2iSiCazoA2CrqQzokZA/mgo4Jlhw0CJqSq4DNXNufw5oX8LuejuTp7IYpJ
        FIs2fiQaJ/SeQUTGibUx6g0cwM6pbaMkoQ5rnaF0hDwKRCQR/yiMAe0EyXGQiW8nKpssBf3
        7Epy3HILmQ/zzxE4zCKN11KVxYHz2ffoW7MAPGAiy/u2hn2qvXGeKl7L6RFv/yCMbBQUSe+
        A9IA1RYusTO4xKN85ZRGvA8y7wh5Cwj0APfXFYIfOKSMFhmwbN2VXYjnNVeYV3nsABxdZlN
        YwmXxdlivp/Maw9izMq+kx/Ug6JZg2UvXuZP6Y5jOlW2HTQQQN7svidDDy23o4erTTP2nWO
        uGHBzhtIvr7lNYb9gN8DBXlpGv2TOaa9+64qgxRc8jw8TekGwY=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, aniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drm/gma500: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:08:54 +0800
Message-Id: <20220823140854.8045-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index 9ee99a7d4fbe..a286861ffa3f 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -114,7 +114,7 @@ i2c_algo_dp_aux_stop(struct i2c_adapter *adapter, bool reading)
 
 /*
  * Write a single byte to the current I2C address, the
- * the I2C link must be running or this returns -EIO
+ * I2C link must be running or this returns -EIO
  */
 static int
 i2c_algo_dp_aux_put_byte(struct i2c_adapter *adapter, u8 byte)
-- 
2.36.1

