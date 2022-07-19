Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B78579201
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiGSEee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbiGSEe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:34:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B44DFE3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658205266; x=1689741266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=neKJC/MBJk7HJU48Xebuj3JV9Ozvfki6yw7hkBYle98=;
  b=eBkd90gtcpOZsAU59QzZ4rxoEpPfEQ+gx/+S+q/TqqV2mKR7Qx5KdFD5
   mtiGQu9dKGyb8UlQKSoLqSsPKmvqfPHY+phs72XsRCu4qLhO3QK086Uaz
   VfTrKwK8o5LzBNyvOcWilPHn4zl2/5ASrySoaMA62+vgMoOwQwqqsoF99
   P5/94eEhlN9U7dJL9Wt3Ih79LkA7J+vL3JgA9skq+EFYmngtRGH2oh/1s
   O48B8qwLEHCrDLQcUIc6PHF7dXu8997hKn8FvinuoqrgRADUadYz25jor
   MlQMJrUTxa6UZUhDE3zdWyFksC7Ttp7o4NfCq+H6S34o1jLp1iWiYpoUV
   w==;
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="172873871"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 21:34:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 21:34:25 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 18 Jul 2022 21:34:22 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <tudor.ambarus@microchip.com>, <p.yadav@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@gmail.com>, <vigneshr@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michael@walle.cc>
Subject: Re: [PATCH] MAINTAINERS: Use my kernel.org email
Date:   Tue, 19 Jul 2022 07:34:20 +0300
Message-ID: <165820520992.90015.1804934724521244853.b4-ty@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718151243.1149442-1-p.yadav@ti.com>
References: <20220718151243.1149442-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@gmail.com>

On Mon, 18 Jul 2022 20:42:43 +0530, Pratyush Yadav wrote:
> Use the kernel.org email I have for reviewing patches.
> 
> 

Applied to spi-nor/next, thanks!

[1/1] MAINTAINERS: Use my kernel.org email
      https://git.kernel.org/mtd/c/7de3074b218f

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@gmail.com>
