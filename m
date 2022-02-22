Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FE94C01C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiBVS7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiBVS73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:59:29 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055B4151343
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:59:03 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so10311060oti.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sr0bZ/IYx5fNgYIhrtES2Y53AQkSGkgSrNO7ZdZIC3Q=;
        b=ZhqRZL1lIFwgAvx2B1EAPpwJgojg1Hi42R0xhoNL9F+8ADtR+J+GLx8Dyemeyz07bb
         AKCjA1lLb6wiFn0GLKn2i3cUZpz9QhYKsXQb2P3c0cF5wyU9nt1sdZKqoWYXpR5HGLV0
         cTFEGK5CmTSsZ2zEhqU4IKtoLYMINfiFDTJr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sr0bZ/IYx5fNgYIhrtES2Y53AQkSGkgSrNO7ZdZIC3Q=;
        b=Ujq8P6dbugBVFLw1Fi3vVbhIEEnwd6R1gPr3EujodTDF+bvUWMNIiqsBdvxEzkJROc
         B7k4wnlX7ncb9/Q25HzcgIvLuk74K9KKVumzp74jM6EjjDSko0/wsJUQt80GESDY+hrV
         8R0nO2FqYP4LVckCmVNSCOldbxioDbCHgHRGY0CcO7yUtQ+s2WJ/1/IymhVTdlsuxlNV
         swJTnZoyavhTsL79pQ9gyV54Rt0qEmFuF1YQxgL0h+MkribPdA75qOSjmO0Ht0zDHifc
         FVTdKfxgqImG4K9miKK1cTP1+0CvbRy+sFTEig/NTgp0GJg+D3liw3duic1H63MZDdr+
         t2Zg==
X-Gm-Message-State: AOAM533lpXlLmjhDQ2uKdXI+28+9Pl5/4qX8kiWnMSNud+Wv0hAbc/Dk
        K5i/C+AZxVFq/NiRMhdC7CVkEQ==
X-Google-Smtp-Source: ABdhPJx43lTtrcAsV/EG4qlYsVml8Jq/qj9Hd4Y/C+i0e4zg3+UpdjivGCQxjYv7vBO59tVaan2CtA==
X-Received: by 2002:a9d:715c:0:b0:5ad:3858:4d54 with SMTP id y28-20020a9d715c000000b005ad38584d54mr6872077otj.214.1645556342321;
        Tue, 22 Feb 2022 10:59:02 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p13sm8964946oiv.23.2022.02.22.10.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 10:59:02 -0800 (PST)
Subject: Re: [PATCH 2/2] Documentation/vm/page_owner.rst: fix a phrase
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>, corbet@lwn.net
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au,
        hanshenghong2019@email.szu.edu.cn, vbabka@suse.cz,
        georgi.djakov@linaro.org, weizhenliang@huawei.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220220082932.2808-1-caoyixuan2019@email.szu.edu.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f27d2965-bd4d-bad3-4137-09c7f4214bd9@linuxfoundation.org>
Date:   Tue, 22 Feb 2022 11:59:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220220082932.2808-1-caoyixuan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/22 1:29 AM, Yixuan Cao wrote:
> I think that using "by default" will be better.
> 
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>

While you are at it could you fix others as well:

> ---
>   Documentation/vm/page_owner.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 2b54e82b9fe1..5ac1c12fcfc2 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -26,7 +26,7 @@ fragmentation statistics can be obtained through gfp flag information of
>   each page. It is already implemented and activated if page owner is
>   enabled. Other usages are more than welcome.
>   
> -page owner is disabled in default. So, if you'd like to use it, you need
> +page owner is disabled by default. So, if you'd like to use it, you need
>   to add "page_owner=on" into your boot cmdline. If the kernel is built

page owner is disabled by default. So, if you'd like to use it, you need
to add "page_owner=on" to your boot cmdline.

>   with page owner and page owner is disabled in runtime due to no enabling

with page owner and page owner is disabled in runtime due to not enabling

>   boot option, runtime overhead is marginal. If disabled in runtime, it
> 

With these fixed:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
