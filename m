Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D041B5AE7F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiIFMWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240094AbiIFMVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 08:21:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764CE7AC2B;
        Tue,  6 Sep 2022 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662466692; x=1694002692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DaiUSVC6Vw2OGQ1nqKygaDnHULlbwE0S21QZSGoOUac=;
  b=DdZG1hhhDALRjnSzmIL+IsCB/OViVBZAi77iGm/MRvVMb332ZxHjfetw
   /749VXie7jQjOGJhed9FevKdjwffgfYgFbRGEQWnm8J7jQkfwwlhDEl2Z
   +rGyMUBxCF/y3DqGyKrkRGSGzAo/MvgwMjynkGzqF+8IxhXqIPUoKmqsS
   +PqecdfDj9OzPVBaQ9iKtBrfFPz/4a3+Rin5PSFjD5CSKFRk013GqZAaZ
   mI/AwIuPHzrwUVX9LR6yDSXg0smHXtBSW27Z6sfVlVkVbh3YTJvwCGzZl
   quad+tBdK7YJ/8A7KB/zxl3mJ+5oRq+OQKt5DiqlSkZe6BInKomy2Ho3l
   g==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="179327800"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 05:16:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 05:16:05 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 6 Sep 2022 05:16:03 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] dt-bindings: vendor-prefixes: Add entry for Aldec
Date:   Tue, 6 Sep 2022 13:15:24 +0100
Message-ID: <20220906121525.3212705-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220906121525.3212705-1-conor.dooley@microchip.com>
References: <20220906121525.3212705-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per their website:
Aldec, Inc. is an industry-leading Electronic Design Automation (EDA)
company delivering innovative design creation, simulation and
verification solutions to assist in the development of complex FPGA,
ASIC, SoC and embedded system designs.

Link: https://www.aldec.com/
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2f0151e9f6be..922be64799a2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -69,6 +69,8 @@ patternProperties:
     description: Annapurna Labs
   "^alcatel,.*":
     description: Alcatel
+  "^aldec,.*":
+    description: Aldec, Inc.
   "^allegro,.*":
     description: Allegro DVT
   "^allo,.*":
-- 
2.36.1

