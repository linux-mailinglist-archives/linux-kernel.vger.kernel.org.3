Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49069548258
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbiFMIzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiFMIzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:55:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39DD8B871
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:55:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA758D6E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:55:03 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81CEB3F66F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 01:55:03 -0700 (PDT)
Date:   Mon, 13 Jun 2022 09:54:54 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     1064094935@qq.com
Cc:     James Wang <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        pengfuyuan <pengfuyuan@kylinos.cn>, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH 1/5] drm/arm: Fix spelling typo in comments
Message-ID: <Yqb7XpHyay80PiQY@e110455-lin.cambridge.arm.com>
References: <tencent_3F6C6B27BB06D7A05825908262DBE693E906@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_3F6C6B27BB06D7A05825908262DBE693E906@qq.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 11:39:03AM +0800, 1064094935@qq.com wrote:
> From: pengfuyuan <pengfuyuan@kylinos.cn>
> 
> Fix spelling typo in comments.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I've got only patch 1 of 5, so I'm going to assume that you're going to get the
series merged via some other way. If that's not the case, please let me know.

Best regards,
Liviu

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c | 2 +-
>  drivers/gpu/drm/arm/malidp_regs.h                          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index e672b9cffee3..3276a3e82c62 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -1271,7 +1271,7 @@ int komeda_release_unclaimed_resources(struct komeda_pipeline *pipe,
>  	return 0;
>  }
>  
> -/* Since standalong disabled components must be disabled separately and in the
> +/* Since standalone disabled components must be disabled separately and in the
>   * last, So a complete disable operation may needs to call pipeline_disable
>   * twice (two phase disabling).
>   * Phase 1: disable the common components, flush it.
> diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp_regs.h
> index 514c50dcb74d..59f63cc2b304 100644
> --- a/drivers/gpu/drm/arm/malidp_regs.h
> +++ b/drivers/gpu/drm/arm/malidp_regs.h
> @@ -145,7 +145,7 @@
>  #define     MALIDP_SE_COEFFTAB_DATA_MASK	0x3fff
>  #define     MALIDP_SE_SET_COEFFTAB_DATA(x) \
>  		((x) & MALIDP_SE_COEFFTAB_DATA_MASK)
> -/* Enhance coeffents reigster offset */
> +/* Enhance coeffents register offset */
>  #define MALIDP_SE_IMAGE_ENH			0x3C
>  /* ENH_LIMITS offset 0x0 */
>  #define     MALIDP_SE_ENH_LOW_LEVEL		24
> -- 
> 2.25.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
