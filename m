Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F0A53C262
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbiFCBTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241071AbiFCBTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:19:37 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067473B019;
        Thu,  2 Jun 2022 18:19:36 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id m82so8645191oif.13;
        Thu, 02 Jun 2022 18:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=diS8PwoyWt/p5LP4hXPbJbNLO+pd+GJMAUbfZlaW88c=;
        b=kzo4mFJd1UBuo7qmhsz2XpO3doIBpDAgmx7jA4dlViN8Jhxp5Vy/030cQds7BXz3MV
         Cq7h2VGLiokJMqEnWGHl2JbNQb7pscknSDgWNYvv6TsuoZtAfTSoSrkgFbAh1JjmNotH
         qbHowtys5bVMqXeCkNbSnr+Vybt3ekdENvCNpIE652Exxzb/W15qigjjs9NAJK+juYM5
         9+ZYPcxfbeT+Plzs5iXubBGmPa4Zcdli2w3425XFJgGCMR2Cj/bv7R9pMPyftA7PDU7e
         qnJfKuxKzRiAjCepTE4NfEyZX34K42BpVkE7nVt2FS5H4kLy3TMaHjfCV8b3VLNL4qAH
         bKfA==
X-Gm-Message-State: AOAM530m7ramXgOXpoLnCa6tie6VYL4UfGKQMMgPTxL4M/4/tjKkFoNc
        ri62LPW2aPOi4coyiH86Xg==
X-Google-Smtp-Source: ABdhPJxZksYyr71+RUJRx/n5C4BbUG6LvJsTw2ySKaZVTe/zjTSrhUz2XGyR5Rqd5XPtYETsehyy9A==
X-Received: by 2002:a54:4006:0:b0:32c:ce5:5bc2 with SMTP id x6-20020a544006000000b0032c0ce55bc2mr4287750oie.279.1654219175138;
        Thu, 02 Jun 2022 18:19:35 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id na14-20020a0568706c0e00b000f5d8d031b6sm2679746oab.49.2022.06.02.18.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 18:19:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: arm: Rename Coresight filenames to match compatible
Date:   Thu,  2 Jun 2022 20:19:31 -0500
Message-Id: <20220603011933.3277315-2-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220603011933.3277315-1-robh@kernel.org>
References: <20220603011933.3277315-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the compatible strings for filenames as that is the preferred naming
convention for DT bindings.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../arm/{coresight-cti.yaml => arm,coresight-cti.yaml}      | 2 +-
 .../arm/{ete.yaml => arm,embedded-trace-extension.yaml}     | 2 +-
 .../arm/{trbe.yaml => arm,trace-buffer-extension.yaml}      | 2 +-
 MAINTAINERS                                                 | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename Documentation/devicetree/bindings/arm/{coresight-cti.yaml => arm,coresight-cti.yaml} (99%)
 rename Documentation/devicetree/bindings/arm/{ete.yaml => arm,embedded-trace-extension.yaml} (96%)
 rename Documentation/devicetree/bindings/arm/{trbe.yaml => arm,trace-buffer-extension.yaml} (94%)

diff --git a/Documentation/devicetree/bindings/arm/coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
similarity index 99%
rename from Documentation/devicetree/bindings/arm/coresight-cti.yaml
rename to Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
index 21e3515491f4..d32d214ed64e 100644
--- a/Documentation/devicetree/bindings/arm/coresight-cti.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
@@ -2,7 +2,7 @@
 # Copyright 2019 Linaro Ltd.
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/coresight-cti.yaml#
+$id: http://devicetree.org/schemas/arm/arm,coresight-cti.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: ARM Coresight Cross Trigger Interface (CTI) device.
diff --git a/Documentation/devicetree/bindings/arm/ete.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/arm/ete.yaml
rename to Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
index 7f9b2d1e1147..2415beeb12ea 100644
--- a/Documentation/devicetree/bindings/arm/ete.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
@@ -2,7 +2,7 @@
 # Copyright 2021, Arm Ltd
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/ete.yaml#"
+$id: "http://devicetree.org/schemas/arm/arm,embedded-trace-extension.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
 title: ARM Embedded Trace Extensions
diff --git a/Documentation/devicetree/bindings/arm/trbe.yaml b/Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
similarity index 94%
rename from Documentation/devicetree/bindings/arm/trbe.yaml
rename to Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
index 4402d7bfd1fc..b1322658063a 100644
--- a/Documentation/devicetree/bindings/arm/trbe.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
@@ -2,7 +2,7 @@
 # Copyright 2021, Arm Ltd
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/trbe.yaml#"
+$id: "http://devicetree.org/schemas/arm/arm,trace-buffer-extension.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
 title: ARM Trace Buffer Extensions
diff --git a/MAINTAINERS b/MAINTAINERS
index 7dff84d95e5f..abfdc62abf98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1972,10 +1972,10 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-*
 F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
-F:	Documentation/devicetree/bindings/arm/coresight-cti.yaml
+F:	Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
 F:	Documentation/devicetree/bindings/arm/coresight.txt
-F:	Documentation/devicetree/bindings/arm/ete.yaml
-F:	Documentation/devicetree/bindings/arm/trbe.yaml
+F:	Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
+F:	Documentation/devicetree/bindings/arm/arm,trace-buffer-extension.yaml
 F:	Documentation/trace/coresight/*
 F:	drivers/hwtracing/coresight/*
 F:	include/dt-bindings/arm/coresight-cti-dt.h
-- 
2.34.1

