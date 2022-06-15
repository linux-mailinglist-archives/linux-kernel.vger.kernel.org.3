Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF22654C66F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbiFOKpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244097AbiFOKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:45:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED2651585;
        Wed, 15 Jun 2022 03:45:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v19so15523622edd.4;
        Wed, 15 Jun 2022 03:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0P+2ycIPfEXzSOt85zHiD/ynpCkJhE/8jTCsWqxMHAc=;
        b=oGswadRGlbzc30T6VkRcMrhIadQFGnUgpO4ULYVZVE3Pi3cEdB8BC8lqmUV1xSXFaK
         jBTlZJ16YdZuPJuFANZioND+/26KH94L+HbhkXSjPpPtJZ5Bpm3UEOmR4EkbvKQtRjoY
         NQ0nLGgB5nYRCT4mNqBTgh42rfkaBA6+qhQLC7bfH5Bw9hmhhyUarB5bK8a39cUo4kvW
         vBVr583L9EsxQYaGDgZ1/JwyFbb8JmTqoLuD2bNs1m6eXW4JhhMwBU72CbkHJgYrl4e8
         K1l4m2IDxU3zTSkhOZ6kv76DFbQhKmlKDaK9BN50jh0Rv8Ir4mKIY/R9UCr2XfaH8vqp
         qZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0P+2ycIPfEXzSOt85zHiD/ynpCkJhE/8jTCsWqxMHAc=;
        b=houm8Uu+0HZosK4klNJ+vyhMG+6vKGDcJefety2LSKiV6oppAl4Ckq8d4QS8VdnZ/A
         dHEBlbjzNoGnKehNDWRWJV54y7ZPMCYcEdh2A1zzLWhRFKDDAjlHmz4CiQdy96LJijAS
         RKKdUIgI3Mzog8zjnN8QMfYtnCm8h1hVHTs4qn1iXvdP6N7/6Um7FOqHYCH4e+iSHJ7B
         l8VRcoO2SKKbIptJ9hcalkSoGyRbESrFuh7oCrU1JpBuSf951MINfyeuVZmFEl1L+DU2
         v8jwFB7u7nZHWH3CSRXYuN7+mcYthb6rOjjn4sa9WiOP28F2Ln5jQWNd209HQY4g8i9w
         XsEQ==
X-Gm-Message-State: AJIora9uZrZt0B5T/jkTUUE2Zih8ZhuaOaC5E2vuGFWMnondodQ4Uwas
        6NV2GPaDa7+8d5P5SxNzmuU=
X-Google-Smtp-Source: ABdhPJwewuxvGqr64410LjSPkD6Wg8bhtB3r3O/8zW6VW3tTXh8h8y3w//Ag/8akFarecarGcrTX2A==
X-Received: by 2002:a05:6402:2381:b0:42d:c8fe:d7fe with SMTP id j1-20020a056402238100b0042dc8fed7femr11834124eda.248.1655289936134;
        Wed, 15 Jun 2022 03:45:36 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1a9e008d6dafec091202b8.dip0.t-ipconnect.de. [2003:cf:9f1a:9e00:8d6d:afec:912:2b8])
        by smtp.googlemail.com with ESMTPSA id l13-20020a056402254d00b0042617ba637bsm9347393edb.5.2022.06.15.03.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:45:35 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Michael Carns <mike@carns.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add missing comma in board name list.
Date:   Wed, 15 Jun 2022 12:45:20 +0200
Message-Id: <20220615104520.35687-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
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

From: Michael Carns <mike@carns.com>

This fixes a regression introduced by commit 5b4285c57b6f
("hwmon: (asus-ec-sensors) fix Formula VIII definition")
where coma lead to concatenating board names and broke module
loading for C8H.

Signed-off-by: Michael Carns <mike@carns.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 886a71b4c64e..19d3ca71b360 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -268,7 +268,7 @@ static const struct ec_board_info board_info[] = {
 	},
 	{
 		.board_names = {
-			"ROG CROSSHAIR VIII FORMULA"
+			"ROG CROSSHAIR VIII FORMULA",
 			"ROG CROSSHAIR VIII HERO",
 			"ROG CROSSHAIR VIII HERO (WI-FI)",
 		},
-- 
2.35.1

