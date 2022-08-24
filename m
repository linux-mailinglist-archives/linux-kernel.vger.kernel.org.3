Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99D59FABC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbiHXNBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbiHXNBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:01:05 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F6E979FB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:01:03 -0700 (PDT)
X-QQ-mid: bizesmtp62t1661346053ti9axgbk
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:00:52 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: znfcQSa1hKYHO1gX45sTNKeH1GcIr48myKvElCaFdXX4Yh+Ntz1JV2w8Srvvm
        1P5NupsHSAJGFT09LT9HZeS/pXp8CrMRoRepDVw3fm36Rw2xvAr8QxKM8S1FW0h1dSqVZ6r
        vZvgA6ukXFjh/BFBDLfPLAaRjnr+ZqkwioOd7EML2MNIoFw9k/K9cA3gbQT97r7uTNkMAkU
        swVyI2LcoYr9g/7vMOTkXbZ6Fa0N4ckqpibNc9fKYAYiVYmXexnsbVQqUk5W3CpykZ1YlTR
        Y/WX5fzHqurshg/0diUe44gcXa3OzPpAx+wk8u/7YziJm2bjED1+q8rSmKWqRW7wgq3x2kz
        Hd55sjfQJ9PjyDQclTlySh90gvm+F0PqjDWu0CLx+4vlQ/KXkI=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drm/vc4: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:00:45 +0800
Message-Id: <20220824130045.32211-1-yuanjilin@cdjrlc.com>
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
 drivers/gpu/drm/vc4/vc4_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index a2b5cbbbc1b0..f0290fad991d 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -264,7 +264,7 @@
  * output line.
  */
 # define SCALER_DISPSTAT_ESLINE(x)		BIT(10 + ((x) * 8))
-/* Set when the the downstream tries to read from the display FIFO
+/* Set when the downstream tries to read from the display FIFO
  * while it's empty.
  */
 # define SCALER_DISPSTAT_EUFLOW(x)		BIT(9 + ((x) * 8))
-- 
2.36.1

