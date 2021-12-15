Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0371D475D90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244923AbhLOQeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244890AbhLOQeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:34:07 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C8EC061747
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:34:06 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id jo22so20737033qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GgGIgMajEhcXcb+pSiiU8hULLmnW3Ix8+OrCDOiX3Lw=;
        b=tvxDsHukx98Bl1dr8J4BCivPCewSe+XXEALjhJFUjvhImq9MArSB0jWh/L+CH9L57Z
         Jg5Rhcyd0FN1spcGFuPAyw8b8BiYIqeVdYRUIUyEqv7+9ua1ek1TQ3A+8kysdEk7pnl9
         gZvr+lDkr5AVF+9NEgDx5MkV9CF69D/NsJA4fGXekSE4ubXzbFaVwvcFitlIEfdz1nxa
         VpwJJ9sPGpddnWvasyqQSNXYvbmkW1rWIZdHNai7xrICgirKZ1R23+wub+wkjnSu060L
         w0a2rMmn2VbKcA22omKAUbxV2SB/9/MNycDATt1GnwR6zhSwqrXp4s/MPU/lADZg0IKF
         QjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GgGIgMajEhcXcb+pSiiU8hULLmnW3Ix8+OrCDOiX3Lw=;
        b=A+Khb05GY2Y6MpYf8Q5/X6JoAKSroWe3+Mhdq5l7fZJjl6UFooNVHqKtjYEf02tuRh
         PlehQBL8SceGcv+17jvGTaU91CmKcnzEnLXL+pgRjbAxNVrJlPK+2WGmRg9/L0xCWrRE
         jqkjy7YqztteZDDo2jteU5OPWyCC1n1dpQLmzU7OJ3rt8gOGNlmO4d64Miu7/Y5ecZiI
         Xu+0OFfGG9PEojJlmrXqMMrWC+H5ccEYznQptvgZMZO7or6mhtnS5e8PwtoYb8rzkMLp
         rEYfpofwtVoptP6R137QYSGfnGCGKWAPY8Kzo1hvoEeSYUtCnWX6PNnq3t+PMCESmZkh
         O1Qw==
X-Gm-Message-State: AOAM533+XXRxVd/m8KusOEsbt9s4rvhy8+fwf+0qBLwwZ6rgLhpqFY7M
        QAhOIIaAcrL5+6yMRqCKVUzGaQ==
X-Google-Smtp-Source: ABdhPJwhXqy8GxjvDlO1udF6JRXEeZtq/mjtgfQ89irHU6rbPueO1Ii1sLU2RrONdSXciSrUhx140A==
X-Received: by 2002:a05:6214:cc7:: with SMTP id 7mr11525178qvx.55.1639586045725;
        Wed, 15 Dec 2021 08:34:05 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id w10sm1824832qtj.37.2021.12.15.08.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:34:05 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v2 3/3] dt-bindings: thermal: Add sm8150 compatible string for LMh
Date:   Wed, 15 Dec 2021 11:34:00 -0500
Message-Id: <20211215163400.33349-4-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215163400.33349-1-thara.gopinath@linaro.org>
References: <20211215163400.33349-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the LMh dt binding document to include compatible string
supporting sm8150 SoC.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index 289e9a845600..a9b7388ca9ac 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - qcom,sdm845-lmh
+      - qcom,sm8150-lmh
 
   reg:
     items:
-- 
2.25.1

