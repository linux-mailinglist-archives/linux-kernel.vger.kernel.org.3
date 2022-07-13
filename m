Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5E572EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbiGMHFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiGMHF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:05:29 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18960E192F;
        Wed, 13 Jul 2022 00:05:24 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id E981E1C804B5;
        Wed, 13 Jul 2022 15:05:21 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 13 Jul
 2022 15:05:21 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Wed, 13 Jul
 2022 15:05:21 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 13 Jul 2022 15:05:21 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id A65BE63A23; Wed, 13 Jul 2022 10:05:19 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <j.neuschaefer@gmx.net>, <zhengbin13@huawei.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 0/2] iio: adc: npcm: add Arbel NPCM8XX support
Date:   Wed, 13 Jul 2022 10:05:15 +0300
Message-ID: <20220713070517.172852-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds Arbel NPCM8XX Analog-to-Digital Converter (ADC) support 
to ADC NPCM driver.

The NPCM8XX ADC is a 12-bit converter for eight channel inputs.

The NPCM ADC driver tested on NPCM845 evaluation board.

Addressed comments from:
 - Rob Herring : https://www.spinics.net/lists/kernel/msg4433755.html
 - Krzysztof Kozlowski: https://www.spinics.net/lists/kernel/msg4434546.html
 - Andy Shevchenko : https://www.spinics.net/lists/devicetree/msg516844.html

Changes since version 1:
 - Modify dt-binding compatible property.
 - Use device_get_match_data function instead of_match_node function.

Tomer Maimon (2):
  dt-bindings: iio: adc: npcm: Add npcm845 compatible string
  iio: adc: npcm: Add NPCM8XX support

 .../bindings/iio/adc/nuvoton,npcm750-adc.yaml |  7 ++--
 drivers/iio/adc/npcm_adc.c                    | 35 +++++++++++++++----
 2 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.33.0

