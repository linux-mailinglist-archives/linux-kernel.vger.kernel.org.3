Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B48D4D030D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243842AbiCGPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240008AbiCGPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:38:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C6591AF6;
        Mon,  7 Mar 2022 07:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646667443; x=1678203443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TrTmRDWS002Fs0oH2HQhyZPSCME9/cyHeGCKtKiJKfo=;
  b=ZRyBoHmNCWWmmWmfKHZSrQ37E4nWJoTVG6su0GCzilRg+C6ltAg0RnNz
   UUSV8OZlCRRbn/eFM1Z+KMYnDXZkAeH/NIo1GiFBwLWggnuaKK7bST/9O
   H8Eq49RGrtY9Jj9ZGJmJ7vKZkcaUoEMi4hFjDFaFIJEfkFcE7rAJ3eMhH
   RiTc0CaF4y3q6ddZZLEWJo9i+w6IKt7zPn8fsDnRQhnjOmbtrSo4v0IWp
   8+QigtYKfFgRFyF+6s0WIkerN2QJQqQuyFZskUsSmIBGovAc8eQe9EB2e
   3j5iOJPpiwqjek7RP+ErgRfjau9Lkc9LMdTNgPEp4orgVPKZG4LfOGXFV
   g==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="151110204"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 08:37:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 08:37:23 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 7 Mar 2022 08:37:21 -0700
From:   <conor.dooley@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>
CC:     <lewis.hanly@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Conor Dooley" <conor.dooley@microchip.com>
Subject: [PATCH 2/2] MAINTAINERS: update PolarFire SoC support
Date:   Mon, 7 Mar 2022 15:40:24 +0000
Message-ID: <20220307154023.813158-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307154023.813158-1-conor.dooley@microchip.com>
References: <20220307154023.813158-1-conor.dooley@microchip.com>
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

From: Conor Dooley <conor.dooley@microchip.com>

Add mpfs-rng to the list of files included in PolarFire SoC support.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 573e5ee54162..dfbd076bddb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16589,6 +16589,7 @@ RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
 M:	Lewis Hanly <lewis.hanly@microchip.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	drivers/char/hw_random/mpfs-rng.c
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/soc/microchip/
 F:	include/soc/microchip/mpfs.h
-- 
2.35.1

