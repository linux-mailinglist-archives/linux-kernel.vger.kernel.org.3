Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D70472A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbhLMK3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344676AbhLMK1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:27:42 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCDC01DF1A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:01:32 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so12215498pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 02:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W860UaRrJsw2Gobo/QW4yrvE/2SVc50lvblET7Jsnp4=;
        b=qP0BshOUlN/3iiQfIWavoPtTVodrDzrlK6ANQ/PbNwQsTRx1GeRhbz/r70UkTCZVB8
         GNrTgSloKnDmLS73Ab8u6sgDWavI+OWH1MEjeZvXZ0sic+8l6P3YRq6eCGIICvCaygRS
         A/iiPG+u+si9eWSeCgA7+9kTbrWlKSCLRqJTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W860UaRrJsw2Gobo/QW4yrvE/2SVc50lvblET7Jsnp4=;
        b=V8hjCFz/BrJEp1x4X5TqlS639a79siOa66g9EdrziWujuoeyqxyoniqVqoQrxaxtV1
         jltaIaig7l2qbB8GPyTC1rddR8M3/sExWQtgljClLGU/7nnIBlRIEa4ceRxBXUFw6bir
         OHZgy1G/WD+8gzoi7ige/uGyOg1PEqiyIjqjQC75UyBjbRShBDj8oVQHRnDn88HHy6xo
         zuX4wWA4wPrhWcgrImlXkG4Lz+6/z3RKF/DYde+JPiZmNrzkdPNzTqScoZR1CN0CpSPk
         gNP320QN3YbyEKepu6af6rJ1htDn4yorCRwnrqzy3GtomtxFYPxHkAQNlrCkqyYmWoqI
         JH7Q==
X-Gm-Message-State: AOAM53284+Lkz40+Suu9h2fbD7xNWAqHr1tdg7Rr2Tiovku6HxaObV4u
        +hBI3BQfyGVFLT/IvP/cVAgbIg==
X-Google-Smtp-Source: ABdhPJxszvLSWm3tqZ4LbukdjNkTUOWUchH9G8Sa+++bFJf5LlAhqXkStwc6cpKh6r/pftv9Oo3DUg==
X-Received: by 2002:a17:902:8e87:b0:143:759c:6a2d with SMTP id bg7-20020a1709028e8700b00143759c6a2dmr93012133plb.59.1639389691796;
        Mon, 13 Dec 2021 02:01:31 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id d185sm9953767pgc.58.2021.12.13.02.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 02:01:31 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, romain.perier@gmail.com,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 2/3] dt-bindings: arm: mstar: Add compatible for Miyoo Mini
Date:   Mon, 13 Dec 2021 19:01:11 +0900
Message-Id: <20211213100112.1791192-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213100112.1791192-1-daniel@0x0f.com>
References: <20211213100112.1791192-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Miyoo Mini is a SigmaStar SSD202D based retro emulation
device.

Add a compatible for it to the list of infinity2m devices.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Link: http://linux-chenxing.org/infinity2/miyoomini/
---
 Documentation/devicetree/bindings/arm/mstar/mstar.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
index a316eef1b728..8e1a0e99a60b 100644
--- a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
+++ b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
@@ -25,6 +25,7 @@ properties:
           - enum:
               - honestar,ssd201htv2 # Honestar SSD201_HT_V2 devkit
               - m5stack,unitv2 # M5Stack UnitV2
+              - miyoo,miyoo-mini # Miyoo Mini
           - const: mstar,infinity2m
 
       - description: infinity3 boards
-- 
2.34.1

