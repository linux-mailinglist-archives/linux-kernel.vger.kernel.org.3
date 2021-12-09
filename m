Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB28A46E706
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbhLIKxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:53:48 -0500
Received: from mail.emtrion.de ([87.139.198.129]:21153 "EHLO mail3.emtrion.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230283AbhLIKxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:53:41 -0500
Received: from emtrion-yocto-comrzn1d.emtrion.local
 (2003:f9:5824:1:20c:29ff:fe08:43c4) by EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 11:50:05 +0100
From:   <reinhold.mueller@emtrion.com>
To:     <robh+dt@kernel.org>, <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <reinhold.mueller@emtrion.com>
Subject: [PATCH v2 0/2] new emtrion hardware emSBC-Argon
Date:   Thu, 9 Dec 2021 11:49:45 +0100
Message-ID: <20211209104947.4647-1-reinhold.mueller@emtrion.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [2003:f9:5824:1:20c:29ff:fe08:43c4]
X-ClientProxiedBy: EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1) To EMT-KA-S004.emtrion.local
 (2003:f9:5824:1:c59f:32f4:72e5:b9e1)
X-C2ProcessedOrg: 5b249fcb-306f-4927-9982-5d11b1d300ce
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinhold Mueller <reinhold.mueller@emtrion.com>

This patch series adds support for the emtrion emSBC-Argon

Changes

v2:
[PATCH 1/2]
	- replaced enum by const
[PATCH 2/2]
	- no fixes

v1:
[PATCH 0/2]
	- split former patch in dts -and yaml patches
[PATCH 1/2]
	- no fixes
[PATCH 2/2]
	- small modification in subject name
	- node name for leds moved to led-X
	- update of clocknames removed,
		already defined in stm32mp151.dtsi
	- removing some unneeded entries status = "disabled" 
	- moved pin configurations to stm32mp15-pinctrl

Reinhold Mueller (2):
  dt-binding: arm/stm32: Add emtrion hardware emSBC-Argon
  ARM: dts: stm32: Add support for the emtrion emSBC-Argon

 .../devicetree/bindings/arm/stm32/stm32.yaml  |   6 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |  92 +++
 arch/arm/boot/dts/stm32mp157c-emsbc-argon.dts |  53 ++
 .../boot/dts/stm32mp157c-emstamp-argon.dtsi   | 552 ++++++++++++++++++
 5 files changed, 704 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32mp157c-emsbc-argon.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi

-- 
2.20.1

