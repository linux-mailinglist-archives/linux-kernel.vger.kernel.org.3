Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ED152D09F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiESKfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiESKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:34:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E879756C0C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652956496; x=1684492496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CzscFN28RfQFN3KQ63YDFxL/7IzpZ529WY8hP6rkgDI=;
  b=NefQ6vk365YGQOZinm+3vpglCloPam+Bua5gVReMdejG+Bl7RmhE4Sea
   lj5vSW/8WtENJwG8BY1n0wFy/cpdKx2ajFeqpTFyey9I/XQ/paerLJvte
   FXipES9H8zfSIJoLSf1/uVl2sz9qK1dj/PDd+XoHGJDZf7zksaQo8iHBh
   E+skof4Dx7hknehfvqUcxPhM+W22GElLlwgHJaFDUgUpoJb1f8CbbFOpC
   TiX6d+H06jzaNO928WWlSEAPgPNYr0tF78HVTCd0gpWmBvC1TkC/UuO/V
   a6bnLAOvfmVXB3q5xjF7is9x7MK4QeCnZSFGKBb1BjvbW46yhSs//+kPP
   A==;
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="164401315"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2022 03:34:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 19 May 2022 03:34:53 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 19 May 2022 03:34:52 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <sboyd@kernel.org>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] ARM: at91: pm: fix wakeup from RTC for ULP1
Date:   Thu, 19 May 2022 13:37:21 +0300
Message-ID: <20220519103723.925800-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Series fixes the wakeup from RTC alarm for ULP1 on SAM9X60 and SAMA7G5.
I kept them as 2 patches to be able to be backported to proper kernels.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  ARM: at91: pm: use proper compatible for sam9x60's rtc and rtt
  ARM: at91: pm: use proper compatible for sama7g5's rtc and rtt

 arch/arm/mach-at91/pm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1

