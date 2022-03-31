Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13144ED316
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiCaEik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCaEig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:38:36 -0400
X-Greylist: delayed 6820 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 21:36:49 PDT
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C1645C35F;
        Wed, 30 Mar 2022 21:36:48 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 6BFD11C81053;
        Thu, 31 Mar 2022 10:43:07 +0800 (CST)
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 31
 Mar 2022 10:43:07 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 31 Mar
 2022 10:43:06 +0800
Received: from localhost.localdomain (172.19.1.47) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Thu, 31 Mar 2022 10:43:02 +0800
From:   Jacky Huang <ychuang3@nuvoton.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>, <krzk+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <cfli0@nuvoton.com>, Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH 0/3] Add initial support for MA35D1 SoC
Date:   Thu, 31 Mar 2022 10:42:53 +0800
Message-ID: <20220331024256.14762-1-ychuang3@nuvoton.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds initial support for Nuvoton MA35D1 SoC,
include initial dts and clock controller binding.

Jacky Huang (3):
  dt-bindings: clock: add binding for MA35D1 clock controller
  dt-bindings: clock: Document MA35D1 clock controller bindings
  arm64: dts: nuvoton: Add initial support for MA35D1

 .../bindings/clock/nuvoton,ma35d1-clk.yaml    |  59 ++++
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/nuvoton/Makefile          |   2 +
 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts    |  23 ++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 106 +++++++
 .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 262 ++++++++++++++++++
 6 files changed, 453 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
 create mode 100644 arch/arm64/boot/dts/nuvoton/Makefile
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1-evb.dts
 create mode 100644 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
 create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h

-- 
2.30.2

