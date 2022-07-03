Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB15646FF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiGCLLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiGCLLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:11:46 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363FD9FCD;
        Sun,  3 Jul 2022 04:11:45 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o7xVi-00047D-JN; Sun, 03 Jul 2022 13:11:30 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sandy Huang <hjc@rock-chips.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: Fix an error handling path rockchip_dp_probe()
Date:   Sun,  3 Jul 2022 13:11:27 +0200
Message-Id: <165684667536.1187961.10202917102569434363.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <b719d9061bb97eb85145fbd3c5e63f4549f2e13e.1655572071.git.christophe.jaillet@wanadoo.fr>
References: <b719d9061bb97eb85145fbd3c5e63f4549f2e13e.1655572071.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2022 19:08:05 +0200, Christophe JAILLET wrote:
> Should component_add() fail, we should call analogix_dp_remove() in the
> error handling path, as already done in the remove function.

Applied, thanks!

[1/1] drm/rockchip: Fix an error handling path rockchip_dp_probe()
      commit: 5074376822fe99fa4ce344b851c5016d00c0444f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
