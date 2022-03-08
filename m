Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301014D1BA9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347810AbiCHP2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347870AbiCHP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:28:04 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D514754D;
        Tue,  8 Mar 2022 07:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646753227; x=1678289227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OqLAsScm99MzSHfnnVnnariDd9egzhLVRa/r0A/f1gg=;
  b=YI749p7VNXoSYSZyKt3o670mJ10NeFFW+tkoFh8q1wgTzGoa/Oh9PHUP
   GOsUVb0kL6LbxlEteiHGOFgpNh7xDrCBeYwKMUsdrDmWZeOUbKqmn/KXn
   VboXywArLVygMJyHXXl9FxAVrFEbp8XFlfkE0GR21CDo0BbLY/83KmFLC
   kryQG8Y7JDuDG1oZTAivQvgk95FlCAOeS/AwxiCt4vsXEquwLk2l8ym/I
   i+swbEnTdpOy9vp9bNr6FdLEkbKI/iyOO2lR+uvlWM/geQULo+gaYH9C8
   FoBSZ3pBIjM9NhzMLL3RfDfxVimGU4IB5Q62P3BSqGEy+Num1a/Q/ZyCq
   g==;
X-IronPort-AV: E=Sophos;i="5.90,165,1643698800"; 
   d="scan'208";a="156121015"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 08:27:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 08:27:07 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Mar 2022 08:27:05 -0700
From:   <nicolas.ferre@microchip.com>
To:     <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] clk: at91: clk for 5.18
Date:   Tue, 8 Mar 2022 16:26:57 +0100
Message-ID: <20220308152657.30651-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
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

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Stephen,

Here are a couple more clk changes for 5.18. This Pull-Request is made on top
of what you already have for at91 targeting 5.18 on your clk-at91 existing
branch. Hopefully, we are aligned on this.
this.

Please pull.

Thanks, best regards,
  Nicolas

The following changes since commit a5ab04af49434aef532bf6cd4baa08a13665d608:

  clk: at91: sama7g5: Allow MCK1 to be exported and referenced in DT (2022-01-24 17:05:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/clk-at91-5.18

for you to fetch changes up to 8e842f02af7e2f6225d52d78cd25b465a98d344b:

  clk: at91: clk-master: remove dead code (2022-03-08 15:37:08 +0100)

----------------------------------------------------------------
AT91 clk driver additional changes for 5.18:

- sama7g5: One low priority fix for GCLK of PDMC
- clk-master: cleanup of dead code

----------------------------------------------------------------
Claudiu Beznea (1):
      clk: at91: clk-master: remove dead code

Codrin Ciubotariu (1):
      clk: at91: sama7g5: fix parents of PDMCs' GCLK

 drivers/clk/at91/at91rm9200.c  |   3 +-
 drivers/clk/at91/at91sam9260.c |   3 +-
 drivers/clk/at91/at91sam9g45.c |   3 +-
 drivers/clk/at91/at91sam9n12.c |   3 +-
 drivers/clk/at91/at91sam9rl.c  |   3 +-
 drivers/clk/at91/at91sam9x5.c  |   3 +-
 drivers/clk/at91/clk-master.c  | 117 ++---------------------------------
 drivers/clk/at91/dt-compat.c   |   3 +-
 drivers/clk/at91/pmc.h         |   2 +-
 drivers/clk/at91/sam9x60.c     |   3 +-
 drivers/clk/at91/sama5d2.c     |   3 +-
 drivers/clk/at91/sama5d3.c     |   3 +-
 drivers/clk/at91/sama5d4.c     |   3 +-
 drivers/clk/at91/sama7g5.c     |   8 +--
 14 files changed, 22 insertions(+), 138 deletions(-)

-- 
Nicolas Ferre
