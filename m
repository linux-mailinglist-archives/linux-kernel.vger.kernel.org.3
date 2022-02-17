Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744674B9C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 10:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbiBQJ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 04:28:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiBQJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 04:28:14 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715461B27A5;
        Thu, 17 Feb 2022 01:28:00 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4JzqHd4QjHz9sQq;
        Thu, 17 Feb 2022 10:27:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645090075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3WOWoBkW9fNOW7y5qawru7527uDPIT2KJWNbGZXIZU=;
        b=R8NEaVtWnn+eMjm8FRHPjgNGgnirt9RRDGFOKJ+ISQahv1bzxHBj/6EZ6SNy861TP4V6ij
        9x+fU7m5G+oy04XluGCr2ojKPYnsxYScbDmui12XT/cxf5NqFVv+yXTrjKhQdPG63Xl2c4
        8rVvU49fyOtjZ2G6001j4lGVgIxPk+Mi6/TONCioQorQzWeyVqPFtclo3l8n+9KYyYc2oL
        HYuSI998TzxVQoEJMfNMNq+ZCf86nd1XX6HVbH636FeJGOlx83RrXc28CdtJLRhfffK3IA
        HCJzsL3Bo5s2gGcW+1ejEbRrFFPylmgtNgI4tOsNDQ84aNXtoXKdGM0gY6TnzQ==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: trivial-devices: Add xdpe11280
Date:   Thu, 17 Feb 2022 10:27:28 +0100
Message-Id: <625a8402c23a5312842a0eaca5df9fa0750ef364.1645088804.git.sylv@sylv.io>
In-Reply-To: <cover.1645088804.git.sylv@sylv.io>
References: <cover.1645088804.git.sylv@sylv.io>
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
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 091792ba993e..8a42aea3b8a6 100644
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
2.34.1

