Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CD05A4C70
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiH2MwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiH2Mvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:51:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A335E110E;
        Mon, 29 Aug 2022 05:39:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bh13so7582480pgb.4;
        Mon, 29 Aug 2022 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=fEf0pV+OPzHy8WyIpNckWTwEQxjCvSHSf17d7p43mVU=;
        b=ZK8+SgTptYbuWhsIQyc6mEDrMmMcX2Z3gctBdrB9CEw7Cml/ejjlEXJLihW9Wj0NqA
         JvczC7vdOAKZAoT4RMmvyJrVPIBBrr+o4VpQLQsclugES8Gld1qfMGxAAPTSESuMCBVw
         XBamqkyWNn24zWtFcU51g+ajQfbJga87E5IjtaFF1JaLIKccR9rpzWUaQGSsBRb4zePh
         AS7HHIDP4Hv/PjaW520MNDKFdAiJWCxZwiQlxDOIvwDBLo48WAoJWPPXbKuVe6PgMx3g
         N19c5fRqIiCGzMZF2DmexMoktbkdWtbuZubVLSuk7bw2n2TQfAdaDk2doerAidi6pmtR
         VKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=fEf0pV+OPzHy8WyIpNckWTwEQxjCvSHSf17d7p43mVU=;
        b=mBNcsadM7aBMX+Yst79Byi4FZX0ooSPAmkp4z0IyGS5aNENcpdJWrQ0G8EtEGXWToN
         oXK/EnxJtwbAuR+TvehFlxx7R2k0tyUonHiuPFl7AU3/Kb8WBm073pijzrqpzloW0R72
         q3udyNCSn1znn9WmIWoj4gu7tlTNygKAH+QmydOWihRT7Qhbtd3rzATdkBEkTa/6r2v8
         xQ12s48WtzvGX1WyWvcX6LfpNWHnn20cF5hftVr0MXCpedEF8Y5dkkvddlty1rwvwGMf
         m8BRJhYW32sKcKzBMvNv71HhqZ4k/njvVeMV54Z+45PSL4oXju0lIi2/PDKPC61cK5U8
         fLkA==
X-Gm-Message-State: ACgBeo0KW7Ey9T6IPaTjxlGFB/KNbVhH4U9wK/7aHXvW3FJbH8fviGih
        DmRTLGT553VBeu27p8iIkv4=
X-Google-Smtp-Source: AA6agR7mO1Griw3XzkfQsazvUPkd5+iIKjyWFO0U9q3nbsrJZ3tCdLWvl5uTaUpvpPClHTb0VqkFxg==
X-Received: by 2002:a05:6a00:ad1:b0:530:2cb7:84de with SMTP id c17-20020a056a000ad100b005302cb784demr16584389pfl.3.1661776787078;
        Mon, 29 Aug 2022 05:39:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b0016be596c8afsm7367157plk.282.2022.08.29.05.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:39:46 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     djogorchock@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] HID: nintendo: remove redundant variables ret
Date:   Mon, 29 Aug 2022 12:39:42 +0000
Message-Id: <20220829123942.268598-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Return value directly from __joycon_hid_send() instead of
getting value from redundant variable ret.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 drivers/hid/hid-nintendo.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 6028af3c3aae..eee569998e02 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -1378,7 +1378,6 @@ static void joycon_parse_report(struct joycon_ctlr *ctlr,
 
 static int joycon_send_rumble_data(struct joycon_ctlr *ctlr)
 {
-	int ret;
 	unsigned long flags;
 	struct joycon_rumble_output rumble_output = { 0 };
 
@@ -1403,9 +1402,8 @@ static int joycon_send_rumble_data(struct joycon_ctlr *ctlr)
 
 	joycon_enforce_subcmd_rate(ctlr);
 
-	ret = __joycon_hid_send(ctlr->hdev, (u8 *)&rumble_output,
+	return __joycon_hid_send(ctlr->hdev, (u8 *)&rumble_output,
 				sizeof(rumble_output));
-	return ret;
 }
 
 static void joycon_rumble_worker(struct work_struct *work)
-- 
2.25.1

