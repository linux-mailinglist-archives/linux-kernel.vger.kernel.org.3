Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5264B9FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbiBQMJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:09:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbiBQMJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:09:19 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99976378;
        Thu, 17 Feb 2022 04:09:04 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id d23so9485474lfv.13;
        Thu, 17 Feb 2022 04:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o61zkZsaE0vJ73sO4uibEGQryzO/LSOJ+6q66VT7/0s=;
        b=U+ehdluwKGz6WTZzeethEyl9CiEaqVsJUllKJVE7EakT4m/rsuE6oVApqbWAINtIMd
         f/A1S//YnRgPtDFTEsEPl2hAzuwYq8/vhpzf3MCq9Bnl8arbv5etqZKKeHLfM0b8AIhP
         qD7SotQBhlY0uVPf3WW+gJGmOK4kI614sLxbe9VnZ0MpjzrPZcs3OQ0M73+t3KmGhTXG
         JItv68B1Ap2AyASWGXkdLpf/ptd9myAsXCM1UC+mQ5P0yAk2Sobpg0sBY3KCdS19+Bud
         6o+PNUC9iaWxRU+a1jMj3vX5lAHHMShbdSovnoSa9cwveWhHw4Ow3O2UTYBgOAWrQmr9
         20KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o61zkZsaE0vJ73sO4uibEGQryzO/LSOJ+6q66VT7/0s=;
        b=q6JkT4LJbhDAnWDCWFHMJsg3UQCvxWDORIS2v8hJp7qUjro6SKUAICYWmiUJC6fD97
         XXp1+qdh/BQbajIkLO0qYm68akElZEVYnPOTYsuXiXPuhJbcXU/av2OlCF4fJLBwMomD
         dQvM15lAVSe7m8HgO45BYo89EdXrEccZsHPolyFviaiBg89RBixjgFPpOFH/SlYqH6sk
         5EygWSwQopbe6Q8tyHrtYShaPvJJ9cZNoP01N7ay86o98PggX/cMoT+innjAHjBWEzp3
         CvSY6bAP+PVJKUfdzz88UX5donqeUG4iTDld3/ijdTMq7A9vOssz3jy1bNm/9ZAol9UN
         zaIQ==
X-Gm-Message-State: AOAM531An8pf6PyhQA6dO1zIuSmH8kqecKi6FswV2J7TChGoaXHSScjv
        WzzcYUf1Ie/alDsFyuOalJY=
X-Google-Smtp-Source: ABdhPJxSdQt17vUP+C9eEr/kMKsTaGB2mrogkx4RsuJLkwn5hr9mf8Cb16I1wO92LK9/rkn0r+BKaw==
X-Received: by 2002:ac2:5fb2:0:b0:443:14a8:d89b with SMTP id s18-20020ac25fb2000000b0044314a8d89bmr1868860lfe.6.1645099742985;
        Thu, 17 Feb 2022 04:09:02 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t4sm1106625ljh.67.2022.02.17.04.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 04:09:02 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>,
        Ricardo Salveti <ricardo@foundries.io>,
        Michal Simek <michal.simek@xilinx.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>, u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH RFC *RFC*] dt-bindings: add U-Boot chosen for environment data phandle
Date:   Thu, 17 Feb 2022 13:08:56 +0100
Message-Id: <20220217120856.2910-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

This is RFC and request for a help & discussion.

While reviewing patch for U-Boot env binding it has been mentioned that:

1. /Processing/ whole DT in U-Boot may be too much work
   Handling flash devices, partitions, their formats & NVMEM may require
   too many U-Boot drivers involved.

2. It'd be nice to have env data storage devices pointed in chosen

I wrote this hacky PATCH to give a rough idea how it could look like.

Please review this and let me know:
1. If solution with chosen + phandles is acceptable
2. How to properly name .yaml file
3. Where it put it

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../devicetree/bindings/u-boot,chosen.yaml    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/u-boot,chosen.yaml

diff --git a/Documentation/devicetree/bindings/u-boot,chosen.yaml b/Documentation/devicetree/bindings/u-boot,chosen.yaml
new file mode 100644
index 000000000000..8369da91193d
--- /dev/null
+++ b/Documentation/devicetree/bindings/u-boot,chosen.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/u-boot,chosen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: U-Boot setup
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  u-boot,env:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      A list of storage volumes containing U-Boot environment data.
+
+      Env data can be stored on various kinds of storage devices, e.g.:
+      1. Raw flash partition
+      2. UBI volume
+
+additionalProperties: true
+
+examples:
+  - |
+    chosen {
+        u-boot,env = <&env>;
+    };
+
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        env: partition@0 {
+            reg = <0x0000000 0x1000>;
+            label = "u-boot-env";
+        };
+    };
-- 
2.34.1

