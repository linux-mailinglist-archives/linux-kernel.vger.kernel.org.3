Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEFF4754B3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbhLOIy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbhLOIyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:54:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B62DC06173F;
        Wed, 15 Dec 2021 00:54:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12C20B81EB6;
        Wed, 15 Dec 2021 08:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3C8C34609;
        Wed, 15 Dec 2021 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639558480;
        bh=fDAWfkLs5FXSzKRxO/wgG3KsNLmVUnspvUUbPXB+4yE=;
        h=From:To:Cc:Subject:Date:From;
        b=X0Peyw7EYP0egTzB2GFsYgzMKXSCT9FFQFmONsJrjUn8bbD+OYf8cGQa947tMvO/9
         TxtsG2bLG1jzJwDzZ6O9VxSlM1RqG+SAyfXRkpOVuj/GekBAdFeNRwwWZ7oHzS1o+e
         qLJcEj5+oOL72/xvNMcWcjJMCIH7gzetsQBd5GpqMmPEogGz7NUVyDW4/kzOj/UJfE
         h1UV17QUaM5ZbHHZL9b6K+GfzSeVJSFd3hUTeqhm07EdKrHXi5Cbs99mrNxrK4wiyF
         WR/PUj3g/AE8UBjxMID3hO0hkFI2zJnaoyt2mxGmmvwYzcC4XCryzJG4IV5I1UhnKC
         EgepCIth4bTrw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mxQ3Z-0054Hp-Jh; Wed, 15 Dec 2021 09:54:37 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH RESEND 0/7] DT bindings for Hikey960/970 USB/PCI
Date:   Wed, 15 Dec 2021 09:54:26 +0100
Message-Id: <cover.1639558366.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thosre are the only missing parts for PCI to work on HiKey970 and
for USB on HiKey960 and HiKey 970 boards.

John Stultz (1):
  arm64: dts: hisilicon: Add usb mux hub for hikey960

Manivannan Sadhasivam (1):
  arm64: dts: HiSilicon: Add support for HiKey 970 PCIe controller
    hardware

Mauro Carvalho Chehab (4):
  dt-bindings: clock: hi3670-clock.txt: add pmctrl compatible
  dt-bindings: usb: hisilicon,hi3670-dwc3: add binding for Kirin970
  arm64: dts: hisilicon: Add support for Hikey 970 USB3 PHY
  arm64: dts: hisilicon: Add usb mux hub for hikey970

Yu Chen (1):
  dt-bindings: misc: add schema for USB hub on Kirin devices

 .../bindings/clock/hi3670-clock.txt           |   1 +
 .../bindings/misc/hisilicon,hikey-usb.yaml    |  87 ++++++++++
 .../bindings/usb/hisilicon,hi3670-dwc3.yaml   | 105 +++++++++++
 .../boot/dts/hisilicon/hi3660-hikey960.dts    |  35 +++-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 106 ++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 163 ++++++++++++++++++
 6 files changed, 495 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml

-- 
2.33.1


