Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C06564282
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiGBTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiGBTcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:32:53 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271C1959D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 12:32:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6DDE35C0132;
        Sat,  2 Jul 2022 15:32:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 02 Jul 2022 15:32:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656790372; x=1656876772; bh=NFzetHdLCqetwr73VJiN2bfUP
        4tyajVF75O728IzP2s=; b=CBWebKpBWjZnYdpPp9ncptZsa28Yp69MMLIzgXWph
        XL0AGNWkc8I7QNBnAD/gLx2EXijzLpYmgt7043/QjEvKNOBPSqmuydqOnyp95akV
        Gq5QnpFYFXYr6nlXZQbqo1kw8m2Q2LV2fJFwFgu48qzexijCmJg5zVMFlAfN+5vp
        Bpisr8gDWUQ2PZdZViuwEDLPL/8r6rIzrqp4vqiJPeC6R5nJt3vkzuLqBeRP+b/j
        a5sG9T6fXfEs2wrJdZXq9DbYTJru6MSx0d+iX7DOb+UaYlVpAgNtUoibtfpUkl0X
        X/QJYlAsQccFnomrZltasTnOtOQ/kqcSMfetldgNmQ2uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656790372; x=1656876772; bh=NFzetHdLCqetwr73VJiN2bfUP4tyajVF75O
        728IzP2s=; b=wJTwxZbxlYBJO8gemZplA7wZT1a6QsNynnz/GYw3HU2RC4c9RSD
        pTYY1VP8W7EiPH678LT0QpznIv2P7haTmc4p67nP4ZIdoD6cQMsMShVIFcfmZyFi
        FQWfctS+lSPmKxuBRBU1munSImB/B0ofkVG16+sxOyP/lCJC58ID/xMhKC9k0JWh
        8q0cjD3xl8JhYygR0gp6ce6POz6iCK1l1htZvZKxSmqyY2lai2UXpEq+LmyL0IRh
        I3JYmR4iJ0A919S+tRD5DIJJ9l+I2xPg1LDoH/ZIEAgRYYeiTApULqCKuzI2iyqY
        Wh6XfRZcfUrZc3chAySd2RIl1M1Cx1giE1w==
X-ME-Sender: <xms:Y53AYtngb2kiljCdyrK0CBEO4ZsbHbxXwl-ITtv0zUAAe3EnUL2KkQ>
    <xme:Y53AYo3OpyY3v9EE0PM1CRUXj_zlq_eAiyP_--fetb-lNYAwH_Z7DcRLi9X-9effY
    -Fv6JPdSV0gFtV6iQ>
X-ME-Received: <xmr:Y53AYjr4YeAsDMH4MSaEbXIOZOtIHbvOsb5fR-BYmfEFd0PhgyJz1oM61jiqa0E7XFSD_55aSetv_WqKxOln_TjJ1HQFPerVDFdCuOR8vqRzMl87VIvyshirdIyBjcyrGiR9XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeeh
    hffhkeekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:Y53AYtk4FvX_uQ10YNqC_C9VYr_dP5h1nvKwrKnd3JSveUA4EG0RyA>
    <xmx:Y53AYr3u2COdryL7g7u6oQN3-sWORSPDNlU84olL5keQQCVOcGZXlg>
    <xmx:Y53AYssQ_qYFo0-BEfNZwsF4EwJ4XvuQ46yXSQpDKHScEkOC-ybIPQ>
    <xmx:ZJ3AYkJjxy5Z1kJTjrjAbeZTYn-EQWLBgzDVwgoaFnebuSltI1PoAg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 15:32:51 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] drm/sun4i: Update Kconfig defaults and descriptions
Date:   Sat,  2 Jul 2022 14:32:50 -0500
Message-Id: <20220702193250.52959-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner display drivers are split roughly into two generations. The
first generation was found on early 32-bit ARM SoCs and contains DE1.0
and a custom HDMI controller. Clarify that these options only apply to
a specific list of SoCs, and limit selecting them to 32-bit ARM, to
avoid confusion.

The second generation, found in A83T and newer SoCs (both 32-bit and
64-bit), contains a DE2.0 and a DesignWare HDMI controller. Since this
is the most widely-used generation, enable it by default. The previous
default condition (MACH_SUN8I) was limited to 32-bit SoCs. Also enable
the DSI controller by default, which is found on 64-bit SoCs as well.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/gpu/drm/sun4i/Kconfig | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 3a43c436c74a..1c2f8909f3cd 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -16,23 +16,25 @@ config DRM_SUN4I
 if DRM_SUN4I
 
 config DRM_SUN4I_HDMI
-	tristate "Allwinner A10 HDMI Controller Support"
+	tristate "Allwinner A10/A10s/A20/A31 HDMI Controller Support"
+	depends on ARM || COMPILE_TEST
 	default DRM_SUN4I
 	help
-	  Choose this option if you have an Allwinner SoC with an HDMI
-	  controller.
+	  Choose this option if you have an Allwinner A10/A10s/A20/A31
+	  SoC with an HDMI controller.
 
 config DRM_SUN4I_HDMI_CEC
-	bool "Allwinner A10 HDMI CEC Support"
+	bool "Allwinner A10/A10s/A20/A31 HDMI CEC Support"
 	depends on DRM_SUN4I_HDMI
 	select CEC_CORE
 	select CEC_PIN
 	help
-	  Choose this option if you have an Allwinner SoC with an HDMI
-	  controller and want to use CEC.
+	  Choose this option if you have an Allwinner A10/A10s/A20/A31
+	  SoC with an HDMI controller and want to use CEC.
 
 config DRM_SUN4I_BACKEND
 	tristate "Support for Allwinner A10 Display Engine Backend"
+	depends on ARM || COMPILE_TEST
 	default DRM_SUN4I
 	help
 	  Choose this option if you have an Allwinner SoC with the
@@ -41,8 +43,8 @@ config DRM_SUN4I_BACKEND
 	  selected the module will be called sun4i-backend.
 
 config DRM_SUN6I_DSI
-	tristate "Allwinner A31 MIPI-DSI Controller Support"
-	default MACH_SUN8I
+	tristate "Allwinner A31/A64 MIPI-DSI Controller Support"
+	default DRM_SUN4I
 	select CRC_CCITT
 	select DRM_MIPI_DSI
 	select RESET_CONTROLLER
@@ -55,15 +57,17 @@ config DRM_SUN6I_DSI
 config DRM_SUN8I_DW_HDMI
 	tristate "Support for Allwinner version of DesignWare HDMI"
 	depends on DRM_SUN4I
+	default DRM_SUN4I
 	select DRM_DW_HDMI
 	help
 	  Choose this option if you have an Allwinner SoC with the
-	  DesignWare HDMI controller with custom HDMI PHY. If M is
+	  DesignWare HDMI controller. SoCs that support HDMI and
+	  have a Display Engine 2.0 contain this controller. If M is
 	  selected the module will be called sun8i_dw_hdmi.
 
 config DRM_SUN8I_MIXER
 	tristate "Support for Allwinner Display Engine 2.0 Mixer"
-	default MACH_SUN8I
+	default DRM_SUN4I
 	help
 	  Choose this option if you have an Allwinner SoC with the
 	  Allwinner Display Engine 2.0, which has a mixer to do some
@@ -75,6 +79,6 @@ config DRM_SUN8I_TCON_TOP
 	default DRM_SUN4I if DRM_SUN8I_MIXER!=n
 	help
 	  TCON TOP is responsible for configuring display pipeline for
-	  HTMI, TVE and LCD.
+	  HDMI, TVE and LCD.
 
 endif
-- 
2.35.1

