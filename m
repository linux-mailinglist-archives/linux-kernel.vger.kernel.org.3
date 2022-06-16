Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D454EA56
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378273AbiFPTvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFPTva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:51:30 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E882952B0B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:51:25 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-f2a4c51c45so3106532fac.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HTgpJSeP+XwifnYxDA/LJk/7XOzXmGLk6CrRWFbkrjY=;
        b=XkFXXNErM+yRGdy+qDtbkmX+4VEZ5m9qHKugCJbfJNdgl3ve0jWy/+F4tTXu32KdUs
         ZlmzzkfaIykxgSklCoJEWA4BXMJezfChe7fTAG3y+gNO0A3Prjdi7G7ftrJ1fMW4Chtu
         Ur8b5KwGC2vFzJcnLOOxos3vYSElw5q+r2fhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HTgpJSeP+XwifnYxDA/LJk/7XOzXmGLk6CrRWFbkrjY=;
        b=sg2GXWWCR3zC5VLjIl1jDVKfwPagLketj4k+rBSpe94g5u4J4AyXhACH/2fA7CPWwT
         Wg/55hzt65x7/ZLmIDb6J2SxaFgPao/14wgo8JOmFEHy8ARvFg5chpkg2ZWG32vbnHRA
         I0JGHgnQYrpaESr7g11tp0cEpvGx2Rwq5FkED5+Nure0V7gOq8cwtWyIRork/oL890AU
         iD0hM4tJsH0krmeql2EbhYs+652ZIYhkRXz7kT7Y7tuP+Hi2UlB2UKJgAhKWbpR3kRCH
         GfChh0XMnVAGDzHRlOciJZBEhUWbj79vd/PN16Y8HsubcDanDxkEXjPwAPdx/efx4q73
         OrnQ==
X-Gm-Message-State: AJIora8o3sXpvaR4G33Bf0DnmdbrGtTVKR8MlviH5IXtDqVaP3nXFrcP
        UWzxqDeb7x4srHrabY89FcyRMA==
X-Google-Smtp-Source: AGRyM1s4uanJHUKKIod6+EwvsNt4/SWBuP00+8jsvXiuD/qtY/XgyCaOaCIlBPonxuNlTwaxAfu3OQ==
X-Received: by 2002:a05:6870:2385:b0:f2:77a6:797 with SMTP id e5-20020a056870238500b000f277a60797mr3670372oap.257.1655409085231;
        Thu, 16 Jun 2022 12:51:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p15-20020a9d76cf000000b0060c0c358b8esm1268248otl.3.2022.06.16.12.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 12:51:24 -0700 (PDT)
Subject: Re: [PATCH] drivers/char/agp: Remove unnecessary variable assignment
 in agp_generic_create_gatt_table()
To:     Gautam Menghani <gautammenghani201@gmail.com>, airlied@linux.ie
Cc:     linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220616181939.225041-1-gautammenghani201@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <81aaa86d-f963-0265-6a4e-6a6110758b99@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 13:51:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220616181939.225041-1-gautammenghani201@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 12:19 PM, Gautam Menghani wrote:
> Remove unnecessary variable assignment in the function
> agp_generic_create_gatt_table(). This fixes the clang scan warnings:
> 
> warning: Value stored to 'page_order' is never read [deadcode.DeadStores]
>          page_order = num_entries = 0;
> 
> warning: Although the value stored to 'num_entries' is used in the
> enclosing expression, the value is never actually read from 'num_entries'
> [deadcode.DeadStores]
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>   drivers/char/agp/generic.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
> index 3ffbb1c80c5c..046ef61132f6 100644
> --- a/drivers/char/agp/generic.c
> +++ b/drivers/char/agp/generic.c
> @@ -864,7 +864,6 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
>   	table = NULL;
>   	i = bridge->aperture_size_idx;
>   	temp = bridge->current_size;
> -	page_order = num_entries = 0;

It would be safe to initialize page_order and num_entries when
they are declared a few lines above.

>   
>   	if (bridge->driver->size_type != FIXED_APER_SIZE) {
>   		do {
> 

thanks,
-- Shuah
