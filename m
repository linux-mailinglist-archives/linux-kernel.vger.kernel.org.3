Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ECE49B4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385706AbiAYNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:22:27 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:2794 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450629AbiAYNSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643116714; x=1674652714;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FwsaWjSKkuZkjObWuatzweam4HfqUJ6urkQQ4ZbcMfc=;
  b=kL+Di5krC9hHpolQMJt4Pqa8JHPo6HULdK978mLroDLSycuHgexwp4oX
   D4RBBE7IGJNdmPHf5QGH2h4ex327Zn8/XSqwHymknSXMNIYXACYnhTPsf
   47jmTEqaBJa3hUWn5b4Kzv6NqC9WvvVYwTVt+YZ7sXKalvSwRPuSwH4G+
   eEUxVXHY+XlSSOnK9qGn9patnLNsq1/vbAVDarZbJeKA2IWjITPzYeQy2
   rFLgzufRMYQ1u7u5DRPzm5gJHiESQVFeMOvWDMwCBRvReJO37AiGHDmWx
   iVUSDyVP3W3CVvfM4vJGSEb56xgXJezasJ20C/P1/BEEuVv/hmr3ou8+9
   g==;
IronPort-SDR: gWioOZyOP0ZwI9zAEoNuHEnK2uPHu3JW0Q8OBka308RHJmRxO+Jdp+OxznTzZfD6siN/UvVXjK
 x+hRkoDuVV7jixdosaIWtAqMjISm61Sf8Xuz4XjzmfTlr3lBF4soaZIOzlZc0yzqAnKgf6kuYx
 uHqAcV3ere6yBOAAYTpD48lQ8ZHDzHzY56n34StX3eEK7BzqT+O5i+04jg9aMyW3e8l0zntLC/
 ZUR2PQitAaW67u7km4futzQZ2yu1JM4WHdKh5ANHXSLkS0eNgf5/BhzhlKzBsy2gxAXC1e7kFc
 s3OthP2f2pBax5eVgGt1t6LH
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="159889610"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jan 2022 06:18:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 25 Jan 2022 06:18:21 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 25 Jan 2022 06:18:20 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 0/2] pinctrl: ocelot Add support for ServalT
Date:   Tue, 25 Jan 2022 14:18:56 +0100
Message-ID: <20220125131858.309237-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for ServalT pinctrl.

Horatiu Vultur (2):
  dt-bindings: pinctrl: ocelot: Add ServalT SoC support
  pinctrl: ocelot: Add support for ServalT SoC

 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt  |   4 +-
 drivers/pinctrl/pinctrl-ocelot.c              | 102 ++++++++++++++++++
 2 files changed, 104 insertions(+), 2 deletions(-)

-- 
2.33.0

