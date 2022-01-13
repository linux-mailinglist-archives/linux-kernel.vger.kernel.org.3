Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58B48D5BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiAMKaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiAMKaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:30:09 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D54C06173F;
        Thu, 13 Jan 2022 02:30:09 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u25so21366487edf.1;
        Thu, 13 Jan 2022 02:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=n9Q4JuWIPg3MOiLez+9oLLllF2Gtxdpf/wkTX1+nJ2U=;
        b=jWTfFwqao0lfZMvAXf+762PjpfMsR1z9Z1RirsLYBCyQHntG5yixKZfcW7ypDqihL1
         EScoMjo6bII9saxj6Oy8o7Vj+W6KIXws9gHwJA8mudvonzA19+vMCP8ipcXNx9m8IrX6
         Y3AjOq9uJ7T+Ln/TQnlqUorSLm2e6kJ1G7u4HH30nTvY8qOj61lzdOZoSmgPFpHid8B1
         ZqhVD5G2c21rHw0r899XwjFNxNy16Ojry9C1kHrBpRF0bnPKuc+HhJNDhuJRgWh+9X3q
         peJmjctFiosOSEAhLNg4URKt86XYsqBGExxRcNyMnaJ71R7cdfNHM8yBezf35xhC4/cY
         eQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=n9Q4JuWIPg3MOiLez+9oLLllF2Gtxdpf/wkTX1+nJ2U=;
        b=nYW7R7KZGZTe+2vMxJ3DOD7xVTc9kCrEJ130sRVlivqNtZRIqQUPJuUxCwAEa1Qpux
         Z0JGjeWic4vp67GlxL9p0QmkSblDpqkFXfGPxMw5JxgudZ1YV+zXzDILBBwr/mek3MGX
         m++B0sBSJoQJ9fjpr2dm31B6LXL8s284wkm2G9pcFt3dN5MUhYLfQpZStPgGpLi8WqhO
         f5Abqbn2+ghPeQmyTRffHxfESRAhSqou/oQWmXCo/Lwu1wVSAfsRqxxNDxXv1LWtgxlp
         jXLP1ceDMH+5JY4nSEOS8jQ3766a2AqmzHh7wyedh6WT8NEvBw2CHjXpsG/GPuCJ4FFF
         vvBg==
X-Gm-Message-State: AOAM531nrRrTAh5PAmVgJyVPG23pidHKKnGmeTyTNjRGg60weXuFktMs
        FwRBtA2t9F1jzcud77WcjobE3J7rK4w=
X-Google-Smtp-Source: ABdhPJxKMlMTUFblkpGesWPSu5KtgnGWB6So1VC8IUMWno37RwaaYSnaF2+B8/penFsdGnotdPK1Eg==
X-Received: by 2002:a05:6402:2804:: with SMTP id h4mr3452656ede.193.1642069807720;
        Thu, 13 Jan 2022 02:30:07 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id gn39sm728700ejc.184.2022.01.13.02.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 02:30:07 -0800 (PST)
Date:   Thu, 13 Jan 2022 11:30:05 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] dt-bindings: vendor-prefixes: add Huawei
Message-ID: <20220113103005.GA4421@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor prefix for Huawei [1] is used in device trees [2][3], but was
not documented so far. Add it to the schema to document it.

[1] https://www.huawei.com/en/
[2] arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
[3] arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in v2:
  - Reworked patch description
  - Rebase on next-20220113

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b3de81e8290f..76e89f26820d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -519,6 +519,8 @@ patternProperties:
     description: HannStar Display Co.
   "^holtek,.*":
     description: Holtek Semiconductor, Inc.
+  "^huawei,.*":
+    description: Huawei Technologies Co., Ltd.
   "^hugsun,.*":
     description: Shenzhen Hugsun Technology Co. Ltd.
   "^hwacom,.*":
-- 
2.25.1

