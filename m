Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22D74A4034
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358271AbiAaKak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358193AbiAaK3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:29:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1387BC061757
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:29:27 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nETvR-0008WD-Oi; Mon, 31 Jan 2022 11:28:45 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1nETvO-008Cbi-BL; Mon, 31 Jan 2022 11:28:42 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/5] ARM: dts: protonic maintenance patches
Date:   Mon, 31 Jan 2022 11:28:36 +0100
Message-Id: <20220131102841.1955032-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes v2:
- add missing new lines
- rename adc label to adc_ts
- add thermal zones patch

Oleksij Rempel (4):
  ARM: dts: imx6dl-prtvt7: Add display and panel nodes
  ARM: dts: imx6qdl-vicut1: add CAN termination support
  ARM: dts: imx6dl: plym2m, prtvt7, victgo: make use of new
    resistive-adc-touch driver
  ARM: dts: imx6dl: plym2m, prtvt7, victgo: add thermal zones and hwmon

Robin van der Gracht (1):
  ARM: dts: imx6dl-prtvt7: Add missing tvp5150 video decoder node

 arch/arm/boot/dts/imx6dl-plym2m.dts   | 131 +++++++++++++++--
 arch/arm/boot/dts/imx6dl-prtvt7.dts   | 203 ++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6dl-victgo.dts   | 121 +++++++++++++--
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi |  12 +-
 4 files changed, 413 insertions(+), 54 deletions(-)

-- 
2.30.2

