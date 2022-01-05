Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BA948579C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242515AbiAERqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:46:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:35733 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242509AbiAERqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641404812; x=1672940812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HG/5iccwAFaXwpkSi5oT26UvgeoYhpgBrYfY7nFNaIU=;
  b=GNn81nuHZEv4Ht2ZyJ5jWQNQT5mI0b/iI+Q2NviLkzJzgyM5FcxQpoKq
   3+KeXkIPRcm+/JC27LeW/NR8nLKFUG4MG86dXpPX2ax1lk6wxvisMzMzQ
   3dKo6d2nOD2XMKFLmPtN5npsZ/uiZjQ0DFz8CUoKQK5VI+KoNotm5AStF
   e0QNr6atBrzJ/dp4cc2BHo97T/G4EKVvBDISu4meRkdBJSb98ksQxthSo
   L1yibD1RIELsl+HsoU1lsSNk7+jR5DbB9HZbRlf9s2d1cU7dFuYGV2sIZ
   uz7tnRw5ndWx7+bsDdRMW5YSXkkoNAV/TlI0jBlQJPf6hHuLDQekW2vwA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242292507"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="242292507"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 09:46:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="513052828"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2022 09:46:48 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5AN5-000Gtv-NX; Wed, 05 Jan 2022 17:46:47 +0000
Date:   Thu, 6 Jan 2022 01:45:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kbuild-all@lists.01.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: [RFC PATCH] ACPI: PCC: pcc_ctx can be static
Message-ID: <20220105174554.GA29945@1e936cf764ba>
References: <20220103155838.616580-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103155838.616580-1-sudeep.holla@arm.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/acpi/acpi_pcc.c:34:22: warning: symbol 'pcc_ctx' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 acpi_pcc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index 64552fdb73470..9df4d740b52a6 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -31,7 +31,7 @@ struct pcc_data {
 	struct acpi_pcc_info ctx;
 };
 
-struct acpi_pcc_info pcc_ctx;
+static struct acpi_pcc_info pcc_ctx;
 
 static void pcc_rx_callback(struct mbox_client *cl, void *m)
 {
