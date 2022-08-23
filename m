Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F086559E8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244296AbiHWRMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245758AbiHWRJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:09:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5605E1585BE;
        Tue, 23 Aug 2022 06:37:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98B62113E;
        Tue, 23 Aug 2022 06:37:06 -0700 (PDT)
Received: from [10.57.15.51] (unknown [10.57.15.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A63F03F70D;
        Tue, 23 Aug 2022 06:37:01 -0700 (PDT)
Message-ID: <48f4a56f-0586-9e9d-c121-6309be65b803@arm.com>
Date:   Tue, 23 Aug 2022 14:36:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] drm/exynos: fix repeated words in comments
Content-Language: en-GB
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, airlied@linux.ie,
        daniel@ffwll.ch, krzysztof.kozlowski@linaro.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220823122117.15757-1-yuanjilin@cdjrlc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220823122117.15757-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-23 13:21, Jilin Yuan wrote:
>   Delete the redundant word 'next'.

 From the context, I'm not sure it is redundant - as far as I can tell 
this comment seems to be describing a sequence of 3 commands, where 
"current" is the first, "next" is the second, and "next next" implies 
the third. The whole comment could certainly be reworded more clearly, 
but as it stands I suspect a replacement like s/next next/next+1/ is 
more likely to be correct.

Robin.

> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
> ---
>   drivers/gpu/drm/exynos/exynos_drm_g2d.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> index 471fd6c8135f..4f9edca66632 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -1195,7 +1195,7 @@ int exynos_g2d_set_cmdlist_ioctl(struct drm_device *drm_dev, void *data,
>   	 * If don't clear SFR registers, the cmdlist is affected by register
>   	 * values of previous cmdlist. G2D hw executes SFR clear command and
>   	 * a next command at the same time then the next command is ignored and
> -	 * is executed rightly from next next command, so needs a dummy command
> +	 * is executed rightly from next command, so needs a dummy command
>   	 * to next command of SFR clear command.
>   	 */
>   	cmdlist->data[cmdlist->last++] = G2D_SOFT_RESET;
