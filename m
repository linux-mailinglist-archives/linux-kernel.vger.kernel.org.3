Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294604C6C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbiB1MYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbiB1MXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:23:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BB91163;
        Mon, 28 Feb 2022 04:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646050985; x=1677586985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KoTey0W8zWvjOFwkoy6mMXu9NuJCfWBfIG0o3q2AE/c=;
  b=04budhYJPA/npJhGUDB+4Xitb8sA611Fq55DbmgIYaWjpu0z4o909JA4
   Du8kB1E99RFhoJVsSWRPTBBSwG53a/Pv31yEyXQI1je6NGeKMu1WVh+P5
   hOmVoG9l9xt7hDBQj4jqIon+4RuPKi8GF1fskzMVbZ5tjbBM8qYoaKyyc
   OMre40xXj6PMCAWHzZyHkKrYfse0NtGRB9R/8ZICCdvf/oY0cqdwNNJWd
   Hvq+5oRNbxl1NnrsQAf+clcg6JvKyWQDur8JxlcdxK84Gefjux5HFB5l4
   a5W6FVwJcPdgKuSo2ydrjtnbyPzd/vMweiyjMxe+PPoWoTepvd+XJ+Id4
   g==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643698800"; 
   d="scan'208";a="155104953"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2022 05:23:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 28 Feb 2022 05:23:04 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 28 Feb 2022 05:23:01 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] ARM: at91: enable eic
Date:   Mon, 28 Feb 2022 14:23:24 +0200
Message-ID: <20220228122326.1400954-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following 2 patches enable EIC support available on SAMA7G5.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  ARM: dts: at91: sama7g5: add eic node
  ARM: configs: at91: add eic

 arch/arm/boot/dts/sama7g5.dtsi   | 13 +++++++++++++
 arch/arm/configs/sama7_defconfig |  1 +
 2 files changed, 14 insertions(+)

-- 
2.32.0

