Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6531E4669F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376752AbhLBSoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:44:15 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.123]:16360 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376640AbhLBSnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1638470400;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mgm9FcGOkzWufyh28STSVM1vIR8mFSf+dMssEkkvORM=;
    b=BfU4XnjSCXSy4LQlOSfUxUFLbul9KavDZayutyGkm0ZoAEgLFmLBPOFDEAo5BKuD2A
    TozyfO3h/WE4W0xRXHZNHTvXPvtjQZe6Ms7cnty/GUeZlmtfykkiLKBDvQRcw2uDpigu
    xXktbst1syFBlSk8OS8ydgOeTceCE6nVVPm/5yUACEh2YjpIBpKB2pMrViaiJv98ECu/
    azYbSCNpytMQeqCFYsJBBdJDnd4sPNFR3F8FQeXln3hB2vu1tnST/KIBhCUQWmOkAquP
    aBUqZYH/0jYr7yUk6Ic4CDs4lceMs2Zdzp+j+kTNCT+i7ani+Wm/oQCrmSDPZ5J0hofx
    MMYg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNOsPj0lByOdcK1X0"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.34.10 DYNA|AUTH)
    with ESMTPSA id e05ed8xB2IdxeZK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 2 Dec 2021 19:39:59 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v11 7/8] MIPS: defconfig: CI20: configure for DRM_DW_HDMI_JZ4780
Date:   Thu,  2 Dec 2021 19:39:52 +0100
Message-Id: <ed598a97b46a72bdc4defa953570f208dfc1599d.1638470392.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638470392.git.hns@goldelico.com>
References: <cover.1638470392.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG options as modules.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/configs/ci20_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index ab7ebb0668340..cc69b215854ea 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -98,7 +98,13 @@ CONFIG_RC_DEVICES=y
 CONFIG_IR_GPIO_CIR=m
 CONFIG_IR_GPIO_TX=m
 CONFIG_MEDIA_SUPPORT=m
+CONFIG_DRM=m
+CONFIG_DRM_INGENIC=m
+CONFIG_DRM_INGENIC_DW_HDMI=m
+CONFIG_DRM_DISPLAY_CONNECTOR=m
 # CONFIG_VGA_CONSOLE is not set
+CONFIG_FB=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
 # CONFIG_HID is not set
 CONFIG_USB=y
 CONFIG_USB_STORAGE=y
-- 
2.33.0

