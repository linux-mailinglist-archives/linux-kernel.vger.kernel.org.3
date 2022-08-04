Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB8C589B31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbiHDLsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDLsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:48:07 -0400
Received: from bg5.exmail.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6234F65B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:48:06 -0700 (PDT)
X-QQ-mid: bizesmtp64t1659613676to75nwmc
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 19:47:54 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: D2GZf6M6C/jjswy3ORhVLlvpqecF+t4ix1O1Cutz9c0tIIu8jsNH991133ObA
        J5T+FYyaWHtvHYnKshQvwh2MA5PLjr2rka+y9IARyJVto+jmYFGdVNe1V9/E7R8Qrl7ATMH
        jOYW8rTV1wC2PnZ29/LK3C3QCP62nnKmDc5wjvEzF3GC1gHBnXQ4Tr0AWzikezNAjnsKY0r
        fjDq6tzgMA3hr99/lgqPi/iHrRblNijA+mIEMunbTOlW7kUampjVaVqt+MZHttj/cFDXzVk
        EAjjC+NPfMzCa+p02JHqYlu/BkUpivzjlSbQc2RU16o1cQwRR51bl1pytAQFHNaEMwryEsH
        YGwmCcC9Rt7DchalhX/0o8U7/6alnWJ4PTkJ//DbeHIMaRtt2gapDANho0DAEeqvZ1m1dBq
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     airlied@linux.ie
Cc:     patrik.r.jakobsson@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] drm/gma500: Fix comment typo
Date:   Thu,  4 Aug 2022 19:47:51 +0800
Message-Id: <20220804114751.46714-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
index bb2e9d64018a..53b967282d6a 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
@@ -115,7 +115,7 @@ i2c_algo_dp_aux_stop(struct i2c_adapter *adapter, bool reading)
 
 /*
  * Write a single byte to the current I2C address, the
- * the I2C link must be running or this returns -EIO
+ * I2C link must be running or this returns -EIO
  */
 static int
 i2c_algo_dp_aux_put_byte(struct i2c_adapter *adapter, u8 byte)
-- 
2.35.1

