Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6E59FB65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbiHXNaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237450AbiHXNac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:30:32 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305D653D29;
        Wed, 24 Aug 2022 06:30:26 -0700 (PDT)
X-QQ-mid: bizesmtp86t1661347754tyglzwgb
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 24 Aug 2022 21:29:13 +0800 (CST)
X-QQ-SSF: 01000000002000C0E000B00A0000000
X-QQ-FEAT: szTy5SWxjRks+Bzw59zguH4g/YqgW6pBQAg7ogv2q+sUnQ7QlHf8NBvO1YDe8
        QE4KxO3LJhmnAvwLo3orVtEoIJ1h3ZL3LzSOVU7SSd8BLZQxinGh25NnwyZOeiUInceCBo8
        t1OZJKIyV0iUdfiULuOdGW7VDLPW4GJtk8Rs3StLHSGu5mlZgCWB/1t7z/39Ap9ZchViWJA
        2jlgAAW4NiZjaNUfP0oEtpl3rrMUxA9dELwWS1nCTpjlYzNgcoU107hz+W0M8HSwl6KVs76
        dpmjwnxEZ6pJQVs+1TkOsmsRQ2Avxc7BoyPoOR0mpC1rXTQ5sBx+PogO3uULOlyjHnsgeHA
        xvTVpyggHLhkHzgMUv+lZmo3+j524VL0sgPnx/NalUHhBgkvtYlbcse+bHFAeuyKH/uovKj
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] pci/cx18: fix repeated words in comments
Date:   Wed, 24 Aug 2022 21:29:07 +0800
Message-Id: <20220824132907.63186-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'of'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/pci/cx18/cx18-firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx18/cx18-firmware.c b/drivers/media/pci/cx18/cx18-firmware.c
index fdac310d7477..1b038b2802bf 100644
--- a/drivers/media/pci/cx18/cx18-firmware.c
+++ b/drivers/media/pci/cx18/cx18-firmware.c
@@ -248,7 +248,7 @@ void cx18_init_power(struct cx18 *cx, int lowpwr)
 	 *
 	 * Many thanks to Jeff Campbell and Mike Bradley for their extensive
 	 * investigation, experimentation, testing, and suggested solutions of
-	 * of audio/video sync problems with SVideo and CVBS captures.
+	 * audio/video sync problems with SVideo and CVBS captures.
 	 */
 
 	/* the fast clock is at 200/245 MHz */
-- 
2.36.1

