Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C0C46E876
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhLIMdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:33:18 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47853 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhLIMdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639052985; x=1670588985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3F3Dz0wUk5ASUSeln9niusk85Melb4USDFCJejNzGpc=;
  b=ZPFoNj0TiHnG75jomqFACWNIoXem1ul/uh0S891tNGynITIiPmw6TIJb
   GJYZrvXbxXzDNKHVk0TUDZbZJgp3eG2rUikP3IPNErKTEz+QgGH6CIh54
   izJzltHjR2echDfLcpNy3PIjaUihYa3+kSvEXRw4nISHZ18Ig7heBmqgO
   tFmyGCyFsD1gDqSlGy7VSMgalgypRMlRhzaTvjcPzvxpSqlVvTTeleOsL
   nJpO5hTKe93MTKBcOIR/eARBHmFga0yafjI+6ggmj8HxSnrzlphRxSdme
   fgpbE1AhVyHeQd6gzMRcFOIFKbCII/+oZjg/GrteU6vSuOcGs2Uyrn+DH
   w==;
IronPort-SDR: 4yl1lNcGEN9F2zOdyhi5eu5MX7HndK+hX805lbP7WnI3ZA/vZQQ7No49VCYDiRyjzJqYPF4vGo
 FzXUQnH+77YA9yX3C/+ZhNArP9W3sAxaf57K5PzUb7yBlscwc/EpuwtBcSMzb8mio+GY5IMEYV
 0VLIpikYtLTDi7ANdzcTL8DAacd4EJupqC9MIpdZ06vLnEgOCVg299kSQDxwJ50jyQ/t3iHJB0
 akAMPGdw1gjq4dJwyOBPJ2hIhoUStOdJF8GNynU0LnLvcTiQSC70q42ZfFVRQnQb214yz7wyF+
 eJRS0FkPxPpJnL3nD1k5IS9/
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="146076877"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Dec 2021 05:29:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 05:29:43 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Dec 2021 05:29:41 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 0/2] dt-bindings: spi: atmel,quadspi: Define sama7g5 QSPI
Date:   Thu, 9 Dec 2021 14:29:37 +0200
Message-ID: <20211209122939.339810-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Atmel QuadSPI controller Device Tree binding documentation
to json-schema. Define sama7g5 QSPI.

After the conversion to yaml, make dtbs_check reavealed a problem
that was fixed with:
https://lore.kernel.org/lkml/20211209102542.254153-1-tudor.ambarus@microchip.com/

Tudor Ambarus (2):
  dt-bindings: spi: atmel,quadspi: Convert to json-schema
  dt-bindings: spi: atmel,quadspi: Define sama7g5 QSPI

 .../bindings/spi/atmel,quadspi.yaml           | 99 +++++++++++++++++++
 .../devicetree/bindings/spi/atmel-quadspi.txt | 37 -------
 2 files changed, 99 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/atmel-quadspi.txt

-- 
2.25.1

