Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62022487950
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347923AbiAGOzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347895AbiAGOz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:55:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B717EC06173F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 06:55:27 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n19-20020a7bc5d3000000b003466ef16375so5576754wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 06:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47wpJBWQnnL/Yb6rNHbZNchIMuG97gnS58weYyw8g1s=;
        b=oDkoluSypttLPb8Umty2MkLN39zoNn+9O+8uwJHEHGGV530ukbfqnm4b05aPIAWwse
         /2V6s2vxjhUrjAZGU41ncmfN+ghD273nb2lCOlD6KX1CR5RGjjVkypoCBmQOYxnhbxGr
         j29xczS30M6R8PDuiilNYwCKA08PJYH1+/ufSiO6+xC+NrtfjlXlDevRjgguGzpQxey6
         x7b39MeJgsG8uKRUkQpPFg70pMUPxHe5oYg46UIHAhZbu3ZeDHbC3DXYRxIx7b3+Q/fZ
         fdOcqfqaB3CqPoclqeAW7ANd6Cz/7dUyXUxE25RwNSkOFMFulUUBKDXSglnWbiP/suCB
         fhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47wpJBWQnnL/Yb6rNHbZNchIMuG97gnS58weYyw8g1s=;
        b=FiQmA1XqbFev0h0ctWwV/uyVHWIN1tReem07/NZRsh0sm8qCvnxSNKQLa1sga4rb37
         ShdLR0I4uqaOfsN+zhj46BpgxChL6yVEFLHFiR1XMbexiGPjfBlLHqd8xWgKVqdqMK+I
         HIvH6Wu0pas/Kj1bbvLmwMLw3CHUNlcwhb0+mRe6KdcMB6uzlzG1SBjBpNX736gasoJf
         4LUos3ksptPP/mN2Fsx7mW7gIUC7PzcsDOXGB92tpA0+8ezUwUtknib/PuRrT6Zd2QMF
         CmKcCv2UrEHtquC+VDnttSKTOzx9CZbtvm/S43UVkmcBWDNUUzararvLpu61CG0QY/n3
         Giug==
X-Gm-Message-State: AOAM530w02TmYNnNa7tLfWM+6qi8tGrRDG398+icxQW5PAw43GmcYnFw
        yCaaWu5Ybu2hJ1IDdF/vOmfj5g==
X-Google-Smtp-Source: ABdhPJyBKmX/qE3POuKtDj/Gi6P0EsDyoBMPeSdgpd9TbRF+5r9CaPnxZmF+nL27uoClnSD7luMOTQ==
X-Received: by 2002:a1c:7214:: with SMTP id n20mr11484032wmc.118.1641567326252;
        Fri, 07 Jan 2022 06:55:26 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:fc89:e826:8938:cbde])
        by smtp.gmail.com with ESMTPSA id n8sm5594492wri.47.2022.01.07.06.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 06:55:25 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/6] dt-bindings: display: meson-vpu: add third DPI output port
Date:   Fri,  7 Jan 2022 15:55:11 +0100
Message-Id: <20220107145515.613009-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107145515.613009-1-narmstrong@baylibre.com>
References: <20220107145515.613009-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add third port corresponding to the ENCL DPI encoder used to connect
to DSI or LVDS transceivers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/display/amlogic,meson-vpu.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
index 851cb0781217..525a01a38568 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
@@ -92,6 +92,11 @@ properties:
     description:
       A port node pointing to the HDMI-TX port node.
 
+  port@2:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node pointing to the DPI port node (e.g. DSI or LVDS transceiver).
+
   "#address-cells":
     const: 1
 
-- 
2.25.1

