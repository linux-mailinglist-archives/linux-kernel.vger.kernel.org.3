Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE750E6A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243768AbiDYRQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243750AbiDYRQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:16:56 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543ED17E3F;
        Mon, 25 Apr 2022 10:13:49 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id v2so4103697qto.6;
        Mon, 25 Apr 2022 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SzhN/kJ1Ng8zCdutOc3nctS/QZK6IJDtlvfBQWvSTto=;
        b=DpQq/Hsa5QR5ZA9qodYr092BiMhLcpbjYU+g9TwkZDltW4qBD8QreTp9GqVRRJadN9
         VseBb3c5pgroMUvVAPftP2PAVwT4V7Ehtwi8zHTUnPxfpco+kzWUYig1m/ybLqrFEbvt
         k9Jx0ptBxg4uHyHNdipsJCujEYPsUd6wtP9RsZRwLNtgrCjgCohFrM+eRtYgxLkR6Ezn
         DLgSfheTbpKKKpLDePSoWTqTnXDckZ5q9c8v+Pl8sjPin4fr9oxrUBLXYeYFkOulqYiA
         V1VXo5IHGwaOCIZE0Ax79dylvfz+qQ4Q2bz3D8Vv8rvuGAX3EctCDRMN5MBclxz3KWAm
         FKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SzhN/kJ1Ng8zCdutOc3nctS/QZK6IJDtlvfBQWvSTto=;
        b=pyvu52V25ANkiJl8T0AXkxI2NkqQsaNbW4zmUGncxPHC9bhrPqNW02Mo7k79UHbKZ3
         J+WyRM/K92EHpfpWcC0TqPXx9vxQEA2VKzng7ZVUzXQxBO/9k3HV6ZxudR4byLdE0EZK
         h8plmDmL1eJjfgrCrj1fYyBOVydCeOWP6mQ+k7Dsdv8lLBAj8c6y73cRL4r+Kuc3a6lH
         AU3ylFLZLbZ7jiekWLHXenR6QlJO/P7njkvYxQtJBldMjZMfcsinEgDmcw35RpHdJQ3p
         j7VFx7RDJz8DWEfKAE4T1KSfDbZR6Mju75PvIiSX4D4UMAWJhvM+IOr+6UUJJULq0U4X
         tPOA==
X-Gm-Message-State: AOAM530URPaL43S4mOym+lLZJ9UN9V6lgn9f6D0G2ofIL7CQmXyO7r73
        D6u+tX8UIR7+QH5+DzVl82c=
X-Google-Smtp-Source: ABdhPJxgdYaaCfLD97p67JumbC8icR3zvjp2z5x1tM5o4WTDF047qyxbG6wGzR56X86sQJRyLWUQYA==
X-Received: by 2002:a05:622a:507:b0:2f3:57bd:1241 with SMTP id l7-20020a05622a050700b002f357bd1241mr11808542qtx.199.1650906828430;
        Mon, 25 Apr 2022 10:13:48 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm7154928qtw.64.2022.04.25.10.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:13:48 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/7] dt-bindings: arm: rockchip: Add Pine64 SoQuartz SoM
Date:   Mon, 25 Apr 2022 13:13:39 -0400
Message-Id: <20220425171344.1924057-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425171344.1924057-1-pgwipeout@gmail.com>
References: <20220425171344.1924057-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoQuartz system on module is designed to be pin compatible with the
RPi CM4 SoM. It is based on the rk3566 SoC and outputs on uart2 for
debug and console. The first carrier board supported is the CM4IO board
from RPi.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index d6650a366753..ad940e4127d9 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -512,6 +512,13 @@ properties:
           - const: pine64,quartz64-b
           - const: rockchip,rk3566
 
+      - description: Pine64 SoQuartz SoM
+        items:
+          - enum:
+              - pine64,soquartz-cm4io
+          - const: pine64,soquartz
+          - const: rockchip,rk3566
+
       - description: Radxa Rock
         items:
           - const: radxa,rock
-- 
2.25.1

