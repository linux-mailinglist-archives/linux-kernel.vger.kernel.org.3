Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6446850F154
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiDZGpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343524AbiDZGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:44:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A65FD36
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:41:21 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k2so3515479wrd.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J4tC84WDnGWKXHk8A2ip3/SUHhJiwykkygcCLy7ZG3M=;
        b=q2dhjUAABiVeC6Em5zKVCnViGpVUUOW2I4YSRya8dguehmirQjNOmrah76tZuQBp/l
         Bp6lyecUxlwNZfQ/zDahwkcSciiMsEMh0Y9viZfnlDhcP9pi2z7xLEzTT6oNqMuHtjKG
         J7Kn7/NrorXbV6zvOdWoMUDca1mQqA6FncO1Ocuv8gR2dUn0rodVw1ZsJUAD6YjVM+A4
         1G8iMH8E5RvfkFxVxMgGVTf74OCHyz/STdupWqG6vj/C106wBGuIoa6p91HtULI7jwUG
         spaDgyOA3VqlIQ2iJU7SxeE2OFj0Rpwzj3Y9WhZ3ONWCl/VCWQ/r/5bwlhN4OdgOlad6
         kIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J4tC84WDnGWKXHk8A2ip3/SUHhJiwykkygcCLy7ZG3M=;
        b=c9HYPgkmXEjgPQznK4DIyzlWA3gCv7R/+IIz5PalvHpUj6PFlqRICh7qz0GwD+vsCu
         b97oBaCJQGKhVtXfuH7LXaQzKFBglcOpB593Dq0AQwbRODKp9qKkhPvkIxpVbhpF5wt9
         m3cDShmaxg3Ol9CN9SV3aqZHo7oIW4stQgk/s1fjNCXphRDgjgH8uu6GHZBqyCXiO+YR
         +/AfgsaUOolIVvlvYnBRdfT9zUGrWYs5OR41cWB4oB4WexTz8tyqf5YSmv7YjkeK2P5e
         IxsqVUwBTyNAnEY35ATmg+kGSRHNR0Afah7FGRnrHvFUFVjfugxpweI3ztjiK1BNNVdC
         1DoA==
X-Gm-Message-State: AOAM531i/OlhXUmXd9emXIDLeaMTjg+OUh3R2ZMv2opqMx6/B/fPuBa+
        nSID0sPyI9SAvW0vUxpyEzlLPQSLO6G2nw==
X-Google-Smtp-Source: ABdhPJxxLdGpWyDF3ZLOHrmbGFENDP469dDaGp3hSGgRcQQz1ogYATB8V3giSHft4XpQCY4ilTfHyw==
X-Received: by 2002:adf:eb4d:0:b0:1ed:c1f7:a951 with SMTP id u13-20020adfeb4d000000b001edc1f7a951mr16504691wrn.454.1650955279990;
        Mon, 25 Apr 2022 23:41:19 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j13-20020a05600c190d00b00393ee555683sm4216157wmq.27.2022.04.25.23.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 23:41:19 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     amitk@kernel.org, daniel.lezcano@linaro.org, rafael@kernel.org,
        rui.zhang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] thermal: thermal_of: fix typo on __thermal_bind_params
Date:   Tue, 26 Apr 2022 06:41:13 +0000
Message-Id: <20220426064113.3787826-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing s to __thermal_bind_param kernel doc comment.
This fixes the following sparse warnings:
drivers/thermal/thermal_of.c:50: warning: expecting prototype for struct __thermal_bind_param. Prototype was for struct __thermal_bind_params instead

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/thermal/thermal_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index da484800906f..b65d435cb92f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -35,7 +35,7 @@ struct __thermal_cooling_bind_param {
 };
 
 /**
- * struct __thermal_bind_param - a match between trip and cooling device
+ * struct __thermal_bind_params - a match between trip and cooling device
  * @tcbp: a pointer to an array of cooling devices
  * @count: number of elements in array
  * @trip_id: the trip point index
-- 
2.35.1

