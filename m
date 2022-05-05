Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5155F51B935
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbiEEHiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiEEHh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:37:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87609488AA;
        Thu,  5 May 2022 00:34:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id z2so5483456ejj.3;
        Thu, 05 May 2022 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3J1208WPQ4jno3J/uykQTL89a7eLGDMeF5YveJlEzDs=;
        b=S78SIfXfk2AKH1/DmhfhwODqbNeadxZX0FAVXnAnkEm6si5fxgcBYmwi4u0eOSalAu
         3/BurbYRXdysgUV9NhwhO4OR+B6/u6w3kaetOVLGz0jDZOm6/p6tv8VCrd5y0dx+0D4O
         qD2i6qkY1F14UHRMvTlAF8mpAx3q6gbCr7mNWPHF5MbYbIkt0by+93IEmz3f+AvH065R
         hMPgvsSSbkpkcZ30GGY9mmyEO8kr5OlnZ720U6dMfxYQ7uZV3Pqu+LDdKwQfhUcrJHZ+
         SyE/DH1xarFajb7IiT42GvtIbqtm6FSmn/5OD15oVKaE0aN3pecsdzMoL+iJgEB+lBqo
         wFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3J1208WPQ4jno3J/uykQTL89a7eLGDMeF5YveJlEzDs=;
        b=k8LaBVfb0mCxdzMYxUPoOTENgOWpsaqu9B6pqqpzoN5EPK08FaDbjhKUsGuiBSFbxK
         5oYCIaOtZMQjRcQJyEmW75V8gzGVBlA6SToI0GSRrHmthcBl/vlt5Q3t04kOkoMCBZT3
         oD5himFFMOQo00DC1Q+Uhzd7yWdgsruhEt18dBrEMPKlIk+bj3m+dEKTtxSSPke4x+Lm
         fZbtR9FrdxtMiovLzCKpaih4XJzFJTnehHvjpsMvvmaNc7Rysgte7Yjl7Y9WLKzInQs+
         yD+xygOl8Wxvh5p9rKpd+SxrhFj0xJBkw5y6vBIXItf4n4aBUs6pMw99ul/qX3vhkkZQ
         86kg==
X-Gm-Message-State: AOAM532wJmFhKdfmuhkU5o9D8NIAV0plhlypTTns9MObNwAMZoZuOrsZ
        FG4jHVYPO6TkhPGpdO+9qAI=
X-Google-Smtp-Source: ABdhPJw025Btub/yVDtZYX9TuyPMCGQ444n5wDrt1oQXpxmbeOFzK9MviShruWUWDTtZ2kzd89eCqA==
X-Received: by 2002:a17:906:eb82:b0:6f3:9044:5fba with SMTP id mh2-20020a170906eb8200b006f390445fbamr24240010ejb.715.1651736058913;
        Thu, 05 May 2022 00:34:18 -0700 (PDT)
Received: from tiger.museclub.art (p200300cf9f27690001ea8a0258c36e97.dip0.t-ipconnect.de. [2003:cf:9f27:6900:1ea:8a02:58c3:6e97])
        by smtp.googlemail.com with ESMTPSA id og21-20020a1709071dd500b006f3ef214df8sm297592ejc.94.2022.05.05.00.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 00:34:18 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Debabrata Banerjee <dbavatar@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add ROG STRIX X570-E GAMING WIFI II
Date:   Thu,  5 May 2022 09:33:51 +0200
Message-Id: <20220505073351.123753-1-eugene.shalygin@gmail.com>
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

From: Debabrata Banerjee <dbavatar@gmail.com>

Adds support for the ROG STRIX X570-E GAMING WIFI II board and
simplifies formatting for the list of supported models.

Signed-off-by: Debabrata Banerjee <dbavatar@gmail.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst | 23 ++++++++++++-----------
 drivers/hwmon/asus-ec-sensors.c         |  8 ++++++++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 1700fe619597..78ca69eda877 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -4,19 +4,20 @@ Kernel driver asus_ec_sensors
 =================================
 
 Supported boards:
- * PRIME X470-PRO,
- * PRIME X570-PRO,
- * Pro WS X570-ACE,
+ * PRIME X470-PRO
+ * PRIME X570-PRO
+ * Pro WS X570-ACE
  * ProArt X570-CREATOR WIFI
- * ROG CROSSHAIR VIII DARK HERO,
+ * ROG CROSSHAIR VIII DARK HERO
  * ROG CROSSHAIR VIII HERO (WI-FI)
- * ROG CROSSHAIR VIII FORMULA,
- * ROG CROSSHAIR VIII HERO,
- * ROG CROSSHAIR VIII IMPACT,
- * ROG STRIX B550-E GAMING,
- * ROG STRIX B550-I GAMING,
- * ROG STRIX X570-E GAMING,
- * ROG STRIX X570-F GAMING,
+ * ROG CROSSHAIR VIII FORMULA
+ * ROG CROSSHAIR VIII HERO
+ * ROG CROSSHAIR VIII IMPACT
+ * ROG STRIX B550-E GAMING
+ * ROG STRIX B550-I GAMING
+ * ROG STRIX X570-E GAMING
+ * ROG STRIX X570-E GAMING WIFI II
+ * ROG STRIX X570-F GAMING
  * ROG STRIX X570-I GAMING
 
 Authors:
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 998d49d6b799..611e897429b1 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -315,6 +315,14 @@ static const struct ec_board_info board_info[] = {
 		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
 		.family = family_amd_500_series,
 	},
+	{
+		.board_names = {"ROG STRIX X570-E GAMING WIFI II"},
+		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
+			SENSOR_TEMP_T_SENSOR | SENSOR_CURR_CPU |
+			SENSOR_IN_CPU_CORE,
+		.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
+		.family = family_amd_500_series,
+	},
 	{
 		.board_names = {"ROG STRIX X570-F GAMING"},
 		.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-- 
2.35.1

