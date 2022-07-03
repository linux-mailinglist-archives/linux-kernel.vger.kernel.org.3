Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754215646FE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 13:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiGCLLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 07:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiGCLLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 07:11:39 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5BE9592
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 04:11:37 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o7xVi-00047D-2z; Sun, 03 Jul 2022 13:11:30 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Brian Norris <briannorris@chromium.org>,
        David Airlie <airlied@linux.ie>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] drm/rockchip: vop: Don't crash for invalid duplicate_state()
Date:   Sun,  3 Jul 2022 13:11:26 +0200
Message-Id: <165684667535.1187961.4152536263848598.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220617172623.1.I62db228170b1559ada60b8d3e1637e1688424926@changeid>
References: <20220617172623.1.I62db228170b1559ada60b8d3e1637e1688424926@changeid>
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

On Fri, 17 Jun 2022 17:26:52 -0700, Brian Norris wrote:
> It's possible for users to try to duplicate the CRTC state even when the
> state doesn't exist. drm_atomic_helper_crtc_duplicate_state() (and other
> users of __drm_atomic_helper_crtc_duplicate_state()) already guard this
> with a WARN_ON() instead of crashing, so let's do that here too.

Applied, thanks!

[1/1] drm/rockchip: vop: Don't crash for invalid duplicate_state()
      commit: 1449110b0dade8b638d2c17ab7c5b0ff696bfccb

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
