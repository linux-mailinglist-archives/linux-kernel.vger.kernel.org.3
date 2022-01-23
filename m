Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27304972A9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237985AbiAWPlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:41:00 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47002 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237950AbiAWPky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:40:54 -0500
Received: from p508fcdea.dip0.t-ipconnect.de ([80.143.205.234] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nBez0-0005OB-FH; Sun, 23 Jan 2022 16:40:46 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Mark Brown <broonie@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Sandy Huang <hjc@rock-chips.com>
Subject: Re: (subset) [PATCH v2 0/3] (Re)enable DP/HDMI audio for RK3399 Gru
Date:   Sun, 23 Jan 2022 16:40:43 +0100
Message-Id: <164295214821.418606.10125525976562860474.b4-ty@sntech.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220114230209.4091727-1-briannorris@chromium.org>
References: <20220114230209.4091727-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 15:02:06 -0800, Brian Norris wrote:
> This series fixes DP/HDMI audio for RK3399 Gru systems.
> 
> First, there was a regression with the switch to SPDIF. Patch 1 can be
> taken separately as a regression fix if desired. But it's not quite so
> useful (at least on Chrome OS systems) without the second part.
> 
> Second, jack detection was never upstreamed, because the hdmi-codec
> dependencies were still being worked out when this platform was first
> supported.
> 
> [...]

Applied as fix for 5.17, thanks!

[1/3] arm64: dts: rockchip: Switch RK3399-Gru DP to SPDIF output
      commit: b5fbaf7d779f5f02b7f75b080e7707222573be2a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
