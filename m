Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF4646F499
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhLIUJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhLIUJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:09:22 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4459C061746;
        Thu,  9 Dec 2021 12:05:48 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b40so14117640lfv.10;
        Thu, 09 Dec 2021 12:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g9AJiL9uTfpDDMd7SS4C6nAmWL0XZo0V0ZfDFdYmLjY=;
        b=COAXXVLnmQmpr5BGzCN9BcuqWFvHw2ocxZLxo6ryJ5Lhw+xJPSJQG8U5fyMK+rUwSi
         EYiKUFWwRjqcCV5YBfFzHQXgooJ8gBMmNeHvmX/AgiZxPAVXkq9PVW+yvKPlmzOl4aYu
         W2uDd1pXtu8UqzUIkvBXbL2Ch/O5tKOkr88Ei7WEG/HFl30t6yY/I9V2vtZteJYlrLxv
         iWHYSmmfEP5O8RSy/8n2R2GZzIGviX+SR5pmTvEBaL0XRT/AWDwa2km8xegEcMSEcF2l
         kf/OIUNJdOMax5XXVTNReI1Ic72Mf3qeSkVeziNzAaC0ItMUN+asYzsXxndrXbw7kj4E
         Rwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g9AJiL9uTfpDDMd7SS4C6nAmWL0XZo0V0ZfDFdYmLjY=;
        b=0U5MynlwcWqnfHghabiMKK/GMfpqDO6MVdNejJ0ZfpfnHYKxZ2kJBNO/45YDdwaPsJ
         yHp/s6aUYJJm9mrjjviluMrVrcG+1EFS2TJahOaT6YsPNf2ZmiAK3PLMo47bxtfHdGMt
         xsWNhLNlpYrVX8AAehHfIvLN+vl5ugzGddVpExFCR+RsscQYMfFASc1HqCRFtMZy9Li1
         J3/pRLP5wjwHXuKSiokjnQ5pWYVCWP1rktoEGzDqEzJgkjO+4lCEYYXx7pat3hI+LL/6
         U95i4GdDTX91Bd7qbFOhWUPYVSU2jFfx/pjhhyI3g0QccfOtZptTUAASRzbXAXW1dBQ7
         N0yA==
X-Gm-Message-State: AOAM531DGqMzPsqmp4XIUdocZUUds8vCXyOA+xp6YYmOm7Bnihd/7kL6
        aRc/xpqxZIjLxBJqw/GYousJ7N/rec2bYg==
X-Google-Smtp-Source: ABdhPJyxDwm4qD0w1ssRjatqaxocOTEkFxXrsK+gDNk3bFfYXhmsC90Kh+C73THhn+OlTC99iNMRWQ==
X-Received: by 2002:a05:6512:ea2:: with SMTP id bi34mr8469336lfb.12.1639080346992;
        Thu, 09 Dec 2021 12:05:46 -0800 (PST)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id o12sm87371lft.134.2021.12.09.12.05.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 12:05:46 -0800 (PST)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: [PATCH V4 6/6] dt-bindings: xen: Clarify "reg" purpose
Date:   Thu,  9 Dec 2021 22:05:36 +0200
Message-Id: <1639080336-26573-7-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
References: <1639080336-26573-1-git-send-email-olekstysh@gmail.com>
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

While at it, remove the following sentence:
"This property is unnecessary when booting Dom0 using ACPI."
for "reg" and "interrupts" properties as the initialization is not
done via device-tree "hypervisor" node in that case anyway.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes V2 -> V3:
   - new patch

Changes V3 -> V4:
   - add Stefano's R-b and Rob's A-b
   - remove sentence about ACPI for "reg" and "interrupts"
     properties
---
 Documentation/devicetree/bindings/arm/xen.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
index db5c56d..61d77ac 100644
--- a/Documentation/devicetree/bindings/arm/xen.txt
+++ b/Documentation/devicetree/bindings/arm/xen.txt
@@ -7,15 +7,17 @@ the following properties:
 	compatible = "xen,xen-<version>", "xen,xen";
   where <version> is the version of the Xen ABI of the platform.
 
-- reg: specifies the base physical address and size of a region in
-  memory where the grant table should be mapped to, using an
-  HYPERVISOR_memory_op hypercall. The memory region is large enough to map
-  the whole grant table (it is larger or equal to gnttab_max_grant_frames()).
-  This property is unnecessary when booting Dom0 using ACPI.
+- reg: specifies the base physical address and size of the regions in memory
+  where the special resources should be mapped to, using an HYPERVISOR_memory_op
+  hypercall.
+  Region 0 is reserved for mapping grant table, it must be always present.
+  The memory region is large enough to map the whole grant table (it is larger
+  or equal to gnttab_max_grant_frames()).
+  Regions 1...N are extended regions (unused address space) for mapping foreign
+  GFNs and grants, they might be absent if there is nothing to expose.
 
 - interrupts: the interrupt used by Xen to inject event notifications.
   A GIC node is also required.
-  This property is unnecessary when booting Dom0 using ACPI.
 
 To support UEFI on Xen ARM virtual platforms, Xen populates the FDT "uefi" node
 under /hypervisor with following parameters:
-- 
2.7.4

