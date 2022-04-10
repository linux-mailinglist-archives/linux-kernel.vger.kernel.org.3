Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C19E4FAE1E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 15:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiDJN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbiDJN4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 09:56:37 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A41574BB;
        Sun, 10 Apr 2022 06:54:26 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C64DB5C00F0;
        Sun, 10 Apr 2022 09:54:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 10 Apr 2022 09:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=Yuv1GmIDy+5OCJAJ3kdoGsDEnFsZtnCcD0X/Tf
        eNxDw=; b=UpIIVGnsZ+oJNshkqylAhqq+ABP9zjNcfnvj3XQUCGJkT+3GEpavc4
        D34M5Ovi3h7vSc7A725bpBgo/rl49OWNiWcDrgSAGGGW5KAQZpqgEf3EgkiAIvJE
        FsaaO4YGRGEAXt1QrAkGH+mDX7lNNqJADoj6/d1KPr2qadi+vTmKaPsuPbUk6tKF
        tIwpC9zl7rSDRQLofNHYvFtu+YczDIJ6D0jSX8v8tUIH9VaU4mpoigP1GW15t9Ws
        sFCf13ZGZ1SYHF+X6RH4+FW0zMmhneXlVrmVdAU76OnuQSUwDjn6N9WGLQhiY2eI
        mNXDNkMoNR+ORmZYAg6l+8MWPbX3+P2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=Yuv1GmIDy+5OCJAJ3kdoGsDEnFsZt
        nCcD0X/TfeNxDw=; b=EnrCQcj6/T5nNgG5hzmD+WJnzueKwaupGdSuVu86q9h9w
        7lye4lC7O8t3L0p2BZe9cAUpe0hlwW+0MQZtnLCAyhiKtsWs6VqJk2f+JwFOtkRf
        Eyjs8W88GlYxggkvM+S7Uceq8lkQVp18YdFNkle6l2MXvRFngF856YLjMEItD/2q
        srj5Mzl12WpwZsHxim8gmS/o8lGd+o1Hyyoq6Ai9XObRrIIf9mV8qXuGAXy9UoLj
        y9eS5exlwQOM7m04JcI7wxhbqAFv03LO0VHjSw2y9VWE93yZsji12MRLeWyT5Rqb
        O9CtgULcrYANghuK+3PesRVsRChDY7J0VR6BrY/Ug==
X-ME-Sender: <xms:juFSYgq3C9RIc1co6nXPc5rn5TAj1-0gjTA4uhaCqlRtkfIl1ge2Sg>
    <xme:juFSYmoHnoC6oyMdyELX425O5FJabPeSJvvjRGGG0oeUTCXpcEC8ILSLOH3ejYcdf
    JLZh6NC2_oF0oo4OQI>
X-ME-Received: <xmr:juFSYlO8CncKSKc-AA4aOiSIdjlE7fwOkJZUs-XyikNjEs2vSKF1jz1McBKP1vqZtwEQG2dmABMUAkDCS0mEvPYU_jWwKFw7JnLTIJ4OGFCrMS1FNNIna4DRMYxx_qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekgedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:juFSYn4tLDB_g9XvsEvmUC3E2TteZMG9X9sj1J2pjdDio_kxiVo5zQ>
    <xmx:juFSYv5WGqTKBUEjHFtewWFHH_MQVoySzVzQodRYqtV0y27JHDOuMg>
    <xmx:juFSYnjabYBIM-7zqkwqutGXlf1lGul12bhOPHn-SBIpzBBEldWCOg>
    <xmx:juFSYsGpv43aKNZ2SLRF9jLpIdXqUzeEPvLaRArEHwPIWj_1x40LVg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Apr 2022 09:54:20 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowsk <krzysztof.kozlowski@canonical.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] MAINTAINERS: Add apple efuses nvmem files to ARM/APPLE MACHINE
Date:   Sun, 10 Apr 2022 15:54:12 +0200
Message-Id: <20220410135414.20606-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v4:
  - new commit to split off MAINTAINER changes requested by Srinivas Kandagatla

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fd768d43e048..1bf57fd937b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1837,6 +1837,7 @@ F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
@@ -1847,6 +1848,7 @@ F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/irqchip/irq-apple-aic.c
 F:	drivers/mailbox/apple-mailbox.c
+F:	drivers/nvmem/apple-efuses.c
 F:	drivers/pinctrl/pinctrl-apple-gpio.c
 F:	drivers/soc/apple/*
 F:	drivers/watchdog/apple_wdt.c
-- 
2.25.1

