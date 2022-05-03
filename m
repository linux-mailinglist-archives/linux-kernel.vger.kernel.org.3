Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BE05181BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbiECJ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiECJ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:56:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B8134674;
        Tue,  3 May 2022 02:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651571566; x=1683107566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xCvgXxKvxoWeg9KhfgZYjZcGmeQCc6iJ9XkPFD9h1D0=;
  b=AIrUPCDUSjouch9wFJ+2vuN12zrW8CV94FbQZCSSXcJU1SVymPB5dZz7
   uOoi1psPkPRlxJ93IAzJrpNdji/fBwX63lS5rjARMBPFqyhq+3AYD2UzP
   l9qJ0DJGtKns2IFzXNN3KqN9ycx1I5pv/jK21KtHY4S+gtQS7JSZTLSLf
   oCDivGj/+WG2e7y/pe8xVDa3Tosbf1DJh1YnrKdWZg3lE6Hdtki453en8
   c5GelZCUycoOjxlyMMkMas0WhvTmvLrL+fvESJKNwyzzp9odAnau353yS
   eManvOQEzoJpxrvivUS7oGl45ttq53Dh10TPRT6GFqry3jSyfSh77flNH
   w==;
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="94364020"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 02:52:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 02:52:44 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 02:52:32 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <hverkuil@xs4all.nl>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <jacopo@jmondi.org>, Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v10 4/5] ARM: configs: at91: sama7: add xisc and csi2dc
Date:   Tue, 3 May 2022 12:51:26 +0300
Message-ID: <20220503095127.48710-5-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503095127.48710-1-eugen.hristev@microchip.com>
References: <20220503095127.48710-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 07b0494ef743..b375bf5f924c 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -138,6 +138,8 @@ CONFIG_MEDIA_SUPPORT_FILTER=y
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

