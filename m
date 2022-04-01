Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127484EE7F6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245224AbiDAF4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiDAF4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:56:20 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADB78A32E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:54:31 -0700 (PDT)
Received: from [192.168.0.4] (ip5f5aef67.dynamic.kabel-deutschland.de [95.90.239.103])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A9F4761EA192A;
        Fri,  1 Apr 2022 07:54:29 +0200 (CEST)
Message-ID: <2a2b1f76-7e9b-9561-e190-16d808eb5399@molgen.mpg.de>
Date:   Fri, 1 Apr 2022 07:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu/vcn: remove Unneeded semicolon
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <1648706190-4596-1-git-send-email-baihaowen@meizu.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <1648706190-4596-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Haowen,


Thank you for your patch.

Am 31.03.22 um 07:56 schrieb Haowen Bai:

In the commit message summary, please use:

Remove unneeded semicolon

> report by coccicheck:
> drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:1951:2-3: Unneeded semicolon
> 
> fixed c543dcb ("drm/amdgpu/vcn: Add VCN ras error query support")

Please use

Fixes: …

and a commit hash length of 12 characters. (`scripts/checkpatch.pl …` 
should tell you about this.)


Kind regards,

Paul


> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 3e1de8c..17d44be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1948,7 +1948,7 @@ static uint32_t vcn_v2_6_query_poison_by_instance(struct amdgpu_device *adev,
>   		break;
>   	default:
>   		break;
> -	};
> +	}
>   
>   	if (poison_stat)
>   		dev_info(adev->dev, "Poison detected in VCN%d, sub_block%d\n",
