Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8535804A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiGYTms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiGYTmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:42:47 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB7140DC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fB8xfMvgHCM7t/ObN6FhkrJI21/VktO8GPsKtazK7EU=; b=dbJzEm9oou0SafxUIgduHewGCM
        aiDDJ940JHEO8P0qh5z3xWEDuBc9qqRUqKvs/63xFcJ0gZidlP7rrUyAkt+O0tMLXDToGeHZfwWjU
        4a5IcRhO+zSvIKIzWmhPrWqM0aVU2aBlcf0iC3SJfmznzSDdzP8piptTe3zK4if8DO/njj7xiPjIP
        d9c1ptNjEXbFjR6IkU4DjvLZz00E+2KM9LpSCQeIOaV5U8XQULWMIT9gjNo0wdo+gAod1paN8ticg
        YXLx2nAetOQ4xnOOUoCIgX6Bjxwgn4mMfmbMNf6h+QzXu1iTfB0k5XM777+ejeKdUKp9ES66UR8gE
        91hEb1GA==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220] helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oG3yP-006KdW-3E; Mon, 25 Jul 2022 21:42:37 +0200
Message-ID: <a7589316-2a55-85f2-b665-5fe4bebf7a69@igalia.com>
Date:   Mon, 25 Jul 2022 16:42:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amd/display: change variables type
Content-Language: en-US
To:     Magali Lemes <magalilemes00@gmail.com>
Cc:     siqueirajordao@riseup.net, harry.wentland@amd.com,
        Xinhui.Pan@amd.com, christian.koenig@amd.com,
        alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
        tales.aparecida@gmail.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, mwen@igalia.com,
        mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
        isabbasso@riseup.net, andrealmeid@riseup.net, sunpeng.li@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
References: <20220725181559.250030-1-magalilemes00@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220725181559.250030-1-magalilemes00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Magali,

Às 15:15 de 25/07/22, Magali Lemes escreveu:
> As "dcn3_15_soc" and "dcn3_16_soc" are of type "struct
> _vcs_dpi_soc_bounding_box_st", change their types accordingly.
> 

I can see that indeed this type change sense for those variables, but
isn't a bit strange that the type was wrong in the first place? I wonder
if this variable is even used, given that it would very likely throw a
compiler error when using the wrong type and trying to access struct
members that aren't defined.

> Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h | 2 +-
>  drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
> index 39929fa67a51..45276317c057 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
> @@ -32,7 +32,7 @@
>  	container_of(pool, struct dcn315_resource_pool, base)
>  
>  extern struct _vcs_dpi_ip_params_st dcn3_15_ip;
> -extern struct _vcs_dpi_ip_params_st dcn3_15_soc;
> +extern struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc;
>  
>  struct dcn315_resource_pool {
>  	struct resource_pool base;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
> index 0dc5a6c13ae7..d2234aac5449 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
> @@ -32,7 +32,7 @@
>  	container_of(pool, struct dcn316_resource_pool, base)
>  
>  extern struct _vcs_dpi_ip_params_st dcn3_16_ip;
> -extern struct _vcs_dpi_ip_params_st dcn3_16_soc;
> +extern struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc;
>  
>  struct dcn316_resource_pool {
>  	struct resource_pool base;
