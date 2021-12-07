Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878BE46B622
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhLGIkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhLGIkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:40:08 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E84C061748;
        Tue,  7 Dec 2021 00:36:38 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 13so25914143ljj.11;
        Tue, 07 Dec 2021 00:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlYUyB267zRhWHErr+nJIFE9vcvHYd5t7U4mg/8Hi0Y=;
        b=HSYuJeEYa11G8cde/aHBJ67FLo/70lWm81UkGfm//hqvANeDge/w9FbJnuH8zbiH1a
         4d95iPPqpho7z6/34c6G141tHm2YzjtQ0BZHc3+qPuOXXtMXSYkApFd3811Ns9UDcOVY
         3SweIqHNTEtzgaegDRwcXBPsUVgS9XXNwY3l25QjPwJ7sj3/xeqJIU15TQ0c1otuhhmK
         f22qa5vP3CwvAoDydCnMHfTn6gPAQsaJ5qWBOBZYcXTpsM+GqjjmnU0MjXTjdCbdyCtx
         hIXQEPfK8TjPz7+lwttBHPSGZiANzUGvJxoyxNs9jq6e1eSk+SEzGax5IgJIGTnkm5NL
         aSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlYUyB267zRhWHErr+nJIFE9vcvHYd5t7U4mg/8Hi0Y=;
        b=RbHi6krLxFRzmxB2T23sw+0fZJaIKXD74PfxGqaAzNao2YqgTdbt+fNRBiV1uqP7ht
         hiqABlWXtAvXM0QmrZNoweD2sddAi1MxOI+YmjV7ZxLKlnP74kngDxEappOKRT10QY85
         W4b4/9PygLmi78qqS6C4iqjwoUup9eP9v80cf3HM3NYYFXAkxCT4TI0ckw+TNu1rwVmY
         hzLlRwUmYohftbW5bBInmCEjY6YfrUE1zEGQNwtj++Jk3wN8oRECAQUOJcico2MzQg2E
         VV13TcnlA9/VnehWtmJx8BwYAt8uGDb2rWzWCWltcHh/oiAFwV4h3Ic5ku6L2KIleDIl
         r2/w==
X-Gm-Message-State: AOAM533niagd5zKAX+3mhPoqavepOKIi5qI8P9jU0YrkbGVO8OHf5Qa3
        u3dbs4L0o4AEcbQQvbK3D5Y=
X-Google-Smtp-Source: ABdhPJy370SD/W2VgTDgwCTyzxI0sgHro2MB8sQzzFjxeK//DcV/vPDGZtzq13i5a+ZxC8k9SDhxOw==
X-Received: by 2002:a2e:730b:: with SMTP id o11mr41721795ljc.14.1638866196333;
        Tue, 07 Dec 2021 00:36:36 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id cf34sm1601358lfb.222.2021.12.07.00.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:36:35 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: mfd: cirrus,lochnagar: fix pin controller nodename
Date:   Tue,  7 Dec 2021 09:36:18 +0100
Message-Id: <20211207083618.12940-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Replace custom nodename with a generic "pinctrl" to match new pinctrl
binding requirement. This will fix:
Documentation/devicetree/bindings/mfd/cirrus,lochnagar.example.dt.yaml: lochnagar-pinctrl: $nodename:0: 'lochnagar-pinctrl' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
        From schema: Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml

Reported-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
index c00ad3e21c21..ad285cb480c9 100644
--- a/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
+++ b/Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
@@ -126,7 +126,7 @@ properties:
       clock-frequency:
         const: 12288000
 
-  lochnagar-pinctrl:
+  pinctrl:
     type: object
     $ref: /schemas/pinctrl/cirrus,lochnagar.yaml#
 
@@ -255,7 +255,7 @@ required:
   - reg
   - reset-gpios
   - lochnagar-clk
-  - lochnagar-pinctrl
+  - pinctrl
 
 additionalProperties: false
 
@@ -293,7 +293,7 @@ examples:
                 clock-frequency = <32768>;
             };
 
-            lochnagar-pinctrl {
+            pinctrl {
                 compatible = "cirrus,lochnagar-pinctrl";
 
                 gpio-controller;
-- 
2.31.1

