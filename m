Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438735001CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbiDMWXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbiDMWW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:22:26 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380AE23BF0;
        Wed, 13 Apr 2022 15:19:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DA9EB5C0340;
        Wed, 13 Apr 2022 18:19:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Apr 2022 18:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1649888383; x=1649974783; bh=Qt
        Ox4T0HCpftqJcX0VmKkuT5uvDIfTobCkM4Jig4EYE=; b=XDrAt+uvDf0VTBvnBx
        xV6fY/r43+56hVhxGIinMCoZBALz9K+MTpsGGOGYZcgk6X8fxFKUdcKfo7hvoAw3
        rlmpRXK+IAxkbSMnxfTd5+xXfl+VKP+V2S4O6kLq/ucyEQM3VfupIPIbBFd9hLcV
        ZPMPME1EXUQFiCr7H4thhG4/vKr/pnP9lQ5WurO3wV5w3bhhxKYZj0yAxN2DZzwT
        734mWh478oLDkTKIL4oh18DtNtf7b+LmWjZeUnJg5wzMJZCOJGrpn6KbsQ/Z545+
        xSsE2wb6d1r/o65h9a8LVKYox9AM16nKNg8n6vcf8teN9UjOhVNU2t+c/tlrhQxo
        /N0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1649888383; x=1649974783; bh=QtOx4T0HCpftqJcX0VmKkuT5uvDIfTobCkM
        4Jig4EYE=; b=bZiOfd0iJLPlzQ2/ZVIL+ux8BJZtFvN7R7gXr9xO4tjFQReZG6S
        PgjGn2fxUzoxC4EUae30tFI2E3IIlAJjwYk204JoEi8fOaHmUYXaVarSrzf4o1Lk
        WuV6x7ne4j1UEmh/ke9qXMgHI1xMjhChma1ajoNjlDIXfx0oNu3ylhRnU/frmSXf
        +YyXpunm+zqpYIyFdAE7Ou1dKKfBWdWuJIxq81ihfgbEh3fvkehvdFA5X/LmuswJ
        wBIlg5Tjgs5+1kezxWtkNFRGBxwuo7fRQUeT2lDBmlJqXVWvjYkfgkNz/C0tbg6b
        YH1bkCZVzhPu3XJtnw2OAMA3UMV8iBJi0Jg==
X-ME-Sender: <xms:f0xXYozxT0hPaWizky0griKB_VlXctdoFZPmKXktbSTS00WIOESg7g>
    <xme:f0xXYsS8E_rmV4rffQTp9RbNdY0ZHtZypbvnQ0Klyp74pIpOHPhPR9UqUJQUEa8iO
    vGngG1dNdSJfIP81Q>
X-ME-Received: <xmr:f0xXYqXPDyooGXLL3izYL36jOXAy7VLm7Akyfe_kjvotrLlZRlijp2sp1XGpJoXvnP3w5xWGEDXigRSd8xsjEJXtiIlVdNUJ74-QTV_cHbLnPv6a_xHJDQo0ndzQdXa6S0ezAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudelvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:f0xXYmgTSeSENXT-8jeQwdynlTukA9CaUiSbDuXcg3mDG6V1SfSc8A>
    <xmx:f0xXYqB3sCrTT5SxqqwkuaKXNsuYe3JQ0cL4OegqjoT59wLVJhf4fw>
    <xmx:f0xXYnJLA0FO0fajsgT8KYErBD0uizJmtIbwoCxLwfieAUlzy_3bnw>
    <xmx:f0xXYrxe6vxM-fF8bKXvEmDdLmBnxZnWBe_yDcz6F2dbz3-toB1_ew>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Apr 2022 18:19:42 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-rockchip@lists.infradead.org,
        Alistair Francis <alistair@alistair23.me>,
        =?UTF-8?q?Ond=C5=99ej=20Jirman?= <x@xff.cz>,
        Andreas Kemnade <andreas@kemnade.info>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liang Chen <cl@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/16] drm/rockchip: ebc: Enable diff mode for partial refreshes
Date:   Wed, 13 Apr 2022 17:19:11 -0500
Message-Id: <20220413221916.50995-12-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413221916.50995-1-samuel@sholland.org>
References: <20220413221916.50995-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some waveforms, such as GC16, cause the display to flash even when the
previous and next pixel values are the same. This can be helpful,
because it produces more consistent brightness, but usually it is more
distracting. Add an option, enabled by default, for the hardware to
ignore the LUT and always send zeroes for pixels with unchanged values.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/gpu/drm/rockchip/rockchip_ebc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_ebc.c b/drivers/gpu/drm/rockchip/rockchip_ebc.c
index c3e4b65bdee6..dcd8c8e8208e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_ebc.c
+++ b/drivers/gpu/drm/rockchip/rockchip_ebc.c
@@ -158,6 +158,10 @@ static int default_waveform = DRM_EPD_WF_GC16;
 module_param(default_waveform, int, 0644);
 MODULE_PARM_DESC(default_waveform, "waveform to use for display updates");
 
+static bool diff_mode = true;
+module_param(diff_mode, bool, 0644);
+MODULE_PARM_DESC(diff_mode, "only compute waveforms for changed pixels");
+
 static bool skip_reset;
 module_param(skip_reset, bool, 0444);
 MODULE_PARM_DESC(skip_reset, "skip the initial display reset");
@@ -582,11 +586,14 @@ static void rockchip_ebc_refresh(struct rockchip_ebc *ebc,
 		dsp_ctrl |= EBC_DSP_CTRL_DSP_LUT_MODE;
 	} else {
 		epd_ctrl |= EBC_EPD_CTRL_DSP_THREE_WIN_MODE;
+		if (diff_mode)
+			dsp_ctrl |= EBC_DSP_CTRL_DSP_DIFF_MODE;
 	}
 	regmap_update_bits(ebc->regmap, EBC_EPD_CTRL,
 			   EBC_EPD_CTRL_DSP_THREE_WIN_MODE,
 			   epd_ctrl);
 	regmap_update_bits(ebc->regmap, EBC_DSP_CTRL,
+			   EBC_DSP_CTRL_DSP_DIFF_MODE |
 			   EBC_DSP_CTRL_DSP_LUT_MODE,
 			   dsp_ctrl);
 
-- 
2.35.1

