Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4F34C50DB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiBYVpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiBYVps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:45:48 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE981EF35A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:45:15 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id x14so231597ill.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GlfIBSqlGvtgBv75Rg1rA8MquMPJgcWiel0j8isuYbQ=;
        b=HLrWX91wZAju9leNV7HFPStLOTDTKTykc0vJTupccN3o3/OiwP19YNo6Qzp1zeF9iD
         ySamRLGUmUYo7kRYhJG/V0jfmkCyf0d/RpuJNgm+9j17cf7ewVM5FPh3eQ84me4uAq3l
         S8XVO2DI41apmljHGwvmrhoJMRDM4MwtWny+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GlfIBSqlGvtgBv75Rg1rA8MquMPJgcWiel0j8isuYbQ=;
        b=fTqT89wLgVupfcBLje+f8QjLXsiGx9GanbWJ/H3uYmpP5IYjR0jndhtZU5fryLOqaz
         48GKpw8yn8ORQZgxPOzXf8HAyCyWHehdW/KOp0Fy6C/EXL3GlcNN4cILTsbRdIXxFrSn
         iO9vb5mKTkMEjvIZ0zxXvfgFfUi+oM1lHJGEV1ipz/NlTnDDjF+YU5SqPt6ZTtnfGNXs
         Cd69BJEE+imiTEQ0Evgn74q7TqtkuPc5fw/FBaCYzg02HfmWMwfKBAvWkrxlkBvFl4sb
         CwQxP0J2o3gJjZEPqP1anRP07sSprj56o15FQdoWylGTlWPQp1WC/VAx6eus2aQM1kVT
         hX6w==
X-Gm-Message-State: AOAM530rOrzOqawwsDzAdiXpH/A6yBOgZnChz31jc5tLwvK2r7uw0jYz
        h/2F0AdygOFkkR/00pj+CIvZzx6GNxQ05w==
X-Google-Smtp-Source: ABdhPJzjQSzxBomZ267t53/TYFeVaTmMzeMKuCTgGRpRcjfFDZWL3xDvV1iuoyl5WamEe6X7iVBpaA==
X-Received: by 2002:a05:6e02:12c1:b0:2bf:2a61:9848 with SMTP id i1-20020a056e0212c100b002bf2a619848mr8166860ilm.109.1645825515032;
        Fri, 25 Feb 2022 13:45:15 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o4-20020a92c044000000b002c1e884226asm2313784ilf.12.2022.02.25.13.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:45:14 -0800 (PST)
Subject: Re: [PATCH] Documentation/vm/page_owner.rst: fix the description of
 "-f"
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>, corbet@lwn.net
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        weizhenliang@huawei.com, georgi.djakov@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hanshenghong2019@email.szu.edu.cn,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220225090824.2343-1-caoyixuan2019@email.szu.edu.cn>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <73c74276-3c29-e662-cb96-c09fbba0d2b1@linuxfoundation.org>
Date:   Fri, 25 Feb 2022 14:45:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220225090824.2343-1-caoyixuan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 2:08 AM, Yixuan Cao wrote:
> Few days ago,
> I noticed that in tools/vm/page_owner_sort.c,
> there is a comment that need to be fixed.
> 
> In function usage():
> "-f Filter out the information of blocks whose memory has
> not been released."
> 
> This comment does not match the actual function, the "not"
> should be removed. As a result, I submitted a patch to fix it.
> 
> Similarly, this document should also do the same
> modification, that's why I submit this patch.
> 

Please refer to a few change logs to write them so maintainers
don't have to fix them. This can be written as:

"Fix function usage information for -f option"

> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
> ---
>   Documentation/vm/page_owner.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index aec1906976f4..32ca54757d3f 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -78,7 +78,7 @@ Usage
>   
>   2) Enable page owner: add "page_owner=on" to boot cmdline.
>   
> -3) Do the job what you want to debug
> +3) Do the job what you want to debug.
>   
>   4) Analyze information from page owner::
>   
> @@ -126,4 +126,4 @@ Usage
>   		-c		Cull by comparing stacktrace instead of total block.
>   
>   	Filter:
> -		-f		Filter out the information of blocks whose memory has not been released.
> +		-f		Filter out the information of blocks whose memory has been released.
> 

I can't find this in Linux 5.17-rc5 - is this patch based on linux-next?

thanks,
-- Shuah
