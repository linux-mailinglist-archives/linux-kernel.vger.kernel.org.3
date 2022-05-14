Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B3C5270B7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiENKi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 06:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiENKiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 06:38:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646E4EAB;
        Sat, 14 May 2022 03:38:50 -0700 (PDT)
Received: from p508fd4ce.dip0.t-ipconnect.de ([80.143.212.206] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nppAa-0006cU-CP; Sat, 14 May 2022 12:38:44 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/rockchip: Fix spelling mistake "aligened" -> "aligned"
Date:   Sat, 14 May 2022 12:38:42 +0200
Message-ID: <5595180.aeNJFYEL58@phil>
In-Reply-To: <20220513135341.290289-1-colin.i.king@gmail.com>
References: <20220513135341.290289-1-colin.i.king@gmail.com>
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

Hi,

Am Freitag, 13. Mai 2022, 15:53:41 CEST schrieb Colin Ian King:
> There is a spelling mistake in a drm_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

didn't you sent the same patch some days ago already?
Which is applied to drm-misc-next in [0].

Just want to make sure I didn't miss anything.

Thanks
Heiko

[0] https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f0eaf60c67738da8aae786bda74a2fffeca6d7cc

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 0b49fed16535..04e8e22a8640 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1202,7 +1202,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
>  		 */
>  		stride = (fb->pitches[0] << 3) / bpp;
>  		if ((stride & 0x3f) && (xmirror || rotate_90 || rotate_270))
> -			drm_err(vop2->drm, "vp%d %s stride[%d] not 64 pixel aligened\n",
> +			drm_err(vop2->drm, "vp%d %s stride[%d] not 64 pixel aligned\n",
>  				vp->id, win->data->name, stride);
>  
>  		rb_swap = vop2_afbc_rb_swap(fb->format->format);
> 




