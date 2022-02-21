Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D414BE889
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353224AbiBUKXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:23:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354327AbiBUKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:22:57 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73123E5C3;
        Mon, 21 Feb 2022 01:42:41 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4K2HQm12DYz9sWT;
        Mon, 21 Feb 2022 10:42:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1645436558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXyDWJOi2TMbTegBFxuy90N+VPfjmUO34aZ2XisvdHc=;
        b=Qia4g1k8umSG9wQL559MOs+D7uBYG9muc1P29pjVOUXCFZPkHwvLRo48GGJ0gbOsYgXjaw
        79eC9WlHc5veBQF0H5NxbuH1+qR2YLsL54XlboU5NOLv04ABACbTJWfumrdYjS5HMIjqI6
        ZDahsgTwt1fKpRMwWhpwKuzXUJrsjYw+DidA2bra1IA7aJvARAoNrHik2LJ02IKu71x6L8
        Z9t4po56oGcVDHxfLx9MhlghSGyw5mKAGvwM/A4ixOfXHaZqU2pCLKimsLIQrMguytkav8
        zggcB/RJfw0onXZ/r4VK0JgJ/TjZ36XPLx1l3EzbAhlegsfb92h7I4joU6soIg==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings:trivial-devices: Add pli1209bc
Date:   Mon, 21 Feb 2022 10:42:05 +0100
Message-Id: <15a9fcfb5b9592c6d87f12c2a4c77fd069f5cfff.1645435888.git.sylv@sylv.io>
In-Reply-To: <cover.1645435888.git.sylv@sylv.io>
References: <cover.1645435888.git.sylv@sylv.io>
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

