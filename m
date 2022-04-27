Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411B8511FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244613AbiD0SGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244601AbiD0SGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:06:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCF43A2363;
        Wed, 27 Apr 2022 11:02:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bv19so4963272ejb.6;
        Wed, 27 Apr 2022 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kFl7F+bDiuTXuRK9B+innYEa8c7xLmi165v70TPlxvo=;
        b=g1+X8ARdAKY3b3yP0X0ZmFyJOuQQ7wyti6Nr/e2OkKjrdDZsnjWpHAeY14DgJtO/BR
         8AvpI+Sh3u9AEkRpdtrs9/r7ip/p9RiMaG0xn6kuFe7QvYwzgKvC07tLhPGDrpSuKVAV
         xnmYGCz/Z/Yr473MbHTiRIUBwe1ic0debupuOGp07h6MDlnVt5ZaAz92mYpL1HmXAna3
         d9vanuE4VpBLovhxee1wq0bLQ8P3ePyu6gQGce8P01S+ZsO8N8xPkCGGz9Sp0B14Kk3r
         NID2F8DDG7N4TXOeXVUAzGr1jT7AeCdD7WaTctycMSETLmV3+HN7W48FcDZlKCBijWmz
         3Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kFl7F+bDiuTXuRK9B+innYEa8c7xLmi165v70TPlxvo=;
        b=59q+9JvhWziyqRlexsJUJAwHNmiPiKT4M5CbOuZ4rbgUQEbtFtISnIBcCO7gz5eNwe
         lpAi64OHLknfANviC33DgApUwD4XQHpcIZCS6H5wTjjzf/zdzFcKOrag33+M6EJZIYFL
         tie7+NObMeU+S0NdfgRE854Xvf3C/hXlU9yUXD3QKar7oPdg7OkXE5Mr7Flq7UCALBQL
         zosLZk4d8+mWzUxQkKLX4YqVlPKfxYz/3/MwHJx5pA/VsGMmu1VYekOALYk34haAxzVx
         jHcEoNTut+tFmmRfdIg1mr7f/jKnB02Kw7kUtl2hjMdancHXlflFvQsPLze1UALWwLQH
         FJTw==
X-Gm-Message-State: AOAM530iywWLuxWPrVcTqZCk4dKH0AiOqA+4S3qYTusLH95JXL2n/q9k
        HfN5bQhRO9LbY4t7Lt1FqWw=
X-Google-Smtp-Source: ABdhPJxdsVTmlYPCwZAL6LfmspKOKFwpTh0gGX+jG1taFFNxyj+O7zNYFpdayz32BJXR51B834LIFQ==
X-Received: by 2002:a17:907:7d86:b0:6f3:a92d:7fa4 with SMTP id oz6-20020a1709077d8600b006f3a92d7fa4mr10978810ejc.498.1651082569820;
        Wed, 27 Apr 2022 11:02:49 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f393100d379c1e4199524ea.dip0.t-ipconnect.de. [2003:cf:9f39:3100:d379:c1e4:1995:24ea])
        by smtp.googlemail.com with ESMTPSA id lf5-20020a170907174500b006f3806fc9cdsm5638036ejc.39.2022.04.27.11.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:02:49 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add doc entry for PRIME X470-PRO
Date:   Wed, 27 Apr 2022 20:02:36 +0200
Message-Id: <20220427180237.1475954-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PRIME X470-PRO to the list of supported boards.

Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 36ca531d32dd..1700fe619597 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -4,6 +4,7 @@ Kernel driver asus_ec_sensors
 =================================
 
 Supported boards:
+ * PRIME X470-PRO,
  * PRIME X570-PRO,
  * Pro WS X570-ACE,
  * ProArt X570-CREATOR WIFI
-- 
2.35.1

