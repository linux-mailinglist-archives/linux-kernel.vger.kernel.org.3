Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EBD591500
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239536AbiHLRhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 13:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbiHLRhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 13:37:04 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94D0915DF
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 10:37:02 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id z5so579301uav.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 10:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:reply-to:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=dizPcrD7xaXzAQLAnOvA/lJAJfB2ho1YY43Lw3GIZ2w=;
        b=Lq3WwTdrt3jfthJq/u97yFXe4RHqde540SLRAxlnszttUC7h5f60tyX14x0KSDc5LX
         4r0zkBPbxqJXcnnsJ4ZCBXJvdBw9RVCuhLMIdoAY7UqsTDGaqJdqWVXVgSn7RzkaLGAp
         jObndePyxg+TK2DFK/BdCyLVIaFg/UuyX2a+WKIuaMi3ZQJ0aF00PCaQMTSc6n32iPTc
         AxpmSQeswsUV1kS3nnQt+sp1rLUHCLv9b5AJQSsrudXvlk13uhOz2VVfAQO/x5OiM8x4
         7mD/gT7dsrRvKAjl+zD0iZdCCXAHLWRxIKe+92BWgZe+69WQWAKkllth9/Y9qRuIX+iy
         Kkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:reply-to:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dizPcrD7xaXzAQLAnOvA/lJAJfB2ho1YY43Lw3GIZ2w=;
        b=oti5OOba/YdhnTwJ6pNO653bYi8vC5j50WSNuKsPHMQ6o823lFQHWA8AzyY6P6PY7d
         2/sc2wEOP8KIXCz+YO5UUk148WZeDNWcf6xV3Bdtgj4NLGXNh7muo8lB4FPzWh4ofCnw
         3sGnmmHqHq2b8MGL8dWq3XqGgbH0+L/KByD5jiieoYVUrqiI3YlyEBU7xQKMf9Cd351X
         PeuXBvUP+37IUh9qcF8acjSMqJVVWvsuWwPi8BN4txroK9teI/4IrLAuQP+JWawzZwgH
         nSR+W5cOAabXVDz8hmcdkq42SGHeBzVEsPuE/8URW7gXRjZjOdYzWeoGUFSt9rB0lpLJ
         68EA==
X-Gm-Message-State: ACgBeo3rvTuEFNgdq1DC1hZQbKVs9fOcGOwB4V4KrSXcAKZvv4Jjnavx
        UE3upjCSPGtDet0QMdrUpYp9xCwvl3hdIw==
X-Google-Smtp-Source: AA6agR7Tv5COQ1lJT43XUNgNFNdFg+u4AY4yoTnhGQw7c+iaZmZPk2lYqyVssMVzUx77zM9XWUwdUg==
X-Received: by 2002:ab0:6602:0:b0:38d:539:d611 with SMTP id r2-20020ab06602000000b0038d0539d611mr2406701uam.103.1660325821392;
        Fri, 12 Aug 2022 10:37:01 -0700 (PDT)
Received: from ?IPV6:2804:14c:4c2:8202::1003? ([2804:14c:4c2:8202::1003])
        by smtp.gmail.com with ESMTPSA id g19-20020ab05993000000b00383fbaaa7d2sm121055uad.22.2022.08.12.10.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 10:37:01 -0700 (PDT)
Message-ID: <e95a5040-6cd2-3b74-1b65-50bc7c6b6ddb@gmail.com>
Date:   Fri, 12 Aug 2022 14:36:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] drm/amd/display: remove unreachable code
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     airlied@linux.ie, Xinhui.Pan@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, daniel@ffwll.ch,
        christian.koenig@amd.com, alexander.deucher@amd.com
References: <20220812031911.62729-1-jiapeng.chong@linux.alibaba.com>
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Reply-To: 20220812031911.62729-1-jiapeng.chong@linux.alibaba.com
In-Reply-To: <20220812031911.62729-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/08/2022 00:19, Jiapeng Chong wrote:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:1658 dml32_TruncToValidBPP() warn: ignoring unreachable code.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1894
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> index 05fc14a47fba..0758e1da55a9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> @@ -1654,10 +1654,6 @@ double dml32_TruncToValidBPP(
>   		else
>   			return DesiredBPP;
>   	}
> -
> -	*RequiredSlots = dml_ceil(DesiredBPP / MaxLinkBPP * 64, 1);
> -
> -	return BPP_INVALID;
>   } // TruncToValidBPP
>   
>   double dml32_RequiredDTBCLK(

Seems correct.

Reviewed-by: Tales Aparecida <tales.aparecida@gmail.com>

I feel like RequiredSlots is not actually used anywhere in the code, 
just passed around dml32_TruncToValidBPP() and 
dml32_CalculateOutputLink(). I've looked for any mentions of it in the 
mailing list, but could not find anything that implied it's part of 
ground working. I wonder if it's something outside the Linux tree for 
other platforms or related to HW gospel.
