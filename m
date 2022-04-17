Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05E8504985
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiDQVHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiDQVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:07:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11BF1CD;
        Sun, 17 Apr 2022 14:04:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b7so1288740plh.2;
        Sun, 17 Apr 2022 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mF7shcJLRLDmKDOAwfAC9+BvBlyRxOzL6W5YQmW9cgI=;
        b=S91yHj3wQzzNwI5tqLikNLSQlEuMNCRcChdZrDi4OsJ8dBUmu5wE4ljoNdOkXQIZqs
         jCbTRNnKnxhjdL44eFYsKKQDrpI5RkMCMDvDOXJSS/o8KujVcwyBULs7VoIEOF+rhI7g
         UWl0SfjOAp4DN0KWrCFQ6JE/U2gpVY9SowezdfWe8FYgFb+63T+SzSlmDK57bnPMGfqU
         byarHIKgcUTfrTl3F0OU/2E2VtLU8Fbbh9TbvwVS7zzA9QBbzrAokIYYtLpX73l62OMv
         jOgUOtxecwDKs1QeAQcOf1GG0S+8l1QFyXyR3Axe0XLaaYTkw6EtzJ26BM4Of2P8Uckc
         e4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mF7shcJLRLDmKDOAwfAC9+BvBlyRxOzL6W5YQmW9cgI=;
        b=1PDDIQQSVA1Jk2SQlljY7R5nZuNZysLe9WeuIDY5E6VjjhRWnc0xvPl0RmVrr+KwXE
         8mcXUoZ6J2+SsfspuJ/sx1n58jVXKT4NBPnAtbUd3IVAd5XWy0zxD7XfeGpDwt4Xbjey
         gxZpzg8zMtTAvHFN/Aa3a0dz8FjFU99udpfU8FdEQAe+ITba1EajduOBSaOIvPKzGuax
         L98yYXoAtq4ir7R6t4hTR3fI1i86YoWZY1LzsjFwE22ivh9v/iKxH+pvQCdPmbUiH9ad
         Lf2IKhoLbA+JJRhbPsBdZhTjVQOGHUYL+CAa1HykMBAg+jhEkVbCPUWFzg1NLDHcxYmK
         olnw==
X-Gm-Message-State: AOAM532UjKQH7g+nXdIyo/LUeSKoTScW/OF5PPYKwI8bKEVbDpkjJ3dX
        9s/lwgYjjLcxH1gMtXAgQnLTXEO51Y0=
X-Google-Smtp-Source: ABdhPJzIjoyInkb9cthGdiIpkfLnD9NJYC0XwgibHzKMOSfsVTZMzJqpS7Gl4jumwLgBAfFdfmZhTg==
X-Received: by 2002:a17:90b:1e0e:b0:1d2:8906:cffe with SMTP id pg14-20020a17090b1e0e00b001d28906cffemr3529116pjb.220.1650229481462;
        Sun, 17 Apr 2022 14:04:41 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id 137-20020a63078f000000b0039d9c13cd39sm10547711pgh.67.2022.04.17.14.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 14:04:41 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/6] Convert Qcom BAM dma binding to json format
Date:   Mon, 18 Apr 2022 02:34:30 +0530
Message-Id: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1,2,3,4,5 require generic node name for dma and 6/6 is actual
conversion change.

Looking forward towards review comments. Thanks!

---
v3:
- Add Krzysztof's R-b tags for dts changes
- Add qcom,ee as required property(Krzysztof)
- Use type as boolean
- Add min/max to qcom,ee
- Clocks are required ones, skip them as it's users are not fixed.
---
v2:
- Add more variants of ip4019-ap/dk-{01/04/07} for dma node rename
- Add #dma-cells in binding file
- use additionalproperties as false
---

Kuldeep Singh (6):
  ARM: dts: qcom: apq8064: User generic node name for DMA
  ARM: dts: qcom: mdm9615: User generic node name for DMA
  arm64: dts: qcom: msm8996: User generic node name for DMA
  ARM: dts: qcom: ipq4019: User generic node name for DMA
  ARM: dts: qcom: ipq8064: User generic node name for DMA
  dt-bindings: dma: Convert Qualcomm BAM DMA binding to json format

 .../devicetree/bindings/dma/qcom,bam-dma.yaml | 97 +++++++++++++++++++
 .../devicetree/bindings/dma/qcom_bam_dma.txt  | 52 ----------
 arch/arm/boot/dts/qcom-apq8064.dtsi           |  6 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi |  4 +-
 .../boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts    |  2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi |  2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi |  4 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |  6 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi           |  4 +-
 arch/arm/boot/dts/qcom-mdm9615.dtsi           |  4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  2 +-
 11 files changed, 114 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt

-- 
2.25.1

