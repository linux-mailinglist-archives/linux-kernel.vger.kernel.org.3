Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC537478886
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhLQKNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhLQKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:12:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12DCC061574;
        Fri, 17 Dec 2021 02:12:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96E48B82787;
        Fri, 17 Dec 2021 10:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4747BC36AE1;
        Fri, 17 Dec 2021 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639735975;
        bh=Vj3Lsqq1DMV8v0b3cbSCA7WL/NE5Wa/pI0kYsoHgxrY=;
        h=From:To:Cc:Subject:Date:From;
        b=sik4rgSqEFFom+xJPuVwcQLCuGPlL1e8xemVbEA6+U85WXcwzqrR8I4nH07JPkQ4G
         RkE9J51Imxu3jjP/rZXF+Ono79/ZxNYteOcDg6gK7tlBopCvmR63MnbV4exYhpWPpK
         6sVLjRwcoov+iHTg2jCuvLSwzbiFXwNAOz1Y8A5OMYApFC085PMCZS/XkuomRpoumD
         DtrlIz/cfJMwWdWNzIndkgzZlKr1t+Coe2f7VVv/lrj8f1i60YLwKc3n5kXy8VBxFN
         s0fHwdTO8m4uFNaiJwp6vNkRXX+F7MvLzjSAIeRi4NBzb7mmQcW/0dy5PsHiKLVza4
         5tR2DH2m662yQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1myAEP-000g65-4M; Fri, 17 Dec 2021 11:12:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 0/7] DT bindings for Hikey960/970 USB/PCI
Date:   Fri, 17 Dec 2021 11:12:44 +0100
Message-Id: <cover.1639735742.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thosre are the only missing parts for PCI to work on HiKey970 and
for USB on HiKey960 and HiKey 970 boards.

-

v2:
  - patch 1: fixed port description for the USB hub;
  - patch 2: added an ack;
  - patch 3: is now dual-licensed, and had some renames;
  - patch 4: changed accordingly.

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
 .../bindings/misc/hisilicon,hikey-usb.yaml    |  84 +++++++++
 .../bindings/usb/hisilicon,hi3670-dwc3.yaml   | 105 +++++++++++
 .../boot/dts/hisilicon/hi3660-hikey960.dts    |  35 +++-
 .../boot/dts/hisilicon/hi3670-hikey970.dts    | 106 ++++++++++++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 163 ++++++++++++++++++
 6 files changed, 492 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/hisilicon,hi3670-dwc3.yaml

-- 
2.33.1


