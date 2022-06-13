Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC03B549231
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384172AbiFMOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 10:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385566AbiFMObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 10:31:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBBDABF55;
        Mon, 13 Jun 2022 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655120944; x=1686656944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pj2tfW8mZzif7jlpRh0HExia+x5zaVcrwbz9+Z9tZBk=;
  b=qMRDPdF59gqW39xcqHhgQ/WCJ7/Jo5Aecc0qTJ3pu7ABVIp5C/9qMO9e
   s58r3jIcbWjt1efpZjMSu2f2Ggd5MZEdo4EO/wiRN29IQTPnjPT2cfY7c
   iCmopRcbzh7t/+tiZ5A/vKyOa6t5amSHaahBsPH2WWEXgDLAJsib+RTzP
   M5ewXcukkmdYng5HZLFAQ5n70DO8jNureYEZouPrLn5pYYn3W+TO8/SWh
   UaLdOeKTVoijmyO6LOt6YuJonpaL+JMb2z9dR3qTDSX2zsDN+bLx3l5mi
   u+IDA9qie4gE5LS6lTlOwIDVOHG2HmfktEgafXck+f/5+fg46tVk9xRA+
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="168174938"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jun 2022 04:48:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Jun 2022 04:48:34 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 13 Jun 2022 04:48:32 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/2] MAINTAINERS: add musb to PolarFire SoC entry
Date:   Mon, 13 Jun 2022 12:46:43 +0100
Message-ID: <20220613114642.1615292-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613114642.1615292-1-conor.dooley@microchip.com>
References: <20220613114642.1615292-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the newly introduced musb driver to the existing PolarFire SoC entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..b07b2cfa3567 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17143,6 +17143,7 @@ S:	Supported
 F:	arch/riscv/boot/dts/microchip/
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/soc/microchip/
+F:	drivers/usb/musb/mpfs.c
 F:	include/soc/microchip/mpfs.h
 
 RNBD BLOCK DRIVERS
-- 
2.36.1

