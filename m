Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7736347E71D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhLWRdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhLWRdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:33:43 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C770C061401;
        Thu, 23 Dec 2021 09:33:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z29so24116209edl.7;
        Thu, 23 Dec 2021 09:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=E0/YQJ43ks9rfBu4JnnAsmKLJ07kJTfqV/arSmMfD9Q=;
        b=CfmnnQraty6UZHCrWwtMX/TFGU1UgDTVytCT9sKEY4sZgXNOv0JF6NEVb3IroMCwUP
         nNOLSiU36bIUDocXH3mkY21WQ/js0o+kPISJK+0yD4zqfUvYqz853pm9dsY+iPWfpefZ
         ZLaA/xJVISHgZJmN64GLASMchrK7qpBCdNF6vQEWZpFQ+vTYQ1WFvCaZ64QrEj5bd8TS
         A3ckS0tjuGiDorxN8btb7QhAlF2HvGhva5obFrBE5z/Lo+o5Fo2OXp0cBV3LjFd+uHLZ
         BtQNpwq1bOTYV8BOij3Na5iUptrURZbog73xEUSG8K+5kxGIqpL2OHt0QlxbwQqGTiE4
         UqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=E0/YQJ43ks9rfBu4JnnAsmKLJ07kJTfqV/arSmMfD9Q=;
        b=HZd5aJsRoEudzv8etkZ/Pj/mSEaPUUqCGm1lEI3HWJ1deWREtANBSg0YsZfKq0UnQG
         xhAhy+mVq9AGH+6iSpuvh4H8BHbuiloBu7di1GnE505+SZgMnKpGsYfbnUaOQmXGNMzi
         f6sX5MLFlzn9eknJpdVzkwPL/O4ulOpZ93ncR7imSlUYieiP1UBcYHq0cUb6od0TDeWS
         nZC8zv06R0p2aQtSaNUdrZnudbJITpRb2u8qZGsv5SuEVgwUfF5J74chJWEjLI5raxJs
         MByfWUN4/NeZ40+98B7tL8COufG/3iz/9VnZeMROtO3ZZUTt9iItfYt1i8y6wyAEPAjf
         vP3A==
X-Gm-Message-State: AOAM530LmooHBvqCwAyetlSPgKcSi9cmf7xJgcFo3HqV3bpXDWsIS7kE
        c+I4aCZsNIagaMIdhH/u8TU=
X-Google-Smtp-Source: ABdhPJz1wb9lZeAJjuhN0BSqjf+Y/9f1AfyNiqQT/ha2qp8Ia+obXP8Z6LU16my6WHEOEyT7BpN+xw==
X-Received: by 2002:a17:906:9413:: with SMTP id q19mr2756677ejx.296.1640280821676;
        Thu, 23 Dec 2021 09:33:41 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id m12sm967093edd.86.2021.12.23.09.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 09:33:41 -0800 (PST)
Date:   Thu, 23 Dec 2021 18:33:39 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "dt-bindings: arm: qcom: Document SDX65 platform and
 boards"
Message-ID: <20211223173339.GA3925@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3b338c9a6a2afd6db46d5d8e39ae4f5eef420bf8.

This was a duplicate of 61339f368d59d25e22401731f89de44e3215508b,
causing the sdx65 compatible and its board to be documented twice.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
Link: https://lore.kernel.org/all/20211223144407.GA6503@standask-GA-A55M-S2HP/
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 370aab274cd1..04ff0b55bb85 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -48,7 +48,6 @@ description: |
         sdx65
         sm7225
         sm8150
-        sdx65
         sm8250
         sm8350
         sm8450
@@ -228,11 +227,6 @@ properties:
               - qcom,sdx65-mtp
           - const: qcom,sdx65
 
-      - items:
-          - enum:
-              - qcom,sdx65-mtp
-          - const: qcom,sdx65
-
       - items:
           - enum:
               - qcom,ipq6018-cp01
-- 
2.25.1

