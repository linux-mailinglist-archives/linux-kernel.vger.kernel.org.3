Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2A44BB1FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiBRG02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:26:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiBRG0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:26:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204A22B620C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 22:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=POm9JYmsLrxFoP9B+CGxuYMAxAilfVuUdXuMegBj6uY=; b=FW6CR8247cKApPgjySAL04P8Ar
        LE1MqNA79IoQvj8RJQX2J/EI0CL4LlNJyed1yaPqFXp96Wgmz1YJXbvmZwA876C3fckVdTYNsCVFM
        YvLktLNAeSI15c5gM9kOhYS/Q2dqRtCHEwtFidCfjFoWwzOo2cwDuUBqmqcmLnjY3IegqZsLeO5Vp
        lYJtMpdH5W2QqGmLl3ah0BqCFntlvxsA/av9ogOviEI2JKghsJnFFQY6vL97ypKpbMsHOHlmcP2HV
        BiAMSSWWpGPx7UrF9HaNrW9cWjVCOu/W5B5S6RW5bxDW3qlJXa+77YdTnzDsGbVPQ5k+kMQnQvk7D
        55wohEHA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKwiC-00AlTE-A8; Fri, 18 Feb 2022 06:25:48 +0000
Message-ID: <cc01ec4c-c95c-fae4-0231-8b92d572d1da@infradead.org>
Date:   Thu, 17 Feb 2022 22:25:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] drm/amdgpu: Fix ARM compilation warning
Content-Language: en-US
To:     Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <Alexander.Deucher@amd.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <202202160733.1Egjqp9Y-lkp@intel.com>
 <20220216220853.59961-1-luben.tuikov@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220216220853.59961-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also seen on i386.

On 2/16/22 14:08, Luben Tuikov wrote:
> Fix this ARM warning:
> 
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:664:35: warning: format '%ld'
> expects argument of type 'long int', but argument 4 has type 'size_t' {aka
> 'unsigned int'} [-Wformat=]
> 
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: kbuild-all@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 7e60fbfbdc10a0 ("drm/amdgpu: Show IP discovery in sysfs")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index ad2355b0037f52..6c3a3c74e0231f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -668,7 +668,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>  			    le16_to_cpu(ip->hw_id) != ii)
>  				goto next_ip;
>  
> -			DRM_DEBUG("match:%d @ ip_offset:%ld", ii, ip_offset);
> +			DRM_DEBUG("match:%d @ ip_offset:%zu", ii, ip_offset);
>  
>  			/* We have a hw_id match; register the hw
>  			 * block if not yet registered.
> 
> base-commit: f723076ae13011a23d9a586899e38bc68feeb6b2

thanks.
-- 
~Randy
