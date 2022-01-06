Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6EC4869C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbiAFSZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:25:34 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:45604 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242739AbiAFSZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:25:31 -0500
Received: by mail-oo1-f42.google.com with SMTP id l10-20020a4a840a000000b002dc09752694so852250oog.12;
        Thu, 06 Jan 2022 10:25:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+1b8xpRYxZ8vmZgumm9JuvwJZHTxs74RlVPJnbYxN54=;
        b=6LQ8G/u5/vITcAYomYrGqQaDApTOEOLmMl3h7OnqqropHSE7xvNWq63vaBLvtwXswF
         FfEzdIWy0ekLFia7xkKe2l0c2RYSO31UPFpArrjo7L9v2K+ncZn85NBqc+KeCB6i30Uc
         yP64NfxASa/44MvvqS8auIUn/4c58h8h6jkAtBbho4pgdI3JLu+Orp3379tTIYOYCuy5
         X4OohLx9VxFitUpeV044pr7vyWdiR1G31hTBF+s6L2ts/1SQ5J+eTWMy/chUITm0qWeX
         K6KpV32nUImzqAtYIMl7iHkXCPiexX9Ljnq4cA8XNod020y1KFy+CJVkJ5inUaJAGdMo
         IakA==
X-Gm-Message-State: AOAM531byy0GLEkxd1eN53FW/Imem5cGprnGFM4zGWLiTr9qz7untqmc
        ZvfxUawAROYDRyVBvQ8nTLlgdDakUQ==
X-Google-Smtp-Source: ABdhPJxOg9d7S+nH7Ow7Pl1QUcRGuNmgke+MFJ4NpJB8DgqESzYqHfSD7oJu/egfBzNw/9xjD79V1A==
X-Received: by 2002:a4a:be90:: with SMTP id o16mr36439739oop.28.1641493531034;
        Thu, 06 Jan 2022 10:25:31 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id r13sm484949oth.21.2022.01.06.10.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:25:30 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio/adc: ti,palmas-gpadc: Split interrupt fields in example
Date:   Thu,  6 Jan 2022 12:25:11 -0600
Message-Id: <20220106182518.1435497-3-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Best practice for multi-cell property values is to bracket each multi-cell
value.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml        | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
index 7b895784e008..57a31356082e 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,palmas-gpadc.yaml
@@ -74,9 +74,9 @@ examples:
         compatible = "ti,twl6035-pmic", "ti,palmas-pmic";
         adc {
             compatible = "ti,palmas-gpadc";
-            interrupts = <18 0
-                          16 0
-                          17 0>;
+            interrupts = <18 0>,
+                         <16 0>,
+                         <17 0>;
             #io-channel-cells = <1>;
             ti,channel0-current-microamp = <5>;
             ti,channel3-current-microamp = <10>;
-- 
2.32.0

