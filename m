Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB0C49329E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350815AbiASB4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:56:21 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42868 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbiASB4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:56:18 -0500
Received: by mail-oi1-f178.google.com with SMTP id y14so1766136oia.9;
        Tue, 18 Jan 2022 17:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xl4YF7yMBh19aRnWIpeFHcZPT/DRkG3ZpsT4F+vO3Fo=;
        b=wTvtAVM1Cs7gJTGELuFhmQ6o3syly0FlXCeT0lJgKlcbsjJ7WOb7vh0DvCajF/Epsy
         EzGRxlU/OwcrAUJ1qNPy2Dn5P7r/MZeut/T9DFHuZQsx1IgE3bqufpUDtElyDgB3Sc49
         RIvrunXUB83zEeW3wbZP4FND4CPoE93oNQFeIqMaJTWgQFoFRKk9gETgyZmwrVuo8eW6
         AzLLmMXu5BgM1ll0PQ/1PLZEwcaaKzG8EmyDSdUaq5laQjbMNf6/hzYVjALYlcpiUmpW
         pvbfO5cDsUkU+VFtd1oQg7KKgO74FU3TroZqO1sWnDrpLjG1EvMQ0Bx5vMdkKkm5BVOc
         GGsw==
X-Gm-Message-State: AOAM532h4CM0Xi1qnR6Yuwn4B6nJ3vdK1gGRwMUmcpWT77GQ43/Vq7GT
        SjKIi3P56m0EOcJn0o/05w==
X-Google-Smtp-Source: ABdhPJzmXj447zYYE0lAjRVE977hZD66BZMTkLTujaaDyR1hxj2Lg9/s5ZEp8Ie75aHaV6GnG7lSVw==
X-Received: by 2002:a54:469a:: with SMTP id k26mr1117153oic.147.1642557377523;
        Tue, 18 Jan 2022 17:56:17 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id g11sm5403640otq.13.2022.01.18.17.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 17:56:15 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        - <patches@opensource.cirrus.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: cirrus,madera: Fix 'interrupts' in example
Date:   Tue, 18 Jan 2022 19:56:11 -0600
Message-Id: <20220119015611.2442819-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'interrupts' properties takes an irq number, not a phandle, and
'interrupt-parent' isn't needed in examples.
---
 Documentation/devicetree/bindings/mfd/cirrus,madera.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/cirrus,madera.yaml b/Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
index 5dce62a7eff2..68c75a517c92 100644
--- a/Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
+++ b/Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
@@ -245,8 +245,7 @@ examples:
 
             interrupt-controller;
             #interrupt-cells = <2>;
-            interrupts = <&host_irq1>;
-            interrupt-parent = <&gic>;
+            interrupts = <4 1 0>;
 
             gpio-controller;
             #gpio-cells = <2>;
-- 
2.32.0

