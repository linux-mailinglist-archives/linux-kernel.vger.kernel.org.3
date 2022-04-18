Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30ED75054C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbiDRNTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbiDRNAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:00:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1834C3150D;
        Mon, 18 Apr 2022 05:41:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so17179085pjb.2;
        Mon, 18 Apr 2022 05:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7kzCvTCHP5Ec0EYskhQImxhR7aaaSEbjrSNccJSSVpE=;
        b=idMzA4OgXctXR29po4+p6or86OZoa5hbLmu3y7m+IThAXzETFBdUKW63uXTQ2ZIqJq
         g3mZLGIhZFksaJ+TmYkuRTKR/L5KPGb3An5NUO6nrvF+MCowHEsta510JE48ntxwJROr
         UXoKRab9tbihG62rOSi8l4gZPh4u1W4y+rKSAgHMwPCnyCOyrDyqHcVblpPvPJmvmp/J
         c+yOnA/DuXrD3BwLNsYady06+agKPQ4z2U1pNJwBS5hw7SFmaBWoGXSHulLYuAiwQs/t
         jJtKLtkE4hANn1PcGA7x3VQw01OX2mrrjJwCwbp9DoOrz4NcM3mqtItoyLL7SXxKXCNB
         0B6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7kzCvTCHP5Ec0EYskhQImxhR7aaaSEbjrSNccJSSVpE=;
        b=WkF7wOaH4NWNzo4arIaqGtwqibwr0CX6n/3tnjSg6F4VMcFU/zeMqMlvmiYyStH2g/
         098FVOk8Gx42fRNWvdAI7MWYkWWBGe2GYkydNSy6sTfntEAz5uMknzPIsVF4JyesvzbS
         U+vhssbFVWK2ibbcoGGl56o0fF58HtPpdQugD1bVtSx38ILNzdfKhYKKtFT97OTdYOi1
         v/k+jscJ+RG/P6zfNtCp0LoBcBTwK9Ebbi1WMgDTp4cJTC8O2CJqcbC9Svq3tIeYYolf
         GdLcUCg4GarAvpUl0E0lLuQP6bsh/adRvKwY0QixXhYdxRSCUpWcPK/Yg+yPdTqIcdPP
         Sq/w==
X-Gm-Message-State: AOAM530OJH7j9Dy17IlXRe4n4DKo7mBszd59nz9G0kHrCIbEb3E3ZSID
        nq0oJhIUwkS38AJ14pgrJzY=
X-Google-Smtp-Source: ABdhPJxr8oswLT3gJLSeJiCYVoAg8kYjyl9WW56hpoZQdqGlGIrW34LbW+mDHJBjVaFvmRGTwXLAHg==
X-Received: by 2002:a17:902:ce06:b0:156:8118:9e9a with SMTP id k6-20020a170902ce0600b0015681189e9amr10977783plg.169.1650285711582;
        Mon, 18 Apr 2022 05:41:51 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00218600b004f65315bb37sm13060177pfi.13.2022.04.18.05.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 05:41:51 -0700 (PDT)
Message-ID: <202ba5f5-f842-f4ce-dd67-c5166d94cc67@gmail.com>
Date:   Mon, 18 Apr 2022 20:41:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4] docs/zh_CN: sync with original text
 Documentation/vm/page_owner.rst
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, siyanteng01@gmail.com
Cc:     alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, siyanteng@loongson.cn
References: <CAEensMx3qvL7qmT=PhxYoJ4v5P8USn1qyAGBcB1WR5R4FQ24og@mail.gmail.com>
 <1650274084-27871-1-git-send-email-baihaowen@meizu.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <1650274084-27871-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haowen,

There are still some space error during the 'git apply'.
Could you like to fix them?

thanks
Alex

Applying: docs/zh_CN: sync with original text Documentation/vm/page_owner.rst

.git/rebase-apply/patch:21: trailing whitespace.

		--sort <order>	指定排序顺序。排序语法是 [+|-]key[,[+|-]key[,...]]. 从 

.git/rebase-apply/patch:65: indent with spaces.

        ======          ==========      ===================

.git/rebase-apply/patch:66: indent with spaces.

        缩写键          全称键          描述

.git/rebase-apply/patch:67: indent with spaces.

        ======          ==========      ===================

.git/rebase-apply/patch:68: indent with spaces.

        p               pid             进程 ID

