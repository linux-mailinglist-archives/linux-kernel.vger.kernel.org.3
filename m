Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ABA5659DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbiGDPbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiGDPbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:31:13 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B764210FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:31:10 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o8O2T-00038m-2I; Mon, 04 Jul 2022 17:31:05 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Steven Price <steven.price@arm.com>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] drm/rockchip: Detach from ARM DMA domain in attach_device
Date:   Mon,  4 Jul 2022 17:31:02 +0200
Message-Id: <165694865211.1434291.3332055091205134554.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220615154830.555422-1-steven.price@arm.com>
References: <20220615154830.555422-1-steven.price@arm.com>
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

On Wed, 15 Jun 2022 16:48:30 +0100, Steven Price wrote:
> Since commit 1ea2a07a532b ("iommu: Add DMA ownership management
> interfaces") the Rockchip display driver on the Firefly RK3288 fails to
> initialise properly. This is because ARM DMA domain is still attached.
> 
> Let's follow the lead of exynos and tegra and add code to explicitly
> remove the ARM domain before attaching a new one.

Applied, thanks!

[1/1] drm/rockchip: Detach from ARM DMA domain in attach_device
      commit: 8490cad4dc4e2ee265ba9e12cd47bdfd6b9a3d34

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
