Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD54C4D36DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbiCIQxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbiCIQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:45:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE45F4D27;
        Wed,  9 Mar 2022 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646844033; x=1678380033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYznwx5dXH097XmlK1oyi9a51is+vbtNveAKiaCJeUg=;
  b=ILNZBkxhOM8VrU0Roq7LFNQfMwYEKyr+vYzV3gN0I00g1DAZJCRJysMy
   4PSb0C120ptqTryCY7X0BoCI7KazCCOLSKwihRkg8NcMJTYo4aQr6+IEe
   OZhD+NJKKbxI9pxT55Ke+EEsCdoPAYcYmsdEXlxmKvvjx+ajGTkgM0dBX
   uhNpfnr/T1CfkkHcsXaa1ndiV3oyUVPwdqvNQHHt+fFSZjLxrsTjpe+gl
   jfbqGb2Nb/lOmiHc2u8W2vjlnUhBoKw8cZYGXVnJOiTFdzn26iQchsap8
   ACTZltkp1HV7fSEJbJCwebWl5UzEBt8My5Ud661Bk7s0mzTGpX2gt+Uh0
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643698800"; 
   d="scan'208";a="165123130"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 09:40:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 09:40:31 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 09:40:20 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v8 12/13] ARM: configs: at91: sama7: add xisc and csi2dc
Date:   Wed, 9 Mar 2022 18:37:57 +0200
Message-ID: <20220309163758.2672727-13-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309163758.2672727-1-eugen.hristev@microchip.com>
References: <20220309163758.2672727-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable XISC and CSI2DC drivers.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 0368068e04d9..9918cff93e5b 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -127,6 +127,8 @@ CONFIG_MEDIA_SUPPORT_FILTER=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_ATMEL_XISC=y
+CONFIG_VIDEO_MICROCHIP_CSI2DC=y
 CONFIG_VIDEO_IMX219=m
 CONFIG_VIDEO_IMX274=m
 CONFIG_VIDEO_OV5647=m
-- 
2.25.1

