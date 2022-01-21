Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78349495CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379753AbiAUJeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:34:10 -0500
Received: from comms.puri.sm ([159.203.221.185]:56104 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349592AbiAUJeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:34:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id CE625DF9DC;
        Fri, 21 Jan 2022 01:34:08 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D8b-TvVhkATg; Fri, 21 Jan 2022 01:34:08 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 0/2] arm64: dts: imx8mq: fix mipi_csi port numbering
Date:   Fri, 21 Jan 2022 10:33:24 +0100
Message-Id: <20220121093326.2388251-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Shawn and all interested,

This is a fix for an embarrassing bug that slipped into commit
bcadd5f66c2a ("arm64: dts: imx8mq: add mipi csi phy and csi bridge descriptions")
and commit fed7603597fa ("arm64: dts: imx8mq-librem5: describe the selfie cam").

When preparing the imx8mq.dtsi description I only tested with port@1
being connected to the csi bridge, but what I sent said port@0.

I have this on my list for a while and want to sort this out now. I'm
sorry for the inconvenience. Until now imx8mq-librem5 is the only user
(maybe because of this :).

thank you,

                              martin


Martin Kepplinger (2):
  arm64: dts: imx8mq: fix mipi_csi bidirectional port numbers
  arm64: dts: imx8mq-librem5: fix mipi_csi1 port number to sensor

 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mq.dtsi         | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.30.2

