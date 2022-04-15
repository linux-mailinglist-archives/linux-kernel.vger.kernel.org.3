Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB26B502A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353465AbiDOM41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245333AbiDOM4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:56:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED09BF51A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650027235; x=1681563235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uyfcbJqga1kaQg0YBcWsxpMgI10Tfpa6pQWrGukY7QE=;
  b=L6bD9P4ZVzXBZFmKs+VjukoUjrIpFh1uJOolDq5J0NFAj8zMoTTfFIpx
   vUtClibF7tObU5oR0bIEQxLoxwA3voDcTx8wIySZGhLhmuFYYaf8A7QR1
   UvWRVuKTuM8hvuwvnDHM6JdHePJHhWs/Y866Fb3tX6jF/wxFGRxMxQf2w
   xJkxzS5vpp1y7jHgzhr4wrFki6SBx6p5IPGd4UilaUSQ0Fl1hyb3vVAVC
   Brqj3NpwAmxUq6ycHOj8CWuiiycr/Sq7vWW9NC9WTO/PQ+RQgJ7aNpLMd
   Kp2aSkqxEwQm4WCL7w66D9HF27woGcuX/8PWhUPhUwE+pvcJnWWYOlPKk
   w==;
X-IronPort-AV: E=Sophos;i="5.90,262,1643698800"; 
   d="scan'208";a="160220602"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Apr 2022 05:53:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Apr 2022 05:53:53 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 15 Apr 2022 05:53:52 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v1 0/4] polarfire soc kconfig/maintainers updates
Date:   Fri, 15 Apr 2022 13:52:18 +0100
Message-ID: <20220415125221.2871991-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Thanks,
Conor.

Conor Dooley (4):
  riscv: select peripheral drivers for polarfire soc
  riscv: config: enable the mailbox framework
  riscv: select vitesse phy driver for polarfire soc
  MAINTAINERS: add polarfire rng, pci and clock drivers

 MAINTAINERS                  | 3 +++
 arch/riscv/Kconfig.socs      | 5 +++++
 arch/riscv/configs/defconfig | 1 +
 3 files changed, 9 insertions(+)

-- 
2.35.2

