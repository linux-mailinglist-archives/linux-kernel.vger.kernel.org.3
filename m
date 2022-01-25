Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85D49A899
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319647AbiAYDJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1312160AbiAYClx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:41:53 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136E5C019B2B;
        Mon, 24 Jan 2022 18:10:43 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id b8so1186237qtt.8;
        Mon, 24 Jan 2022 18:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JQ08bNvQMf8xaiplyU2DXnMjp5Aby3EKSZotltu5q8c=;
        b=WH2j+oCodFc1Yg9Ni0NDUttB7JOhwscDIgD9gCV7Df60jfKqGbatfOL7XTjQlA49yA
         ZIm921dGBfGiNW4LAb4MGAfUZ1h5Jsd0lsPtDdRF8ZrcWIRjtJbobLjZ7nYPpkiYCHtE
         apWYwUSWICpBDs6drQVAkUuq4Xhw2e7UJ+NQss9tbJ8jeKYcsGf8KzKuPlExk/XNFE1F
         hgTuEjEL10n/hbup+1XhabHypLOzIy149cetX1/R8QFCVyznBDFuqqJVkt5F60a+/vmc
         kGa5wJhUQ4KlhDNzUaxAC8+9ntpQnr7T/DDBwehxQ0XyeoP62S8qhmv//wui1slS0aSv
         X28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JQ08bNvQMf8xaiplyU2DXnMjp5Aby3EKSZotltu5q8c=;
        b=4/nompHpY8uQkAxlWMZQ9QqyYr2CX08tAVpdbGHpQKox18FE4phUoNeZmL1NRZKyFm
         XMvhuIHslG5BvcTaFcP0AHSmAyRsN0aeoeDTckk472R4vEzLF44qBbUJn/lRV8fkmALU
         ftZ+TGBPw4YE21bfT+mxSLpxoJBrPzw6vwF1mKpzDxRk61NQxJdSbwVMGn8OVx0L7xJ6
         JmmDBctB9XRfVLAGGjKGGXK8BnW2o0k9ppz/6Hux6UCqWaXYdoapCz9riMBICs2mep1u
         al30i9TxMNCGqMd5M4Jx+yzF6LzCzbfakeisrO7Mb3twuFYKAHaFB4ZgOGToWPRMMXAc
         HHMQ==
X-Gm-Message-State: AOAM530aRqQ28d3hxSLLirVPFVKv7CFtmbQwBkdzLCm9A3ZOhtZjuAx0
        iTbsI8au/tOVxguVbglwhoGeVRmBBqVg4w==
X-Google-Smtp-Source: ABdhPJwZBAfW0IlBXV7hYkVdYLtM6cmtQtfsb2+NhozfesQ8eWj60l8cjw3Py0M6/eOhObwvM3BOiw==
X-Received: by 2002:ac8:5810:: with SMTP id g16mr14599532qtg.183.1643076642303;
        Mon, 24 Jan 2022 18:10:42 -0800 (PST)
Received: from Dell-Inspiron-15.dartmouth.edu ([129.170.195.217])
        by smtp.gmail.com with ESMTPSA id m190sm8024845qkf.58.2022.01.24.18.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 18:10:42 -0800 (PST)
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
Cc:     Ben Wolsieffer <benwolsieffer@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] dt-bindings: arm: qcom: document HP TouchPad
Date:   Mon, 24 Jan 2022 21:07:04 -0500
Message-Id: <aa59002aeae45a95097300213fc34490aa8db250.1643075547.git.benwolsieffer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643075547.git.benwolsieffer@gmail.com>
References: <cover.1643075547.git.benwolsieffer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the HP TouchPad.

Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 370aab274cd1..f7418a8a49fc 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -119,6 +119,7 @@ properties:
       - items:
           - enum:
               - qcom,apq8060-dragonboard
+              - qcom,apq8060-tenderloin
               - qcom,msm8660-surf
           - const: qcom,msm8660
 
-- 
2.34.1

