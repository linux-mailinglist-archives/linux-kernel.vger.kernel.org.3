Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8012846554B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352355AbhLAS0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352301AbhLASZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:25:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE819C061748;
        Wed,  1 Dec 2021 10:21:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 133so21200204wme.0;
        Wed, 01 Dec 2021 10:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qzpn3X7YSU7kqDgBL/msm7A2QFpd96QjV7OFVFdJdDc=;
        b=gQF2MAgPbjKUTnky23wGo+zGaO/BXsioNUUzVpDBk4nR+Fik/WELZ++ACqG4qGRGvb
         l0Uu105LT6VV2szmjliSZKZ0uKfq1y8YHzh0nhbBDh03qNx7HbCSedXBL3l0PKRp4fPm
         eNQqyOYi4yhH/hPmRO0DMVwuWILaR67I2+BGe1MZgs22osJ/6pdP6MM2l411+80PHJD9
         lWaZYCeJM5mTqBr9JEWH4FqcGd35lFm8lMfq5EGJ+KqMR285DLtH/rdlFvonMOGep+FB
         Eutvq4rcKtqSXNTC8aigKLgF9M4afYQ3Fgav6JRWvSpjUhimL4s+4X0eMMG3HYsZbVO3
         q5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qzpn3X7YSU7kqDgBL/msm7A2QFpd96QjV7OFVFdJdDc=;
        b=fuwfGt9P6bvdX8v05UGi/mE1Iv0zCHa9UkfnN2vsFGhcV/SUJAdlc2/a+/KYs7IGOA
         K2KVcNawEc26dYpREdC/gEOqy6OFow00J2sXw7k77HpPfHrwiBCOsom8PQtx/qmCMHPu
         1BOEdrHtD31uv2cFQ1NTZAZkvETourRgXACB72VySWiyJWv6JI3Xmcph3yELaRdJGdAr
         ZXBi+/Al0ToBdNYgJd08oZqEAaFLg9aaq7jIeEYyUZauxGpWaF/Di4wkkf9DNvawXLoX
         9d1ke/tZxkRaotmiqaLx5/0OU4eXMzp36Bjx3Rg0T4PvP7tKIDUoXFVqeibC6Aw2rNOX
         vHEQ==
X-Gm-Message-State: AOAM533mkos/XAOnMp6lc1WD7GMNKa++BCo97ZFR1olw/9Je4yNBcw5T
        FDDqIWQ+jZvPNmCDFU9xM/o=
X-Google-Smtp-Source: ABdhPJzUoNgZFCQUF0K5G5fiyEY5lvNE4xEEfZC79YJ2ioGRMHVcVJlggzrA/3UacmYTFkoQAAzbtQ==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr8795672wmh.193.1638382899462;
        Wed, 01 Dec 2021 10:21:39 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id f7sm604705wri.74.2021.12.01.10.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:21:39 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/5] dt-bindings: arm: sunxi: Add Tanix TX6 mini
Date:   Wed,  1 Dec 2021 19:21:15 +0100
Message-Id: <20211201182118.1213806-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
References: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 mini is, as its name suggest, very similar to Tanix TX6, but
with less features. It misses bluetooth support, it has less RAM, wifi
supports only 2.4G, it comes with different IR remote, etc.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 889128acf49a..c8a3102c0fde 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -808,6 +808,11 @@ properties:
           - const: oranth,tanix-tx6
           - const: allwinner,sun50i-h6
 
+      - description: Tanix TX6 mini
+        items:
+          - const: oranth,tanix-tx6-mini
+          - const: allwinner,sun50i-h6
+
       - description: TBS A711 Tablet
         items:
           - const: tbs-biometrics,a711
-- 
2.34.1

