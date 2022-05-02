Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766785179F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbiEBW2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiEBW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:27:51 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E9DB7CD;
        Mon,  2 May 2022 15:24:21 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nleSe-0005bu-O7; Tue, 03 May 2022 00:24:08 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        inki.dae@samsung.com
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        samuel@sholland.org, krzk@kernel.org, wens@csie.org,
        hjc@rock-chips.com, airlied@linux.ie, sw0312.kim@samsung.com,
        alain.volmat@foss.st.com, daniel@ffwll.ch, lgirdwood@gmail.com,
        linux-samsung-soc@vger.kernel.org, jernej.skrabec@gmail.com,
        linux-rockchip@lists.infradead.org, jy0922.shim@samsung.com,
        alim.akhtar@samsung.com, linux-sunxi@lists.linux.dev,
        broonie@kernel.org, p.zabel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com,
        mripard@kernel.org
Subject: Re: (subset) [PATCH 0/5] Replace drm_detect_hdmi_monitor() with drm_display_info.is_hdmi
Date:   Tue,  3 May 2022 00:24:02 +0200
Message-Id: <165153020899.255051.7449667943189045907.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421170725.903361-1-jose.exposito89@gmail.com>
References: <20220421170725.903361-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 19:07:20 +0200, José Expósito wrote:
> After implementing a similar change in the VC4 driver [1], as suggested
> by Laurent in the ToDo list [2], I noticed that a similar pattern is
> used in the Exynos, Rockchip, STI and sun4i drivers.
> 
> This patchset replaces drm_detect_hdmi_monitor() with is_hdmi in the
> mentioned drivers.
> 
> [...]

Applied, thanks!

[2/5] drm/rockchip: inno_hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
      commit: d449222dd533ca83a3a2f88aafe06fdd8d589280
[3/5] drm/rockchip: rk3066_hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
      commit: d2eabdb64474c2101953859601794f1ea08ec1d9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
