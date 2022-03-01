Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930414C9279
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiCASCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiCASCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:02:20 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E1C3F336;
        Tue,  1 Mar 2022 10:01:39 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4K7Q6n6nJqz9sV3;
        Tue,  1 Mar 2022 19:01:37 +0100 (CET)
From:   Marcello Sylvester Bauer <sylv@sylv.io>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1646157696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p97zePmp9d+cmIP2kHmhFQpvfjnvmtO8AdQThs+dFK8=;
        b=d4r/5BHJSFvayCukRPPSEHOCvNQOh70bHqFz7Lqh0cNdl08zR2gZjgdKhofzZhwjJfrSQD
        UvT8TkO9R1jmGB27jGObWOFTKLEu3JBipdrF5Sau8uCaCf76pz+j3v+F+NXeeBjIs7rDru
        ExCs7POuUUeZ3/X/EbQBAeiNoIixVV+FR7ddpmfrocfDid6evuHJ64NgfeIxu2KN06bEN9
        w9VOyUsmxqwdqB+riv0/VG/1tbiCd97oxY91nJcduuubyscFIvoKJ+DQCQ3+pc+Ehgi0Ai
        Fuj/GRcc4fUByfmw11FXlkeMiKxZZZ6sMkGAnOfEt5+HUpBLXXYwDYgUYa3VPg==
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: trivial-devices: Add xdpe11280
Date:   Tue,  1 Mar 2022 19:01:11 +0100
Message-Id: <81c0523ba790965a371d267bb1944652d80f5f72.1646157237.git.sylv@sylv.io>
In-Reply-To: <cover.1646157237.git.sylv@sylv.io>
References: <cover.1646157237.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Infineon Multi-phase Digital Controller XDPE11280.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 1c49bbc654ee..da929cb08463 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -137,6 +137,8 @@ properties:
           - infineon,slb9645tt
             # Infineon TLV493D-A1B6 I2C 3D Magnetic Sensor
           - infineon,tlv493d-a1b6
+            # Infineon Multi-phase Digital VR Controller xdpe11280
+          - infineon,xdpe11280
             # Infineon Multi-phase Digital VR Controller xdpe12254
           - infineon,xdpe12254
             # Infineon Multi-phase Digital VR Controller xdpe12284
-- 
2.35.1

