Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C41551EE6B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 17:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiEHPFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 11:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbiEHPFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 11:05:33 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422A5DEA4
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 08:01:41 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nniPh-0000sz-ES; Sun, 08 May 2022 17:01:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Yang Li <yang.lee@linux.alibaba.com>, hjc@rock-chips.com
Cc:     Heiko Stuebner <heiko@sntech.de>, daniel@ffwll.ch,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, Abaci Robot <abaci@linux.alibaba.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm/rockchip: remove unneeded semicolon
Date:   Sun,  8 May 2022 17:01:35 +0200
Message-Id: <165202207401.1750960.5749921686386411114.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505232659.4405-1-yang.lee@linux.alibaba.com>
References: <20220505232659.4405-1-yang.lee@linux.alibaba.com>
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

On Fri, 6 May 2022 07:26:59 +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:1476:2-3: Unneeded
> semicolon

Applied, thanks!

[1/1] drm/rockchip: remove unneeded semicolon
      commit: 813bb91da10bb6638dfadad73f2f0a5f9883946b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
