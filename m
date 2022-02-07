Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954204AC8DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiBGSuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiBGSrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:47:07 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22309C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:47:06 -0800 (PST)
Received: from apollo.. (unknown [IPv6:2a02:810b:4340:43bf:4685:ff:fe12:5967])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 909EB22239;
        Mon,  7 Feb 2022 19:47:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644259624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GSEvHFnULQv/IzdQQUd+TGASCzwSK/pi2J8B80qzsvo=;
        b=GUL29nJQXjfU40722IVcv9BU22uXsKynU+6OvtJTQlQkxIkJ5cEAq1Q1hSwMlBCza37eYX
        j2VBFc7Z9e9tz/vhRKtr7WL2hxtk9FrUy1ksrrNAxwd/3MoMOOOAFWjxfM0Z6ZwLodm16A
        uLxBGPqXFOaG0QSK0mnGkcKBf7u4TQg=
From:   Michael Walle <michael@walle.cc>
To:     soc@kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] MAINTAINERS: add myself as a maintainer for the sl28cpld
Date:   Mon,  7 Feb 2022 19:46:52 +0100
Message-Id: <20220207184652.1218447-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sl28cpld is a management controller found on the Kontron SMARC-sAL28
board for now. Support for it was added by me quite a while ago, but I
didn't add a MAINTAINERS entry. Add it now.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Hi,

since this affects so many subsystems, I'm not sure through which tree this
should go. I'm sending this to the arm soc maintainers because it's an
aarch64 board where this driver is used as well as Lee as the MFD
maintainer.

 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddcee331dc09..c14209168ce6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17762,6 +17762,21 @@ S:	Maintained
 W:	http://www.winischhofer.at/linuxsisusbvga.shtml
 F:	drivers/usb/misc/sisusbvga/
 
+SL28 CPLD MFD DRIVER
+M:	Michael Walle <michael@walle.cc>
+S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
+F:	Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
+F:	Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
+F:	Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
+F:	Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
+F:	Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
+F:	drivers/gpio/gpio-sl28cpld.c
+F:	drivers/hwmon/sl28cpld-hwmon.c
+F:	drivers/irqchip/irq-sl28cpld.c
+F:	drivers/pwm/pwm-sl28cpld.c
+F:	drivers/watchdog/sl28cpld_wdt.c
+
 SLAB ALLOCATOR
 M:	Christoph Lameter <cl@linux.com>
 M:	Pekka Enberg <penberg@kernel.org>
-- 
2.30.2

