Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85903477525
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbhLPO7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:59:37 -0500
Received: from mail.wizzup.org ([95.217.97.174]:44582 "EHLO wizzup.org"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238173AbhLPO7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wizzup.org;
        s=mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DjXxSvbpnfZWTB8la9pvej64oJM3C+QTUUElIiq87ao=; b=TSSAkwA6pQ/NlDPpVQ1i4T2A3W
        IjjcU1YI7v18WTw0BShCnbAWjAVurXGahHA7Hy6xTVYPTvhPqHm/Z6USHxDGazVVJF9cbMmJoskSq
        edNuFu/Y03bjT+6tOVwFqB7pI5blIIO/pBtMRKGGpmyarmO/CQ46WgYdih8Jr5vi9iNVHUZn/6oJS
        c/D2kk2VKzPWlUblZVj7qsOpezvXySZ99Ja5naYXuxjKasFJgJc76X/Qn/tAjtVQAVcHPAxtbTgLQ
        OGElxntYaxl8gQzBV6lSjNS9BLv5mSHGS0WRYhNSYuWcPQiiGk5qoT517pMuZimT4boiUNIeUy/sf
        zXieq3eQ==;
Received: from [45.83.235.159] (helo=gentoo-x13.fritz.box)
        by wizzup.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <merlijn@wizzup.org>)
        id 1mxsE7-0004VS-Pv; Thu, 16 Dec 2021 14:59:23 +0000
From:   Merlijn Wajer <merlijn@wizzup.org>
To:     merlijn@wizzup.org
Cc:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Dev Null <devnull@uvos.xyz>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap2plus_defconfig: enable TLV320AIC3X
Date:   Thu, 16 Dec 2021 16:05:06 +0100
Message-Id: <20211216150506.31163-1-merlijn@wizzup.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a96d2ba2d824 ("ASoC: codecs: tlv320aic3x: move I2C to separated
file") split the driver into SPI and I2C code and also provided a
separate configuration option for it.

The RX51 audio fails to probe since this commit, so let's add this
non-obvious configuration option to the defconfig.

Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 7a41e9cbcc7b..5c916e92068e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -566,6 +566,8 @@ CONFIG_SND_SOC_OMAP_HDMI=m
 CONFIG_SND_SOC_CPCAP=m
 CONFIG_SND_SOC_MOTMDM=m
 CONFIG_SND_SOC_TLV320AIC23_I2C=m
+CONFIG_SND_SOC_TLV320AIC3X=m
+CONFIG_SND_SOC_TLV320AIC3X_I2C=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_HID_GENERIC=m
-- 
2.32.0

