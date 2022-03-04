Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE95A4CD589
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbiCDNxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiCDNx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:53:28 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C73E0DA;
        Fri,  4 Mar 2022 05:52:37 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224C7LfC026984;
        Fri, 4 Mar 2022 14:51:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=9JE03u4sfdT0zvRoo95MCiqvaB33/YInHqU6AdtpVKc=;
 b=dk7XRLbqWXKacTDClup5Bgfmh3YJc5ZrIRf2U3JOp5LzHZ9H45c7s5M+YjJ4JqEyOBv+
 FVjYeOSsJ03uxz16/x/fzLRtIRldCRwsIoWSdBnIbfjIq+wqBrUYmMNgh6LYrgan8AVs
 rbX8MEZVM2cO+PC/R7GRSwJ3xZolrf+f8ST9oe3HkMHJbUbAnJYoQ7S8bgrtcUyQ+Pe+
 2JNUIoofngkeb/orgBeAZ6O8CF97wUvKNWtfbmpCCAC7l6jei2mZv6d28R9+C4VwKb08
 4kENr9i9/P/kjRIcO4WYCHOwH2D0Xus8KcnvsTzMSBPIEXelEe0s2DeXaou14tXjxTrf pA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ek4jxd558-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 14:51:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 01BF610002A;
        Fri,  4 Mar 2022 14:51:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D4A96222CBE;
        Fri,  4 Mar 2022 14:51:42 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 4 Mar 2022 14:51:42
 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>, <kernel@dh-electronics.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Grzegorz Szymaszek <gszymaszek@short.pl>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 0/3] mmc: mmci: stm32: updates for SDIO
Date:   Fri, 4 Mar 2022 14:51:31 +0100
Message-ID: <20220304135134.47827-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_06,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To properly manage SDIO on STM32 variant of PL18x, we cannot have DMA
Linked Lists enable. As it has to be disabled during probe sequence,
we cannot wait until we have communicated with the SDIO chip. This
should then be done through a DT property.
The MMC_PM_KEEP_POWER should also be disabled on STM32MP157x-DK2 board
as the clock used for wifi is not always-on.

Yann Gautier (3):
  dt-bindings: mmc: mmci: add a property to disable DMA LLI
  mmc: mmci: stm32: manage st,disable-dma-lli property
  mmc: mmci: manage MMC_PM_KEEP_POWER per variant config

 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml |  5 +++++
 drivers/mmc/host/mmci.c                              |  5 ++++-
 drivers/mmc/host/mmci.h                              |  1 +
 drivers/mmc/host/mmci_stm32_sdmmc.c                  | 10 ++++++++--
 4 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.25.1

