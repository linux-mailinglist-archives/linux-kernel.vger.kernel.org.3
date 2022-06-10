Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D4E545E93
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347289AbiFJISm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347310AbiFJISQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:18:16 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D2E823512D;
        Fri, 10 Jun 2022 01:18:15 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 8D54816A6;
        Fri, 10 Jun 2022 11:18:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 8D54816A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849139;
        bh=ziywhS226uueS7ATE0wHWin9aE5fJAEXVPduh54bP74=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=SuOxovivlh/stWfNHG5TLO+h5avykiBoP88eN0ALtI86v6D0JSiGWWvNFJ14scpw6
         3iqgWWUEaf89yFnn5TI9FOsXz7zGI5K3FuNj6pxJ65ToeJptX1x1yF/re30OINl/Cu
         6iEQU8fq42m2YvhRZHkQWnFtuVrRvIa0E2KHRgmg=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:18:07 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 05/23] dt-bindings: ata: sata-brcm: Apply common AHCI schema
Date:   Fri, 10 Jun 2022 11:17:43 +0300
Message-ID: <20220610081801.11854-6-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom SATA controller is obviously based on the AHCI standard. The
device driver uses the kernel AHCI library to work with it. Therefore we
can be have a more thorough DT-bindings evaluation by referring to the
AHCI-common schema instead of using the more relaxed SATA-common one.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v4:
- This is a new patch added on v4 lap of the review procedure.
---
 Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
index 4ee74df8e58a..fa8ebc8f243f 100644
--- a/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
+++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcm.yaml
@@ -14,7 +14,7 @@ maintainers:
   - Florian Fainelli <f.fainelli@gmail.com>
 
 allOf:
-  - $ref: sata-common.yaml#
+  - $ref: ahci-common.yaml#
 
 properties:
   compatible:
-- 
2.35.1

