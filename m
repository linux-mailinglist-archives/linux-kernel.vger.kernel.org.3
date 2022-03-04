Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1276D4CD6A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbiCDOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiCDOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:44:23 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5D31BD061
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646405015; x=1677941015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CW0GZlgSnEJ+z/BmZSRD3m0q4ahJDHVBRYgA4ELGTuQ=;
  b=Da82NlmDu3Rc4JRJt+loH/XuG8r2/keqZTkeGrBQnUAYJukjjLQapl/C
   jClP0blbog0pvuXgfwCQP7TuEn2ArnCRtVW4Yimp4E0YwkDxGBz223xsR
   GGcI8hHuekEpOs7ZRU4mHVBW5rrg+ySX6q/iW37eYlJOGpfYEw/4Chra/
   8r0pgLySkOEDWfvzV2+3CoIQ5FmaMWG/OWShKJpNcP2iSIy00Z1/UQxpf
   5Lxm48ESBVOX4zRBbMgMbC0xoVKMf7TvLO0EsRmPWaC12Xxnm/UPQoDmH
   P3j86UTS3BHOAcdGSekvqqP07Ag39QJnGsVLY9e1QoiXzI/bSxVI4cJed
   w==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="150870328"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 07:43:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 07:43:34 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 07:43:32 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [GIT PULL] ARM: at91: soc for 5.18 #2
Date:   Fri, 4 Mar 2022 15:42:17 +0100
Message-ID: <20220304144216.23340-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
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

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

One more patch for 5.18 on the SoC branch.
You already have the patch made by Conor "soc: microchip: make
mpfs_sys_controller_put static" in your tree, so I didn't add it here.

Thanks, best regards,
  Nicolas

The following changes since commit d0054a470c33902f5ae88835ed8a8ecc3cf8faa4:

  soc: add microchip polarfire soc system controller (2022-02-25 12:50:59 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-soc-5.18-2

for you to fetch changes up to def8abbb1464579c37f15b3d7a95e5f3bab758dc:

  ARM: at91: add support in soc driver for new SAMA5D29 (2022-03-04 12:49:22 +0100)

----------------------------------------------------------------
AT91 SoC #2 for 5.18:

- SAMA5D29 variant to the SAMA5D2 family in SoC driver.

----------------------------------------------------------------
Mihai Sain (1):
      ARM: at91: add support in soc driver for new SAMA5D29

 drivers/soc/atmel/soc.c | 3 +++
 drivers/soc/atmel/soc.h | 1 +
 2 files changed, 4 insertions(+)

-- 
Nicolas Ferre
