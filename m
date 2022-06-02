Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CE053B8F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiFBMWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiFBMWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:22:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE56010A7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654172525; x=1685708525;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K0RnMTtm6/0xuSTlPAD0Tp2bmCGrrymvRxF7juGErjQ=;
  b=exbGzCUxM3yYbbkCAPKN7YqkPkcTu0aHlUH+E1EcPS5GlEM7z4gCMQSk
   YB/8ecN5tNdgDwpEWd0H+ur72MnIZ0R7yNQUgW3+47l+ctlfs908j3Ji5
   tQzqBPSRJkfKFyOtQvCDD0v0RbIY0hQj9dFtS5iTyjV9+mRABLQuwZ6hG
   Yz75lhmKZikthFYZRRH1C8LfF9hy/PDZWRt+JawCqL106wztWqJwE7x9r
   DeSKFRdodyWEONTyizxn8d1w4yYLr1dEZsMe0UzbdFJe0miGsNZUHwVlP
   8kyBqSopTkI+LVC5qu370MWLJ589SDYF70acDZVeaYC+vPOz9M2opR/kj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275939420"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="275939420"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="612798886"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2022 05:22:03 -0700
From:   kah.jing.lee@intel.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        tien.sung.ang@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>
Subject: [PATCH 0/2] New driver for Intel(Altera) FPGA System ID softIP 
Date:   Thu,  2 Jun 2022 20:20:09 +0800
Message-Id: <20220602122008.3021030-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

Hi,
Patches have been internally reviewed by colleagues at Intel.

New sysid driver for Altera(Intel) Sysid component is generally part of an
FPGA design. The component can be hotplugged when the FPGA is reconfigured.
This patch fixes the driver to support the component being hotplugged.

Thanks,
KJ

Kah Jing Lee (2):
  drivers: misc: intel_sysid: Add sysid from arch to drivers
  dt-bindings: misc: Add the system id binding for Altera(Intel) FPGA
    platform

 .../misc/intel,socfpga-sysid-1.0.yaml         |  39 +++++
 drivers/misc/Kconfig                          |   9 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/intel_sysid.c                    | 142 ++++++++++++++++++
 4 files changed, 191 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/
intel,socfpga-sysid-1.0.yaml
 create mode 100644 drivers/misc/intel_sysid.c

-- 
2.25.1

