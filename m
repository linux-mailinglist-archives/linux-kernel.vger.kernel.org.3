Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E4849E7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbiA0Qhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiA0Qhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:37:36 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611ABC061714;
        Thu, 27 Jan 2022 08:37:36 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2680C22239;
        Thu, 27 Jan 2022 17:37:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643301454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xNawuObWhyP0ImzFqSgiOualNkD16J48BR142Yz0pXY=;
        b=LcyvZYwzhqf1IChnWrgxom96FXIrrkDW/QVTb8vPoAZnYrH7pGK5517TpcCQ8xxsNewtAv
        sHCQrYB66JUfVm0A0nRKDFVzxcUK+qOoziN3hjpA4P1KWujIwFMj3DkXK68DOOaXemOV22
        JCbTptAJ6RV7T7UB/W/VfRES87U7EMI=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 0/3] nvmem: add Layerscape SFP support
Date:   Thu, 27 Jan 2022 17:37:25 +0100
Message-Id: <20220127163728.3650648-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Security Fuse Processor found on Layerscape
SoCs.

Michael Walle (3):
  dt-bindings: nvmem: add fsl,layerscape-sfp binding
  nvmem: add driver for Layerscape SFP (Security Fuse Processor)
  arm64: dts: ls1028a: add efuse node

 .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 38 ++++++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 11 +++
 drivers/nvmem/Kconfig                         | 12 +++
 drivers/nvmem/Makefile                        |  2 +
 drivers/nvmem/layerscape-sfp.c                | 91 +++++++++++++++++++
 5 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
 create mode 100644 drivers/nvmem/layerscape-sfp.c

-- 
2.30.2

