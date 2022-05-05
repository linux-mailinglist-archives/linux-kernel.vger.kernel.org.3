Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE7351BD8F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356276AbiEELAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiEELAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:00:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56CF3BA48
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651748188; x=1683284188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xlM61Y37Naj7kWV5fF8LkJvKRN7akCoevsKIFW0HQ70=;
  b=fOEO/tgWqJB1u95WU4p/D7QSaZjFtz+jVKao8r8zPe5WMe8AJ/H8W8iL
   9AZ4H9wLL43+SOsM7MXBqDvZmSLHHeb2giBdusFmEWUVRl37rmy8hMbW9
   q1vQ88/ywQTwZCxveUxEeJbUfzwxCIKnq3yU/RAMY4bb9mdyD6tf3GtVP
   JKOANxVTz5F6s2JG4PF5qDuL9i+zLK8RZLYvF5fgsjiI7Lz11OT+E7zGq
   pq64AJReS6dcQNOVp440Ips4kfSvotxK2zO1Yf+YD7xNM2Zh1lU4mOldi
   SYXRAV4p0yox/gsu43B/VYgBdJunyqiu65Y0OjeQW+gUkI9GrldaQunsh
   A==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="162828730"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 03:56:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 03:56:27 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 5 May 2022 03:56:25 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <daire.mcnamara@microchip.com>, <lewis.hanly@microchip.com>,
        <cyril.jean@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 0/1] polarfire soc kconfig/maintainers updates
Date:   Thu, 5 May 2022 11:55:25 +0100
Message-ID: <20220505105525.3881259-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Palmer,

As I said yesterday on IRC, for v4 of this patchset I have removed
the kconfig changes, pending deciding on a better/consistent way
of using the SOC_FOO symbols in kconfig.socs.
The only remaining patch in this set is now the MAINTAINERS update
which was patch 4/4 in v3.

Thanks,
Conor.

Conor Dooley (1):
  MAINTAINERS: add polarfire rng, pci and clock drivers

 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.35.2

