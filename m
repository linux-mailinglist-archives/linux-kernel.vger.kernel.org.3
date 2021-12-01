Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18E446482C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347369AbhLAH3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:29:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:55431 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347401AbhLAH3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:29:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236346383"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236346383"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 23:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="500130682"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2021 23:26:27 -0800
From:   lakshmi.sowjanya.d@intel.com
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        bgolaszewski@baylibre.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, tamal.saha@intel.com,
        pandith.n@intel.com, kenchappa.demakkanavar@intel.com,
        lakshmi.sowjanya.d@intel.com
Subject: [PATCH v2 0/2] Add pinctrl support for Intel Thunder Bay SoC
Date:   Wed,  1 Dec 2021 12:56:24 +0530
Message-Id: <20211201072626.19599-1-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Hi,

This patch set enables the support for the integrated pin controller in
the Intel Thunder Bay SoC.

Patch 1 holds the relevant Device Tree bindings documentation and an
entry in MAINTAINERS file.
Patch 2 holds the implementation of pinctrl driver.

Keem Bay and Thunder Bay platforms doesn't provide identical feature set
and register interfaces. There is no successor platform after Keem Bay
and Thunder Bay. So, having a uniform framework for different IP will
not give much advantage in this case and we prefer to have this
implementation for Thunder Bay platform as a separate driver.

Please help to review this patch set.

Thanks,
Sowjanya

Changes from v1:
 - Removed hw specific configurations.
 - Add set_config.
 - Removed gpiochip_add_pin_range and added the same in device tree.
 - Add gpio-ranges property in yaml file.

Lakshmi Sowjanya D (2):
  dt-bindings: pinctrl: Add bindings for Intel Thunderbay pinctrl driver
  pinctrl: Add Intel Thunder Bay pinctrl driver

 .../pinctrl/intel,pinctrl-thunderbay.yaml     |  119 ++
 MAINTAINERS                                   |    5 +
 drivers/pinctrl/Kconfig                       |   19 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/pinctrl-thunderbay.c          | 1322 +++++++++++++++++
 5 files changed, 1466 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/intel,pinctrl-thunderbay.yaml
 create mode 100644 drivers/pinctrl/pinctrl-thunderbay.c

-- 
2.17.1

