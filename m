Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DFF48D931
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiAMNjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbiAMNjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:39:05 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5036AC06173F;
        Thu, 13 Jan 2022 05:39:05 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o6so23182638edc.4;
        Thu, 13 Jan 2022 05:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IWJkg6qg27QZKHcTBGNAP9IpEIyzgZGKBVAJTaPA8CI=;
        b=glMInTZSQGsHrG+06GI7+rCeZzg2ojNiv5utidhcUJr3yde4uJXaAkkF613fCWAQlP
         5FCFAzO9lcWdlR69GDKn5/hWQ4U1ATP8AxnjyoZqNctj2kjWnTFzy/ndjnGLcTV5erGE
         RQ8OHkzMZf6B5S6aHOUtUX6n8/Najsb3WFt8fX8m3atvQ8KQjPlT/4X+WdgMAUUYES7I
         ik4AOjpJ9Q1htriVV32p7SQDbJDTh5g/LqFx5GdCD3u49ZaBAK/uE/zVJZss7eb6ZBqC
         RVWBDSPpaLkNBcoMA/Xew2/Lx49WDmNGNBjtUMlm47BIb33TWh5EaeYkEB2UObY66sat
         56HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IWJkg6qg27QZKHcTBGNAP9IpEIyzgZGKBVAJTaPA8CI=;
        b=DbQJBpzv7oRaBZMo7XHZO8QRxPdsEFR/o47kjMxBdZABv/N93iErEpthenRPiGth1K
         eicgsdEfhQVKKEo678NZamxlqdEEJ1doz+rjftvERqNq2rjRhZF2MkpsD1IYifeREwYh
         YXE/h7Ezi9Ri6qM/77u7WMtKWpPrD2z8M0D0liBfA7EEZkHhY0OigCFMjyoCXgGuy1xV
         FHrXt3+jJlxQ5EJOjUi9Q5OERBMXE0jFIlKyDrku5vP6U9Z/uTXnIqpMbVJgklFrV+Rc
         +KOLRp5WY6718DoPKmkXAB0yPUEOQAA4bA3fyTDJX/3sUR0qHURW1rxvlT+iwX5tXry3
         M71Q==
X-Gm-Message-State: AOAM530ARhsX+wHViZYahRx4IiI0k7F93O3lhn/u3lvhmBnoyzraISRS
        I3S29cdmKJomVAelgsTa7rJlx5fnMz8=
X-Google-Smtp-Source: ABdhPJzhjXw3TNb5YmpKnci57SLyYo5aQok2gwaq11GVsAS6uFrYijpUHpmdQrMPTCLhPZVhuYU/wQ==
X-Received: by 2002:a05:6402:40cf:: with SMTP id z15mr4150789edb.185.1642081143935;
        Thu, 13 Jan 2022 05:39:03 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id x11sm1184924edq.55.2022.01.13.05.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 05:39:03 -0800 (PST)
Date:   Thu, 13 Jan 2022 14:39:01 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: trivial-devices: fix swapped comments
Message-ID: <7dc6ddb0b042cd243b2875e9aea81cad541d1c6b.1642080090.git.stano.jakubek@gmail.com>
References: <cover.1642080090.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1642080090.git.stano.jakubek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparkfun,qwiic-joystick and st,24c256 had their comments incorrectly
swapped. Swap them to make them correct.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 9af1b0f4ecea..098811b7aa97 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -303,9 +303,9 @@ properties:
           - skyworks,sky81452
             # Socionext SynQuacer TPM MMIO module
           - socionext,synquacer-tpm-mmio
-            # i2c serial eeprom  (24cxx)
-          - sparkfun,qwiic-joystick
             # SparkFun Qwiic Joystick (COM-15168) with i2c interface
+          - sparkfun,qwiic-joystick
+            # i2c serial eeprom  (24cxx)
           - st,24c256
             # Ambient Light Sensor with SMBUS/Two Wire Serial Interface
           - taos,tsl2550
-- 
2.25.1

