Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F02B51EE6A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiEHPFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 11:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiEHPFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 11:05:37 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4552BDED5
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 08:01:47 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nniPh-0000sz-2i; Sun, 08 May 2022 17:01:37 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     daniel@ffwll.ch, hjc@rock-chips.com, lyude@redhat.com,
        tzimmermann@suse.de, airlied@linux.ie,
        Ren Zhijie <renzhijie2@huawei.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 -next] drm/rockchip: Fix Kconfig dependencies
Date:   Sun,  8 May 2022 17:01:34 +0200
Message-Id: <165202207401.1750960.18152793741312373410.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507100910.93705-1-renzhijie2@huawei.com>
References: <20220507100910.93705-1-renzhijie2@huawei.com>
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

On Sat, 7 May 2022 18:09:10 +0800, Ren Zhijie wrote:
> The DP-helper module has been replaced by the display-helper module.
> So the driver have to select it.

Applied, thanks!

[1/1] drm/rockchip: Fix Kconfig dependencies
      commit: 0b752df77633cc4c3606a6187e3ad37ad6925c15

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
