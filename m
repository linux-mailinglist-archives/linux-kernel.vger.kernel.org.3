Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206D747BF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 13:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhLUMPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 07:15:52 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59578 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237447AbhLUMPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 07:15:51 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 11C621A1300;
        Tue, 21 Dec 2021 13:15:50 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 047571A1217;
        Tue, 21 Dec 2021 13:15:50 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id ED3EC203C3;
        Tue, 21 Dec 2021 13:15:48 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 0/3] Add RTC support to i.MX8QM
Date:   Tue, 21 Dec 2021 14:15:45 +0200
Message-Id: <1640088948-3690-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds rtc devicetree node to i.MX8QM, adds the compatible to the
rtc-imx-sc driver and documents it.

Abel Vesa (3):
  dt-bindings: fsl: scu: Add i.MX8QM rtc binding
  rtc: imx-sc: Add i.MX8QM RTC support
  arm64: dts: imx8qm: Add SCU RTC node

 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 4 +++-
 arch/arm64/boot/dts/freescale/imx8qm.dtsi                   | 3 +++
 drivers/rtc/rtc-imx-sc.c                                    | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.31.1

