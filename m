Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27A4CC715
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiCCUfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiCCUfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:35:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9CEEEA5E;
        Thu,  3 Mar 2022 12:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646339685; x=1677875685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0+Z2OVFJ3xJ8lZxfwd3cdQgStYXDsO8ikyWSekV1+js=;
  b=k5MZ/psfwTligdK9ncHux3KIwVZ4VZYMOaF7IFZ1Vd5CHYZlcRO1giK7
   kABn3IuHLCJLWjutB1Ey8lxso6O4z0K0sIWbu+oG8IkxDw8IQyp7T5fiq
   xUThubT9XEG/wxYVU1DdnCCEYMAQqOPemO/11DFhA+2PIKutz7pTETq3k
   xwAxjs65Ymg/bdl2gmPIBgmG5n1x5w0ZETCEaue1H3zOLcz2jcyxLJ08A
   vnCCQQPl1PKZErHlrdpkslEO8vlOCYC6SjqSyMLfH3X5EgT9Hbp1/Fv96
   XcyjJcCJcEDFhEpFCwMcHeBHMiu+uHq972CCkbhcYJGhU8JXnEseSuEFa
   g==;
X-IronPort-AV: E=Sophos;i="5.90,153,1643698800"; 
   d="scan'208";a="150780450"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2022 13:34:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 3 Mar 2022 13:34:44 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 3 Mar 2022 13:34:42 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <colin.foster@in-advantage.com>,
        <andriy.shevchenko@linux.intel.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 0/2] pinctrl: ocelot: Add fixes for ocelot driver
Date:   Thu, 3 Mar 2022 21:37:14 +0100
Message-ID: <20220303203716.3012703-1-horatiu.vultur@microchip.com>
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

This contains two fixes for the ocelot pinctrl:
- first fixes the memory resource index for pincfg
- second fixes the interrupt parsing

Horatiu Vultur (2):
  pinctrl: ocelot: Fix the pincfg resource.
  pinctrl: ocelot: Fix interrupt parsing

 drivers/pinctrl/pinctrl-ocelot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.33.0

