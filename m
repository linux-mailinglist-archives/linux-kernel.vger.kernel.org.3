Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31654464D14
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348964AbhLALi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:38:56 -0500
Received: from ptr.189.cn ([183.61.185.103]:11455 "EHLO 189.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243427AbhLALiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:38:50 -0500
HMM_SOURCE_IP: 10.64.8.41:58200.40093229
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 3D07D100212;
        Wed,  1 Dec 2021 19:35:24 +0800 (CST)
Received: from  ([14.17.101.176])
        by gateway-151646-dep-b7fbf7d79-9vctg with ESMTP id 3123c9ccac30420ba190d8df854b0e53 for l.stach@pengutronix.de;
        Wed, 01 Dec 2021 19:35:27 CST
X-Transaction-ID: 3123c9ccac30420ba190d8df854b0e53
X-Real-From: 15330273260@189.cn
X-Receive-IP: 14.17.101.176
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Qing Zhang <zhangqing@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xiaochuan Mao <maoxiaochuan@loongson.cn>,
        zhaoxiao <zhaoxiao@uniontech.com>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] mips: loongson64: enable etnaviv drm driver on ls2k1000 and ls3a4000
Date:   Wed,  1 Dec 2021 19:35:02 +0800
Message-Id: <20211201113502.3168-3-15330273260@189.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211201113502.3168-1-15330273260@189.cn>
References: <20211201113502.3168-1-15330273260@189.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: suijingfeng <suijingfeng@loongson.cn>

  v2: merge the last two trival patches into one patch.

Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 arch/mips/configs/loongson2k_defconfig | 1 +
 arch/mips/configs/loongson3_defconfig  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index e948ca487e2d..194f39d07332 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -243,6 +243,7 @@ CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
+CONFIG_DRM_ETNAVIV=m
 CONFIG_FB_RADEON=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=m
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 25ecd15bc952..65987c5abe83 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -280,6 +280,7 @@ CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=m
+CONFIG_DRM_ETNAVIV=m
 CONFIG_DRM_QXL=y
 CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_FB=y
-- 
2.20.1

