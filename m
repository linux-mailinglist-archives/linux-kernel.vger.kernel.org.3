Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2C558FBE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbiHKMIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiHKMIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:08:04 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981BC923E8;
        Thu, 11 Aug 2022 05:08:02 -0700 (PDT)
X-QQ-mid: bizesmtp82t1660219665t9nj96eo
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:07:44 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: XBN7tc9DADKJnmk6DcNav8bT+HU0zq14jnTofoS9qginj1yePo8pGbSIxM1Ap
        swE1CEgBseoyFkUYa5i3DjTY2Vh/yORSSwM28nE95ZRaf+Cv618ODtpbfaxG48cL878AsPy
        JJnXeED/YwDbAy7qA1yYUvyVxlUmS0VJmoWnjEAwd2tBrnBLZmvFDv1mXub+j0Bpvi2c81I
        ZrZFqphpklmZ5rZD4+60O3DlXuUn8AsnauTc8v5TIHd1Lr9kSbCf08FAWLXrGKqwwM76Aix
        7sKeB2U+XnDUhVMDXooUpaQASHuzsqIb/QJ35JbqQ72Az8rp6RodA+n1/zM4uoyLn3miNzO
        R0ZYx1byNgwKs0fC+d246X2bQOd6818TTGC6PvkhhJyIgDACgIPjnhVg/uWuqLOmBDf+9WY
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     gcherian@marvell.com, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] crypto: cavium - Fix comment typo
Date:   Thu, 11 Aug 2022 20:07:05 +0800
Message-Id: <20220811120705.15605-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
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

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/crypto/cavium/cpt/cpt_hw_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/cpt/cpt_hw_types.h b/drivers/crypto/cavium/cpt/cpt_hw_types.h
index 8ec6edc69f3f..ae4791a8ec4a 100644
--- a/drivers/crypto/cavium/cpt/cpt_hw_types.h
+++ b/drivers/crypto/cavium/cpt/cpt_hw_types.h
@@ -396,7 +396,7 @@ union cptx_vqx_misc_ena_w1s {
  * Word0
  *  reserved_20_63:44 [63:20] Reserved.
  *  dbell_cnt:20 [19:0](R/W/H) Number of instruction queue 64-bit words to add
- *	to the CPT instruction doorbell count. Readback value is the the
+ *	to the CPT instruction doorbell count. Readback value is the
  *	current number of pending doorbell requests. If counter overflows
  *	CPT()_VQ()_MISC_INT[DBELL_DOVF] is set. To reset the count back to
  *	zero, write one to clear CPT()_VQ()_MISC_INT_ENA_W1C[DBELL_DOVF],
-- 
2.36.1

