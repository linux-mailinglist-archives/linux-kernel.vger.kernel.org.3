Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91DA4FE4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356975AbiDLP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346458AbiDLP0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:26:23 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A4E2;
        Tue, 12 Apr 2022 08:24:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 15so9687902ljw.8;
        Tue, 12 Apr 2022 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VStffjPSoNuLVmgDL/ileLhw4nppALw1IFNpnjw+ytU=;
        b=BSrsVveb2Ov8wixMuMVEF0afp0t9GItWPOTZos5ZRGOn853uCe9L80l6HaT2uoI+PZ
         dnHRW8B+/F0Sd7bg/sTthP04nX1KwcfAOL56k2+KMbjyeYLsg73rBvNISTLBaGgRHsCj
         qXLus9ixicO3LD1Jqd+lgKZrsqX7YMX3jKZQM2Qbv67Vx2nvzT93b8R2oq8FJrmt+Qzk
         bLEwY6oHS8k4dWdTg/DZ6gNtfD+p4KTG4hfq/f7cG0GJOS0abEpiu7NF/roFpvTzDH5k
         yMuJZ29VRGw4x8NAGwc+lBpY0x+47fLIRfyAbG3+Ert2383Es+T7wYv83OScKUWw8sMy
         qgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VStffjPSoNuLVmgDL/ileLhw4nppALw1IFNpnjw+ytU=;
        b=2jMYbO9J+XMMX98uLlS6KIfH/4F4XtlUxfNqjI62kdj3dlOfOjfMoTr9oRPnnftDUr
         3X68ARnPxYrfS+yy/KZrfGhKNlOL4SlV1GSkW1i032VYDe8utImvFqM010hBh5KM1Giu
         k/rphYyTzQqGfLTb4hKh70eVzBTkreMo4qE5LRku7edVP9qLc8odH4hNV9ot+2EqCjcq
         uU1seI1QcY5A3LconvZWZPrtFz1w0WF6XrhCg0MGyFzIFmgGBhhkHMR+lgB7ZvYGgxCL
         NPp6gYZPHg2lxkWRo91cUWBujmVl3WZHB2OzJ+YktbBl1TEO5HR4mxPXXE2YFiy0Dzrd
         qqPg==
X-Gm-Message-State: AOAM530iwpAgNR/NF1b+eWGefZ1fmFzlTzNUONy4wR0Ay9L7HxFiXI1G
        3xNKX9TqtCCFmo/fBywSmX0=
X-Google-Smtp-Source: ABdhPJx8ntIZ64Ep+1//eaVIjzbkY6UpyEKqOwRsH3Vumux5OXak8LEcuT8NThTvX5bZM+fbF/uzDA==
X-Received: by 2002:a2e:381a:0:b0:24b:68ae:4169 with SMTP id f26-20020a2e381a000000b0024b68ae4169mr5020616lja.208.1649777039712;
        Tue, 12 Apr 2022 08:23:59 -0700 (PDT)
Received: from [192.168.31.104] (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id o26-20020a198c1a000000b0046bc20821f6sm126079lfd.115.2022.04.12.08.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 08:23:59 -0700 (PDT)
Message-ID: <1c8fa321-d91e-c906-a7da-c252a112191b@gmail.com>
Date:   Tue, 12 Apr 2022 17:23:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] block: Remove redundant assignments
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, llvm@lists.linux.dev
References: <20220409101933.207157-1-michalorzel.eng@gmail.com>
 <20220409101933.207157-2-michalorzel.eng@gmail.com>
 <a56d1184-d399-d5f8-765f-5a4f35dacd5e@redhat.com>
 <446a3e88-4c14-300d-862a-1279274c3760@gmail.com>
 <c2c40f00-777c-f19a-eb5f-6e978ddd6bcf@redhat.com>
From:   Michal Orzel <michalorzel.eng@gmail.com>
In-Reply-To: <c2c40f00-777c-f19a-eb5f-6e978ddd6bcf@redhat.com>
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

Hi Tom,

On 09.04.2022 18:03, Tom Rix wrote:
> 
> On 4/9/22 6:20 AM, Michal Orzel wrote:
>> Hi Tom,
>>
>>> On 4/9/22 3:19 AM, Michal Orzel wrote:
>>>> Get rid of redundant assignments which end up in values not being
>>>> read either because they are overwritten or the function ends.
>>> This log is the same as your last patch.
>>>
>>> Instead of a general statement on deadstores, a more specific
>>>
>>> analysis of the setting being removed would be helpful.
>>>
>>> This will mean splitting the patch to match the analysis.
>>>
>>> Tom
>>>
>> I think that this explanation in a commit is enough for such a trivial patch.
>> It informs that we are fixing clang-tidy findings related to deadstores
>> in a block subsystem. What analysis would you want to see?
>> Something like "Remove deadstore assignment ret = -EINVAL  in a function bio_map_user_iov" ?
>> I think that it will create too much of not needed overhead.
> 
> The compiler should remove these already.  All of the static analyzers produce false positives, if you do not provide analysis the reviewer has to assume you have not done any and has to do the false positive analysis themselves. This burdens the reviewer for something of small value that can be dismissed as churn.
> 
> Tom
> 

Ok, I will split the patch into series in v2 and I will add some analysis into commit msg.

Cheers,
Michal
