Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9792757DC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiGVITi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbiGVIT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:19:29 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4ED9E29C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:19:27 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 5FBCC2FEE81;
        Fri, 22 Jul 2022 10:19:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1658477965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cci7jBXhFRtk5ihk6QaoRMJ+OENLYFwI05tf7c5cNPc=;
        b=7t6VG7QCrBIAh1uskrzbCbgEodirJ3W2nKObvOlTTL+NxolV9LAVkfZy3aTK9XaQRJN1Dz
        s9DSxvpbXobHjCSU5T2JkZJZ68/qVWFwrMTnbbGU8Xz6zh+xavDVYJM0KotVz2m5C3Fcf/
        EM04XVt6dUOgnkZfbKRGARrn2O7gNQDJbF9b+71AlUF8UqNFr9y8P0jQE3AMgmJwC+9C8q
        D2dy+UnflVHzZJRfzSavEQPWQJLcUFYaeworrYe4HkJ+MgK1C2/GMvFileC1csxXFxmmyP
        03lfQ6dKjVpvOHJpPYJRM08Nj1yqIeHbGC0bohniD+/MDrrvzOrzUx+tVwVjBA==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Bert Vermeulen <bert@biot.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 2/2] MAINTAINERS: add info for Realtek Otto GPIO
Date:   Fri, 22 Jul 2022 10:19:17 +0200
Message-Id: <d162ec319ff67b77e375c2f2aa24eb297325d7c2.1658477809.git.sander@svanheule.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1658477809.git.sander@svanheule.net>
References: <cover.1658477809.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry with the files for the Realtek Otto GPIO driver with myself
as maintainer. I am already listed as maintainer in the device tree
binding itself, but the driver had no explicit maintainer info yet.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 651616ed8ae2..b173f9e3ee3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17009,6 +17009,13 @@ S:	Maintained
 F:	include/sound/rt*.h
 F:	sound/soc/codecs/rt*
 
+REALTEK OTTO GPIO
+M:	Sander Vanheule <sander@svanheule.net>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
+F:	drivers/gpio/gpio-realtek-otto.c
+
 REALTEK OTTO WATCHDOG
 M:	Sander Vanheule <sander@svanheule.net>
 L:	linux-watchdog@vger.kernel.org
-- 
2.36.1

