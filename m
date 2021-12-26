Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663D947F8CD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 21:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhLZUcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 15:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhLZUcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 15:32:23 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC656C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 12:32:22 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1n1aBl-0000aj-4n; Sun, 26 Dec 2021 21:32:17 +0100
Date:   Sun, 26 Dec 2021 21:32:17 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Abdun Nihaal <abdun.nihaal@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: include variable declarations from
 Hal8188EPwrSeq.h
Message-ID: <20211226203217.bzghwjpyagagstep@viti.kaiser.cx>
References: <20211224121043.175650-1-abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224121043.175650-1-abdun.nihaal@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abdun,

Thus wrote Abdun Nihaal (abdun.nihaal@gmail.com):

> Variable declarations of rtl8188E_power_on_flow, rtl8188E_card_disable_flow
> and rtl8188E_enter_lps_flow are present in Hal8188EPwrSeq.h.

> A previous commit changed Hal8188EPwrSeq.c to include HalPwrSeqCmd.h
> directly instead of Hal8188EPwrSeq.h, causing these sparse warnings:
> - symbol 'rtl8188E_power_on_flow' was not declared. Should it be static?
> - symbol 'rtl8188E_card_disable_flow' was not declared.Should it be static?
> - symbol 'rtl8188E_enter_lps_flow' was not declared. Should it be static?

> This patch reverts the include line to include the declarations.

> Fixes: 4f458ec5f497 ("staging: r8188: move the steps into Hal8188EPwrSeq.c")
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
>  drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c b/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
> index 566a1701302c..6505e1fcb070 100644
> --- a/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
> +++ b/drivers/staging/r8188eu/hal/Hal8188EPwrSeq.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright(c) 2007 - 2011 Realtek Corporation. */

> -#include "../include/HalPwrSeqCmd.h"
> +#include "../include/Hal8188EPwrSeq.h"
>  #include "../include/rtl8188e_hal.h"

>  struct wl_pwr_cfg rtl8188E_power_on_flow[] = {

thanks for spotting this, I should run my patches through sparse
before submitting.

Acked-by: Martin Kaiser <martin@kaiser.cx>
