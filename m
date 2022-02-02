Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D434A7A91
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbiBBVjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:39:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:37102 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232659AbiBBVja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643837970; x=1675373970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yk/jgFqWUvz1adqNi+GwqR741IdbZbWUzfwflmMjc10=;
  b=N408mK+T08OF1HftYslZufGH/RD55Ilgy8b3YzbNA2h7OOQymC/a0Gl1
   tq9NWPVBs6x9k6oDpgC/pel+3VC1ypzUzIYBy3zXrrJmTiQFvaB3XwoFv
   N5lJulDmDgorWRVkU45S/mDugOnLRzAoYWqyl8Mh/nvJ7sZSDir4tt+Xw
   URixhNU1eX/jcO3yQsWdS1byv4aKZjzfcXLhKVLrdyjYPBJO2QuCOHw6o
   gqlYlIUd79zmyF5lZ1zyEb5dWg73a+5pRDb+2BfkfNbEysf6i3dYj2mVo
   UYkXQmswvQ1hpeM2Mg3Y75dsGDLPL/kLjDKTi0YWE9PMl44Wur3gDpCoc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="227994843"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="227994843"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 13:39:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="497896299"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2022 13:39:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFNLb-000V9r-Ip; Wed, 02 Feb 2022 21:39:27 +0000
Date:   Thu, 3 Feb 2022 05:38:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH] mtd: spi-nor: spi_nor_sr_ready_and_clear() can be static
Message-ID: <20220202213855.GA31097@9f7316611cc3>
References: <20220202145853.4187726-13-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202145853.4187726-13-michael@walle.cc>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/mtd/spi-nor/spansion.c:332:5: warning: symbol 'spi_nor_sr_ready_and_clear' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 spansion.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 4756fb88eab232..242d55e043f08d 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -329,7 +329,7 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
  *
  * Return: 1 if ready, 0 if not ready, -errno on errors.
  */
-int spi_nor_sr_ready_and_clear(struct spi_nor *nor)
+static int spi_nor_sr_ready_and_clear(struct spi_nor *nor)
 {
 	int ret;
 
