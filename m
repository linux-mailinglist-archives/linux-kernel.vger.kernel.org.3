Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25274790F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbhLQQF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238729AbhLQQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:05:50 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FE1C061574;
        Fri, 17 Dec 2021 08:05:50 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id u14so276040pfg.2;
        Fri, 17 Dec 2021 08:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95BS8XJBvE+QjXLeaVM9kisHvmzTT134lqI7wR1XgXA=;
        b=ffx4dpdQRlE+qdFJQ6CL/zLctypUJcrdwcvXnkSEe7zGhDI5ty05Z8gvkfuWf4zd3x
         WwZI8RDWwMSMYteZXCE+oshI5tHdqp/dJmrOQoSU9AuF/qDS/MgGLczA3ahMQQH4xXR4
         n+d6w/zc5CEPCR4kyUNEQYjgP5rejpirXfQYJBRPFtzGKb8bJtyhLeZ6h1/3aEruQjm8
         Uehx58al8r+2kn01048o4OnCwNs2Llyzkk6bAWQUxOCcxsPodnkVMosMt5Bhn0dl94Oo
         216UCwQu2g467zAh0LR4+nPYg2sdNmO4GHLqXtVm5mpYFuw+oc0asdKEYJ3qt4qnTWeN
         wGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95BS8XJBvE+QjXLeaVM9kisHvmzTT134lqI7wR1XgXA=;
        b=ZTJ+dMtGsYRtEryMEit5Jl5Kv7pzbi5VuIZ3pGfxIabOxOcafLxWBEQTR4m1f+CYr0
         fNmzE79oZ82hDYOcqv6HDudBqudnv0qJajMeTuOdKEGQoqSyQf26RfmGEwRWMcximBa7
         d7tqnL71IpRaBk9vKi4NRvpdD8fZWEJR8BbxnoFoNw48Rz8kSaWrVxU1LiQzLcikMFGz
         pqVurSUXO1q7VqfZ4+xdyRT70PwTCDogk4ovDPQIBZkKbfWL0SnIWsd0Jg3AmW0rNyzB
         kLd1TfJBawhPUTdTG19sMakIWtRQUcSK/Zti7+LytBn9GsDluZSqhJ1StPZd5mYFN+cu
         dO1g==
X-Gm-Message-State: AOAM533yN4oHiWgKc5kn3BEFLlRJUMTsgV+LNzrXXeJy8bCVAWGBfb4V
        LquUxW06wdSqG3oDIu+tQrbhp24ZcE4=
X-Google-Smtp-Source: ABdhPJwyS0hhkYA9//G4r1pUQdopi5pQlo3GOTqTAhFC6mTJU7VLlqVkOKb1RCdBvUt/GBlc5KlMzA==
X-Received: by 2002:a05:6a00:1344:b0:49f:f357:ac9 with SMTP id k4-20020a056a00134400b0049ff3570ac9mr3835008pfu.62.1639757149255;
        Fri, 17 Dec 2021 08:05:49 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z23sm4020760pfr.189.2021.12.17.08.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 08:05:48 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list:IRQCHIP DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v5 0/2] Broadcom DT bindings updates to YAML
Date:   Fri, 17 Dec 2021 08:05:44 -0800
Message-Id: <20211217160546.497012-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

This patch series contains a number of device tree bindings being
converted to YAML to help with validation.

There will be second, and possibly third rounds later on after those
land in.

Thanks!

Changes in v5:
- removed the patches that have already been merged
- list minItems/maxItems for interrupts for the bcm7120-l2
  interrupt controller

Changes in v4:
- removed the patches that have already been merged
- fixed errors in brcm,bcm7120-l2 binding
- added interrupt descriptions and comments to compatibles of
  brcm,gisb-arb
- added description of the 'phys' for BDC and dropped 'ref'
- combined all enums into a single one for brcm,sata-brcm,yaml

Changes in v3;

- added Gregorys' Acked-by to the GPIO binding patch
- added Uwe's Acked-by to the PWM binding patch
- fixed STB L2 binding to include the missing 2711 compatible string
  and interrupt-names property for 7445
- fixed the NSP SATA3 controller node unit name and added a missing
  check for the 63138 variant to check for the reset/reset-names
  property

Changes in v2:

- rebased against dt/next
- addressed Gregory's feedback on the GPIO binding change
- added Damien's Acked-by to the ATA binding patch


Florian Fainelli (2):
  dt-bindings: interrupt-controller: Convert BCM7120 L2 to YAML
  dt-bindings: interrupt-controller: Merge BCM3380 with BCM7120

 .../brcm,bcm3380-l2-intc.txt                  |  39 -----
 .../brcm,bcm7120-l2-intc.txt                  |  88 ----------
 .../brcm,bcm7120-l2-intc.yaml                 | 151 ++++++++++++++++++
 3 files changed, 151 insertions(+), 127 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm3380-l2-intc.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm7120-l2-intc.yaml

-- 
2.25.1

