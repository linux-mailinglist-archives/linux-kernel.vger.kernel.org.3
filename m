Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6FB50DDA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbiDYKOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiDYKOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:14:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE138CC2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:11:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y19so5905070ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2NknWGo+35JEwhYOnMtzefDe7HwL5J95MApEJDangBw=;
        b=K/l/2GXpQ2StTGjc9+/yRtaawiRjmldlhTsm6pxdlTKEDfXt9k3rSidQ8JgDxuWFPT
         V6m8XfAkFPjE9TzhqRZaIPUF7ts6eBc8rvdaCX3GpHE2ZgcKTyvZ/eMIIK6K3tJx1nMD
         Uk1vmhu9f9Y96WrKkd1bR1qPYGVqOrVxNmj86/EyQ67vybNSUeVk0uf8UqxmMeUG7ihN
         6MAK3Ppfbi0/jELzoGDBDEnToV/TezItmpH4fZ3ZJQIto8Dxv5XEfXqag8iz5Du6ea/8
         gFc2y+9gq4IdkZw9TYt9MA4BP50nQiAjKHbBhJGdHnmQMD/sGx+FSlpTa/h91pFIaQkB
         Znaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2NknWGo+35JEwhYOnMtzefDe7HwL5J95MApEJDangBw=;
        b=H848A4NtDSLcF3tJAnvHeiI5bmD6BDprnrolTFU8QI4FxaaSxiSseoLerMzYRzmAVE
         Pk1IbbR0/lhN1yLDH+Win0wk2On4uvM5AxhiZtgVijg7OmxPQonayIYwjDCaP4pGpset
         X2RcqBqJ7CpK7Kq5FUw0CL0cvSwGsqO0tr6RveMP0gStTlWeox57m6IT75RK3Q3HUTvO
         97ivzWFZROWi+6yeCa7Xodq0zXvxfWQ6b8QPqRJRzsHu/dVxT09QOp3xuTmo2fEQEQsi
         /67e3LtvRghS8Tpg5tmmn77Chc7zEJcNxDtdlEFQ6RjB4KJVXj0pfNtJ0oQT3iwZJ4x6
         4YNQ==
X-Gm-Message-State: AOAM530tqIbtuX9+rOAzJUUZ81tYZzjJucBiZaUSxyHRUc0zHYNLs7rG
        uDIKh0QI6RLGw+GbTL+qs6OYUAumRg1z5g==
X-Google-Smtp-Source: ABdhPJywPIhVLwkEkoCnHeuxN308eHWJhhXhvWF4W+0d4SyArqh6h53CS4QfT0Aci23/62XkSh2ZIA==
X-Received: by 2002:a2e:934f:0:b0:24f:ea1:6232 with SMTP id m15-20020a2e934f000000b0024f0ea16232mr3960527ljh.135.1650881477056;
        Mon, 25 Apr 2022 03:11:17 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id t25-20020a19dc19000000b0044a16b068c7sm1366583lfg.117.2022.04.25.03.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 03:11:16 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, olteanv@gmail.com,
        upstream@semihalf.com, Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH] net: dsa: remove unused headers
Date:   Mon, 25 Apr 2022 12:11:02 +0200
Message-Id: <20220425101102.2811727-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce a number of included headers to a necessary minimum.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 net/dsa/dsa.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 89c6c86e746f..0c6ae32742ec 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -7,19 +7,10 @@
 
 #include <linux/device.h>
 #include <linux/list.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
-#include <linux/of.h>
-#include <linux/of_mdio.h>
-#include <linux/of_platform.h>
-#include <linux/of_net.h>
 #include <linux/netdevice.h>
 #include <linux/sysfs.h>
-#include <linux/phy_fixed.h>
 #include <linux/ptp_classify.h>
-#include <linux/etherdevice.h>
 
 #include "dsa_priv.h"
 
-- 
2.29.0

