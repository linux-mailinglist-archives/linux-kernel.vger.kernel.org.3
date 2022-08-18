Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE5B598913
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344847AbiHRQkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244985AbiHRQkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:40:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DAC8D3EB;
        Thu, 18 Aug 2022 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660840799; x=1692376799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gqGgifVU8B0RyjP+gQqcObAhJ4b3l8QsulvEhM3OJiw=;
  b=GK7mpWWEl9bFQoPgFO1uodxZuajVlib0aa3zUQAg8uOG761ynBoJw1iG
   VdIaW5X/CenRk0O4iN6ItxuNuGoflYzHYbm0VrBTZIGPr2peKLJa1/Vw8
   H57NJrjqKS+wwfvDpILZjDnl01eM8rsQGIN3/MrBS74qpdhC+GoaaFLD8
   fDXcQnMSLq2OFw4/qmj+mRAUu2jmWt5UpxOIJYjTzmnHI7VMq4QYQwd2A
   EUJ5UuXJUmzdOEn6/vaMnEra0q3YCXgeZtjZQJvaX8ruGmQyXAc+H1zfP
   9Y18POrATSgQGpwPSaciz8/FShsJWhCjhLArHhMtidAvvrqiBbEzaVy85
   A==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="176812613"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Aug 2022 09:39:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 18 Aug 2022 09:39:56 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 18 Aug 2022 09:39:55 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 0/2] nvmem: lan966x-otpc: add support
Date:   Thu, 18 Aug 2022 18:44:03 +0200
Message-ID: <20220818164405.1953698-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for lan966x OTP controller that is available on lan966x.
The driver gives access to non-volatile memory. It allows both write
and read access to it.

Horatiu Vultur (2):
  dt-bindings: lan966x-otpc: document Lan966X OTPC
  nvmem: lan966x-otpc: add support

 .../nvmem/microchip,lan966x-otpc.yaml         |  42 +++
 drivers/nvmem/Kconfig                         |   8 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/lan966x-otpc.c                  | 248 ++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan966x-otpc.yaml
 create mode 100644 drivers/nvmem/lan966x-otpc.c

-- 
2.33.0

