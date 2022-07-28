Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C5558392D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiG1HEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiG1HDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:03:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A875F9BF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:03:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id m8so991962edd.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDjEmDyORVH40LT30HT7nddNnjTd9U3ufOmG3gtdwn4=;
        b=bhtAgngU0ARmVRA+ekvUAJt/91+Kyzk4BLE5J+upuCzSXKfnkw4CRLBDKZ+WYbLbaz
         P4jz1l6MzKgopkdCduGCdcy4eKqeECcgE8bISqw9VUyMMzEiwta+BQahMbSk8jkNItHB
         5AZNxbQ3Mqu8N4xD2GFEJ9+PQ0B9n3NppUEMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDjEmDyORVH40LT30HT7nddNnjTd9U3ufOmG3gtdwn4=;
        b=IlK3uoqwC2WyLVA/ySx2DZGpdK5f5BGBf9uah5Alol355zM0zwbrGHet/lm9zFN4P6
         +48xK08ITRI+V0/YOueq1GsI5ScbL7C4/YzWTVHuF633wRMQ6gTOn8VW18wYpK5uKInb
         2SmMka1YW/b//05lniXfQPusGsPWzyhvcNLjt6Htc33thj2t0szczh0Y9ssTwthCnrOD
         3is7VAmgCOFJwJRFFPyWHdTd0ZyQ3zoWmj1lCeocgu4C1yOyt4nb9S3r0G0h0GA+HlHW
         tvEg8Je7ccD37qpm/kUMrBWgEaPwV8qiJKjHSNnMI7pnd4ccDJq4dBcW+tgzVLEwXkDJ
         4cyA==
X-Gm-Message-State: AJIora/X5JiuyAJauhwcy4gxNOQUFDQ8pgXOVl4f55g38bI0St7wQRKF
        kwhIoIl1+FdpO9TKaaVMUHXv2S36zC0eXg==
X-Google-Smtp-Source: AGRyM1tiqzR09UHp1JH3MSCIvelLBjjOZqohNSPDse2yML5BPTWiji9/+KZTUNVZXouGXZpzgbFjSg==
X-Received: by 2002:a05:6402:54:b0:43b:5cbd:d5db with SMTP id f20-20020a056402005400b0043b5cbdd5dbmr27268474edu.264.1658991792820;
        Thu, 28 Jul 2022 00:03:12 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id r18-20020aa7d152000000b0042de3d661d2sm154742edo.1.2022.07.28.00.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 00:03:12 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>, netdev@vger.kernel.org
Subject: [PATCH v4 7/7] MAINTAINERS: Add maintainer for the slcan driver
Date:   Thu, 28 Jul 2022 09:02:54 +0200
Message-Id: <20220728070254.267974-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220728070254.267974-1-dario.binacchi@amarulasolutions.com>
References: <20220728070254.267974-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the suggestion of its author Oliver Hartkopp ([1]), I take over the
maintainer-ship and add myself to the authors of the driver.

[1] https://lore.kernel.org/all/507b5973-d673-4755-3b64-b41cb9a13b6f@hartkopp.net

Suggested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v4:
- Drop the patch "ethtool: add support to get/set CAN bit time register".
- Drop the patch "can: slcan: add support to set bit time register (btr)".
- Remove the RFC prefix from the series.

Changes in v3:
- Put the series as RFC again.
- Pick up the patch "can: slcan: use KBUILD_MODNAME and define pr_fmt to replace hardcoded names".
- Add the patch "ethtool: add support to get/set CAN bit time register"
  to the series.
- Add the patch "can: slcan: add support to set bit time register (btr)"
  to the series.
- Replace the link https://marc.info/?l=linux-can&m=165806705927851&w=2 with
  https://lore.kernel.org/all/507b5973-d673-4755-3b64-b41cb9a13b6f@hartkopp.net.
- Add the `Suggested-by' tag.

Changes in v2:
- Add the patch "MAINTAINERS: Add myself as maintainer of the SLCAN driver"
  to the series.

 MAINTAINERS                        | 6 ++++++
 drivers/net/can/slcan/slcan-core.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fc5ff6ffb8..c82b6e74220e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18450,6 +18450,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
 F:	include/linux/sl?b*.h
 F:	mm/sl?b*
 
+SLCAN CAN NETWORK DRIVER
+M:	Dario Binacchi <dario.binacchi@amarulasolutions.com>
+L:	linux-can@vger.kernel.org
+S:	Maintained
+F:	drivers/net/can/slcan/
+
 SLEEPABLE READ-COPY UPDATE (SRCU)
 M:	Lai Jiangshan <jiangshanlai@gmail.com>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 45e521910236..f079c8f2296b 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -63,6 +63,7 @@ MODULE_ALIAS_LDISC(N_SLCAN);
 MODULE_DESCRIPTION("serial line CAN interface");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Oliver Hartkopp <socketcan@hartkopp.net>");
+MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulasolutions.com>");
 
 /* maximum rx buffer len: extended CAN frame with timestamp */
 #define SLCAN_MTU (sizeof("T1111222281122334455667788EA5F\r") + 1)
-- 
2.32.0

