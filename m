Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7604A9C01
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359749AbiBDPdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:33:42 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:9341 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiBDPdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:33:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1643988784; x=1675524784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4JknExYiSPKRFuX/Pmg3/yXzIABd/kiVY/FH+NRjNpE=;
  b=vZ0Ew/2GAH05YiYEoP7Fs7fnB283U23QwJfbXsWBD6IS7UGrte0hidjl
   JH29CWd7RxUkGMJxOd3LkemQ2ZxQ/09GFXRUXvu9+3Ff1q66xYh3X0P1T
   /Q7rkZuPagf5HMXJTCjg/5ixErmM93qmRFc/VNUfcLVQ21CaqN+AeD7Ek
   gpTnTrbN0gCl6HeRupGnJZ/glLN3eI4Xg6uGRtD8ZJRHiqktPiWI2R51t
   KMh5P/5rUjys+W4SMt6AeWzMXV9wRSP/Yjm0O7arcMQmkM88ikAjYbFUO
   MTFbkjelg5b0AZV0QAznZW9g5wF3+AIVKSqYffIJLbynVB2tRLcTHyc3e
   w==;
IronPort-SDR: 3blC7bM7KXIWrbVQGot97qpC5rQjaV6krojUX+F0DA9Yta9T5nvyiTvt6zGqg48SSj/tskFnqA
 Zmcq7JWqAh3mn/LJe9OxS4E2mSFIN6JYEkjmislqk3xcGM6yb0uE/9mbWd02NAX9ekOCwBJ0mP
 KGevGZcvtMh/Bk84pMv4DX8HrXwWumOfD7409gs35AfpC8YPtiygsLOXS8eTljVjUY8DY56cAR
 06c1ARzitpb0prMkcRRQ0gX8c+rXqfS1pehNMHEOsfgaM+n5VgasQRiQ6pEwOmlotrAiHP4mz9
 xl4VUoRxVyreWoWU+SHo5C8O
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="144922906"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Feb 2022 08:33:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Feb 2022 08:33:39 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Feb 2022 08:33:37 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 0/2] pinctrl: pinctrl-microchip-sgpio: Fixes for irqs
Date:   Fri, 4 Feb 2022 16:35:33 +0100
Message-ID: <20220204153535.465827-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch series contains two fixes to the
pinctrol-microchiop-sgpio, one in the documentation and the oter in the
DT. They were introduced when the irq support was added to the driver.

Horatiu Vultur (2):
  dt-bindings: pinctrl: pinctrl-microchip-sgpio: Fix example
  arm64: dts: sparx5: Fix for sgpio nodes

 .../devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml | 2 +-
 arch/arm64/boot/dts/microchip/sparx5.dtsi                   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.33.0

