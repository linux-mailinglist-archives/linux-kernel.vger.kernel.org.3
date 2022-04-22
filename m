Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81C50B968
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448288AbiDVOFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448185AbiDVOFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:05:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCB35A164
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:02:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b19so11174847wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OiK/+I2vz5bjq7VU2avzLK31jm/Gx9AclMA9jxmVAug=;
        b=cP1Bt93JTvJ0ym8c2XrolVeLQrg9PeDE7UAjT401HVPMZMx6hIrhs3OtmlPuLQPk/6
         4pON7EodSw9TXInYKSWTTvj3ODD48aGIMSDzBuGLZt1g5SK9ZrARAVIM/EMSPxviCMFJ
         a7oDURAoUkMCgihkwepRyC6ipb9gbfuBOYJd3Vjvy1URvkZXYuU1dJkCpKhUdvnkMZxx
         oeYl7Wlh0oYM37rZDYhT/jhW55nV7EC6RQTe3yGbTcET2UqYxSpJ0gLtMhHzuy7vURqg
         +Y+eisKwUkhpwfdXKZ2KrCqHVohGaNeFDTx5y379aVJOuBmOJ0cYPvNRTwb8qLEOmbb9
         NQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OiK/+I2vz5bjq7VU2avzLK31jm/Gx9AclMA9jxmVAug=;
        b=gR2cDo+uRdBdn7FxLWm5u6ZFG86ADRv0adzq9Fz0ijYD1IC2BryfLEcw2kwaPp+3QH
         ol3zggZJEF6/1INUS1bQwVLLK5KdX1TLeZupaPb2uZmQjm/VkxEUa5g1edpAh4iLaXx7
         2OKC6aV1cO6HRjL6w1s2Y5NDdV/B9tO5KVde3cMVq24HG2BrGlL1DqNaK/CE33jPCkNn
         GAlsSn7Wj6XhhGIaEd/1FSlKtegKt0rF6+2X8vX7wG9K+FoUd0JJLyyRP8X3bsm9nhh5
         ga1rPmkPvCpuY9QK4R9/NBwvVEgZiP2TpRd/Hz9GgpaZME0GZdEviq1ml9Y/yThrP3cv
         sp0w==
X-Gm-Message-State: AOAM532eCwrWH5zfmUcLwIh80zG7ywaAdjmvN5e0XU3zqtHXn/MdKJMR
        M0Syl+RGfmLprhtW9BdLH2LABw==
X-Google-Smtp-Source: ABdhPJxAw7xcojsmncdMePgMy8X54Zs34nfgJNuHt5yzr/WIJXG0kuAPDAtcSfh+J8Tw7eLdKN9iCQ==
X-Received: by 2002:a5d:6f0c:0:b0:20a:7db1:3408 with SMTP id ay12-20020a5d6f0c000000b0020a7db13408mr3916991wrb.267.1650636156283;
        Fri, 22 Apr 2022 07:02:36 -0700 (PDT)
Received: from [192.168.1.41] (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm2042767wrb.63.2022.04.22.07.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:02:35 -0700 (PDT)
Message-ID: <78790570-f3cd-11f0-c0dc-0d683013946d@linaro.org>
Date:   Fri, 22 Apr 2022 16:02:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] powercap/dtpm: move dtpm_subsys definition to dtpm.c
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>, Tom Rix <trix@redhat.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220418180814.1811136-1-trix@redhat.com>
 <CAJZ5v0ivfLtbEL2h1ivATmTTE0+AxWXeZnbCrfF8R=Y-7rfkcA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ivfLtbEL2h1ivATmTTE0+AxWXeZnbCrfF8R=Y-7rfkcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 15:56, Rafael J. Wysocki wrote:
> On Mon, Apr 18, 2022 at 8:08 PM Tom Rix <trix@redhat.com> wrote:
>>
>> Smatch reports this issue
>> dtpm_devfreq.c:200:24: warning: symbol 'dtpm_devfreq_ops'
>>    was not declared. Should it be static?
>>
>> dtpm_devfreq_ops is declared in dtpm_subsys.h where it
>> is also used
>>
>> extern struct dtpm_subsys_ops dtpm_devfreq_ops;
>> struct dtpm_subsys_ops *dtpm_subsys[] = {
>> ...
>>          &dtpm_devfreq_ops,
>>
>> Global variables should not be defined in header files.
>> This only works because dtpm.c is the only includer
>> of dtpm_subsys.h and user of dtpm_susys[].
>>
>> Move the definition of dtpm_subsys[] to dtpm.c and change
>> the storage-class specifier to static.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
> 
> Daniel, any comments?
> 
> Or do you want to pick it up yourself?

Yes, I'll pick it

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
