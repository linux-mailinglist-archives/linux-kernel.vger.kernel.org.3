Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0C553DFA9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 04:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352131AbiFFC2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 22:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbiFFC2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 22:28:03 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948EA62EC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 19:27:58 -0700 (PDT)
X-QQ-mid: bizesmtp78t1654482203tle0beb6
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 06 Jun 2022 10:23:15 +0800 (CST)
X-QQ-SSF: 01000000000000C0G000000A0000000
X-QQ-FEAT: +i7PuHLNsE4Ix5ht+UHC/ONIXXVUd/otf/Yv16mrkqnK+G62jVoXJSlWlJWhd
        X1rykKVHwMQL0938fjtP1gXZXFmujcM7soXrJ1EInoHNI0wncGOCGpUYGtjar3npMEcfO4Q
        XPnFX4vervgv95NsIb+AzH0PJH3Xz8DUG06XOiC+jP7nT8Ik5e+0B+RXblJMdNfcGYx0amf
        jaseDKKDfPb/KLRHnd/dB6RrbwjEXEA0PzxW066cJYy7KbelysrvHUEGo24uDCECSu1ZoXO
        CUDSIzGBd+bGnjVC3avnjpaj3C9IMCb2EANxMIHMAEaaqt3SQTPTd/pFN3ktFMt8EJLppVR
        hmZznRoSgUXJjZAqrI=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     bleung@chromium.org
Cc:     groeck@chromium.org, gustavoars@kernel.org, dustin@howett.net,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] cros_ec_commands: Fix syntax errors in comments
Date:   Mon,  6 Jun 2022 10:23:13 +0800
Message-Id: <20220606022313.22912-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'using'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 include/linux/platform_data/cros_ec_commands.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index 8cfa8cfca77e..e59f51c41a1c 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -787,7 +787,7 @@ struct ec_host_response {
  *
  * Packets always start with a request or response header.  They are followed
  * by data_len bytes of data.  If the data_crc_present flag is set, the data
- * bytes are followed by a CRC-8 of that data, using using x^8 + x^2 + x + 1
+ * bytes are followed by a CRC-8 of that data, using x^8 + x^2 + x + 1
  * polynomial.
  *
  * Host algorithm when sending a request q:
-- 
2.36.1


