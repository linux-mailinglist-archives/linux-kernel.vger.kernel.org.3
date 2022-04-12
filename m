Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C749F4FD3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 11:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiDLJvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359678AbiDLJsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:48:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF163503;
        Tue, 12 Apr 2022 01:53:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so2231574pja.0;
        Tue, 12 Apr 2022 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jmCpHCMje6DqtUs4yqS5xd4MJHXw5XyWXqbNnJZJI6A=;
        b=S1S23s85lCZ4pEedIgLJany23GsJwNl+sETb6R8H7W+W3S5VOcSfEGpMnCYfUdhv3m
         g/ew39g3VpTLSdY2410LO2Fvwt6/+p2K1sQNWXKUWyVs6NXQ3FH3FqhZn5xgUCPLKudS
         28Z5QrFim4mD5b/TcyE3bo7QqENkek1BZqRc8iovMrIdJEIWln9trhqrxO/6LpMbcMV7
         WZgoCehtFMafjr9LOmGoM9qTAtzPkzv9bOe4AK68uH/Zrh2hCh5zFOSj1V+BNP55snS8
         b1Er5WX74yVtj3Qj5yuJfHrA1X6gupJrxsO8erNt0vMzldbfeTxdUTMzW9hPRs1YaD8P
         br9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jmCpHCMje6DqtUs4yqS5xd4MJHXw5XyWXqbNnJZJI6A=;
        b=UsYJNc91fMgQjc7xl+zwovb6WcXn/nFIEqO9qYyaZ18jn1OhwPSODiyTIC7hdmBJIv
         uvUI2vE4apWNevHEM1da+Y0lxTth/Fie45klzwwiOS80RUX1WkxcUWgMmRZ8PliKiGcw
         igfXMdbp8hCAuxnYjwsrVPwx0mhp5UxVyA4fcaiFiZ7o82tDRX2wBtBCY/JFGIPYQ8pB
         yWj+0M+FM6HcO7TT5keXaxKyCU6I5BJ0Ej2XV6PDGI6M3WhJftR17bXOnKIF8dAm6mIj
         2scWHAimFWBrPKH2WAr/NaMhLl2cveneEZnvkkD0HO4RtJ0QaBRqoLuOJFiGoGhlGig6
         Xb+w==
X-Gm-Message-State: AOAM531D/64/5LjWdO6ERD8u9GGKWOKTkYnHDGc8uPePhb2rq48E25Pn
        7IKEyz/9Bwqu+0IZUghVsQA=
X-Google-Smtp-Source: ABdhPJzeUmMzv/rHk/HRe+pbfq6rGYcycw2WpFMc6HJD/OaTFSmf83XNk1ns+oO4R5agAGqulZcr9w==
X-Received: by 2002:a17:90b:1803:b0:1c7:24c4:ab52 with SMTP id lw3-20020a17090b180300b001c724c4ab52mr3744795pjb.240.1649753631471;
        Tue, 12 Apr 2022 01:53:51 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id d21-20020a056a0010d500b004fd9ee64134sm37205794pfu.74.2022.04.12.01.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:53:50 -0700 (PDT)
Message-ID: <77119299-efb5-5364-44fe-9f71c7c6a4a4@gmail.com>
Date:   Tue, 12 Apr 2022 16:53:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] docs/zh_CN: sync with original text
 Documentation/vm/page_owner.rst
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        siyanteng@loongson.cn
References: <1649733951-8827-1-git-send-email-baihaowen@meizu.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <1649733951-8827-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Yanteng Si <siyanteng@loongson.cn>

and please remove the warning in git apply:

Applying: docs/zh_CN: sync with original text Documentation/vm/page_owner.rst
.git/rebase-apply/patch:33: trailing whitespace.
                符**部分描述了可识别的关键字。<rules> 可以由键 k1,k2, ... 顺序指定，如下面的 
warning: 1 line adds whitespace errors.



On 4/12/22 11:25, Haowen Bai wrote:
> As the tools/vm/page_owner_sort added some feature and original text
> updated, sync the translation of zh_CN.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  Documentation/translations/zh_CN/vm/page_owner.rst | 54 +++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/vm/page_owner.rst b/Documentation/translations/zh_CN/vm/page_owner.rst
> index 9e951fabba9d..0d4f94034db6 100644
> --- a/Documentation/translations/zh_CN/vm/page_owner.rst
> +++ b/Documentation/translations/zh_CN/vm/page_owner.rst
> @@ -103,14 +103,66 @@ page owner在默认情况下是禁用的。所以，如果你想使用它，你
>  		-m		按总内存排序
>  		-p		按pid排序。
>  		-P		按tgid排序。
> +		-n		按任务名称排序。
>  		-r		按内存释放时间排序。
>  		-s		按堆栈跟踪排序。
>  		-t		按时间排序（默认）。
> +		--sort <order>	指定排序顺序。排序语法是 [+|-]key[,[+|-]key[,...]]. 从
> +						**标准格式说明符**部分选择一个键。"+" 是可选的，因为默认方向是增加数字或字典顺序。
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
> +		标准格式说明符
> +==========================
> +--sort 选项:
> +
> +	缩写键	全称键		描述
> +	p		pid			进程 ID


Are above lines aligned?


Thanks

Alex

> +	tg		tgid		线程组 ID
> +	n		name		任务名称
> +	st		stacktrace	页面分配的调用栈
> +	T		txt			块的全文
> +	ft		free_ts		页面被释放的时间戳
> +	at		alloc_ts	页面分配的时间戳
> +
> +--curl 选项:
> +
> +	缩写键	全称键		描述
> +	p		pid			进程 ID
> +	tg		tgid		线程组 ID
> +	n		name		任务名称
> +	f		free		该页面是否已被释放
> +	st		stacktrace	页面分配的调用栈
