Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748D15A3C3C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 08:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiH1G3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 02:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1G3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:29:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09B04F67C
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:29:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l5so1266207pjy.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=wGaVdZVTafY4oILQ0Q1s/zfrLr5042sPWTRzze9CiOs=;
        b=c9VyZKBpE6E5EOIcElvwGaB4Cd4oi38Ty11LgciZW1BWNsxV09AvVeV0C40y3/dUMx
         mGOqWidvsIHcDb6o/G6o4piplzc+cR07qORltKTMkP8PiplN1iEGCVzqgfh9Bb0iu9vi
         8nhRco5OevZcpk2qmaRU0FCt+NP+hbrynx4QWXYrhrCkJ0XYjPoWNRqSKDuy+jmooV2Z
         UoxGA4L8O9V5/yfVFrPi4+XC63l440dpU6xy/Hv02uzULdUTTFuD3IMLXTwdXHGWoxWp
         B5mK1btvzYlG7uBzrmAAhZVsNr9Oy5BX2/YKknS3EscugbAKRVzPRoRxF6ig3cXw3qjC
         plrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=wGaVdZVTafY4oILQ0Q1s/zfrLr5042sPWTRzze9CiOs=;
        b=EpLY/78FMe0Lm6fhvw4G1pLiFPa16U3Fad0LQygHhvca97YJ4mNmTx1QhEoT/CutK+
         D+ShCM+DV+jqzeAugEoT8vsUY8QN9nDmNcy1xKHq5QHPItux8dAr1dTzxr6Qz6h1bQRL
         k2fQ5UvMPX8qWS6dPV7s/sg8GahPkXEWMWxWt/+hwa7nNNBy2hAt88oCxfEeC53+W7/C
         sRYIfVG8tsVrYlcu0Dn4tKXb0VvXKBcsYthqjrappYlllcU7fcPMhyoaAzI2S92vC82t
         HUSzQup8h99MZKBpnRd/luKlkCQ36EtlyA4aEeVWV8mCv5vRRf1E8oytkr1Pg0Ewi/AI
         ldbw==
X-Gm-Message-State: ACgBeo1OR+ZiBsZzymA84RaeQ0LzV/FdfYLjuLb7jaRT92F4RTai4a0Y
        AzupfQHKcIWoJbRHHuCKl7w=
X-Google-Smtp-Source: AA6agR60Iaoj7lhpi3L0GWRz3/CESLVcYFesBorz4m0OA/DApORsCWr0GNshLH7VUGCoy8NAxJTgMA==
X-Received: by 2002:a17:902:9886:b0:172:bb36:70f1 with SMTP id s6-20020a170902988600b00172bb3670f1mr11276961plp.139.1661668181273;
        Sat, 27 Aug 2022 23:29:41 -0700 (PDT)
Received: from localhost.localdomain ([112.134.152.151])
        by smtp.gmail.com with ESMTPSA id 14-20020a63184e000000b0041d6cda2d60sm3969280pgy.66.2022.08.27.23.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:29:40 -0700 (PDT)
From:   Dhanuka Warusadura <wdnuka@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dhanuka Warusadura <wdnuka@gmail.com>
Subject: [PATCH] Documentation: fixes a documentation warning in serial_core.h
Date:   Sun, 28 Aug 2022 11:59:17 +0530
Message-Id: <20220828062917.182879-1-wdnuka@gmail.com>
X-Mailer: git-send-email 2.37.2
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

These changes fix the documentation warning: Function parameter
or member 'start_rx' not described in 'uart_ops'

Signed-off-by: Dhanuka Warusadura <wdnuka@gmail.com>
---
 include/linux/serial_core.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index aef3145f2032..44a7b4746f36 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -149,6 +149,14 @@ struct gpio_desc;
  *	Interrupts: locally disabled.
  *	This call must not sleep
  *
+ * @start_rx: ``void () (struct uart_port *)``
+ *
+ * Start receiving characters; the @port is in the process of being opened.
+ *
+ * Locking: @port->lock taken.
+ * Interrupts: locally disabled.
+ * This call must not sleep
+ *
  * @enable_ms: ``void ()(struct uart_port *port)``
  *
  *	Enable the modem status interrupts.
-- 
2.37.2

