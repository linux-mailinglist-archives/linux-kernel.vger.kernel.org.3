Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4835148D5CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiAMKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiAMKbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:31:13 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63385C06173F;
        Thu, 13 Jan 2022 02:31:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a18so21324856edj.7;
        Thu, 13 Jan 2022 02:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=FRgtdY54ky7tlq4RR5YyMTcefNy3Rd5B5NuglelQbfY=;
        b=XRhWyOYnQtolT7HHIhIsBXQLhNmePTOVZhZNuUfRCZNksXsvF6BwuwF4bn+54p/m09
         DhNIvs2OuJ9g/9zcvs51v3xyLXQsSRAiMvq2N1LvomeHnbrr6quYHfQGhRystWi3OAYC
         XJyVy9rGe2n1oOwl/ZmzBoTSt95Ajvftjows9v3DcdDHbxIfRVcOywVwLx0gPWI+Dtx5
         xi73tDmR3F5CSbOkxsI8Pval0NHtI3bLLSK4ViAJ8imDh+sAqx+qNuFOKHwRJHLx8IeF
         0OrYtZ2eTeZLKAZ84ltUJV6DgH4Egi+eDHrx4owXXkwt5qIDQsdKEqB4ZiWgN3W67qN4
         BlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FRgtdY54ky7tlq4RR5YyMTcefNy3Rd5B5NuglelQbfY=;
        b=q33OGunxXnw3ErBy4ASjpR3XAuW5U7j+TZWmGGmm1NUKdhilQ0LKPWCaGFoUcgNNiE
         oSbup3+wEX2cT25YgDoETHJYlhA2giJofABHpc/jGGu258GUZcOS0HVp94h8iOpVQxcX
         3vaJQkTOXdyCfhQLDINi4NfUdfFcp8UzPr+UliAOW8M5HTBYSJNV9ae2ztWmgQYh5Xiw
         X3F6IH0PqIprBX6yUjkdcPEPo6ijZPJpg/qoK6dTUZzGcSG5NxKtWqUxZ5eNPCwIJO7I
         2xu35H4vlwX0WBV6x8EcQiXUKyUCWYWTNS7umoFph95HLKGHCPl5QSRn+9VBL6JLxjiP
         PCkQ==
X-Gm-Message-State: AOAM531HotKOZTfypUvgDIyLE6C+2nEwwY99wMYtPv8k+mYNAG2VMWaX
        4VntIVFlANapmGc1Ds2AVe8=
X-Google-Smtp-Source: ABdhPJxvf5Q/FHfJRtOY+93WrFf4USegInKpk2/TMhXd/U1ta9Pt9BhQfsZycXC/QzAWu57PqG+bSg==
X-Received: by 2002:a17:906:456:: with SMTP id e22mr3097659eja.203.1642069872005;
        Thu, 13 Jan 2022 02:31:12 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id g3sm731386ejo.147.2022.01.13.02.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 02:31:11 -0800 (PST)
Date:   Thu, 13 Jan 2022 11:31:10 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: vendor-prefixes: add Wingtech
Message-ID: <20220113103110.GA4488@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor prefix for Wingtech [1] is used in device tree [2], but was
not documented so far. Add it to the schema to document it.

[1] http://www.wingtech.com/en
[2] arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in v2:
  - Reworked patch description
  - Rebase on next-20220113

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b3de81e8290f..eaf7f4940978 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1338,6 +1338,8 @@ patternProperties:
     description: Wiligear, Ltd.
   "^winbond,.*":
     description: Winbond Electronics corp.
+  "^wingtech,.*":
+    description: Wingtech Technology Co., Ltd.
   "^winlink,.*":
     description: WinLink Co., Ltd
   "^winstar,.*":
-- 
2.25.1

