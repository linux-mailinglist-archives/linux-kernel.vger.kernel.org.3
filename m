Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C69595BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbiHPMgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiHPMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:36:35 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842B594130
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:36:33 -0700 (PDT)
X-QQ-mid: bizesmtp90t1660653389tq5cfmij
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 20:36:28 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: RLrSOnjbvYFwkB/n0mwWIWtFVchHA9SvRxVl0Y01uIHbctXQj3ak5prBVWEWh
        pyR9iPDgbtMYMaC2ec26CtJayZJoVvnjFWcnTjd1hmlgChF1hR5x8EkaiurjVvaFHMNrW5p
        lR03xUHRs1yI0kKz/3lLewkqG13EKSYImLLU9WWlbND0FfIJiy6WHCbFMbNZM0J1CASGjs4
        H44zOag26c6BTuvtwca6KluxuDq0zavmUokQJ/KHHqCzz0TTX6oQ9U2r4WxpV5T8nFQNmk4
        lw+tAYHh0lMmI/3A6CnvEkfSJpGuJkmkK4Qf36jta5yLstbvAM/nUa/D8RuHdEoQv1fGVBV
        gInigQ2XIiPvML0iLwmwHb82WlUEffT20ANfCQgLv254WJI2Eu4RW/TXda754XRMx6nPkEo
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] soc/codecs: fix repeated words in comments
Date:   Tue, 16 Aug 2022 20:36:21 +0800
Message-Id: <20220816123621.10189-1-yuanjilin@cdjrlc.com>
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

 Delete the redundant word 'as'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 sound/soc/codecs/hdac_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 66408a98298b..98467667ef39 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1337,7 +1337,7 @@ static int hdac_hdmi_add_ports(struct hdac_device *hdev,
 
 	/*
 	 * FIXME: max_port may vary for each platform, so pass this as
-	 * as driver data or query from i915 interface when this API is
+	 * driver data or query from i915 interface when this API is
 	 * implemented.
 	 */
 
-- 
2.36.1

