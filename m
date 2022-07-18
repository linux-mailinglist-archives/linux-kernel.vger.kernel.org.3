Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EC95783F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiGRNl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiGRNlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:41:55 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF0E1DA42;
        Mon, 18 Jul 2022 06:41:55 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id h132so10582900pgc.10;
        Mon, 18 Jul 2022 06:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rnjh/i5JdMf0J8B93u/CObaqJyaPuNqc0mMcjhYd/7c=;
        b=UdUmwx8z6t1T5W1twXtmQ+4sWtICHFYFcqfdK1FC6W1nqsKt8g4tUW7B1gSh1Vk53F
         vpnJ/VzDLFAVnggvC6dW+/EoNQ9fA5gDgr3Fr48RlZHhA0S+2nqkGU2UVdx/yfXN1Jbh
         KcaxQa87EvtTTDbFasTW8irBZMXEDEH8/zpVj1wkHsQCL0JMf9NyEg5MNPkT1ojynFvT
         QwrxVwYuZwZrRbjhTmeEtdR4JbrRO/k5DKdAI5mEPnXueyah4eW1QuO95Npi87kfcRLP
         FKmf250XeZCBrPvTCM58aDjmToMquu87A4uLk7DtsaTpFfGayXXg0+3clq/8Ypco80/D
         pz1w==
X-Gm-Message-State: AJIora9+Db5AC36JWQEo2NIdBBzPY2AIGt4qRD4Hnx1f2s23eb0gd7ZS
        0yu0so/p1oR1OMIc7dT3IvVaczG8jmg=
X-Google-Smtp-Source: AGRyM1vaZgqSURLsI49S4CAXVaT+0OJ5kw/Xn9OoIvrsCVaaAcWfb25DQXgmenKH2fRDbtTR5uvA0w==
X-Received: by 2002:a05:6a00:450d:b0:52b:84ca:9509 with SMTP id cw13-20020a056a00450d00b0052b84ca9509mr524383pfb.74.1658151714220;
        Mon, 18 Jul 2022 06:41:54 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id w188-20020a6282c5000000b0052aee60e058sm9268784pfd.102.2022.07.18.06.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:41:53 -0700 (PDT)
Message-ID: <5a245067-7adb-c482-3ea4-22beb81fa719@acm.org>
Date:   Mon, 18 Jul 2022 06:41:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] blktrace: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, rostedt@goodmis.org
Cc:     axboe@kernel.dk, mingo@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220718061755.114599-1-yang.lee@linux.alibaba.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220718061755.114599-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/22 23:17, Yang Li wrote:
> Remove warnings found by running scripts/kernel-doc, which is caused by
> using 'make W=1'.
> kernel/trace/blktrace.c:1884: warning: Function parameter or member 'opf' not described in 'blk_fill_rwbs'
> kernel/trace/blktrace.c:1884: warning: Excess function parameter 'op' description in 'blk_fill_rwbs'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   kernel/trace/blktrace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 150058f5daa9..5632b6159d88 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1873,7 +1873,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
>   /**
>    * blk_fill_rwbs - Fill the buffer rwbs by mapping op to character string.
>    * @rwbs:	buffer to be filled
> - * @op:		REQ_OP_XXX for the tracepoint
> + * @opf:	a combination of a request operation and request flags
>    *
>    * Description:
>    *     Maps the REQ_OP_XXX to character and fills the buffer provided by the

A patch similar to the above patch should already have been queued by 
Jens Axboe. See also "[PATCH 0/2] Fix recently introduced kernel-doc 
warnings" 
(https://lore.kernel.org/all/165797480617.363028.4687340933765044343.b4-ty@kernel.dk/).

Thanks,

Bart.
