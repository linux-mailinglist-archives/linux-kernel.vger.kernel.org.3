Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364AC4EAFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbiC2PJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiC2PJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:09:35 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA2F1E7A7C;
        Tue, 29 Mar 2022 08:07:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u26so21034291eda.12;
        Tue, 29 Mar 2022 08:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9v27V0/JfuIbfFojrBajwITmYHf2b8Rf6L3R9h8DQQ=;
        b=fGHjBdelOVCq0/HLdLy1UetI3cugft3sVAH5OtbM5CkxW6DAVq34oE5s3Zze28+2a8
         U8QSzvPv0ufc5bZFWAdBpn6ZsuGhpWCJ98RxiwbEJK9luYn7m5qL/TwdXmNQfb3i1fbZ
         yxVwcjDNcdoEXTVoRTHjU9CIfFTQze2w3UzVANnDwDZ7i1mcyBPW6OBQn0yAglHNdrPf
         spLmwoo0vmcrRFEif1xOHSQmvd5vzS2jcEyRbaiQyFp3ixIJqTM4P1sr73pd9xSSlGi/
         hcfMf/ZU5jLx6pUNmiAmEsUV0xbzpaK8oa4mEKdcLLJtlYy8xoB3VRZkUWscWMJxC8nZ
         unPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9v27V0/JfuIbfFojrBajwITmYHf2b8Rf6L3R9h8DQQ=;
        b=z17u1jOchJ3Bc9fFS9VJKEOSkuXjtoIm5xEjbZJSwTbJzoy9J6PNmIgTP+X3Q2dCHc
         eSolcT1PrPuZg7GQ9PMDUleOOpWLUC9cxdm6foedENhjFmcj4jYmm1ZYmRB3p8iLrl95
         JxFhA8XFVZkz0SMjeb84UsDfNZ+uRfSPxrKFeBxCp/rtJpMFJX19/uy1rqYoRHrC4w84
         HPROIqa38AT7Cj04cLZ5kuItQ086eZIPcz+iDgOlNj11yAjZhowOlV//sUmlf3ZGYkvc
         FiUT/0yiab2/AnhoxdHDSMCYx50Aj/cXyGjUW1BQreP2sOWg/EzhhsHRWUlIlSa+L8Wv
         1uXw==
X-Gm-Message-State: AOAM532k027XevPF8bfdOvWbYxW5x1Cmb7Wf8Q5hqhQV6VYFBjn5yCap
        P9WjyZDO0n2M8h5iB0jQvjs=
X-Google-Smtp-Source: ABdhPJxso/UMv+vRLnya+BieCPXHQXWBIEBC2uFnNZ672GwfuzASripXLXTFP7UXiqKuRr4+8CDwLg==
X-Received: by 2002:aa7:d58e:0:b0:419:c121:ea33 with SMTP id r14-20020aa7d58e000000b00419c121ea33mr5012304edq.256.1648566470557;
        Tue, 29 Mar 2022 08:07:50 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm3261643edb.39.2022.03.29.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:07:49 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: clock: fix some conversion style issues for rockchip,rk3399-cru.yaml
Date:   Tue, 29 Mar 2022 17:07:37 +0200
Message-Id: <20220329150742.22093-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of rockchip,rk3399-cru.txt a table with external clocks
was copied. Make it a bit cleaner by aligning the columns. Also fix
a description. Phrases start with a capital.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/clock/rockchip,rk3399-cru.yaml        | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
index 72b286a1b..76dd24d49 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
@@ -22,11 +22,11 @@ description: |
   There are several clocks that are generated outside the SoC. It is expected
   that they are defined using standard clock bindings with following
   clock-output-names:
-    - "xin24m" - crystal input - required,
-    - "xin32k" - rtc clock - optional,
-    - "clkin_gmac" - external GMAC clock - optional,
-    - "clkin_i2s" - external I2S clock - optional,
-    - "pclkin_cif" - external ISP clock - optional,
+    - "xin24m"           - crystal input                          - required,
+    - "xin32k"           - rtc clock                              - optional,
+    - "clkin_gmac"       - external GMAC clock                    - optional,
+    - "clkin_i2s"        - external I2S clock                     - optional,
+    - "pclkin_cif"       - external ISP clock                     - optional,
     - "clk_usbphy0_480m" - output clock of the pll in the usbphy0
     - "clk_usbphy1_480m" - output clock of the pll in the usbphy1
 
@@ -62,8 +62,8 @@ properties:
 
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
-    description: >
-      phandle to the syscon managing the "general register files". It is used
+    description:
+      Phandle to the syscon managing the "general register files". It is used
       for GRF muxes, if missing any muxes present in the GRF will not be
       available.
 
-- 
2.20.1

