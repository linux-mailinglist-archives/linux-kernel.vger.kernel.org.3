Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B594B6BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiBOMKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:10:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237518AbiBOMKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:10:21 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC9F68EC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:10:10 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c10so8940486pfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Rvc5VFNuQvOUoAjdswhh5nR82Ho+mPvuJf8m7WDO3Qs=;
        b=xtE/ytqcCPY1yN5pIplQeeZomXpKV5da0WHr6CnDmO4fmr9rg8Zr9b3UABGLxx8V3u
         NDNsNtiv5jxI1QCHK7eI3QQKYPuOnQoFIk7qgfFewZ7YvL7MNyQAmr7w1JwmKQxwcAiw
         GJwoOrkN7OZ4C4IKmVNpoSCOB3apeP2UORrDJRJa1/lkq5lBbX+pSCaIM1fIYLOQep5i
         OdNRbnYd+Qc74cE8kHsyBYQNbsumy3whUl0KtR/KQb+tWGWQJ5FrYimIpbZejLR/Gefh
         cLpIHXyY/a5xV3XSh9/zfHngVTYXBqsFWdxKHGGF409sAG6RXss20rkdj+DIkw7G2Hld
         tGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rvc5VFNuQvOUoAjdswhh5nR82Ho+mPvuJf8m7WDO3Qs=;
        b=Y9kWhqsfD57XVjKiEjqXpZTXKygr4XR98YoPIIppzxtufSNGvFS0KPp3mNrLnPBL2V
         swGgI8ep09qEH8yT45jR5iNmhoiJMvREHOPGbPPIv6l/JO4TK/9CVxCXevsAI8OiKH4c
         e8iOO0ljy25Jmlv916f747gjIBGHvV1aVeZ1i+/atvXvXdYHrJKAdVer8sXmF6vf+hPN
         JJbIiSTSd+lq0eYxQ0E32Eu8Y/ucHY9aQ4gXhXAQLv2JZjbCdbN5lQjOAC7Tx9rrwTUq
         4u61d173s1WnBvfRt/rBLx9JRqw99c/Pp8tQTj9UJL9xSsocA1Iws+EaWaWguxTL8S9R
         SPRg==
X-Gm-Message-State: AOAM5337PReZDCKfElRwY2HvPG3TKztUNw4/+aLE1E13zfdIznog+43c
        p7hlyk2pLPmkYc9zUFUZKquAtHDbCU/7pA==
X-Google-Smtp-Source: ABdhPJyywc6pxdHcOr/YlYI/BiLGm6yw8O3kIJaImkJ35VKGI9WA1zODQyKYxzF/X12TQesyAppR4Q==
X-Received: by 2002:aa7:88d1:: with SMTP id k17mr3619040pff.38.1644927010288;
        Tue, 15 Feb 2022 04:10:10 -0800 (PST)
Received: from [10.255.13.118] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id h9sm41137904pfi.124.2022.02.15.04.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 04:10:09 -0800 (PST)
Message-ID: <c4b3b8c3-890a-59d1-623a-3341abcf290e@bytedance.com>
Date:   Tue, 15 Feb 2022 20:10:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [Phishing Risk] [External] Re: [PATCH] blk-cgroup: set blkg
 iostat after percpu stat aggregation
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, boris@bur.io, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220213085902.88884-1-zhouchengming@bytedance.com>
 <Ygqmjsbu96+UZDw+@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Ygqmjsbu96+UZDw+@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/2/15 2:59 上午, Tejun Heo wrote:
> On Sun, Feb 13, 2022 at 04:59:02PM +0800, Chengming Zhou wrote:
>> Don't need to do blkg_iostat_set for top blkg iostat on each CPU,
>> so move it after percpu stat aggregation.
>>
>> Fixes: ef45fe470e1e ("blk-cgroup: show global disk stats in root cgroup
>> io.stat")
> 
> I'm not sure Fixes tag is necessary here.

I'm also not sure, since the io.stat reports correct data after all. I put
the Fixes tag here in case someone wants it. Please feel free to delete it.

Thanks.

> 
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> but other than that,
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 
