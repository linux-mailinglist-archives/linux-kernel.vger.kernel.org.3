Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB63475A78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243269AbhLOOSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:18:09 -0500
Received: from marcansoft.com ([212.63.210.85]:56656 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237554AbhLOOSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:18:04 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6E3E4419BC;
        Wed, 15 Dec 2021 14:18:01 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     SoC Team <soc@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Apple SoC DT updates for 5.17, v2
Message-ID: <a24faafd-f2ae-c3a7-5327-b27da7d9e34b@marcan.st>
Date:   Wed, 15 Dec 2021 23:17:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SoC folks,

Please merge these additional Apple SoC DT updates for 5.17.

These mostly cover some cleanups, changes that go along with the PMGR
pull, new compatibles & minor binding changes, and adds the watchdog
node.

-Hector

The following changes since commit bf2c05b619ffc0bccf60d2108bfadc880ee7f5c7:

   arm64: dts: apple: t8103: Expose PCI node for the WiFi MAC address (2021-12-07 13:41:32 +0900)

are available in the Git repository at:

   https://github.com/AsahiLinux/linux.git tags/asahi-soc-dt-5.17-v2

for you to fetch changes up to 301f651614c3396d711a8cc3f92f6fb95b12f5c5:

   dt-bindings: mailbox: apple,mailbox: Add power-domains property (2021-12-15 20:20:38 +0900)

----------------------------------------------------------------
Apple SoC DT updates for 5.17, round 2:

- Various cleanups (removing useless props, sorting nodes, renaming
   things)
- Add PMGR min-state binding & props (see PMGR pull for driver change)
- Initial compatibles for t600x machines (M1 Pro/Max). This covers the
   bindings that just need compatible bumps & minor tweaks, no driver
   changes.
- Add watchdog node (driver not merged yet, hopefully will be; binding
   went in the previous pull)
- Add missing power-domains property to the mailbox binding

----------------------------------------------------------------
Hector Martin (10):
       arm64: dts: apple: t8103: Remove PCIe max-link-speed properties
       dt-bindings: power: apple,pmgr-pwrstate: Add apple,min-state prop
       arm64: dts: apple: t8103: Add apple,min-state to DCP PMGR nodes
       dt-bindings: arm: apple: Add t6000/t6001 MacBook Pro 14/16" compatibles
       dt-bindings: i2c: apple,i2c: Add apple,t6000-i2c compatible
       dt-bindings: pci: apple,pcie: Add t6000 support
       dt-bindings: pinctrl: apple,pinctrl: Add apple,t6000-pinctrl compatible
       arm64: dts: apple: t8103: Rename clk24 to clkref
       arm64: dts: apple: t8103: Sort nodes by address
       dt-bindings: mailbox: apple,mailbox: Add power-domains property

Sven Peter (1):
       arm64: dts: apple: t8103: Add watchdog node

  Documentation/devicetree/bindings/arm/apple.yaml   | 21 ++++++
  .../devicetree/bindings/i2c/apple,i2c.yaml         |  4 +-
  .../devicetree/bindings/mailbox/apple,mailbox.yaml |  3 +
  .../devicetree/bindings/pci/apple,pcie.yaml        | 28 +++++--
  .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |  4 +-
  .../bindings/power/apple,pmgr-pwrstate.yaml        |  8 ++
  arch/arm64/boot/dts/apple/t8103-pmgr.dtsi          |  2 +
  arch/arm64/boot/dts/apple/t8103.dtsi               | 85 ++++++++++++----------
  8 files changed, 106 insertions(+), 49 deletions(-)

