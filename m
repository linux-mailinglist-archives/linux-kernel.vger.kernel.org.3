Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EAC46E1C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 06:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhLIFNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 00:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhLIFNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 00:13:46 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5004CC061746;
        Wed,  8 Dec 2021 21:10:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 09C5841E57;
        Thu,  9 Dec 2021 05:10:08 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Sven Peter <sven@svenpeter.dev>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] dt-bindings: Add trivial Apple t6000/t6001 SoC bindings
Date:   Thu,  9 Dec 2021 14:09:57 +0900
Message-Id: <20211209051001.70235-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob et al,

This series adds trivial DT binding changes (compatibles and some misc
changes) to support Apple's t6000/t6001 SoCs and the devices that use
them. These changes are for devices that need no driver changes to
support these new SoCs. Drivers that need changes (notably AICv2) have
the binding change submitted as part of that series.

The only nontrivial patch is #3 for the PCIe binding, which grew a port.
I tried to set it up so it'll fail validation if you try to have too
many ports on t8103.

I'll be happy to merge this through the Asahi-SoC tree once reviewed :)

Hector Martin (4):
  dt-bindings: arm: apple: Add t6000/t6001 MacBook Pro 14/16"
    compatibles
  dt-bindings: i2c: apple,i2c: Add apple,t6000-i2c compatible
  dt-bindings: pci: apple,pcie: Add t6000 support
  dt-bindings: pinctrl: apple,pinctrl: Add apple,t6000-pinctrl
    compatible

 .../devicetree/bindings/arm/apple.yaml        | 21 ++++++++++++++
 .../devicetree/bindings/i2c/apple,i2c.yaml    |  4 ++-
 .../devicetree/bindings/pci/apple,pcie.yaml   | 28 ++++++++++++++-----
 .../bindings/pinctrl/apple,pinctrl.yaml       |  4 ++-
 4 files changed, 48 insertions(+), 9 deletions(-)

-- 
2.33.0

