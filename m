Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583454B5D22
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiBNVpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:45:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiBNVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:45:29 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2AE184621;
        Mon, 14 Feb 2022 13:45:20 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:105:465:1:3:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4JyHnq3hXYz9sVv;
        Mon, 14 Feb 2022 22:45:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1644875117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXyDWJOi2TMbTegBFxuy90N+VPfjmUO34aZ2XisvdHc=;
        b=PSeIAGiMrPN3ZUTy2C2zX72ryIC0a5D8Sk+bCAKEbvPcqv+v3kHT62h23D7j2HpSOpfH8W
        VB4+9QWY7BE6dmY+k7KwnZq+UEvqg5lHj4tIzwQcw1gIvx/5KUkFY58mXjVslx6qT5sBX2
        l7og2zGoKO75i8NLntmNzcBycpx2h/jnPfundg6+Y97CsnjEhPDlhOHdAl+ARIOe1PyBvy
        fA8fQu0pAIM1ZS9aHaOXSwruAktxWiUeR+OCFf7E7kZNKGLtaSukxGN7zmf56dxyauhUjt
        j48J9aUc7mx2h+j9RobCyNSn68Z1oDvtSFWch2dfwzzYfRG6bU5nkg49XjWxrg==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings:trivial-devices: Add pli1209bc
Date:   Mon, 14 Feb 2022 22:44:54 +0100
Message-Id: <f1fedce71149a2ce811bf40a2097fee5b54911bf.1644874828.git.sylv@sylv.io>
In-Reply-To: <cover.1644874828.git.sylv@sylv.io>
References: <cover.1644874828.git.sylv@sylv.io>
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

