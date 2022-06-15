Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3E254C61F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347777AbiFOK3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbiFOK3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:29:37 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1A14BBB8;
        Wed, 15 Jun 2022 03:29:36 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AE502200CCB;
        Wed, 15 Jun 2022 12:29:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 77E21200CC9;
        Wed, 15 Jun 2022 12:29:34 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0F83D1802205;
        Wed, 15 Jun 2022 18:29:32 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH 0/3] add bt-sco sound card support for i.MX8MQ/MM/MN
Date:   Wed, 15 Jun 2022 18:15:31 +0800
Message-Id: <1655288134-14083-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add bt-sco sound card support for i.MX8MQ/MM/MN

Shengjiu Wang (3):
  arm64: dts: imx8mm-evk: add bt-sco sound card support
  arm64: dts: imx8mq-evk: add bt-sco sound card support
  arm64: dts: imx8mn-evk: add bt-sco sound card support

 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 43 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 43 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 43 +++++++++++++++++++
 3 files changed, 129 insertions(+)

-- 
2.17.1