warning: squelched 16 whitespace errors

warning: 21 lines add whitespace errors.



On 4/18/22 17:28, Haowen Bai wrote:
> As the tools/vm/page_owner_sort added some feature and original text
> updated, sync the translation of zh_CN.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: fix whitespace warning.
> V2->V3: fix some tab Alignment issue.
> V3->V4: fix sphinx warning
> 
>  Documentation/translations/zh_CN/vm/page_owner.rst | 61 +++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/zh_CN/vm/page_owner.rst b/Documentation/translations/zh_CN/vm/page_owner.rst
> index 9e951fabba9d..4d719547ce4f 100644
> --- a/Documentation/translations/zh_CN/vm/page_owner.rst
> +++ b/Documentation/translations/zh_CN/vm/page_owner.rst
> @@ -103,14 +103,73 @@ page owner在默认情况下是禁用的。所以，如果你想使用它，你
>  		-m		按总内存排序
>  		-p		按pid排序。
>  		-P		按tgid排序。
> +		-n		按任务名称排序。
>  		-r		按内存释放时间排序。
>  		-s		按堆栈跟踪排序。
>  		-t		按时间排序（默认）。
> +		--sort <order>	指定排序顺序。排序语法是 [+|-]key[,[+|-]key[,...]]. 从 
> +						**标准格式说明符** 部分选择一个键。"+" 是可选的，因为默认方向是增加数字或字典顺序。
> +						允许混合使用缩写键和全称键。
> +
> +		Examples:
> +				./page_owner_sort <input> <output> --sort=n,+pid,-tgid
> +				./page_owner_sort <input> <output> --sort=at
>  
>     其它函数:
>  
>  	Cull:
> -		-c		通过比较堆栈跟踪而不是总块来进行剔除。
> +		--cull <rules>
> +				指定筛选规则。筛选语法是 key[,key[,...]]。在**标准格式说明符**部分选择一个多字母键
> +
> +		<rules> 是逗号分隔列表形式的单个参数，它提供了一种指定单个筛选规则的方法。下面的**标准格式说明
> +				符**部分描述了可识别的关键字。<rules> 可以由键 k1,k2, ... 顺序指定，如下面的
> +				STANDARD SORT KEYS 部分所述。允许混合使用缩写形式和完整形式的键。
>  
> +		Examples:
> +				./page_owner_sort <input> <output> --cull=stacktrace
> +				./page_owner_sort <input> <output> --cull=st,pid,name
> +				./page_owner_sort <input> <output> --cull=n,f
>  	Filter:
>  		-f		过滤掉内存已被释放的块的信息。
> +
> +	Select:
> +		--pid <pidlist>		通过 pid 进行选择。这将选择进程 ID 号出现在 <pidlist> 中的块。
> +		--tgid <tgidlist>	通过 tgid 进行选择。这将选择线程组 ID 号出现在 <tgidlist> 中的块。
> +		--name <cmdlist>	按任务名称选择。这将选择任务名称出现在 <cmdlist> 中的块。
> +
> +		<pidlist>、<tgidlist>、<cmdlist>是逗号分隔列表形式的单参数，它提供了一种指定单个选择规则的方法。
> +
> +
> +		Examples:
> +				./page_owner_sort <input> <output> --pid=1
> +				./page_owner_sort <input> <output> --tgid=1,2,3
> +				./page_owner_sort <input> <output> --name name1,name2
> +
> +标准格式说明符
> +==============
> +
> +--sort 选项:
> +
> +        ======          ==========      ===================
> +        缩写键          全称键          描述
> +        ======          ==========      ===================
> +        p               pid             进程 ID
> +        tg              tgid            线程组 ID
> +        n               name            任务名称
> +        st              stacktrace      页面分配的调用栈
> +        T               txt             块的全文
> +        ft              free_ts         页面被释放的时间戳
> +        at              alloc_ts        页面分配的时间戳
> +        ======          ==========      ===================
> +
> +--curl 选项:
> +
> +        ======          ==========      ==================
> +        缩写键          全称键          描述
> +        ======          ==========      ==================
> +        p               pid             进程 ID
> +        tg              tgid            线程组 ID
> +        n               name            任务名称
> +        f               free            该页面是否已被释放
> +        st              stacktrace      页面分配的调用栈
> +        ======          ==========      ==================
