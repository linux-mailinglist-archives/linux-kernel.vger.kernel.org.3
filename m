Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A452470025
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbhLJLka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbhLJLk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:40:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7939CC0617A1;
        Fri, 10 Dec 2021 03:36:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d10so17519981lfg.6;
        Fri, 10 Dec 2021 03:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q0EX2c887v+fPFHULPYX+g0HtB41ahOOyTy81jfN7fA=;
        b=QFq3dfEuaC/ZrR9cXElNTzTKqK6fX2+DXYCfLxD1Y9fFygejwQK+MmoAwbRE8J+uOT
         zeS3bSIDwqVavq/FS2H67pebzo4N8j2Px8nUCvx40EmGl6amObvoLXNf7hpJcT333n15
         SmzGx3weO44DWQDIbq4dDvkCKdFM/o4i2eHU5HCEXQ1Bh1hZOshjF+cK20j8Xv7I83O8
         QB9QqLTEy/K3BJcRSgKLRqvQ1bGFrMkYvftxQDZubsW6H0izMf+/mbjN+hAthkKWi+Tg
         fN9x3VjsjO1iDNnQwfbZ5YpGdNwYCqzrxIAYT6ga13p5VY3z61Tq+mmDXiPWI6chDC1B
         9LLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q0EX2c887v+fPFHULPYX+g0HtB41ahOOyTy81jfN7fA=;
        b=6DzYEqJqacPZiFXXJblHr4YeF4g3QoldEBI96/TRkU4l5ddRiG2kxaGTLFjoMcbZfd
         Qgylu4gd16RRBhsDt2ROD4jOWw6QkSPxd7F8agvVORZO/q62e1xqxgciuN+FMkSr1OyL
         Xq7cYH2JWmxjLJ/h4Zvp6yxNbajdfcOPlt+RNx28gOox22DQFsdVaBjfbCgV6PCrmZ9D
         Lr2wvIt15jdZE9xe57dztB5QVKLF0joUGGusqTWKd30rDa9oDDH11lolx9mgrRYVQlY+
         Nas+YH0CNfFI/yphRbIQdTJavJDcyQ2MP8ma7MPhv06Ywn5l2b7Qa5NOeGa0+rJ3toIF
         0IHg==
X-Gm-Message-State: AOAM532KT177y7cxf7crplMXOKK9QQf1KhjoDpOvHT0kw3V2Y27TUS/3
        rSEfpP+KqKR3OZjxsupHNpA=
X-Google-Smtp-Source: ABdhPJw5t4mb+80yXTBjzMnq1ZoZI2s9GRnKP6bfIY+UCxPG1pIehe8j8CjKjA9WLpHwTnfsNtCSdA==
X-Received: by 2002:a05:6512:685:: with SMTP id t5mr12006434lfe.84.1639136210663;
        Fri, 10 Dec 2021 03:36:50 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id i8sm285074lfl.287.2021.12.10.03.36.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 03:36:50 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V4 6/6] dt-bindings: xen: Clarify "reg" purpose
Date:   Fri, 10 Dec 2021 13:36:41 +0200
Message-Id: <1639136201-27530-1-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <35ee3534-9e24-5a11-0bf1-a5dd0b640186@gmail.com>
References: <35ee3534-9e24-5a11-0bf1-a5dd0b640186@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Xen on Arm has gained new support recently to calculate and report
extended regions (unused address space) safe to use for external
mappings. These regions are reported via "reg" property under
"hypervisor" node in the guest device-tree. As region 0 is reserved
for grant table space (always present), the indexes for extended
regions are 1...N.

No device-tree bindings update is needed (except clarifying the text)
as guest infers the presence of extended regions from the number
of regions in "reg" property.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Changes V2 -> V3:
   - new patch

Changes V3 -> V4:
   - add Stefano's R-b and Rob's A-b
   - remove sentence about ACPI for "reg" and "interrupts"
     properties

Changes V4 -> V4.1
   - bring the mentioning of ACPI back which, as was pointed out by Julien,
     fits in the context:
     https://lore.kernel.org/xen-devel/9602b019-6c20-cdc7-23f3-9e4f8fd720f6@xen.org/T/#t
     so technically restore V3 state
   - remove Stefano's R-b and Rob's A-b as I am not 100% sure they are
     happy with that
---
 Documentation/devicetree/bindings/arm/xen.txt | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
index db5c56d..156fe10b 100644
--- a/Documentation/devicetree/bindings/arm/xen.txt
+++ b/Documentation/devicetree/bindings/arm/xen.txt
@@ -7,10 +7,14 @@ the following properties:
 	compatible = "xen,xen-<version>", "xen,xen";
   where <version> is the version of the Xen ABI of the platform.
 
-- reg: specifies the base physical address and size of a region in
-  memory where the grant table should be mapped to, using an
-  HYPERVISOR_memory_op hypercall. The memory region is large enough to map
-  the whole grant table (it is larger or equal to gnttab_max_grant_frames()).
+- reg: specifies the base physical address and size of the regions in memory
+  where the special resources should be mapped to, using an HYPERVISOR_memory_op
+  hypercall.
+  Region 0 is reserved for mapping grant table, it must be always present.
+  The memory region is large enough to map the whole grant table (it is larger
+  or equal to gnttab_max_grant_frames()).
+  Regions 1...N are extended regions (unused address space) for mapping foreign
+  GFNs and grants, they might be absent if there is nothing to expose.
   This property is unnecessary when booting Dom0 using ACPI.
 
 - interrupts: the interrupt used by Xen to inject event notifications.
-- 
2.7.4

