Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F565589B3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbiHDLxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDLx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:53:28 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B82D1BE8A;
        Thu,  4 Aug 2022 04:53:26 -0700 (PDT)
X-QQ-mid: bizesmtp75t1659614002tfudm0ov
Received: from localhost.localdomain ( [182.148.15.41])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 04 Aug 2022 19:53:21 +0800 (CST)
X-QQ-SSF: 01000000008000F0U000B00A0000020
X-QQ-FEAT: DRnj/z+Sqaetg1jnBkQ2U79IT3N/PQhV5Hh/TBQMekyeMBxEo9qD9QJ8EGYqf
        iEFu3gowZorJ6pt7P8xjzD6diUUxd9EDKmXBOQ1KW6piAWUtP6xJNljoJocRoM4+tU6tBKP
        YP3wiv/Y0+Wu1H7kLiyNl55BSdNYtjgYTpjcYs2q+D1l7mC24utIrADl3DVcixJ3ttHXIj0
        ZxGfRCEbB8WU4C6jP5FL8j+gwGbHD4y44W3kMuHN77CQU5aQzqSkNBK1SWZp7oCA/WOFgSv
        fYR2KeHi84ddJQkguG6yh8Rjl9wnPxhh6E82+gtpQ6dDwTpRAmXRdZMaPbdn7qhWcbmLz4B
        ALq3KBeHs9zH6OSdcBR06XMumh1igEo8yUhGnZ9TodnZc5VJ/WWlggAE1PYIJE+rJu+Ml0Z
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: dvb: Fix comment typo
Date:   Thu,  4 Aug 2022 19:53:18 +0800
Message-Id: <20220804115318.50405-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/dvb-frontends/tda10048.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
index d1d206ebdedd..0b3f6999515e 100644
--- a/drivers/media/dvb-frontends/tda10048.c
+++ b/drivers/media/dvb-frontends/tda10048.c
@@ -1118,7 +1118,7 @@ struct dvb_frontend *tda10048_attach(const struct tda10048_config *config,
 		state->pll_pfactor = 0;
 	}
 
-	/* Establish any defaults the the user didn't pass */
+	/* Establish any defaults the user didn't pass */
 	tda10048_establish_defaults(&state->frontend);
 
 	/* Set the xtal and freq defaults */
-- 
2.35.1

