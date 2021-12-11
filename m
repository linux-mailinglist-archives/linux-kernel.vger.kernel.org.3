Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DE74713CB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 13:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhLKMgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 07:36:40 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:42823 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229668AbhLKMgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 07:36:40 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1895E32006F2;
        Sat, 11 Dec 2021 07:36:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 11 Dec 2021 07:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=jyZwPC0X2++DprKxr15vyZyWAU
        AUS3bZhV+pVBZjM1c=; b=Ks8hXDxbnpH+i/dVF8g8uzofQQXiiEVKGnWDILiGTg
        gRmGYiD4669CAs615P8EV5gugCKuP7wvmcjd5ohxGJEFzItDA9etDIw5o+uKxrvv
        SPT+FbG1UCqHhyDzyRozACoDd7H2qOUqB6C2hq2tTZ2AuGLydGPeH5Zur42XM42B
        FWGCQGUHxVz1mTPtAWwYC75YzYo7XWw1aGj9JkO3Z7CvajBJZaL0lvyYzG1zrgcv
        O/CLzpBN2vga8KyjMYNYLSeh8nVEy9MM/eib3kNwIIqc6p9mAx15nBtzbLFQv174
        Kf+iufoqHAIRsCFLfVoR1UzKJFjhUOQ+lgcIUv8kVoOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jyZwPC0X2++DprKxr
        15vyZyWAUAUS3bZhV+pVBZjM1c=; b=L/76vsPuRxiShvASzACBWdPmRUGjJ9w1N
        KlUNjwJj4hfzrgt149au6r1YUJRYDgRalErNK7fkjBWLi/Uh3RTT1eUZedb4zzEd
        h95LHolCqS9+c9htp8Lo2kiNux9YKpn+4Cvr9DdthL2nixSjGI7Bbwywi8aZOB5h
        cgjF6ikIRc0Gn65Cubc9dFQsktCXJiLMSc2DgqCOcbiVc0P4EIriVH2IymLJjZ8B
        qyNUPOU6zcbm6ZzV8m0RpNSd/F/xp4x01H2ks0BPMrviT/GycfM3k0kayYvYTKQR
        bAgMWuNdGdzl9Lo1yUkFE4zgt/2f2kzbMmgfzgehlDyE146pZsZOA==
X-ME-Sender: <xms:Vpu0YbaCtiY3RN9Zk5fjeeYgqsS7oVXivEFgdbguAMRWPtpm49DX5g>
    <xme:Vpu0YaZH4xA2hQpFnDVYR8ZvJEs3jqnogmM6kBIYsNIaDYNKBQLoQNbUcBWZPmp7T
    uH4NWgJSKGTPqI61Es>
X-ME-Received: <xmr:Vpu0Yd_9jFvTczrreh7ffj4oNtbxTsgzVeY7A325UM2_s5sAGXXTnCHAMagk0wqYGcYd9peazE8DZJeZNJr16UbycQqGq7cA-jkriJdrkz5e9p97Br21Thu0XvFRKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrkeeggdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfrvght
    vghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    eugfelkedvtdejffefjeehveelfeevkefgudduhfeghfefgedtheevjeefffffgfenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhessh
    hvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Vpu0YRrelVdOwF-PVTiqfI_CcqpjzxmMnUQCzr8vcrmOrc8gcjSoCA>
    <xmx:Vpu0YWqxlnixFdKry1HLnuJNNb9Y5lqHGoQT2O7p8-jQx4WI6sZZ-A>
    <xmx:Vpu0YXRiLbZavPm8QZIbe9wlYHcTCivctB_Vxg3Mnq1pNaP9mm9dEw>
    <xmx:Vpu0YWIH5rl_Kf5XT8vKHZ6R_d5M2uc20m_C6myXAh0xX6Uxg1Ro9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Dec 2021 07:36:36 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Janne Grunau <j@jannau.net>
Subject: [PATCH v3 1/2] MAINTAINERS: Add Apple watchdog to ARM/APPLE MACHINE SUPPORT
Date:   Sat, 11 Dec 2021 13:36:32 +0100
Message-Id: <20211211123633.4392-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add apple_wdt.c under the ARM/APPLE MACHINE SUPPORT entry.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v3: new commit to be taken through the SoC tree to prevent
    merge conflicts upstream since we have multiple drivers
    that all touch the same section in-flight as requested
    by Hector Martin

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43007f2d29e0..0e919de0a808 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1756,6 +1756,7 @@ F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/irqchip/irq-apple-aic.c
 F:	drivers/mailbox/apple-mailbox.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
+F:	drivers/watchdog/apple_wdt.c
 F:	include/dt-bindings/interrupt-controller/apple-aic.h
 F:	include/dt-bindings/pinctrl/apple.h
 F:	include/linux/apple-mailbox.h
-- 
2.25.1

