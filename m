Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1075F4B0772
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiBJHrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:47:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiBJHrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:47:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88535D71;
        Wed,  9 Feb 2022 23:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644479234; x=1676015234;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=bIPlSUHLcLRq3UYEc4UmN0BqPH3Phpsz7g2u3ys/mdI=;
  b=es+DCog7A7je/LYiuoo9nKxIPEcp/Wza5w7waT3FHZ3sI+/HjYCT87KY
   UKRM2dm+5DKNK2AKoeGfwWyJ8HeQ+C5ZF43qzVAZxkc6Yc/Q1+sTVK8lw
   wJrzzeB9aQs2Fd95O7W8ZvaR1gIQX3isPxq3E3gDkvHMRB8Gxesz9Q8PC
   Zqe9wYrJdEiX37WnbfYAqLadzsvT8hWpCc84HjkfUGSwkFxBEgL7DW9t9
   2QjnF3EfJ2n2iF4TPt+oIfVAQmXuMzGPg4IsCupLLF3EKe7dfi+oq7fZG
   MMnYtaB3SBewxuPbLPhvja3bDwdafw93oI8YQXCu29J031On2uKIMa7Sw
   w==;
IronPort-SDR: suxqpfL4ko3hyLqWZgbY4h09mL+bEa37gsi8HtclSYV6qNYhm5gmxisVnQtvQBOn5aw/ndMIUK
 t7sTuirUuAxk+KzUgn1iQQfKMJsIbwRRwRrDartAingttvmMTfNcWfs6hNds3/bPufbza1wxX4
 PbE86ji8KD6LisUzjfCfZ4dB/v3ngIsk85MufYNZQpzn/ASAETmk6lWAE/6PcXThwaSLsWYsIg
 jcNLZ7/v/guWXzgnJSPODtHIWewfJr/eY0mX/U0UMIZ1q6AHz8BL2sIZJChcG6YT8DP1AtKgOD
 dyayKAa4mHLuVdQmiNU81VvV
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="152577833"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 00:47:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 00:47:09 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 10 Feb 2022 00:47:05 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH 0/2] Add support for LAN966 SoC flexcom shared configurations
Date:   Thu, 10 Feb 2022 13:15:44 +0530
Message-ID: <20220210074546.30669-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
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

This patch series adds support for flexcom shared and chip select
configurations of LAN966 SoC.

Kavyasree Kotagiri (2):
  mfd: dt-bindings: add bindings for lan966 flexcom shared
    configurations
  mfd: atmel-flexcom: Add support for lan966 flexcom shared
    configurations

 .../devicetree/bindings/mfd/atmel-flexcom.txt | 12 +++++
 drivers/mfd/atmel-flexcom.c                   | 49 +++++++++++++++++++
 2 files changed, 61 insertions(+)

-- 
2.17.1

