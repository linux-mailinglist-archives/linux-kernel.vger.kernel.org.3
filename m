Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5274B505E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343492AbiBNMll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:41:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiBNMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:41:33 -0500
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E547C6F;
        Mon, 14 Feb 2022 04:41:23 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Jy3k94RJHz9sS2;
        Mon, 14 Feb 2022 13:41:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644842479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXyDWJOi2TMbTegBFxuy90N+VPfjmUO34aZ2XisvdHc=;
        b=13O2VRxq+bRCiUCclBFvpRTOHyjPE78XH7yySuIr2a88E/aFmw07HAS+sHnhTXZfK+Fa0c
        CVs9lWt/giqbT3Oai5Ll3NN/cWrkCrVgpTu3gEOc2+wtho8XdPpihC8X3fdzA/J5Z6TOu2
        +/ljB61PzbGA8Fm9AhO0USd+g2XcSX6pymg9TMH+D1xbuPttg/s91LPhCNece5kpLuqelt
        V/OVHAkJyfKOOOUlc7oTn+/JWchtkVzju9CZg3/3uwtA4VUT4Dw0UgT2EB84VeTpdGXqd2
        c+R4SqVr0iGGxYFYIHLQFpszvhVgV5yt2BijJhYphe56FTMQ22Alrjj3AheUfA==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings:trivial-devices: Add pli1209bc
Date:   Mon, 14 Feb 2022 13:40:33 +0100
Message-Id: <f1fedce71149a2ce811bf40a2097fee5b54911bf.1644834803.git.sylv@sylv.io>
In-Reply-To: <cover.1644834803.git.sylv@sylv.io>
References: <cover.1644834803.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trivial device entry for PLI1209BC Digital Supervisor from Vicor
Corporation.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 091792ba993e..d03d90360aa0 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -354,6 +354,8 @@ properties:
           - ti,tps544c25
             # Winbond/Nuvoton H/W Monitor
           - winbond,w83793
+            # Vicor Corporation Digital Supervisor
+          - vicor,pli1209bc
             # i2c trusted platform module (TPM)
           - winbond,wpct301
 
-- 
2.34.1

