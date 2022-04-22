Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B95850B16B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444765AbiDVH2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353497AbiDVH2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:28:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705A50454
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650612360; x=1682148360;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/YpfyL2u+t1gtrxzfg5VIROIwt7BOm7moe9tHDT1Pfo=;
  b=dlgeP7ebRifM76GOmUCDxIX9ZNz9udgBZfSc1rkT3/d02Jm0E5dSr0ex
   ytWKbQdX9XUl8bqr1sESVir0hghNu3enrj8ItKYKcIbCU/VoLXf4XSw0Q
   sHwLquPraJSY/cG2qOuduZsXtYfWeMQHvPKj9vw/TsFfXOZsUFcbkTLev
   3gJwSywSI3bbjwLrrupip5qPv6PukQqxWDVCsVN+FN2s2la+rYTyI85Ay
   j0A6BLUnYvQE6oPqr7f5eOP1QRHEiKPy4PSWvTwg8Zb4hkWA+Q0V2voSV
   YBfZt5QACpXR5DSa94IMe2gK87ZGu8dxiJRwlGwRcnpxOdGlFCkmWs40z
   g==;
X-IronPort-AV: E=Sophos;i="5.90,281,1643698800"; 
   d="scan'208";a="153462789"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Apr 2022 00:25:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 22 Apr 2022 00:25:57 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 22 Apr 2022 00:25:55 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <cyril.jean@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 0/4] polarfire soc kconfig/maintainers updates
Date:   Fri, 22 Apr 2022 08:25:29 +0100
Message-ID: <20220422072533.2582084-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Palmer,

As discussed, Kconfig.socs updated with the recently upstreamed drivers.
I took the liberty of also adding them to the maintainers entry.
The hwrng isnt in your tree, but was accepted today.
As you suggested, I added the vitesse phy driver in the kconfig.socs
entry - lmk if you don't like what I did with the comment.

In v2 I have replaced Lewis as a maintainer with Daire, since he is the
original author of the clock and pci drivers & a co-author on a bunch of
other (upcoming) drivers.

v3 makes the vitesse depend on phylib to avoid the lkp reported build
errors

Thanks,

Conor Dooley (4):
  riscv: select peripheral drivers for polarfire soc
  riscv: config: enable the mailbox framework
  riscv: select vitesse phy driver for polarfire soc
  MAINTAINERS: add polarfire rng, pci and clock drivers

 MAINTAINERS                  | 5 ++++-
 arch/riscv/Kconfig.socs      | 5 +++++
 arch/riscv/configs/defconfig | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.35.2

