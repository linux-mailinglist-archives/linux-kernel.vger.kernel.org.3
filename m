Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95C2480646
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 06:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhL1FUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 00:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhL1FUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 00:20:18 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF728C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 21:20:17 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id u21so15183863oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 21:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ByvL2Uf/cXpEPeJ2AJET+qvtgysLCEvhZPeq63DSw38=;
        b=B4zhlUAr32kY5oZ8N53jC4N8hPIY76Y5v1jPJEOJ/8WQ/GGjZEEkjMyc62nzUR9fA+
         iwn7SXOmsb3AMDCG7G2wARbdPuxKskTye7cWKkq7ezq1aFwZdRFDIvbp4aaDMdgev2mh
         n7F1qLKmmQwyw5aKDR116G9iStrWa+eiY2wPMCHmXks6ElcXzV7rettiqdDEZ6+MqD6w
         KQ75+fbrRwUTxPrV4tFrmnTSLRGx9+/YVu2ldIlYlJP93Pwva0AUASZGtPKEAvjFEI7U
         0ljq2DhdsSpe3aUhVeYZoitZRvGXgDpIhWniyagk5LDACXH8GsQwmtBukZ0YqCumW61E
         qzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ByvL2Uf/cXpEPeJ2AJET+qvtgysLCEvhZPeq63DSw38=;
        b=Pv/BUecHN1LThqxhccIjZkw9KA2gOzpn0CVdh3kJlutKcrgvsL7NbdRO3mfZiGSTrR
         5XrbJKHQ/OohTS7yhPI7fHa94XVgGIlju3SO2KwQ+tKGmEA5bP54PowVmyUqksrlG8vW
         25K5IwLtm2gT2WJfZzHbdEBnX7D96LhbT8dIPGWoW6Dx5AZgbQatKT2AEQANituIeScs
         Ia7ex5sMcQZh1wh4PDXvQ0+W/BK3/X0DU9KoOwN3e/5lRRSQMCA69G3vICsgWeDaefM9
         QPtvkoFKsQc1g4I1MMTL2Wc5FqcCcjVsmoljVU+/EyGfP5iigt/6GbXXmEbUEuszOyPz
         TQoQ==
X-Gm-Message-State: AOAM530DPEu/R3yeIVBv+dV1D6nm7CkNH32RZN7d4g1/cum5ptGWv47E
        t7ozxACunGo3ySj2i4lj7oHUaQ==
X-Google-Smtp-Source: ABdhPJxct+CkbSvI41JFvkdLrfCsI0wdjHkYbiI93M8uVvOhwpL8J0QsaQ7QXmKuxWERI3iK92ZM+w==
X-Received: by 2002:a05:6808:1408:: with SMTP id w8mr15463765oiv.54.1640668817343;
        Mon, 27 Dec 2021 21:20:17 -0800 (PST)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j5sm3002277oou.23.2021.12.27.21.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 21:20:17 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/8] dt-bindings: phy: qcom,qmp-usb3-dp: Add altmode/switch properties
Date:   Mon, 27 Dec 2021 21:21:09 -0800
Message-Id: <20211228052116.1748443-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP block deals with orientation switching and altmode switching
between USB and DisplayPort. Add the necessary properties to the binding
to allow it to be connected to a TypeC controller and trigger these
operations.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index 60dc27834e1d..f8a745ec479c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -77,6 +77,20 @@ properties:
     description:
       Phandle to a regulator supply to any specific refclk pll block.
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node to link the QMP to a TypeC controller for the purpose of
+      handling altmode muxing and orientation switching.
+
+  mode-switch:
+    description: Flag the port as possible handle of altmode switching
+    type: boolean
+
+  orientation-switch:
+    description: Flag the port as possible handler of orientation switching
+    type: boolean
+
 #Required nodes:
 patternProperties:
   "^usb3-phy@[0-9a-f]+$":
-- 
2.33.1

