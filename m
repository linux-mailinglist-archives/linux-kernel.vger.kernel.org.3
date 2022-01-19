Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F44941C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357329AbiASUcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357339AbiASUcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:32:05 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80C7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:32:05 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id v74so97986pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZ6TQT4GWeSGbapYTD8zwcnou6pSe/ETGXSsIZZ2vnA=;
        b=prfhzT8lrBnwGRfOY1VDCvBcn7r8eAjiAa8UlC2fZL/WDAb9Xa6THPiAfb3wWjCG5S
         w0cW8LqkQXM6lLGTSi/LnYOUL8IDyIGL3RSgT2mycnOwwsHhah5X2x1eFkJB12yJYnD7
         gjVU8AW4CyWL8sy21AhCvXFpzi4DMwGkoTufPSyqIffu9h/ASnUZxm393hy5pXVbpNJW
         Xgwf38qNiXxDJQf8K1PUqkjI6fyTo6IOCRLuKrxgqwkys70X1HjzeIecPVw+uGiJ/K4C
         9NaFMsXQnmgMcyTsp2KeUaiFqBuY7bP44Anwi78nOSSG5UzeofXJ39MkK/Z0u6Bq9ppc
         F7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZ6TQT4GWeSGbapYTD8zwcnou6pSe/ETGXSsIZZ2vnA=;
        b=QykdD09t+5dGLuXmdhdJu25wETG3L18pcViIDTt1lzAtGT4df1acD9VvHgmYe0iWoz
         Vw2qGQzZvUm6kdrsG4uV4lJbgeuZvq6JkEG8RRiApkpOcfjMT8w3cM8i9vDRDFIEFZ3d
         J12+wVhE5WzPXG5XGXiTlDGrIMj/AKwEDHGHf5mE3MQ4uGkvZSB3ru+fQ+87wxvlefhP
         RVd1prDBheyxUvX36/w8it3cmATCBGJP6huTPupO/QEK0BtD2x3IjVYqpgnGk2+RyVjY
         3mjSR53r2U8N/H2zSKAazPwVJgjp7bmPBupr9+N19vLwr00AiBEao7L9NMSyRD2+WVjI
         PQIQ==
X-Gm-Message-State: AOAM531tAQLzIWpY4qVDWghmmKOXKOcUb5bvsA3+RbuLw9F9HFmDt3jf
        8pfBS1vEwWfyyO2VomGDHCgWrQ==
X-Google-Smtp-Source: ABdhPJz4y06xkJGOJqeAXdWqbUCFk1aGCBSrYDYCHhZULINBiM2pNNpqBKKrRn6waq/R36zJvAqSmg==
X-Received: by 2002:a65:460c:: with SMTP id v12mr28021917pgq.58.1642624325264;
        Wed, 19 Jan 2022 12:32:05 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1f3a:47e5:8bff:a3f8:a494:acd0])
        by smtp.gmail.com with ESMTPSA id x13sm6807552pjq.43.2022.01.19.12.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:32:05 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 1/4] dt-bindings: qcom,pdc: Add compatible for SM8150
Date:   Thu, 20 Jan 2022 02:01:30 +0530
Message-Id: <20220119203133.467264-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220119203133.467264-1-bhupesh.sharma@linaro.org>
References: <20220119203133.467264-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible string for SM8150 SoC from Qualcomm.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.txt        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
index 98d89e53013d..bd3539644d3f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
@@ -21,6 +21,7 @@ Properties:
 		    - "qcom,sc7180-pdc": For SC7180
 		    - "qcom,sc7280-pdc": For SC7280
 		    - "qcom,sdm845-pdc": For SDM845
+		    - "qcom,sdm8150-pdc": For SM8150
 		    - "qcom,sdm8250-pdc": For SM8250
 		    - "qcom,sdm8350-pdc": For SM8350
 
-- 
2.33.1

