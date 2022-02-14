Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1859C4B4F74
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352052AbiBNL4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:56:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352155AbiBNLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:55:54 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0102DC3A;
        Mon, 14 Feb 2022 03:55:45 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5A61A2222E;
        Mon, 14 Feb 2022 12:55:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644839743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0xBgLHSdc7TRH0/PGfGNoAOvoTOALso+MfXCGbD69gA=;
        b=ozFM7QoT0l7T2xn+I1qXLR6exg1c2ugev9/CYLVHebTOdzAkEpgVB3q7kr2g3hrozOZoKl
        ZT5NrTPQL6PcPWDhjYkU9amEC/AtaXVNyiENnKrr+qe1y3V+uK98RaECDRlpcj2MleG/Xo
        J4YLhDvA0JaOSdMhWPDGCYo/IVRQwAo=
From:   Michael Walle <michael@walle.cc>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/3] nvmem: add Layerscape SFP support
Date:   Mon, 14 Feb 2022 12:55:26 +0100
Message-Id: <20220214115529.662948-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Security Fuse Processor found on Layerscape
SoCs.

changes since v1:
 - added Rob's Rb
 - cleaned up the include files
 - changed the module license to only "GPL"
 - fix indendation, split lines longer than 80c

Michael Walle (3):
  dt-bindings: nvmem: add fsl,layerscape-sfp binding
  nvmem: add driver for Layerscape SFP (Security Fuse Processor)
  arm64: dts: ls1028a: add efuse node

 .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 38 ++++++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 11 +++
 drivers/nvmem/Kconfig                         | 12 +++
 drivers/nvmem/Makefile                        |  2 +
 drivers/nvmem/layerscape-sfp.c                | 89 +++++++++++++++++++
 5 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
 create mode 100644 drivers/nvmem/layerscape-sfp.c

-- 
2.30.2

