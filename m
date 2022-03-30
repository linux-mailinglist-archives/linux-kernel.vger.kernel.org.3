Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68D44EC9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348977AbiC3QrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348958AbiC3QrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:47:07 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48DC2042B1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:45:16 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648658714; bh=FcWw9Uk/r4WaK0fxaOvlIHfQF0QAszv5h5nSfagPCsc=;
        h=From:To:Cc:Subject:Date;
        b=N2nBqTBORZ9g3fKPtDc13YTkCa69C5+lS47eKXJAoKn3fkY51SzpD0SEYaEqhyL2B
         lTFaR9l/qMCfEd8CgOjN1KbuP+KAE9OZbdGljkCy8aWsPL1UUWaofLO2GUJ29i1D2K
         aK5Gmz+Ts221PkrI+63GWDz3cUsDS55sFQH5kPk0=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 0/2] Apple ADMAC driver
Date:   Wed, 30 Mar 2022 18:44:56 +0200
Message-Id: <20220330164458.93055-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for your review I am submitting a driver for Audio DMA Controller on
recent Apple SoCs.

One note I want to leave: The docs appear to be wrong on the residue
semantics of device_tx_status. They say "In the case of a cyclic
transfer, it should only take into account the current period."
But e.g. ALSA expects the residue to be of the full buffer.

Martin

Martin Povišer (2):
  dt-bindings: dma: Add apple,admac binding
  dmaengine: apple-admac: Add Apple ADMAC driver

 .../devicetree/bindings/dma/apple,admac.yaml  |  73 ++
 MAINTAINERS                                   |   2 +
 drivers/dma/Kconfig                           |   8 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/apple-admac.c                     | 799 ++++++++++++++++++
 5 files changed, 883 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/apple,admac.yaml
 create mode 100644 drivers/dma/apple-admac.c

-- 
2.33.0

