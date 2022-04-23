Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6114C50C933
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 12:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiDWKbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 06:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiDWKbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:31:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC2D193E8;
        Sat, 23 Apr 2022 03:28:07 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s17so16207012plg.9;
        Sat, 23 Apr 2022 03:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nWpbGlpwLh+gEQkkWRq3YHbL1ngb/Lz4M10YRAZLF3A=;
        b=JkmbreG6V3KF7ABzgpWuBafkd0PznuzvpymRkHC8ZFJpH2QT2/cs9+MoXLo8pBqieI
         NY+GhlD/zQKbCV2ubWeFoNlUd5n6DBkvCAqlPuFYeL73Tr1AZ0lfiXoAe6h+KJNaAWhj
         wAHMEiawcTjCo5UJGimf12tuwUvpZguO3Q2RYCr1Sccs4l55+Jb9SjR6j0HdnbUwogCu
         6d4W6S4vhk1VURgyu+zT6KsKJOLdKUpbnsYz+khpn1sTbMyo+5ZFvyWMNMpFlOwEcJGp
         XBEtUOCUAKFNCtCGpAQVI+dQj8MNMv5A4kfwIwqL/HDVklTmMgp7elLp8R5ZG3oNXKc3
         VVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpbGlpwLh+gEQkkWRq3YHbL1ngb/Lz4M10YRAZLF3A=;
        b=hv+XynlAO9kts/6JNv0zGEpNbmJMWMTHsO3YBX7jBrwSw5csRE5kRLcsbAENjNNnxs
         4/hLxjTDDhcudhqEeucrw149UgUM2O1h5GlGuVVHzBQPEnnXvfA2AGO5pbrFXPp6Asew
         WcRh7IwPCWFheOSwsHwhJSBLrkzYhve1NuFYP5KawffEj/+flBJxYaIl8wAl9yCrmMrr
         ZMK2YKvFQHQEfu8VCCXHpcQSrUnFtkMTgkZGsmU0koTHnYgjiBvs3TEizet1t7t2KUf+
         vnGqpBo6nck6gv6l/P6SukN4X6X2EXrCyMnOnoulFTNwEYLraNN1J1Y3zcRiBPvXIcPf
         ZpLg==
X-Gm-Message-State: AOAM532kv9LixCOdpR6WjSSHvVQrXdjWo82JlRidec5BMGEFNGAs42SJ
        nANUUmJ7/uS9Zkc9yFaJ0+A=
X-Google-Smtp-Source: ABdhPJzlCSDoBuNXEtO4t3tDMyqJEjWViQXI6z+2Y63K0fJEUcTtWC5/eRRfg3Xp9bcWQiApoOrc0Q==
X-Received: by 2002:a17:902:d2c5:b0:158:f839:4d8a with SMTP id n5-20020a170902d2c500b00158f8394d8amr8798658plc.108.1650709685590;
        Sat, 23 Apr 2022 03:28:05 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id m23-20020a17090a859700b001cd4989ff47sm8653973pjn.14.2022.04.23.03.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 03:28:05 -0700 (PDT)
Message-ID: <30d2f96e-99e1-2976-a294-8e112166afff@gmail.com>
Date:   Sat, 23 Apr 2022 18:27:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] docs/zh_CN: sync with original text
 Documentation/vm/page_owner.rst
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, siyanteng01@gmail.com
Cc:     alexs@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, siyanteng@loongson.cn
References: <CAEensMzuQ0uAw8_5Xb7u1n685au=DpaJyPevGCT8GCG7xS42ow@mail.gmail.com>
 <1650424016-7225-1-git-send-email-baihaowen@meizu.com>
 <1650424016-7225-2-git-send-email-baihaowen@meizu.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <1650424016-7225-2-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haowen,

I hit the mistake again while apply your patch:
$git am your_patch
error: cannot convert from N to UTF-8

fatal: could not parse patch


You have to try apply it before sending out your patch.
and this patch is better be to be 2nd patch in series.

Thanks
Alex

On 4/20/22 11:06, Haowen Bai wrote:
> As the tools/vm/page_owner_sort added some feature and original text
> updated, sync the translation of zh_CN as below.
> 
> Commit 8bd16bc0a081 ("tools/vm/page_owner_sort.c: support sorting blocks
> by multiple keys") add sorting blocks by multiple keys usage
> description.
> 
> Commit 78a0b94f3829 ("tools/vm/page_owner_sort.c: support for multi-value
> selection in single argument") add multi-value selection in single
> argument usage description.
> 
> Commit c89b3ad2dea2 ("doc/vm/page_owner.rst: remove content related to -c
> option") remove  -c option usage description.
> 
> Commit 9c8a0a8e599f ("tools/vm/page_owner_sort.c: support for user-defined
> culling rules") add user-defined culling rules usage description.
> 
> Commit 8ea8613a616a ("tools/vm/page_owner_sort.c: support for selecting by
> PID, TGID or task command name") add selecting by PID, TGID or task
> command name usage description.
> 
> Commit 194d52d771b8 ("tools/vm/page_owner_sort: support for sorting by
> task command name") add sorting by task command name usage description.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  Documentation/translations/zh_CN/vm/page_owner.rst | 61 +++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/zh_CN/vm/page_owner.rst b/Documentation/translations/zh_CN/vm/page_owner.rst
> index 9e951fabba9d..c692e81c724e 100644
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
