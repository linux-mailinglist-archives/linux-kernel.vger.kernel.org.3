Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F6488996
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 14:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiAINXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 08:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiAINXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:23:15 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C1C06173F;
        Sun,  9 Jan 2022 05:23:14 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v6so21520769wra.8;
        Sun, 09 Jan 2022 05:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6ljeOmhov6fyIoNsyShW3VfnQI2oFJYGrB2spzMT8Oc=;
        b=RkcOAtrIs6HSlRVfVaNth/yJUyiK18SD7882DUMIxGXzU2ntnsO8SFupV6/4n0jiw8
         ry6ywxnN1qjR5S7jHwgx4ztWAA7yJZt776/4TBiC7S6wDyGlnaiYh4e4+G8qlqrSaHoy
         ZH9KOW/j6/MTlDAEWboQj2GPHJGCoVvFIUlfib0C3fuZAsneRIs5vew6IWx/Dv/v/nqR
         XAcmKVCOpil5776o+fVGA6f8dI7dbbUxw1WbBNUnHuqLX7jG6+Sl7iMYN3X85KOmJTWb
         uPN4hDa10YyQTfVRffDJwxsxY8vg27T9zzyeyd1mPvkffjWyghWbvj3/mlv7lx2x+hil
         qYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6ljeOmhov6fyIoNsyShW3VfnQI2oFJYGrB2spzMT8Oc=;
        b=Yw1FdZQTYzw9vdvO+k9MQo0YErkgevhvrQw3ndhDA88hh+Nr0GIjVLgiJB9aM3Hb4z
         rlu7DIglk3uBtqZyrWneE9kL+hQXrjadVv31vK4NPiQdud8UvnIRqJ18+R6h6AyQARuy
         gML2iOSIN4cXBWgzM85PsN24YOUObxUluTBnXUnKYyH0D7wzggIbfMlFBsg+yOP+G0fU
         VeBPlujPHpULUtRzQazA6pBYiXIId//yGOLAluoNtUsoLaJch61wpDf0mtKFKTHQS/Pl
         NhYfxdk4XmHI448R7UCs6AMY6D502iCcA8WSUaGHHJhuaO6vUEIPqz0Onr6FliBbGz8k
         wxeg==
X-Gm-Message-State: AOAM531i4hXvl8/0OUCvSbDIkoqagYOHCFEgfOZ4ZN14Vl9ywA+UMcaH
        pO5aWff2qZiYQ81HoHzCPms=
X-Google-Smtp-Source: ABdhPJxw2SpSJdkkGZHPKbsnufPvft993fpdxhw0siLc8X7F7xDCG7G6qDbzO4sDEp9XqkJ0EFZ3wA==
X-Received: by 2002:a05:6000:1869:: with SMTP id d9mr60153368wri.231.1641734593057;
        Sun, 09 Jan 2022 05:23:13 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id h204sm3957158wmh.33.2022.01.09.05.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 05:23:12 -0800 (PST)
Date:   Sun, 9 Jan 2022 14:23:11 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: vendor-prefixes: add Huawei
Message-ID: <20220109132311.GA2827@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Huawei (https://www.huawei.com/en/)

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a13d6a19c2b4..18ffa2d7379f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -515,6 +515,8 @@ patternProperties:
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

