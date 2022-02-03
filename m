Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4504A7DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245526AbiBCCbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:31:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:21513 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231596AbiBCCbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643855500; x=1675391500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HdaND8u9V1hYcYSjNRBXgne8gGL7vhGYIkgf534pj+o=;
  b=NEx3grv8LVEaDVpV1r9HHFFLYrSAddimBeMg7B6Tc8KXWgyEG51dkwY0
   bV6bf3njX70OAlntmPIHeFJpipIiPjGOpFkHBvEPT1ZnsWWYwCVE1EgLU
   oewq9yqlJo4ezUjzFVIQZQqW0YvAnoK+NQrFVfseRxJeNtAs9JZHUQE4s
   4z98ErPMIGUwRycje2qctGa9rEbgTK9Lk/cKLoDjZnMefFTt/4Y4I/yEc
   gRL5o86S6LHadahRyB4h8WBxEbhfuXh9wl8If8HUrj4xDrBXo1B6Sskr0
   ayGMBen24KJ+nn0wEfe2l6WjP28BBulYTbZd9n1xXC+RfWk444agp3uWM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247829555"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="247829555"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 18:31:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="566270224"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2022 18:31:38 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFRuM-000VRC-2G; Thu, 03 Feb 2022 02:31:38 +0000
Date:   Thu, 3 Feb 2022 10:31:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jorgen Hansen <jhansen@vmware.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        pv-drivers@vmware.com, Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [RFC PATCH] VMCI: dma dg: vmci_write_data() can be static
Message-ID: <20220203023115.GA58435@f185d0c9484e>
References: <20220202144910.10349-8-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202144910.10349-8-jhansen@vmware.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/misc/vmw_vmci/vmci_guest.c:118:5: warning: symbol 'vmci_write_data' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 vmci_guest.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index ca73a19134041e..ba3443dda081bf 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -115,7 +115,7 @@ void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
 		iowrite32(val, dev->iobase + reg);
 }
 
-int vmci_write_data(struct vmci_guest_device *dev, struct vmci_datagram *dg)
+static int vmci_write_data(struct vmci_guest_device *dev, struct vmci_datagram *dg)
 {
 	int result;
 
