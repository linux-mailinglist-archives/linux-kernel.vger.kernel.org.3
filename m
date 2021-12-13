Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B5E4721AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 08:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhLMHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 02:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhLMHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 02:24:02 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A90EC061756
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:24:02 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id o4so14102080pfp.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 23:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHDKjEXSmqoSIP+TB1gPedSyi6ETK7cM1nPYeOviVPg=;
        b=iTfc6TJPsBL+LTaSAFFxrkBLrdtDnOZT025BYaoWu/Vqh49UGHatNRitpC0ROkmsIb
         3G4g45EbcV1b1+vNj3xfT1+cDOZRP5hOKLTzvEo7c1uxYfn6a+j9rhD+Vfq/NF2CSw9J
         fd0ByqizROJ8TT/4blfTOingAS8s3WztCeLz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHDKjEXSmqoSIP+TB1gPedSyi6ETK7cM1nPYeOviVPg=;
        b=yUwQrntNvMWVDKKbtKcpw0bTTbnTtzQPalsZSzkB5SoXQRGBGLkkfl5pOE/5bmmUDh
         4QRDeU1GZn2F24j9qkOwCedTKNNmx6u7G5wFVN4k2Uictv7xFyihmBDAJB60d9NlW4Za
         ueseSIHRW+vAGp0bB63UVjuvqxxRFLNqq5Yxs0pXwDuzQHwv/x5/6yWXTRiZXkf0GjzN
         CSUqOlDbbDJwPMx3/UCM2aX1DRr2jm+KyU/F4K0eYkSFqS2JOkRBTMME1GOF/FUGgXt3
         wi9Xec/eqjUC0Gu5xtL4KQyceFaeAZIRV8pNplGgFqyRBh7/9spqo6MXYoCNhBiJSKip
         fjMg==
X-Gm-Message-State: AOAM5335YzBQjzWhoT6nvSC0lhoJnhTyHyO9pYlhAmfA3YJqbUJYiFMx
        VWNUuzfhsg8e1fF8YQBIm6dzYw==
X-Google-Smtp-Source: ABdhPJxsjVjfJN4rfywh9wlYcdwqLbk+6iNcwHEQBP/1nHNhraHh8toFSnB/i9niYEMN0PBtfZGoPg==
X-Received: by 2002:a65:5c88:: with SMTP id a8mr50572544pgt.542.1639380241991;
        Sun, 12 Dec 2021 23:24:01 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9447:edff:ad23:1bfc])
        by smtp.gmail.com with ESMTPSA id e7sm11747562pfv.156.2021.12.12.23.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 23:24:01 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-katsu
Date:   Mon, 13 Dec 2021 15:23:54 +0800
Message-Id: <20211213072355.4079568-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211213072355.4079568-1-hsinyi@chromium.org>
References: <20211213072355.4079568-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Katsu is known as ASUS Chromebook Detachable CZ1.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 723810cffce2e7..75bb06d1802a08 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -175,6 +175,13 @@ properties:
         items:
           - const: google,kappa
           - const: mediatek,mt8183
+      - description: Google Katsu (ASUS Chromebook Detachable CZ1)
+        items:
+          - enum:
+              - google,katsu-sku32
+              - google,katsu-sku38
+          - const: google,katsu
+          - const: mediatek,mt8183
       - description: Google Kodama (Lenovo 10e Chromebook Tablet)
         items:
           - enum:
-- 
2.34.1.173.g76aa8bc2d0-goog

