Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18E45179EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244887AbiEBW14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiEBW1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:27:46 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE43B7CD
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:24:16 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nleSf-0005bu-Cw; Tue, 03 May 2022 00:24:09 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tom Rix <trix@redhat.com>, hjc@rock-chips.com, daniel@ffwll.ch,
        airlied@linux.ie
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: cdn-dp: change rk3399_cdn_dp from global to static
Date:   Tue,  3 May 2022 00:24:04 +0200
Message-Id: <165153020899.255051.8052745569188083636.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220421144304.586396-1-trix@redhat.com>
References: <20220421144304.586396-1-trix@redhat.com>
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

On Thu, 21 Apr 2022 10:43:04 -0400, Tom Rix wrote:
> Smatch reports this issue
> cdn-dp-core.c:51:20: warning: symbol 'rk3399_cdn_dp' was not declared. Should it be static?
> 
> rk3399_cdn_dp is only used in cdn-dp-core.c so change
> its storge-class specifier to static.

Applied, thanks!

[1/1] drm/rockchip: cdn-dp: change rk3399_cdn_dp from global to static
      commit: 7494b1ed1df414e43dc8429f0c016b2054b1b5da

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
