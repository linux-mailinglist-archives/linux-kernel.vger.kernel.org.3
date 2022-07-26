Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3E581B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 23:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbiGZVEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbiGZVDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 17:03:43 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7695C3A4AB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:03:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ss3so28167813ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AiQ0HcOvDIah4fMpuXqHSwjgHcHZ/tpuZ/vuW2o2BXw=;
        b=evXGwLvcDjU0qDyrkdC6mkUy83vtHbjOvR811LRjxjmNIBxTovzwE71jwghsXDlrVt
         ZZkOUWCYyeCI1cvvw5/0ArR5ytXQlAGQfs488gE2zq3GJ4YjXplfiNFqoBk2x0FURxF9
         ndE63J6sd8f7FN9Tm7oy41WSi51bFyGCDXA3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AiQ0HcOvDIah4fMpuXqHSwjgHcHZ/tpuZ/vuW2o2BXw=;
        b=ZlYfNp27CbrBgYkhGD31xTgV7vpJCa73MAYN189xYNOGdlOqdEQRL54HdhZRy4roGb
         d5rJcvi5pKH5nYTZ/0XEqPzcJqk8Y66bY6td7Xb71aYRs9SBwZxKJoXBWo2blREL4Tik
         TGARiOJQpcZX//anN6ZqdfFZ9d6zG2PTRUbgTBz+JIAAmvDTSh5IlIJj6xix9Z7KAnTa
         4OttgHLxlIMXshsmsVUBqC504nCumPSFKZ/+AgJsFKBE+F70PBTxU1pRnK7vwUMfO83w
         BPPQJKblVvgqgnk0wf3UN3XdxxEKyZRI6knD2FTY2v5Qi3W+wXRP2UaCuIuhaKRwNVo8
         8eyA==
X-Gm-Message-State: AJIora+LX2U+fzd9pSkqewlDN/+PbawzecE7NFKqgUOridHAP7vV26oL
        ftANAsVgTzu+MBEsD6SEVgtDO1IwtsCllw==
X-Google-Smtp-Source: AGRyM1t4M5JDiuIqo8f049Mkcape1IJDhp/IBDYwWppv3LoaojPZmxWycbkF7PwAdBbxdf61ozHpZQ==
X-Received: by 2002:a17:906:8a79:b0:72b:871a:57b7 with SMTP id hy25-20020a1709068a7900b0072b871a57b7mr15018909ejc.602.1658869416578;
        Tue, 26 Jul 2022 14:03:36 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-14-98-67.retail.telecomitalia.it. [87.14.98.67])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7d513000000b0043a7293a03dsm9092849edq.7.2022.07.26.14.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 14:03:36 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>, netdev@vger.kernel.org
Subject: [RFC PATCH v3 9/9] MAINTAINERS: Add maintainer for the slcan driver
Date:   Tue, 26 Jul 2022 23:02:17 +0200
Message-Id: <20220726210217.3368497-10-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220726210217.3368497-1-dario.binacchi@amarulasolutions.com>
References: <20220726210217.3368497-1-dario.binacchi@amarulasolutions.com>
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
index fc7d75c5cdb9..74e42f78e7cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18448,6 +18448,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
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
index 3905f21e7788..6a0f12cfbb4e 100644
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

