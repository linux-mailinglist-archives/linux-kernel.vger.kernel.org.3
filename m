Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8D84BA337
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbiBQOmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:42:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiBQOmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:42:25 -0500
X-Greylist: delayed 18850 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 06:42:10 PST
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434091EA710;
        Thu, 17 Feb 2022 06:42:10 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [80.241.60.233])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4JzyG81ts4z9sW9;
        Thu, 17 Feb 2022 15:42:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645108925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3WOWoBkW9fNOW7y5qawru7527uDPIT2KJWNbGZXIZU=;
        b=P53Xwlqo9K0bhRWOP+bBgy0KgnFYBK1w1Zkli3EzRyysM7MZW+XyvwUSTA5a5O/vRRb+Ku
        FbPuIcKEAc3VzcVcQ4foatjtxakoO8p2Or+hrvT7J3DygCjFZPuExEx0SriVVTwom0SS1M
        XaDv+JLw4TjuUCiverfZqCiB/czEjkeoJ6dHxgshRerBSzA5mEubHrnDKD/gL+lDYzpetK
        /UR2UB2sMSVwT3GmRMqLbdoCcoskUqzip7qONgmz+1+zPQRwkJIJUqe2GyKUYgELAasgQM
        //iUrNYV2zCFesBLPF6PabFEMdO3CsIjMwSWODy24G87AFlYzC9lo3MxMB2DNw==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: trivial-devices: Add xdpe11280
Date:   Thu, 17 Feb 2022 15:41:33 +0100
Message-Id: <cbef5619ca8bb1edef32532ac22a5803248036ee.1645108566.git.sylv@sylv.io>
In-Reply-To: <cover.1645108566.git.sylv@sylv.io>
References: <cover.1645108566.git.sylv@sylv.io>
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

