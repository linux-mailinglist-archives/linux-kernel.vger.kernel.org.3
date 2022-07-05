Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC285661E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 05:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiGEDd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 23:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiGEDdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 23:33:24 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C9C333;
        Mon,  4 Jul 2022 20:33:22 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id q16so12063263qtn.5;
        Mon, 04 Jul 2022 20:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypaL1IlKXP58U4eXRSooCnlyHaXsyMRpZ//5TtTmBio=;
        b=X2SywJSYXMntQ7t2YKLNDWkpQjo903ga7rqfyVpl7K8WcADt72aOnj13360+8hlCmE
         JPvsSTllQm4zSU9kVMOAKIf1UH+a7DazNIQLJIqw/bKSElfOJpcG46K8A28o0OZPfZi0
         klKF3zqQHDbCCwAUJmCV+004BetHWJ7wrK6oadiQWDr4SmMixCS/PgsnxBbTsAxUsn7c
         6vbsySBpSiSxoVxSDvfQW/NK8J6QdK2hze1yjnDbesKwpibi+YkoK23Pp5wW0QnfhtOk
         5bFtzNKj8b4yfYuFfzfm57L52zsej+dLLb0OQOOAHArbv8gSgI2eapgcTeGnFOrdYLjm
         JT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypaL1IlKXP58U4eXRSooCnlyHaXsyMRpZ//5TtTmBio=;
        b=nAUYc48pUengwsQUPMNTQxt8yZeAWuLpHVS6y8rDZLYGeiaBZwxS2afU/mfWWlZCto
         BzljPpZWmEo6AMgb8IwnCuQllOBPlq/MrClcYM4RqLwH3Ii7fUvfpTO1sAnyIKKBfEEa
         zeFptiAH1fELY4MVotvBg0uZKpqcjEmxBZKx+2l7uDwnnrn4zyTHS07bDUraoRkqaKR8
         gvkQOFksFbtzjHj+xwKJV8gDYicRRrdNbkJUK9QrUdaX4EWWm8RFxOZntuD0biY3fJ4h
         F4PJ/sRgbpHxG5hffowCbTw9i+GZS/7x9kCFflSs3HQ2Ly5NqsnwqmYMMcPCAPQJp1mm
         J9VA==
X-Gm-Message-State: AJIora9YvVTTXOnaRUwFzMVX7A86I3AZuS34XfcKO1Ff/TQsCAta1aTp
        S1fNE570d6uScSRVIjwAYNE=
X-Google-Smtp-Source: AGRyM1sGgVAwneyhQ2ThYjuGZTrc72GeAQD7nFraX4FFObM9HqTuGaX848deBZFJl4TJbhyg4lpLKw==
X-Received: by 2002:a05:622a:120e:b0:31b:f5d8:c63c with SMTP id y14-20020a05622a120e00b0031bf5d8c63cmr26487017qtx.316.1656992001422;
        Mon, 04 Jul 2022 20:33:21 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id az16-20020a05620a171000b006af4a816963sm19147037qkb.133.2022.07.04.20.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jul 2022 20:33:20 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     myungjoo.ham@samsung.com, sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH] power: supply: Fix typo in power_supply_check_supplies
Date:   Tue,  5 Jul 2022 11:32:44 +0800
Message-Id: <20220705033244.5791-1-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
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

It seems to be a typo, there is no actual BUG, but it's better to
fix it to avoid any possible BUG after we change the type of
supplied_from.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index fad5890c899e..02228d68c599 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -263,13 +263,13 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		return 0;
 
 	/* All supplies found, allocate char ** array for filling */
-	psy->supplied_from = devm_kzalloc(&psy->dev, sizeof(psy->supplied_from),
+	psy->supplied_from = devm_kzalloc(&psy->dev, sizeof(*psy->supplied_from),
 					  GFP_KERNEL);
 	if (!psy->supplied_from)
 		return -ENOMEM;
 
 	*psy->supplied_from = devm_kcalloc(&psy->dev,
-					   cnt - 1, sizeof(char *),
+					   cnt - 1, sizeof(**psy->supplied_from),
 					   GFP_KERNEL);
 	if (!*psy->supplied_from)
 		return -ENOMEM;
-- 
2.29.0

