Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4F259CBDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiHVXDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiHVXDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:03:11 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5574F64B;
        Mon, 22 Aug 2022 16:03:11 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id q16so6537415ile.1;
        Mon, 22 Aug 2022 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=VlbNwukBUIpEPmPt9v+G7N0f5B1QXw5dPmpD9c3YmBM=;
        b=D2M288oKVQ1NZeC0p+D2eKZTveU75MQ5Bo13o94hLarlQzbhFpm1qBNE1DY8il14kH
         OfXKN50oQ4sf2BpxnErkCexmaOVTg0ssUPXj6WX7xSP89c3LcYMyJBK4H8iCm3RL7p+k
         iuAkORBSTHoMv3u5j4/Tw2SCjeU0wT4IBm/B/GpY+Uf0Zjqd6+s6pYK33eVa8GguxKAu
         6NjSpq0DSiyn8aDuvchZNUHYdtkh6WM+W12LbQxirNSGVDh/JwH8pup8Cl3U/9rvVY20
         Ho1HYRibRxTjWEA6exzlRJb5XrPxW/RrmYkAXgw10UTJCCEbcwBfiwz6C+X9bZXIk974
         HoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=VlbNwukBUIpEPmPt9v+G7N0f5B1QXw5dPmpD9c3YmBM=;
        b=EHyR8YV2gTg32z3ffeepQLr2l1sNOh/Sc/2wuE2qiuDenfcuQg7JdS4os4YllgNPvL
         sPIUwghO45fN20fQYY4TiiLrHzv5p2pYWrraf6hpZ0ezxEcoIrfDWwNdUyZH1Qu8ioOC
         FMUyrnK42Qvg59Bnzt6OBYdYHlUlKd7lxnJn2cgk0DgBhj+ib/CRDaDsk743PtsOUcpS
         NtNfUJSe4wns63r3zCW2tOlfMHOb0n6nww2LOm3n4vdCkOri6Qt9iLvc3qaBtWfu4RuU
         5ulppfH14fJhDSsE29VWByJ0QY7mj+B7Dcse/W4y2aXngwMOEVk1ljmM15ZustK15MG5
         nHEg==
X-Gm-Message-State: ACgBeo2cTEdaxYnR/AKDXtn8UGbsqF0Jw5OPlZQ4urWeKmHU3rbldp6C
        8Hcewe9+YKQPz3m2NTYbh6I=
X-Google-Smtp-Source: AA6agR41PXs5JDyrmEDwM1pxT209xB+GjpwRj+UXccQwgQbTdudDVkNfL3J+IBH4kqlOw+QzKQviCA==
X-Received: by 2002:a92:130f:0:b0:2e4:22c9:7721 with SMTP id 15-20020a92130f000000b002e422c97721mr11522530ilt.34.1661209390685;
        Mon, 22 Aug 2022 16:03:10 -0700 (PDT)
Received: from hestia.gfnd.rcn-ee.org (208-107-176-7-dynamic.midco.net. [208.107.176.7])
        by smtp.gmail.com with ESMTPSA id o16-20020a02b810000000b0033f043929fbsm5609396jam.107.2022.08.22.16.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 16:03:10 -0700 (PDT)
From:   Robert Nelson <robertcnelson@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: ti: Add bindings for BeagleBone AI-64
Date:   Mon, 22 Aug 2022 18:03:03 -0500
Message-Id: <20220822230304.2284952-1-robertcnelson@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This board is based on the ti,j721e

https://beagleboard.org/ai-64
https://git.beagleboard.org/beagleboard/beaglebone-ai-64

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
CC: Rob Herring <robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>
CC: Jason Kridner <jkridner@beagleboard.org>
CC: Drew Fustini <drew@beagleboard.org>
---
Changes since v1:
 - added documenation links
 - add board in alphabetical order
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 61c6ab4f52e2..ff3af46d1dc8 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -34,6 +34,7 @@ properties:
           - const: ti,j721e
           - items:
               - enum:
+                  - beagle,j721e-beagleboneai64
                   - ti,j721e-evm
                   - ti,j721e-sk
               - const: ti,j721e
-- 
2.30.2

