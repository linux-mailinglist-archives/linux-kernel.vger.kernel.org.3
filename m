Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3948D524D62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353947AbiELMtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiELMtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:49:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBEF1EA1AB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k27so6108075edk.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OkJdI54e0iw+j0SubUNETqHu76mK4u9Bb+TpmNhQfJk=;
        b=5AH6OdJ8/7PGETtqZMiwsMZWXZ7N4nlX8jouevOtzvsnUJjRKZDNJtLVY6HoIKVEkN
         DIS3klLgpeuPFnptRUwR3rEbg96G16KW2nPviZgQhm67LQo9crkOT+zA1KDtoTXXkh3I
         hjrxddMOPH3LniNH4vOiY6ijjojvoT2GaHpO2okq9+e9m+ivt+/QC8QW4tPtGO+Ah4MM
         lgK88So696bwTfaEyCciOolMh3PgdWNAKQ8DdH14Pk9LyAp8cL1ldXMOoRTeMS5DSK5j
         pIvbglftdK6/Fuw5oGXALYbzuPbZsq+q1fnapqZ+28EI4qy9rGQ7bA/YtRvgbRbMYODD
         T3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OkJdI54e0iw+j0SubUNETqHu76mK4u9Bb+TpmNhQfJk=;
        b=Em4BOz2k8rqTHgvXJrKYZZx7kaW8oAebWprV5CzMuIBJnKxVbEkeTXfBKBL/1sJWSI
         3ddCeb8sc6rwqk/6VRdXr8Hv4TTsPfCruJKoykpQLCr0HNhVFpmzwZrugr8+NQ+vRLB/
         Qz5GZD730Zfyzg4TVlBU8SvWa4sxlo8dqBy1hRFdcHRARJ14zlEC1kekvd1a05H+SCQn
         fHyXhCKjdd7sQVhHCbbQR4df3uCcEefz28/C0Za6cKv2kWuiCxf8d6wSkePxvJmVBYNn
         CTzxx694Yiwd78QMxANzgzpY22KJSKBbLruX3ouQuLeiAPWYJuL5lTu3IO4KzSZadtCV
         KNcw==
X-Gm-Message-State: AOAM530WseevSF19Vo0nHR7rChPkRNQbDXTrxkYRIna5VPL5dvUGr+od
        4j3k2ictz+Kg6D0lBOVBsQkLVg==
X-Google-Smtp-Source: ABdhPJzxVrYLYC3lVbzm9aZhSephxmDvcoy6S1KPUezJTndXZMpKg7QfDSPH1WKpMombddvHHiRZmw==
X-Received: by 2002:a05:6402:294e:b0:425:f016:24e7 with SMTP id ed14-20020a056402294e00b00425f01624e7mr34667684edb.111.1652359751807;
        Thu, 12 May 2022 05:49:11 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-58.xnet.hr. [88.207.98.58])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170906828300b006f3ef214dc2sm2109475ejx.40.2022.05.12.05.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:49:11 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 01/11] dt-bindings: vendor-prefixes: add Methode Electronics
Date:   Thu, 12 May 2022 14:48:55 +0200
Message-Id: <20220512124905.49979-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Methode Electronics, Inc. (https://www.methode.com)

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..e5ec476f54cd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -764,6 +764,8 @@ patternProperties:
     description: Cisco Meraki, LLC
   "^merrii,.*":
     description: Merrii Technology Co., Ltd.
+  "^methode,.*":
+    description: Methode Electronics, Inc.
   "^micrel,.*":
     description: Micrel Inc.
   "^microchip,.*":
-- 
2.36.1

