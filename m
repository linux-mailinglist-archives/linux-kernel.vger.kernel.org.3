Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1204C7F50
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiCAAew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiCAAet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:34:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6DD6D1A3;
        Mon, 28 Feb 2022 16:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646094849; x=1677630849;
  h=from:to:cc:references:in-reply-to:subject:date:
   message-id:mime-version:content-transfer-encoding;
  bh=YuZO4OlaL+j1Hz0MmUZERoJwsTLfUDX//Mg77p/cZZw=;
  b=AYdLS45WZHZI62FrCfycN7dTfs8pxpTDzMSI+A/2GdBKwDoDN2n0EeOv
   CGWXonMom0zhd+tJGDIUoMPpdCu0M8m/S/shaVyrJGAgO2ydQpeSoH7Yf
   BpNiYm7vi/a97WOeVF6iW/3DOEe1eqH+JNfArWVNKB7KOqSpwm25arTL+
   RWNDSWjMhkFiCz+pEHGYBKIFUX7ZgUocd9pWoAEG4mg1bP0W20/eR25y9
   KtzIaFJkPl4/m+xGGtSr8NbpCq8ZWezuuvmhSDZvOC9MzBWo96OEeaMFU
   Y4rXxR6h0rIyHuRc2NYDInGSayxioIvbmw0qL4tu0MxGS6M2BP3msK4As
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="236530391"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="236530391"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 16:34:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="608636851"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 28 Feb 2022 16:34:08 -0800
Received: from yongli3MOBL1 (yongli3-MOBL1.ccr.corp.intel.com [10.255.30.72])
        by linux.intel.com (Postfix) with ESMTP id 58EB65807D2;
        Mon, 28 Feb 2022 16:34:05 -0800 (PST)
From:   "Yong Li" <yong.b.li@linux.intel.com>
To:     "'Chia-Wei Wang'" <chiawei_wang@aspeedtech.com>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <cyrilbur@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>
Cc:     "Li, Yong B" <yong.b.li@intel.com>
References: <20210817025848.19914-1-chiawei_wang@aspeedtech.com>
In-Reply-To: <20210817025848.19914-1-chiawei_wang@aspeedtech.com>
Subject: RE: [PATCH v2 0/2] aspeed: Add LPC mailbox support
Date:   Tue, 1 Mar 2022 08:34:04 +0800
Message-ID: <000501d82d04$0ffa9870$2fefc950$@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFpITV8ohJziVpZHKVTEr+hR1WqCK2HxEiw
Content-Language: en-us
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: request-justification,no-action
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@andrew@aj.id.au @Chia-Wei Wang @joel@jms.id.au

Just want to check the latest status about this mailbox driver. I would like
to get this driver upstreamed too. 

Thanks,
Yong

-----Original Message-----
From: openbmc <openbmc-bounces+yong.b.li=linux.intel.com@lists.ozlabs.org>
On Behalf Of Chia-Wei Wang
Sent: Tuesday, August 17, 2021 10:59 AM
To: robh+dt@kernel.org; joel@jms.id.au; andrew@aj.id.au; cyrilbur@gmail.com;
devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org;
openbmc@lists.ozlabs.org
Subject: [PATCH v2 0/2] aspeed: Add LPC mailbox support

Add driver support for the LPC mailbox controller of ASPEED SoCs.

v2:
 - Fix error handling for copy_to_user
 - Fix incorrect type in the .poll initializer

Chia-Wei Wang (2):
  soc: aspeed: Add LPC mailbox support
  ARM: dts: aspeed: Add mailbox to device tree

 arch/arm/boot/dts/aspeed-g4.dtsi     |   7 +
 arch/arm/boot/dts/aspeed-g5.dtsi     |   8 +-
 arch/arm/boot/dts/aspeed-g6.dtsi     |   7 +
 drivers/soc/aspeed/Kconfig           |  10 +
 drivers/soc/aspeed/Makefile          |   9 +-
 drivers/soc/aspeed/aspeed-lpc-mbox.c | 418 +++++++++++++++++++++++++++
 6 files changed, 454 insertions(+), 5 deletions(-)  create mode 100644
drivers/soc/aspeed/aspeed-lpc-mbox.c

--
2.17.1

