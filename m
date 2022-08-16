Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D06596163
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbiHPRpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiHPRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:45:37 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C75E09
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:45:34 -0700 (PDT)
X-QQ-mid: bizesmtp75t1660671914tscq1yef
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 17 Aug 2022 01:45:03 +0800 (CST)
X-QQ-SSF: 0100000000200060D000B00A0000020
X-QQ-FEAT: DBLGDch1WOQHRlio3CcgavgMVmbBqFrToEHP8hQ7JKFA9hsvvdsKnfKjex2vX
        QoNcNnTbSgoT0VmpS68DcU3PbL2m3952p1S4L1eCy1GD7ahpnMFPKfzV2r1/AN9lRan2oFr
        GZ6mi9qx/9EhrqPVX/I568VMhki1EQHPGlijpju6TF1n6jk99XXCRUDdQ9RmJq3pifPQ3mx
        olLpixG1t2lJJFb6MKM06k+XbXkQ80qTZigm6yupBYH/1599YzcaSI3sV51sK7aQLWwW7hV
        +nmbMY8715HfDdMoLMBTOqCPBeROxmuVBjyZeP3DkFz9KP0UatOiGMinOXZPMf9ZtZXbqRY
        +NsMyKiwy9ENMcGHnnP7xZlKSJNKdPBeCQzNKz8g6sPgtdRs0bHRUYmKJxKJQ==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] ASoC: Variable type completion
Date:   Wed, 17 Aug 2022 01:45:02 +0800
Message-Id: <20220816174502.7902-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
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

'unsigned int' is better than 'unsigned'.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 sound/soc/codecs/pcm3008.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/pcm3008.h b/sound/soc/codecs/pcm3008.h
index f7f4fbbd89db..45270bcf1c02 100644
--- a/sound/soc/codecs/pcm3008.h
+++ b/sound/soc/codecs/pcm3008.h
@@ -10,10 +10,10 @@
 #define __LINUX_SND_SOC_PCM3008_H
 
 struct pcm3008_setup_data {
-	unsigned dem0_pin;
-	unsigned dem1_pin;
-	unsigned pdad_pin;
-	unsigned pdda_pin;
+	unsigned int dem0_pin;
+	unsigned int dem1_pin;
+	unsigned int pdad_pin;
+	unsigned int pdda_pin;
 };
 
 #endif
-- 
2.30.2

