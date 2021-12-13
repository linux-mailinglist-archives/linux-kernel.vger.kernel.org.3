Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BF34731D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbhLMQ3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbhLMQ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:29:04 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6AAC061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:29:04 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id iq11so12232552pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 08:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PHDKjEXSmqoSIP+TB1gPedSyi6ETK7cM1nPYeOviVPg=;
        b=EQAL2svOqRuf+zxv1dtfNQpVATmX4LvJABaaH6nUaqH4o7Y/8OZ98vtyTXbksNyosX
         fXP6V85IhR6iuR9Xr/EbWsPCfKTkXPg/Ol15Z0Gzaj5iiWZVK0t2KmoGhYvs1OJERxhK
         Arh1UB83YQSTSDjEhMioiq5l6ZbEbBO9JbBzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHDKjEXSmqoSIP+TB1gPedSyi6ETK7cM1nPYeOviVPg=;
        b=0A3ETi6DJ3GDha2ER8CIYmUT5U3HH8b3DwM2mgy09nI5LobpCouN+45xqVhCYWwL0Q
         Gzme2LaYZEmJ4Be46khtuAbGEgV4DmuJVPCGxr1wM2wFsuL+CB+40WwgKameKHu2xDyT
         yVYor3EFxz9Q1ezTX4BDxpC+UzMtBaufXPJmhnPZGz0RMaZziQB3FNC7FVErae+DngJx
         z4X5K07KaXe6rqUd93L3yymppNstCBwYQTPUXN4f/vKeOztLSe/k9nu6j236itil0n8F
         lICKNDkfzMM4aCqDzoacVLVJzPBY5Z13Z9mYRnr3nnCOvMiric4LWkwMaDBoq7OtFlg9
         6oPw==
X-Gm-Message-State: AOAM533VWjT0JckLsv+hSIKJ7qUPGkJSr2/n4GRkc+UI9KYLApdLUhRl
        Ey0RBifVPEtBj7y9R+pX1mRkZA==
X-Google-Smtp-Source: ABdhPJx2ld4vBsWFYDkWoQWK3Tn1x1+xO/FN+YYtifgE6j87eHBM9RajAJ4+aWYkEHW6TxBDymzzyg==
X-Received: by 2002:a17:902:c407:b0:142:28fe:668e with SMTP id k7-20020a170902c40700b0014228fe668emr96615217plk.31.1639412943778;
        Mon, 13 Dec 2021 08:29:03 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:9447:edff:ad23:1bfc])
        by smtp.gmail.com with ESMTPSA id mh1sm7803802pjb.6.2021.12.13.08.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:29:03 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-katsu
Date:   Tue, 14 Dec 2021 00:28:55 +0800
Message-Id: <20211213162856.235130-3-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211213162856.235130-1-hsinyi@chromium.org>
References: <20211213162856.235130-1-hsinyi@chromium.org>
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

