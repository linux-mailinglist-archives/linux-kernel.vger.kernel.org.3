Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF1651EE60
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbiEHO61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 10:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiEHO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 10:58:25 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0A3BCBF
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 07:54:33 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nniIb-0000rS-RG; Sun, 08 May 2022 16:54:17 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haowen Bai <baihaowen@meizu.com>
Cc:     Haowen Bai <baihaowen@meizu.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: Remove unneeded semicolon
Date:   Sun, 08 May 2022 16:54:16 +0200
Message-ID: <3487561.R56niFO833@phil>
In-Reply-To: <1651802157-25092-1-git-send-email-baihaowen@meizu.com>
References: <1651802157-25092-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 6. Mai 2022, 03:55:57 CEST schrieb Haowen Bai:
> Fixes coccicheck warning:
> 
> drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:1476:2-3: Unneeded semicolon
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>

Yang Li was slightly faster [0] than this patch, so I've picked that one.

[0] https://lore.kernel.org/r/20220505232659.4405-1-yang.lee@linux.alibaba.com

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 0b49fed16535..7f9d88634a77 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1473,7 +1473,7 @@ static void rk3568_set_intf_mux(struct vop2_video_port *vp, int id,
>  	default:
>  		drm_err(vop2->drm, "Invalid interface id %d on vp%d\n", id, vp->id);
>  		return;
> -	};
> +	}
>  
>  	dip |= RK3568_DSP_IF_POL__CFG_DONE_IMD;
>  
> 




