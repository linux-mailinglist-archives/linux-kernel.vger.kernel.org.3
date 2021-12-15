Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B25B47601F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245584AbhLOSCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:02:18 -0500
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:58940 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245258AbhLOSCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:02:15 -0500
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 957D3F40EAF; Wed, 15 Dec 2021 18:55:07 +0100 (CET)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        rw-r-r-0644 <r.r.qwertyuiop.r.r@gmail.com>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Subject: [PATCH v3 4/5] powerpc: gamecube_defconfig: Enable the RTC driver
Date:   Wed, 15 Dec 2021 18:55:00 +0100
Message-Id: <20211215175501.6761-5-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211215175501.6761-1-linkmauve@linkmauve.fr>
References: <20211027223516.2031-1-linkmauve@linkmauve.fr>
 <20211215175501.6761-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This selects the rtc-gamecube driver, which provides a real-time clock
on this platform.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/powerpc/configs/gamecube_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/gamecube_defconfig b/arch/powerpc/configs/gamecube_defconfig
index 24c0e0ea5aeb..91a1b99f4e8f 100644
--- a/arch/powerpc/configs/gamecube_defconfig
+++ b/arch/powerpc/configs/gamecube_defconfig
@@ -68,7 +68,7 @@ CONFIG_SND_SEQUENCER=y
 CONFIG_SND_SEQUENCER_OSS=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_GENERIC=y
+CONFIG_RTC_DRV_GAMECUBE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_ISO9660_FS=y
-- 
2.34.1

